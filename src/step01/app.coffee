ArtSuite = require 'art-suite'
{
  createComponentFactory, CanvasElement, RectangleElement, TextElement
} = ArtSuite

module.exports = createComponentFactory
  module: module

  render: ->
    CanvasElement null,
      RectangleElement color: "white"
      TextElement text: "Hello world!"
