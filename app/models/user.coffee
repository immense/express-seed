crypto = require 'crypto'

mongoose = require '../datasources/mongoose'
{Schema} = mongoose

UserSchema = new Schema
  username: String
  password: String

UserSchema.methods.validPassword = (password, cb) ->
  valid = @password is crypto.createHash('sha256').update(password).digest('hex')
  cb null, valid

module.exports = mongoose.model 'User', UserSchema