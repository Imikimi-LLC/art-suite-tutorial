# generated by Neptune Namespaces v3.x.x
# file: step05/namespace.coffee

module.exports = (require 'neptune-namespaces').addNamespace 'Step05', class Step05 extends Neptune.PackageNamespace
  @version: require('../../package.json').version
require './Components/namespace';
require './Configs/namespace';
require './Pipelines/namespace'