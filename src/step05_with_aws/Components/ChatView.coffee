ArtSuite = require 'art-suite'

{
  Element
  RectangleElement
  TextInput
  TextElement
  PagingScrollElement

  createFluxComponentFactory
} = ArtSuite

StyleProps = require '../StyleProps'
ChatMessage = require './ChatMessage'

module.exports = createFluxComponentFactory
  module: module
  subscriptions: chatsByChatRoom: ({chatRoom}) -> chatRoom

  postMessage: ({target}) ->
    {currentUser, chatRoom} = @props
    @setState pendingMessage:
      chatRoom: chatRoom
      user: currentUser
      message: target.value

    @models.chat.postMessage chatRoom, currentUser, target.value
    .then -> @setState pendingMessage: null
    .catch (e) ->
      @setState pendingMessage: null
      throw e

    target.value = ""

  render: ->
    {currentUser, chatRoom} = @props
    {chatsByChatRoom} = @state

    Element
      padding: 10
      childrenLayout: "column"
      RectangleElement inFlow: false, color:"white", shadow: blur: 10, offsetY: 3, color: "#0007"
      Element
        size: ww:1, hch:1
        childrenLayout: "row"
        RectangleElement inFlow: false, color: StyleProps.palette.primaryBackground
        TextElement StyleProps.titleText, padding: 10, text: currentUser
        Element()
        TextElement StyleProps.titleText, padding: 10, text: "room: " + chatRoom

      PagingScrollElement
        clip: true
        childrenAlignment: "bottomLeft"
        Element
          padding: 10
          size: hch: 1, ww: 1
          childrenLayout: "column"
          Element inFlow: false, size: 0 # hack ensures first added message animates in
          for postMessage in chatsByChatRoom || []
            ChatMessage currentUser: currentUser, postMessage

      Element
        size: ww:1, h:45
        RectangleElement color: StyleProps.palette.grayBackground
        TextInput StyleProps.mediumText,
          on: enter: @postMessage
          padding: 10
          placeholder: "new message from #{currentUser}"
