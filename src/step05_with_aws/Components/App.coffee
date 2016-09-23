ArtSuite = require 'art-suite'
{
  defineModule, createComponentFactory, CanvasElement, RectangleElement, TextElement
  wordArray, randomElement
  log
} = ArtSuite

ChatView = require './ChatView'

defineModule module, createComponentFactory

  render: ->
    log "App CanvasElement"
    CanvasElement
      childrenLayout: "row"
      RectangleElement inFlow: false, color: "#eee"
      ChatView
        chatRoom: "fans"
        currentUser: randomElement wordArray """
        Alice   Bill  Craig Dave  Elliot Frank Greg    Harmony
        Ideth   Julie Kate  Laura Marry  Nate  Oliver  Polly
        Quinn   Rob   Sally Ted   Uncle  Vera  William Xavier
        Yolanda Zack
        """
