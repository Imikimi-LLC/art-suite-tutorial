ArtSuite = require 'art-suite'
ArtFluxParse = require 'art-flux-parse'
ArtEryFluxModel = require './ArtEryFluxModel'
ArtEryAws = require 'art-ery-aws'
ArtEry = require 'art-ery'

{DynamoDbPipeline} = ArtEryAws
{ValidationFilter, TimestampFilter, UuidFilter} = ArtEry

{createHotWithPostCreate, log, arrayWith} = ArtSuite
{ParsePusherDbModel} = ArtFluxParse

createHotWithPostCreate module, class Chat extends ArtEryFluxModel
  @pipeline new DynamoDbPipeline
    globalIndexes:
      chatsByChatRoom: "chatRoom/createdAt"

    queries:
      chatsByChatRoom:
        query: (chatRoom, pipeline) ->
          pipeline.queryDynamoDb
            index: "chatsByChatRoom"
            where: chatRoom: chatRoom
          .then ({items}) -> items
        queryKeyFromRecord: ({chatRoom}) -> chatRoom
        localSort: (queryData) -> queryData.sort (a, b) -> a.createdAt - b.createdAt

  .filter     new UuidFilter
  .filter     new TimestampFilter
  .filter     new ValidationFilter
    user:     "trimmedString"
    message:  "trimmedString"
    chatRoom: "trimmedString"

  postMessage: (chatRoom, user, message) ->
    @create
      user: user
      message: message
      chatRoom: chatRoom
