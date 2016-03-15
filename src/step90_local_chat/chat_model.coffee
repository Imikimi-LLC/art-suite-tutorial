{createHotWithPostCreate, arrayWith, log} = require 'art-foundation'
{ApplicationState, models} = require 'art-flux'

createHotWithPostCreate module, class Chat extends ApplicationState
  @stateFields
    history: []

  postMessage: (user, message) ->
    @history = arrayWith @history, user:user, message:message
