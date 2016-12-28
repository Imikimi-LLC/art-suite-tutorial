{defineModule, log, Config, mergeInto, deepMerge} = require 'art-foundation'

defineModule module, class Development extends Config
  Art:
    Aws:
      credentials:
        accessKeyId:      'blah'
        secretAccessKey:  'blahblah'

      region:             'us-east-1'

      dynamoDb:
        endpoint:         'http://localhost:8081'

    Ery: tableNamePrefix: "chat-dev."
