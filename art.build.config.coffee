module.exports =
  package:
    description: "Step by step demo of how to create a realtime chat app using the ArtSuite"
    dependencies:
      "art-suite":      "git://github.com/imikimi/art-suite"
      "art-flux-parse": "git://github.com/imikimi/art-flux-parse"
      "caffeine-script":          ">=0.35.0"
      "caffeine-script-runtime":  ">=0.32.7"

  webpack:
    common:
      resolve: extensions: [".caf", ".caffeine"]
      module: rules: [test: /\.caf(feine)?$/, loader: "caffeine-mc/webpack-loader"]
    targets:
      step01: {}
      step02: {}
      step03: {}
      step04: {}
      step05: {}
