ArtSuite = require 'art-suite'
{
  createComponentFactory, Element, RectangleElement, TextElement
} = ArtSuite

ChatView = require './chat_view'

module.exports = createComponentFactory
  module: module

  render: ->
    Element
      childrenLayout: "row"
      RectangleElement inFlow: false, color: "#eee"
      ChatView currentUser: "Alice"
      ChatView currentUser: "Bill"
