ArtSuite = require 'art-suite'

{
  fullScreenReactAppInit
  Promise
} = ArtSuite

require './Config'
require './Pipelines'

fullScreenReactAppInit Promise.then =>
  Neptune.Art.Ery.Aws.DynamoDbPipeline.createTablesForAllRegisteredPipelines()
  .then -> (require 'art-ery/Flux').ArtEryFluxModel.defineModelsForAllPipelines()
  .then -> require './Components/App'
