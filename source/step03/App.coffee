ArtSuite = require 'art-suite'
{
  defineModule, createComponentFactory, CanvasElement, RectangleElement, TextElement
} = ArtSuite

ChatView = require './chat_view'

defineModule module, createComponentFactory

  render: ->
    CanvasElement
      childrenLayout: "row"
      RectangleElement inFlow: false, color: "#eee"
      ChatView currentUser: "Alice"
      ChatView currentUser: "Bill"
