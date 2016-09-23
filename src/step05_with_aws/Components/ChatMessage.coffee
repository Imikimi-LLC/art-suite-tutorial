ArtSuite = require 'art-suite'
StyleProps = require '../StyleProps'

{
  defineModule, createComponentFactory, Element, RectangleElement, TextElement,
  TextInput
  OutlineElement, FillElement
  log
} = ArtSuite

defineModule module, createComponentFactory
  module: module

  mouseIn: -> @setState mouseIn: true
  mouseOut: -> @setState mouseIn: false

  pointerDown: -> @setState pointerDown: true
  pointerUp:   -> @setState pointerDown: false
  pointerUpInside: ->
    log pointerUpInside: @props
    @props.showEditDialog? chatId: @props.id

  render: ->
    {currentUser, user, message, user} = @props
    {mouseIn, pointerDown} = @state
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
          on:
            mouseIn: @mouseIn
            mouseOut: @mouseOut
            pointerDown:  @pointerDown
            pointerUp:    @pointerUp
            pointerIn:    @pointerDown
            pointerOut:   @pointerUp
            pointerUpInside: @pointerUpInside
          cursor: "pointer"
          if currentUsersMessage
            axis: x:1
            location: xw: 1

          RectangleElement
            inFlow: false
            radius: 2
            shadow: mouseIn && !pointerDown
            animators: shadow: duration: .1

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
