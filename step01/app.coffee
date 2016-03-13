Engine = require 'art-engine'
React = require 'art-react'

{createAndInstantiateTopComponent, RectangleElement, TextElement, CanvasElement} = React

Engine.FullScreenApp.init().then ->
  createAndInstantiateTopComponent

    render: ->
      CanvasElement
        canvasId: "artCanvas"

        RectangleElement color: "white"

        TextElement text: "Hello world!"
