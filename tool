#!/usr/bin/env coffee
require './register'
require './source/step05/Configs'

(require 'art-suite-app/tool')
  package:     require './package.json'
  load:     -> require './source/step05/Pipelines'
