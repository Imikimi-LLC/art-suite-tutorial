React = require 'art-react'
{createComponentFactory, Element, RectangleElement} = React

ChatView = require './chat_view'

module.exports = createComponentFactory
  module: module

  render: ->
    Element
      childrenLayout: "row"
      RectangleElement inFlow: false, color: "#ddd"
      ChatView currentUser: "Alice"
      ChatView currentUser: "Bill"
