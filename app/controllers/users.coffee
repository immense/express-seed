passport = require '../lib/passport'
User = require "../models/user"

checkAuth = (req, res, next) ->
  if req.user?
    next()
  else
    res.status 403
    res.render 'errors/403'

module.exports = (app) ->

  app.get '/users/login', (req, res) ->
    if req.user?
      res.redirect '/users/secret'
    else
      res.render 'users/login'

  app.post '/users/login', passport.authenticate 'local', successRedirect: '/users/secret', failureRedirect: '/users/login'

  app.get '/users/logout', checkAuth, (req, res) ->
    req.logout()
    res.redirect '/users/login'

  app.get '/users/secret', checkAuth, (req, res) ->
    res.render 'users/secret'
