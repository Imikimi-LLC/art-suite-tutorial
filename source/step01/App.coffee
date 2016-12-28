{
  defineModule
  createComponentFactory
  CanvasElement
  RectangleElement
  TextElement
} = require 'art-suite'

defineModule module, createComponentFactory

  render: ->
    CanvasElement null,
      RectangleElement color: "white"
      TextElement text: "Hello world!"
