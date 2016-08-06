{log} = require 'art-foundation'
require 'art-aws/AwsMinAppClientSideSdk'
AWS.config.region = 'us-west-2'
AWS.config.endpoint = "http://localhost:8081"
{config} = require 'art-aws'
config.dynamoDb =
  accessKeyId:    'thisIsSomeInvalidKey'
  secretAccessKey:'anEquallyInvalidSecret!'
  region:         'us-east-1'
  endpoint:       'http://localhost:8081'
  maxRetries:     5

