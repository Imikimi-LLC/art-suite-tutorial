ArtSuite = require 'art-suite'
{
  createComponentFactory, Element, RectangleElement, TextElement
} = ArtSuite

module.exports = createComponentFactory
  module: module

  render: ->
    Element null,
      RectangleElement color: "white"
      TextElement text: "Hello world!"
