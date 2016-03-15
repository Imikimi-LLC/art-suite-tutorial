Foundation = require 'art-foundation'
Engine = require 'art-engine'
React = require 'art-react'
Flux = require 'art-flux'

{wordArray, intRand} = Foundation
{FullScreenApp} = Engine
{createComponentFactory, Element, RectangleElement, TextElement, CanvasElement} = React

(require './config').init()
ChatModel = require './chat_model'
ChatView = require './chat_view'

names = wordArray "alice bill craig dave elliot frank greg harmony ideth julie kate laura marry nate oliver polly quinn rob sally ted uncle vera william xavier yolanda zack"
randomName = names[intRand names.length]

App = createComponentFactory
  module: module
  render: ->
    CanvasElement
      canvasId: "artCanvas"
      RectangleElement inFlow: false, color: "#ddd"
      ChatView currentUser: randomName

FullScreenApp.init()
.then -> App.instantiateAsTopComponent()
