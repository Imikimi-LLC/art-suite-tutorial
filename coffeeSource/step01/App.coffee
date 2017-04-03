{
  defineModule
  Component
  CanvasElement
  RectangleElement
  TextElement
} = require 'art-suite'

defineModule module, class App extends Component

  render: ->
    CanvasElement null,
      RectangleElement color: "white"
      TextElement text: "Hello world!"
