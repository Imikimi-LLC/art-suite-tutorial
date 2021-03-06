{
  defineModule
  Element
  RectangleElement
  TextInputElement
  TextElement

  Component
} = require 'art-suite'

defineModule module, class ChatView extends Component

  render: ->
    {currentUser} = @props

    Element
      padding: 10
      childrenLayout: "column"

      RectangleElement
        inFlow: false
        color:  "white"
        shadow:
          blur:     10
          offsetY:  3
          color:    "#0007"

      Element
        size: ww: 1, hch: 1
        RectangleElement color: "#00bcd4"
        TextElement
          color:      "white"
          fontFamily: "sans-serif"
          padding:    10
          text:       currentUser

      Element null,
        TextElement
          fontFamily: "sans-serif"
          padding:    10
          opacity:    .25
          text:       "(messages go here)"

      Element
        size: ww: 1, h: 45
        RectangleElement color: "#eee"
        TextInputElement
          fontFamily:   "sans-serif"
          padding:      10
          placeholder:  "new message from #{currentUser}"
