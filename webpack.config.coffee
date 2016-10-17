module.exports = (require "art-foundation/configure_webpack")
  entries: """
    step01
    step02
    step03
    step04
    step05
    """
  dirname: __dirname
  package:
    description: "Step by step demo of how to create a realtime chat app using the ArtSuite"
    dependencies:
      "art-suite":      "git://github.com/imikimi/art-suite"
      "art-flux-parse": "git://github.com/imikimi/art-flux-parse"
