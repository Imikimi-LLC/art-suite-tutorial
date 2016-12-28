{defineModule, arrayWith, log, ApplicationState, models} = require 'art-suite'

defineModule module, class Chat extends ApplicationState
  @stateFields
    history: []

  postMessage: (user, message) ->
    @history = arrayWith @history, user:user, message:message
