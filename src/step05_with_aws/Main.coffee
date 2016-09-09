ArtSuite = require 'art-suite'

{
  FullScreenApp
  createAndInstantiateTopComponent
  CanvasElement
  log
} = ArtSuite

require './Config'
{ArtEryFluxModel} = require 'art-ery/Flux'
{DynamoDbPipeline} = require 'art-ery-aws'
require './Pipelines'

FullScreenApp.init()
.then -> DynamoDbPipeline.createTablesForAllRegisteredPipelines()
.then -> ArtEryFluxModel.defineModelsForAllPipelines()
.then ->
  {App} = require './Components'

  createAndInstantiateTopComponent
    render: ->
      CanvasElement App()

.catch (error) ->
  console.error error
  log ArtSuiteTutorial: initError: error
