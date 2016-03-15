React = require 'art-react'
{createComponentFactory, Element, RectangleElement, TextElement} = React

module.exports = createComponentFactory
  module: module

  render: ->
    Element null,
      RectangleElement color: "white"
      TextElement text: "Hello world!"
