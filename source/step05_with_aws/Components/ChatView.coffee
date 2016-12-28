ArtSuite = require 'art-suite'

{
  Element
  RectangleElement
  TextInput
  TextElement
  PagingScrollElement
  arrayWith
  createFluxComponentFactory
  log
  defineModule
} = ArtSuite

StyleProps = require '../StyleProps'
ChatMessage = require './ChatMessage'

defineModule module, ->

  Dialog = createFluxComponentFactory

    render: ->
      {size, axis, location, children, title, message} = @props
      Element
        size: size || ps: 1
        location: location

        axis: axis
        padding: 10
        childrenLayout: "column"
        RectangleElement inFlow: false, color:"white", shadow: blur: 10, offsetY: 3, color: "#0007"
        Element
          size: ww:1, hch:1
          childrenLayout: "row"
          RectangleElement inFlow: false, color: StyleProps.palette.primaryBackground
          TextElement StyleProps.titleText, padding: 10, text: title
          Element()
          message && TextElement StyleProps.titleText, padding: 10, text: message

        children

  EditDialog = createFluxComponentFactory
    subscriptions: "chat"

    updateMessage: ({target}) ->
      {chatId} = @props
      @models.chat.update chatId, message: target.value
      @props.hideEditDialog?()

    render: ->
      {chat} = @state
      Dialog
        title: "edit message"
        size: w: 300, hch: 1
        axis: .5
        location: ps: .5
        Element
          size: ww:1, h:45
          RectangleElement color: StyleProps.palette.grayBackground
          chat && TextInput StyleProps.mediumText,
            on: enter: @updateMessage
            padding: 10
            value: chat.message
            placeholder: "edit here"

  createFluxComponentFactory
    subscriptions: chatsByChatRoom: ({chatRoom}) -> chatRoom

    postMessage: ({target}) ->
      {currentUser, chatRoom} = @props

      @models.chat.create
        chatRoom: chatRoom
        user: currentUser
        message: target.value

      target.value = ""

    showEditDialog: (props) ->
      @setState editDialogProps: props

    hideEditDialog: -> @setState editDialogProps: null

    render: ->
      {currentUser, chatRoom} = @props
      {chatsByChatRoom, pendingMessage, editDialogProps} = @state

      Dialog
        title: currentUser
        message: "room: #{chatRoom}"

        PagingScrollElement
          clip: true
          childrenAlignment: "bottomLeft"
          chatsByChatRoom && Element
            padding: 10
            size: hch: 1, ww: 1
            childrenLayout: "column"
            Element inFlow: false, size: 0 # hack ensures first added message animates in
            for postMessage in chatsByChatRoom
              ChatMessage currentUser: currentUser, showEditDialog: @showEditDialog, postMessage

        Element
          size: ww:1, h:45
          RectangleElement color: StyleProps.palette.grayBackground
          TextInput StyleProps.mediumText,
            on: enter: @postMessage
            padding: 10
            placeholder: "new message from #{currentUser}"

        editDialogProps && Element
          on: pointerClick: @hideEditDialog
          animators:
            opacity: toFromVoid: 0
            location: toFromVoid: y: 10
          inFlow: false
          EditDialog hideEditDialog: @hideEditDialog, editDialogProps
