ArtSuite = require 'art-suite'
{
  createComponentFactory, Element, RectangleElement, TextElement
  wordArray, randomElement
} = ArtSuite

ChatView = require './ChatView'

module.exports = createComponentFactory
  module: module

  render: ->
    Element
      childrenLayout: "row"
      RectangleElement inFlow: false, color: "#eee"
      ChatView currentUser: randomElement wordArray """
        Alice   Bill  Craig Dave  Elliot Frank Greg    Harmony
        Ideth   Julie Kate  Laura Marry  Nate  Oliver  Polly
        Quinn   Rob   Sally Ted   Uncle  Vera  William Xavier
        Yolanda Zack
        """
