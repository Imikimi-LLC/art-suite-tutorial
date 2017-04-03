{
  defineModule, Component, CanvasElement, RectangleElement, TextElement
} = require 'art-suite'

ChatView = require './ChatView'

defineModule module, class App extends Component

  render: ->
    CanvasElement
      childrenLayout: "row"
      RectangleElement inFlow: false, color: "#eee"
      ChatView currentUser: "Alice"
      ChatView currentUser: "Bill"
