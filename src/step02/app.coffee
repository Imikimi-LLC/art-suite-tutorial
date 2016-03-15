React = require 'art-react'
{createComponentFactory, Element, RectangleElement} = React

ChatView = require './chat_view'

module.exports = createComponentFactory
  module: module

  render: ->
    Element
      childrenLayout: "row"
      RectangleElement inFlow: false, color: "#eee"
      ChatView currentUser: "alice"
      ChatView currentUser: "bill"
