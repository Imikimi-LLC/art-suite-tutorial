ArtSuite = require 'art-suite'
{
  defineModule, createComponentFactory, CanvasElement, RectangleElement, TextElement
} = ArtSuite

defineModule module, createComponentFactory
  module: module

  render: ->
    CanvasElement null,
      RectangleElement color: "white"
      TextElement text: "Hello world!"
