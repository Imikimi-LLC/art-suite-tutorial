Foundation = require 'art-foundation'
React = require 'art-react'
{createComponentFactory, Element, RectangleElement} = React

{wordArray, randomElement} = Foundation

Config = require './config'
.init()

ChatModel = require './chat_model'
ChatView = require './chat_view'

module.exports = createComponentFactory
  module: module

  render: ->
    Element
      childrenLayout: "row"
      RectangleElement inFlow: false, color: "#ddd"
      ChatView currentUser: randomElement wordArray """
        Alice   Bill  Craig Dave  Elliot Frank Greg    Harmony
        Ideth   Julie Kate  Laura Marry  Nate  Oliver  Polly
        Quinn   Rob   Sally Ted   Uncle  Vera  William Xavier
        Yolanda Zack
        """
