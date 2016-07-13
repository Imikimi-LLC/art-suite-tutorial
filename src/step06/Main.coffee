ArtSuite = require 'art-suite'

{
  FullScreenApp
  createAndInstantiateTopComponent
  CanvasElement
} = ArtSuite

App = require './App'

FullScreenApp.init().then ->

  createAndInstantiateTopComponent
    render: ->
      CanvasElement App()
