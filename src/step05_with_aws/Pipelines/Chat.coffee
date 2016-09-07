{defineModule, log, arrayWith} = require 'art-suite'
{DynamoDbPipeline} = require 'art-ery-aws'
{createDatabaseFilters} = require 'art-ery/Filters'

defineModule module, ->
  class Chat extends DynamoDbPipeline
    @globalIndexes chatsByChatRoom: "chatRoom/createdAt"

    @filter     createDatabaseFilters
      user:     requiredPresent: "trimmedString"
      message:  requiredPresent: "trimmedString"
      chatRoom: requiredPresent: "trimmedString"
