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

  .filter   new TimestampFilter
  .filter   new ValidationFilter
    user:     "requiredTrimmedString"
    message:  "requiredTrimmedString"
    chatRoom: "requiredTrimmedString"

  @query
    # TODO: thinking again I want to have standard support for non-string keys (consistentJsonStringify)
    # I also want a standard fromFluxKey
    # I figure every model will only use string or non-string keys.
    # What if our standard toFluxKey notes on the model when it sees the first non-string-key, which
    # causes fromFluxKey to start using JSON.parse to do its work.
    chatsByChatRoom: (key) ->
      [
        user: "Bob"
        message: "Hi!"
      ]

  # postMessage: (user, message) ->
  #   @post
  #     user: user
  #     message: message
  #     chatRoom: "main"
