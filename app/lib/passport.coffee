module.exports = passport = require 'passport'
LocalStrategy = require('passport-local').Strategy

User = require '../models/user'

passport.use new LocalStrategy (username, password, done) ->
  User.findOne().where('username').equals(username).exec (err, user) ->
    if err? then return done err
    if not user? then return done null, false
    user.validPassword password, (err, valid) ->
      if err? then return done err
      done null, if valid then user else false

passport.serializeUser (user, done) -> done null, user.id
passport.deserializeUser (userId, done) ->
  User.findById(userId).select('-password').exec (err, user) ->
    if err? then return done err
    done null, user
