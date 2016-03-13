Foundation = require 'art-foundation'
React = require 'art-react'
Flux = require 'art-flux'
Atomic = require 'art-atomic'

{log} = Foundation
{createComponentFactory, Element, RectangleElement, TextElement, CanvasElement, PagingScrollElement, TextInput} = React
{createFluxComponentFactory} = Flux

{merge} = Foundation
class StyleProps

  @palette:
    primaryBackground: "#00bcd4"
    lightPrimaryBackground: "#c7ebf0"
    grayBackground:    "#eee"
    text:
      white:
        primary: "#fffe"
      black:
        primary: "#000e"

  @mediumText:
    color: @palette.text.black.primary
    fontFamily: "sans-serif"
    fontSize: 16

  @titleText: merge @mediumText,
    color: @palette.text.white.primary

Message = createFluxComponentFactory
  module: module
  render: ->
    {currentUser, user, message} = @props
    {user} = @props
    currentUsersMessage = user == currentUser
    Element
      margin: 10
      size: ww:1, hch:1
      addedAnimation: from: axis: if currentUsersMessage then x:-1 else x: 1
      padding: if currentUsersMessage then left: 30 else right: 30
      RectangleElement color: if currentUsersMessage then StyleProps.palette.lightPrimaryBackground else StyleProps.palette.grayBackground
      TextElement StyleProps.mediumText,
        padding: 10
        text: message
        size: ww:1, hch:1

module.exports = createFluxComponentFactory
  module: module
  subscriptions: "chat.history"

  post: ({target}) ->
    {currentUser} = @props
    @models.chat.post currentUser, target.value
    target.value = ""

  render: ->
    {currentUser} = @props
    {history} = @state
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
          for post in history
            Message currentUser: currentUser, post

      Element
        size: ww:1, h:45
        RectangleElement color: StyleProps.palette.grayBackground
        TextInput StyleProps.mediumText,
          on: enter: @post
          padding: 10
          placeholder: "new message from #{currentUser}"
