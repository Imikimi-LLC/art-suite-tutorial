ArtSuite = require 'art-suite'
StyleProps = require '../StyleProps'

{
  createComponentFactory, Element, RectangleElement, TextElement,
  TextInput
} = ArtSuite

module.exports = createComponentFactory
  module: module

  render: ->
    {currentUser, user, message} = @props
    {user} = @props
    currentUsersMessage = user == currentUser

    Element
      margin: 10
      size: ww:1, hch:1
      childrenLayout: "row"
      animators:
        size: toFromVoid: ww:1, h: 0
        axis: toFromVoid: x: if currentUsersMessage then -1 else 1
      Element
        size: hch:1, ww:1
        childrenLayout: "column"
        childrenAlignment: if currentUsersMessage then "right" else "left"

        Element
          size: cs:1, max: ww:1
          if currentUsersMessage
            axis: x:1
            location: xw: 1

          RectangleElement
            inFlow: false
            color: if currentUsersMessage
                StyleProps.palette.lightPrimaryBackground
              else
                StyleProps.palette.grayBackground

          TextElement StyleProps.mediumText,
            padding: 10
            text: message
            size: cs:1, max: ww:1

        TextElement StyleProps.smallText,
          text: user
          margin: 5
          color: StyleProps.palette.text.black.secondary
