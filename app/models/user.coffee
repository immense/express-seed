NodePbkdf2 = require '../lib/node-pbkdf2'
hasher = new NodePbkdf2

mongoose = require '../datasources/mongoose'
{Schema} = mongoose

RoleSchema =
  type: String
  enum: [
    'user'
    'admin'
  ]

UserSchema = new Schema
  username: String
  password: String
  roles:    type: [RoleSchema], default: ['user']

UserSchema.pre 'save', (next) ->
  return next() unless @isModified 'password'

  hasher.hashPassword @password, (err, hashedPassword) =>
    if err? then return next err

    @password = hashedPassword
    next()

UserSchema.methods.validPassword = (password, cb) ->
  hasher.checkPassword password, @password, (err, valid) ->
    if err? then return cb err
    cb null, valid

module.exports = mongoose.model 'User', UserSchema
