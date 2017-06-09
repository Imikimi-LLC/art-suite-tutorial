{
  defineModule
  Element
  RectangleElement
  TextInputElement
  TextElement
  PagingScrollElement

  Component
} = require 'art-suite'

StyleProps = require './StyleProps'
ChatMessage = require './ChatMessage'

defineModule module, class ChatView extends Component

  render: ->
    {currentUser} = @props
    history = [
      {user: "Alice", message: "Hi!"}
      {user: "Bill", message: "Hi, Alice!"}
    ]

    Element
      padding: 10
      childrenLayout: "column"
      RectangleElement inFlow: false, color:"white", shadow: blur: 10, offsetY: 3, color: "#0007"
      Element
        size: ww:1, hch:1
        RectangleElement color: StyleProps.palette.primaryBackground
        TextElement StyleProps.titleText, padding: 10, text: currentUser

      PagingScrollElement
        clip: true
        Element
          padding: 10
          size: hch: 1, ww: 1
          childrenLayout: "column"
          Element inFlow: false, size: 0 # hack ensures first added message animates in
          for postMessage in history || []
            ChatMessage currentUser: currentUser, postMessage

      Element
        size: ww:1, h:45
        RectangleElement color: StyleProps.palette.grayBackground
        TextInputElement StyleProps.mediumText,
          padding: 10
          placeholder: "new message from #{currentUser}"
