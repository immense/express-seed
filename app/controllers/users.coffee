{can} = require 'connect-roles'

passport = require '../lib/passport'
User = require "../models/user"

module.exports = (app) ->

  app.get '/users/login', (req, res) ->
    if req.user.isAuthenticated
      res.redirect '/users/secret'
    else
      res.render 'users/login'

  app.post '/users/login', passport.authenticate 'local', successRedirect: '/users/secret', failureRedirect: '/users/login'

  app.get '/users/logout', (req, res) ->
    req.logout()
    res.redirect '/'

  app.get '/users/secret', can('view secret'), (req, res) ->
    res.render 'users/secret'

  app.get '/users/admin-secret', can('view admin secret'), (req, res) ->
    res.render 'users/admin-secret'
