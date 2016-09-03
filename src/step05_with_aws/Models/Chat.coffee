{defineModule, log, arrayWith} = require 'art-suite'
{DynamoDbPipeline} = require 'art-ery-aws'
{ArtEryFluxModel} = require 'art-ery/Flux'
{createDatabaseFilters} = require 'art-ery/Filters'

defineModule module, ->
  class Chat extends ArtEryFluxModel
    @pipeline new DynamoDbPipeline
      globalIndexes: chatsByChatRoom: "chatRoom/createdAt"

    .filter     createDatabaseFilters
      user:     requiredPresent: "trimmedString"
      message:  requiredPresent: "trimmedString"
      chatRoom: requiredPresent: "trimmedString"
