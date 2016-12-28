require 'art-aws/AwsMinAppClientSideSdk'

(require 'art-aws').config.dynamoDb =
  accessKeyId:    	'thisIsSomeInvalidKey'
  secretAccessKey:	'anEquallyInvalidSecret!'
  region:         	'us-east-1'
  endpoint:       	'http://localhost:8081'
  maxRetries:     	5

