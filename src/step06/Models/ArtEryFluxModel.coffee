Foundation = require 'art-foundation'
Flux = require 'art-flux'
ArtEry = require 'art-ery'

{
  log
  CommunicationStatus
  select
  isString
  isFunction
  decapitalize
  merge
  Promise
  eq
  upperCamelCase
} = Foundation

{missing, failure, success, pending} = CommunicationStatus

{FluxModel} = Flux

class ArtEryQueryFluxModel extends FluxModel
  ###
  options:
    query: (key) ->
      IN: will be the key (returned from fromFluxKey)
      OUT: array of singleModel records
        OR promise.then (arrayOfRecords) ->
  ###
  constructor: (singlesModel, options = {})->
    throw new Error "query required" unless isFunction(options.query)
    super null

    @_singlesModel = singlesModel
    @_options = options # used by derivative children

    {@query} = options
    @toFluxKey = options.toFluxKey if options.toFluxKey
    @register()

  loadData: (key) ->
    Promise.resolve @query key

module.exports = class ArtEryFluxModel extends FluxModel

  @pipeline: (@_pipeline) ->
    @register()
    @_pipeline.tableName = @getName()
    @_pipeline

  @getter "pipeline"

  constructor: ->
    super
    @_updateSerializers = {}
    @_pipeline = @class._pipeline
    @queries @_pipeline.queries
    @actiopns @_pipeline.actions

  ###
  TODO:
  queries need to go through an ArtEry pipeline.
  queries should be invoked with that ArtEry pipeline as @
  every record returned should get sent through the after-pipeline
  as-if it were a "get" request
  ###
  queries: (map) ->
    for modelName, options of map
      if isFunction options
        options = query: options
      class _ extends ArtEryQueryFluxModel
        @_name: upperCamelCase modelName
      new _ @, options

  ###
  TODO:
  actions need to go through an ArtEry pipeline.
  actions should be invoked with that ArtEry pipeline as @
  ###
  actions: (map) ->
    for actionName, action of map
      @[actionName] = action

  ###
  IN: key: string
  OUT:
    promise.then (data) ->
    promise.catch (response with .status and .error) ->
  ###
  load: (key) ->
    throw new Error "invalid key: #{inspect key}" unless isString key
    @_getUpdateSerializer key
    .then => @_pipeline.get key
    .then (data) =>
      @updateFluxStore key, status: success, data: data
      data

  keyFromData: (data) -> data.key

  create: (data) ->
    @_pipeline.create data
    .then (data) =>
      @updateFluxStore @keyFromData(data),
        status: success
        data: data

  # merge data into the fluxRecord at @name/key
  # only merge if data != the current fluxRecord.data
  _applyUpdateToFluxStore: (key, data) ->
    @updateFluxStore key,
      (oldFluxRecord) => merge oldFluxRecord, data: merge oldFluxRecord?.data, data

  ###
  Auto vivifies
  When allDone:
  - remove from @_updateSerializers
  - update fluxStore with the best local understanding of the record's status
  ###
  _getUpdateSerializer: (key) ->
    unless updateSerializer = @_updateSerializers[key]
      updateSerializer = new Promise.Serializer
       #prime the serializer with the current fluxRecord.data
      updateSerializer.then => @fluxStore.get(key)?.data || {}

    updateSerializer.allDonePromise().then (accumulatedSuccessfulUpdatesToData) =>
      @updateFluxStore key, accumulatedSuccessfulUpdatesToData
      delete @_updateSerializers[key]
    updateSerializer

  update: (key, data) ->
    throw new Error "invalid key: #{inspect key}" unless isString key

    # apply local update immediately
    # NOTE: fluxStore.updates are automatically call-order serialized.
    @_applyUpdateToFluxStore key, data

    new Promise (resolve, reject) =>
      @_getUpdateSerializer key

      # apply remote updates in serialized update-call-order
      .then (accumulatedSuccessfulUpdatesToData) =>
        ###

        We call _applyUpdateToFluxStore twice in case a previous update failed
        so fluxStore has the most accurate representation possible.

        NOTE:

          This effectively rolls back fluxStore to the version just before
          this update was called. All pending updates after this one will be
          'lost' UNTIL, those pending updates call their second
          _applyUpdateToFluxStore upon their successes. So, technically, it
          isn't the MOST accurate representation if a previous update failed,
          but it will be resolved to the most accurate rep once all updates
          have completed or failed.

        ###
        @_pipeline.update key, data
        .then (response) =>
          resolve response
          merge accumulatedSuccessfulUpdatesToData, data
        .catch (response) =>
          reject response
          accumulatedSuccessfulUpdatesToData
