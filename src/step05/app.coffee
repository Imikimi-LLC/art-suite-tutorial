ArtSuite = require 'art-suite'
{
  defineModule, createComponentFactory, Element, RectangleElement, TextElement
  wordArray, randomElement
} = ArtSuite

Config = require './config'
.init()

ChatModel = require './chat_model'
ChatView = require './chat_view'

defineModule module, createComponentFactory

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
