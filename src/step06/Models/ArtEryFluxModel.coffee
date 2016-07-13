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
} = Foundation

{missing, failure, success, pending} = CommunicationStatus

{FluxModel} = Flux

class ArtEryQueryFluxModel extends FluxModel
  constructor: (singlesModel, options = {})->
    throw new Error "modelName and query required" unless isString(options.modelName) && isFunction(options.query)
    super decapitalize options.modelName

    @_singlesModel = singlesModel
    @_options = options # used by derivative children

    {@query} = options
    @toFluxKey = options.toFluxKey if options.toFluxKey
    @register()

  loadData: (key) ->
    Promise.resolve()
    .then => @query key

module.exports = class ArtEryFluxModel extends FluxModel

  @pipeline: (@_pipeline) ->
    @register()
    @_pipeline.tableName = @getName()
    @_pipeline

  @queryModel: (options) ->
    new ArtEryQueryFluxModel @, options

  @getter "pipeline"

  constructor: ->
    super
    @_updateSerializer = new Promise.Serializer
    @_pipeline = @class._pipeline

  # IN: key: string
  # OUT: promise.then (fluxRecord) ->
  loadFluxRecord: (key) ->
    throw new Error "invalid key: #{inspect key}" unless isString key
    @_pipeline.get key
    .then (data) ->
      status: Flux.success
      data:   data
    .catch (response) ->
      status: response.status
      error: response.error

  keyFromData: (data) -> data.key

  create: (data) ->
    @_pipeline.create data
    .then (data) =>
      @fluxStore.update @name,
        @keyFromData data
        status: success
        data: data

  ###
  overlapping update strategy:

    1. each update immediatly applies to the local flux record, in invocation order
    2. each remote request gets serialized so the next one only fires after the previous
      one succeeded or failed.
  ###
  _restoreOldFluxRecord: (key, oldFluxRecord) ->
    fluxStore.update @name, key, => oldFluxRecord

  _applyUpdateToFluxStore: (key, data) ->
    new Promise (resolve) =>
      @fluxStore.update @name,
        @keyFromData data
        (oldFluxRecord = {}) =>
          merge oldFluxRecord, data: merge oldFluxRecord.data, data
          resolve oldFluxRecord

  update: (key, data) ->
    throw new Error "invalid key: #{inspect key}" unless isString key

    @_applyUpdateToFluxStore key, data
    .then (oldFluxRecord) =>
      @_updateSerializer
      .always => @_pipeline.update key, data
      .catch (response) =>
        @_restoreOldFluxRecord key, oldFluxRecord
        throw response
