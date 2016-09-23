ArtSuite = require 'art-suite'
{
  defineModule, createComponentFactory, CanvasElement, RectangleElement, TextElement
} = ArtSuite

ChatModel = require './chat_model'
ChatView = require './chat_view'

defineModule module, createComponentFactory
  module: module

  render: ->
    CanvasElement
      childrenLayout: "row"
      RectangleElement inFlow: false, color: "#eee"
      ChatView currentUser: "Alice"
      ChatView currentUser: "Bill"
