ArtSuite = require 'art-suite'
{
  createComponentFactory, CanvasElement, RectangleElement, TextElement
} = ArtSuite

ChatModel = require './chat_model'
ChatView = require './chat_view'

module.exports = createComponentFactory
  module: module

  render: ->
    CanvasElement
      childrenLayout: "row"
      RectangleElement inFlow: false, color: "#eee"
      ChatView currentUser: "Alice"
      ChatView currentUser: "Bill"
