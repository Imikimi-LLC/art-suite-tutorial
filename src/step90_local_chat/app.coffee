{FullScreenApp} = require 'art-engine'
React = require 'art-react'
Flux = require 'art-flux'

ChatModel = require './chat_model'
ChatView = require './chat_view'

{createAndInstantiateTopComponent, Element, RectangleElement, CanvasElement} = React

FullScreenApp.init().then ->
  createAndInstantiateTopComponent
    module: module
    render: ->
      CanvasElement
        canvasId: "artCanvas"
        childrenLayout: "row"
        RectangleElement inFlow: false, color: "#ddd"
        ChatView currentUser: "alice"
        ChatView currentUser: "bill"
