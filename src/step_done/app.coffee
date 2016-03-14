{FullScreenApp} = require 'art-engine'
React = require 'art-react'

require './chat_model'
ChatView = require './chat_view'

{createComponentFactory, Element, RectangleElement, TextElement, CanvasElement} = React

App = createComponentFactory
  module: module
  render: ->
    CanvasElement
      canvasId: "artCanvas"
      childrenLayout: "row"
      RectangleElement inFlow: false, color: "#ddd"
      ChatView currentUser: "alice"
      ChatView currentUser: "bill"

FullScreenApp.init()
.then -> App.instantiateAsTopComponent()
