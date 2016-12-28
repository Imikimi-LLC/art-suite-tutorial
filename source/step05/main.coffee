{
  initArtSuiteApp
  Promise
} = require 'art-suite'

require './Configs'
require './Pipelines'

initArtSuiteApp
  MainComponent: require './Components/App'
  prepare: Promise
    .then -> (require 'art-ery-aws' ).DynamoDbPipeline.createTablesForAllRegisteredPipelines()
    .then -> (require 'art-ery/Flux').ArtEryFluxModel.defineModelsForAllPipelines()
