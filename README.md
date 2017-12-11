# art-suite-tutorial
ArtSuite (ArtEngine + ArtReact + ArtFlux) tutorial

This tutorial shows how to make a realtime chat app in 5 easy steps.

* Try now: [step04 - local-data chat](http://imikimi.github.io/art-suite-tutorial/step04)

### Install and Run

```
git clone https://github.com/imikimi/art-suite-tutorial/
cd art-suite-tutorial
npm install
./node_modules/.bin/webpack-dev-server
```

Then go to: [http://localhost:8080/webpack-dev-server/](http://localhost:8080/webpack-dev-server/)

To run Step 5, you also need to start a local DynamoDb server. Open up another terminal window:

```
cd art-suite-tutorial
./node_modules/art-aws/start_dynamo_db_local_server.coffee
```

### In 5 Steps

Steps 1-3 lay the foundations and are all non-interactive. Step 4 adds real interactivity, and Step 5 adds a real back-end database.

#### step01: Hello world! [(run)](http://imikimi.github.io/art-suite-tutorial/step01)

```coffeescript
# step01/Main.caf
&ArtSuiteApp.initArtSuiteClient
  MainComponent: &App
  title:         :Chat-App

# step01/App.caf
import &ArtSuite

class App extends Component

  render: ->
    CanvasElement
      draw: #eee

      TextElement
        padding:  10
        fontSize: 25
        text:     "" Hello world!
```

#### Step 2: ArtEngine and ArtReact UI Basics &amp; Hot Loading (+ChatView) [(run)](http://imikimi.github.io/art-suite-tutorial/step02)

Step 2 jumps right in and builds out a large chunk of the UI, and yet, it doesn't require much code. The entirety of changes from Step 1 are listed below.

```coffeescript
# step02/Main.caf - no change
# step02/App.caf
import &ArtSuite

class App extends Component

  render: ->
    CanvasElement
      draw: #eee

      Element
        childrenLayout: :row
        childrenMargins: 10
        padding: 10

        &ChatView currentUser: :Alice
        &ChatView currentUser: :Bill

# step02/ChatView.caf
import &ArtSuite

class ChatView extends Component

  render: ->
    {currentUser} = @props

    Element
      childrenLayout:     :column

      draw:
        color:            :white
        shadow:
          blur:           10
          offset:         y: 3
          color:          #0007

      Element
        size:             hch: 1
        draw:             #00bcd4
        TextElement
          color:          :white
          fontFamily:     :sans-serif
          padding:        10
          text:           currentUser

      TextElement
        size:             hh: 1
        fontFamily:       :sans-serif
        padding:          10
        opacity:          .25
        text:             "" (messages go here)

      Element
        size:             h: 45
        draw:             #eee
        TextInputElement
          fontFamily:     :sans-serif
          padding:        10
          placeholder:    "" new message from #{currentUser}


```

#### Step 3: Styles (+ChatMessage +StyleProps) [(run)](http://imikimi.github.io/art-suite-tutorial/step03)

Step 3 adds the `ChatMessage` view and shows how you can do styles. Here is a partial listing:

```coffeescript
# step03/Main.caf - no change
# step03/App.caf - no change
# step03/Palette.caf
import &ArtSuite

class Palette extends HotStyleProps
  @primaryBackground:      #00bcd4
  @lightPrimaryBackground: #c7ebf0
  @grayBackground:         #eee

  @white: primary: #fffe
  @black: primary: #000e   secondary: #0007

# step03/StyleProps.caf
import &ArtSuite

class StyleProps extends HotStyleProps

  @titleText:
    color:      &Palette.white.primary
    fontFamily: :sans-serif
    fontSize:   16

  @mediumText:
    color:      &Palette.black.primary
    fontFamily: :sans-serif
    fontSize:   16

  @smallText:
    color:      &Palette.black.primary
    fontFamily: :sans-serif
    fontSize:   12

  @chatViewBackground:
    color:      :white
    shadow:
      blur:     10
      offsetY:  3
      color:    #0007

# step03/ChatMessage.caf
import &ArtSuite, &StyleProps

class ChatMessage extends Component

  render: ->
    {currentUser, user, message} = @props

    currentUsersMessage = user == currentUser

    Element
      margin:           10
      size:             hch: 1
      childrenLayout:   :row
      animators:
        size: toFrom:   h: 0
        axis: toFrom:   x: if currentUsersMessage then -1 else 1

      Element
        size:               hch: 1
        childrenLayout:     :column
        childrenMargins:    5
        childrenAlignment:  if currentUsersMessage then :right else :left

        Element
          size: cs: 1   max: ww: 1
          if currentUsersMessage
            axis:     x:  1
            location: xw: 1

          draw:
            if currentUsersMessage
              &Palette.lightPrimaryBackground
            else
              &Palette.grayBackground

          TextElement
            mediumText
            padding:  10
            text:     message
            size:     cs: 1   max: ww:1

        TextElement
          smallText
          text:   user
          color:  &Palette.black.secondary

# step03/ChatView.caf
import &ArtSuite

class ChatView extends Component

  history:
    # Some fake history
    {} user: :Alice   message: "" Hi!
    {} user: :Bill    message: "" Hi, Alice!
    {} user: :Alice   message: "" How have you been?

  render: ->
    Element
      childrenLayout: :column
      draw: &StyleProps.chatViewBackground

      Element
        size: hch:1
        draw: &Palette.primaryBackground

        TextElement
          &StyleProps.titleText
          padding:  10
          text:     @props.currentUser

      ScrollElement
        clip: true

        Element
          padding:        10
          size:           hch: 1
          childrenLayout: :column

          array postMessage from @history
            &ChatMessage
              postMessage
              {} @props.currentUser

      Element
        size: h: 45
        draw: &Palette.grayBackground

        TextInputElement
          &StyleProps.mediumText
          padding:      10
          placeholder:  "" new message from #{@props.currentUser}
```

#### Step 4: ArtFlux with local data (+ChatModel) [(run)](http://imikimi.github.io/art-suite-tutorial/step04)

Step 4 adds a local FluxModel for storing state. Finally the chat actually works! Alice and Bill can post messages to each other. Here is all the gist of the new code:

```coffeescript
# step04/Main.caf - no change
# step04/App.caf - no change
# step04/Palette.caf - no change
# step04/ChatMessage.caf - no change

# step04/ChatModel.caf
import &ArtSuite

class Chat extends ApplicationState

  @stateFields
    history: []

  postMessage: (user, message) ->
    @history = arrayWith @history, {} user, message

# step04/ChatView.caf
import &ArtSuite

class ChatView extends FluxComponent
  # NEW in Step 4
  @subscriptions :chat.history

  # NEW in Step 4
  postMessage: ({target}) ->
    @models.chat.postMessage @props.currentUser, target.value
    target.value = ""

  render: ->
    Element
      childrenLayout: :column
      draw: &StyleProps.chatViewBackground

      Element
        size: hch:1
        draw: &Palette.primaryBackground

        TextElement
          &StyleProps.titleText
          padding: 10
          text: @props.currentUser

      ScrollElement
        clip: true

        Element
          padding:        10
          size:           hch: 1
          childrenLayout: :column

          array postMessage from @history
            &ChatMessage
              postMessage
              {} @props.currentUser

      Element
        size: h: 45
        draw: &Palette.grayBackground

        TextInputElement
          &StyleProps.mediumText
          on: enter: @postMessage # NEW in Step 4
          padding: 10
          placeholder: "" new message from #{@props.currentUser}

```

#### Step 5: ArtFlux with remote Data on DynamoDb
Step 5 introduces remote data. It uses DynamoDb as an example. To run, follow the Install instructions above.

### Learn More

See the [Art Suite Wiki](https://github.com/imikimi/art-suite/wiki)
