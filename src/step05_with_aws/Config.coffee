Parse = require 'parse'
Pusher = require '../../extlib/pusher'

module.exports = class Config

  @parse:
    appId:          "6NIEik4g7bbjwcKq6wq87P7VtAJkcyLJ0dNVjsWN"
    clientKey:      "fX4hCSWhFlp2xXX8NTVykXzPVfuczbDHvQyn12zy"
    javascriptKey:  "DsGwJQjsVgHXkqroaskrF0kuKmaaiaH84y8QEPZK"

  @pusher:
    key: "1454aa9845ff6471f86c"

  @init: ->
    Parse.initialize @parse.appId, @parse.javascriptKey

    self.pusher = new Pusher @pusher.key, encrypted: true
