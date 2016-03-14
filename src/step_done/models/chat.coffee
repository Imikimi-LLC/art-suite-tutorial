{createHotWithPostCreate, arrayWith} = require 'art-foundation'
{ApplicationState} = require 'art-flux'

createHotWithPostCreate module, class Chat extends ApplicationState
  @stateFields
    history: []

  post: (user, message) ->
    @history = arrayWith @history, user:user, message:message
