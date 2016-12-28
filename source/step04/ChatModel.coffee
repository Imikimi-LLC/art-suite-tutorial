ArtSuite = require 'art-suite'
{createWithPostCreate, arrayWith, log, ApplicationState, models} = ArtSuite

createWithPostCreate module, class Chat extends ApplicationState
  @stateFields
    history: []

  postMessage: (user, message) ->
    @history = arrayWith @history, user:user, message:message
