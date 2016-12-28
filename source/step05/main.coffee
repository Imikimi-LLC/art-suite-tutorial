ArtSuite = require 'art-suite'

{
  FullScreenApp
  createAndInstantiateTopComponent
  CanvasElement
} = ArtSuite

App = require './app'

FullScreenApp.init().then ->

  createAndInstantiateTopComponent
    render: ->
      CanvasElement App()
