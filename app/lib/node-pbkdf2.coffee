crypto = require 'crypto'

class NodePbkdf2

  constructor: (options = {}) ->
    @iterations       = options.iterations       or 10000
    @saltLength       = options.saltLength       or 12
    @derivedKeyLength = options.derivedKeyLength or 30
    @lengthLimit      = options.lengthLimit      or 4096

  # private functions

  uid = (len) -> crypto.randomBytes(len).toString('base64').slice 0, len

  serializePasswordData = (passwordData) ->
    [passwordData.salt, passwordData.derivedKey, passwordData.derivedKeyLength, passwordData.iterations].join '::'


  deserializePasswordData = (serializedPasswordData) ->
    [salt, derivedKey, derivedKeyLength, iterations] = serializedPasswordData.split '::'

    salt: salt
    derivedKey: derivedKey
    derivedKeyLength: parseInt derivedKeyLength, 10
    iterations: parseInt iterations, 10

  # public functions

  hashPassword: (plaintextPassword, cb) ->
    if plaintextPassword.length >= @lengthLimit then throw new Error 'password is too long'
    randomSalt = uid @saltLength
    crypto.pbkdf2 plaintextPassword, randomSalt, @iterations, @derivedKeyLength, (err, derivedKey) =>
      if err? then return cb err

      cb null, serializePasswordData
        salt: randomSalt
        iterations: @iterations
        derivedKeyLength: @derivedKeyLength
        derivedKey: new Buffer(derivedKey, 'binary').toString 'base64'

  checkPassword: (plaintextPassword, serializedPasswordData, cb) ->
    if plaintextPassword.length >= @lengthLimit then throw new Error 'password is too long'
    {salt, derivedKey, derivedKeyLength, iterations} = deserializePasswordData serializedPasswordData
    if not salt? or not derivedKey? or not iterations? or not derivedKeyLength? then return cb 'serializedPasswordData doesn\'t have the right format'

    # Use the encrypted password's parameter to hash the candidate password
    crypto.pbkdf2 plaintextPassword, salt, iterations, derivedKeyLength, (err, candidateDerivedKey) ->
      if err? then return cb err
      if new Buffer(candidateDerivedKey, 'binary').toString('base64') is derivedKey
        cb null, true
      else
        cb null, false

module.exports = NodePbkdf2
