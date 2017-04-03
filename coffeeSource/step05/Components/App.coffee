{
  defineModule, Component, CanvasElement, RectangleElement, TextElement
  w, randomElement
  log
} = require 'art-suite'

ChatView = require './ChatView'

defineModule module, class App extends Component

  render: ->
    CanvasElement
      childrenLayout: "row"
      RectangleElement inFlow: false, color: "#eee"

      ChatView
        chatRoom: "fans"
        currentUser: randomElement w """
          Alice   Bill  Craig Dave  Elliot Frank Greg    Harmony
          Ideth   Julie Kate  Laura Marry  Nate  Oliver  Polly
          Quinn   Rob   Sally Ted   Uncle  Vera  William Xavier
          Yolanda Zack
          """
