ArtSuite = require 'art-suite'
ArtFluxParse = require 'art-flux-parse'
ArtEryFluxModel = require './ArtEryFluxModel'
ArtEryAws = require 'art-ery-aws'
ArtEry = require 'art-ery'

{DynamoDbPipeline} = ArtEryAws
{ValidationFilter, TimestampFilter, UuidFilter} = ArtEry

{createHotWithPostCreate, log} = ArtSuite
{ParsePusherDbModel} = ArtFluxParse

createHotWithPostCreate module, class Chat extends ArtEryFluxModel
  @pipeline new DynamoDbPipeline
    globalIndexes:
      chatsByChatRoom: "chatRoom/createdAt"

    queries:
      chatsByChatRoom: (chatRoom, pipeline) ->
        log query: chatsByChatRoom:
          chatRoom:chatRoom, pipeline: pipeline
        [
          user: "Bob"
          message: "Hi!"
        ]

  .filter     new UuidFilter
  .filter     new TimestampFilter
  .filter     new ValidationFilter
    user:     "trimmedString"
    message:  "trimmedString"
    chatRoom: "trimmedString"

  postMessage: (user, message) ->
    @create
      user: user
      message: message
      chatRoom: "main"
