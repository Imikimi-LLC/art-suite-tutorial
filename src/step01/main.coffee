Engine = require 'art-engine'
React = require 'art-react'
App = require './app'

Engine.FullScreenApp.init().then ->

  React.createAndInstantiateTopComponent
    render: ->
      React.CanvasElement
        canvasId: "artCanvas"
        App()
