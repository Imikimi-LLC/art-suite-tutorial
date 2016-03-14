{FullScreenApp} = require 'art-engine'
React = require 'art-react'

Models = require './models'
Components = require './components'

{createComponentFactory, Element, RectangleElement, TextElement, CanvasElement} = React
{ChatView} = Components

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
