Foundation = require 'art-foundation'
Engine = require 'art-engine'
React = require 'art-react'
Flux = require 'art-flux'

{wordArray, intRand} = Foundation
{FullScreenApp} = Engine

Config = require './config'
.init()

ChatModel = require './chat_model'
ChatView = require './chat_view'

names = wordArray "alice bill craig dave elliot frank greg harmony ideth julie kate laura marry nate oliver polly quinn rob sally ted uncle vera william xavier yolanda zack"
randomName = names[intRand names.length]

{createAndInstantiateTopComponent, Element, RectangleElement, CanvasElement} = React

FullScreenApp.init().then ->
  createAndInstantiateTopComponent
    module: module
    render: ->
      CanvasElement
        canvasId: "artCanvas"
        childrenLayout: "row"
        RectangleElement inFlow: false, color: "#ddd"
        ChatView currentUser: randomName
