{FullScreenApp} = require 'art-engine'
React = require 'art-react'

{createComponentFactory, Element, RectangleElement, TextElement, CanvasElement} = React

App = createComponentFactory
  render: ->
    CanvasElement
      canvasId: "artCanvas"
      RectangleElement color: "white"
      TextElement
        padding: 10
        text: "Hello world!"

FullScreenApp.init()
.then -> App.instantiateAsTopComponent()
