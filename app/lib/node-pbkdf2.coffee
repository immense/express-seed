crypto = require 'crypto'

class NodePbkdf2

  constructor: (options) ->
    options = options or {}
    @iterations = options.iterations or 10000
    @saltLength = options.saltLength or 12
    @derivedKeyLength = options.derivedKeyLength or 30

  # private functions

  uid = (len) -> crypto.randomBytes(len).toString('base64').slice 0, len

  serializeHashedPassword = (encryptedPassword) ->
    [encryptedPassword.salt, encryptedPassword.derivedKey, encryptedPassword.derivedKeyLength, encryptedPassword.iterations].join '::'


  deserializeHashedPassword = (encryptedPassword) ->
    [salt, derivedKey, derivedKeyLength, iterations] = encryptedPassword.split '::'

    salt: salt
    derivedKey: derivedKey
    derivedKeyLength: parseInt derivedKeyLength, 10
    iterations: parseInt iterations, 10

  # public functions

  hashPassword: (password, cb) ->
    randomSalt = uid @saltLength
    crypto.pbkdf2 password, randomSalt, @iterations, @derivedKeyLength, (err, derivedKey) =>
      if err? then return cb err

      cb null, serializeHashedPassword
        salt: randomSalt
        iterations: @iterations
        derivedKeyLength: @derivedKeyLength
        derivedKey: new Buffer(derivedKey, 'binary').toString 'base64'

  checkPassword: (candidatePassword, encryptedPassword, cb) ->
    {salt, derivedKey, derivedKeyLength, iterations} = deserializeHashedPassword encryptedPassword
    if not salt? or not derivedKey? or not iterations? or not derivedKeyLength? then return cb 'encryptedPassword doesn\'t have the right format'

    # Use the encrypted password's parameter to hash the candidate password
    crypto.pbkdf2 candidatePassword, salt, iterations, derivedKeyLength, (err, candidateDerivedKey) ->
      if err? then return cb err
      if new Buffer(candidateDerivedKey, 'binary').toString('base64') is derivedKey
        cb null, true
      else
        cb null, false

module.exports = NodePbkdf2