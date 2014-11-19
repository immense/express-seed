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

UserSchema.virtual('name').get -> @username

UserSchema.methods.validPassword = (password, cb) ->
  hasher.checkPassword password, @password, (err, valid) ->
    if err? then return cb err
    cb null, valid

UserSchema.statics.isUsernameAvailable = (username, cb) ->
  @findOne().where('username').equals(username).exec (err, user) ->
    if err? then return cb err
    cb null, not user?

# map nulls on the object to undefineds in the db, don't updated undefineds on the object
UserSchema.methods.applyUpdates = (user, cb) ->
  self = @
  for col of @schema.paths
    unless 'undefined' is typeof user[col]
      if user[col] is null
        self[col] = undefined
      else
        self[col] = user[col] or null
  @save (err, newUser) ->
    if err then return cb err
    cb null, newUser

module.exports = mongoose.model 'User', UserSchema
