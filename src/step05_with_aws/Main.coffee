ArtSuite = require 'art-suite'

{
  FullScreenApp
  createAndInstantiateTopComponent
  CanvasElement
} = ArtSuite

{App} = require './Components'

FullScreenApp.init().then ->

  createAndInstantiateTopComponent
    render: ->
      CanvasElement App()
