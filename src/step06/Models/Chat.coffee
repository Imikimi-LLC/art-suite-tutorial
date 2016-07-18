ArtSuite = require 'art-suite'
ArtFluxParse = require 'art-flux-parse'
ArtEryFluxModel = require './ArtEryFluxModel'
ArtEryAws = require 'art-ery-aws'
ArtEry = require 'art-ery'

{DynamoDbPipeline} = ArtEryAws
{ValidationFilter, TimestampFilter} = ArtEry

{createHotWithPostCreate, log} = ArtSuite
{ParsePusherDbModel} = ArtFluxParse

createHotWithPostCreate module, class Chat extends ArtEryFluxModel
  @pipeline new DynamoDbPipeline
    key: "chatRoom/createdAt"
    queries:
      chatsByChatRoom: (key) ->
        [
          user: "Bob"
          message: "Hi!"
        ]

  .filter   new TimestampFilter
  .filter   new ValidationFilter
    user:     "requiredTrimmedString"
    message:  "requiredTrimmedString"
    chatRoom: "requiredTrimmedString"

  # postMessage: (user, message) ->
  #   @post
  #     user: user
  #     message: message
  #     chatRoom: "main"
