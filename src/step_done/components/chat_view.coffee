Foundation = require 'art-foundation'
React = require 'art-react'
Flux = require 'art-flux'
Atomic = require 'art-atomic'

{log, min} = Foundation
{createComponentFactory, Element, RectangleElement, TextElement, CanvasElement, PagingScrollElement, TextInput} = React
{createFluxComponentFactory} = Flux
{point} = Atomic

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
    color = if currentUsersMessage then StyleProps.palette.lightPrimaryBackground else StyleProps.palette.grayBackground

    line = [
      Element
        size: (ps, cs) -> cs.y
        RectangleElement radius: 40, color:color
        margin: 10
        TextElement StyleProps.mediumText,
          size: hch:1, ww: 1
          padding: 10
          align: "centerCenter"
          text: user.slice(0, 1).toUpperCase(), color: StyleProps.palette.text.white.primary

      Element
        size: hch:1, ww:1
        Element
          size: cs:1, max: ww:1
          if currentUsersMessage
            axis: x:1
            location: xw: 1

          RectangleElement inFlow: false, color: color
          TextElement StyleProps.mediumText,
            padding: 10
            text: message
            size: cs:1, max: ww:1
    ]

    if currentUsersMessage
      line.reverse()

    Element
      margin: 10
      size: ww:1, hch:1
      childrenLayout: "row"
      addedAnimation: from: axis: x: if currentUsersMessage then -1 else 1
      line

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