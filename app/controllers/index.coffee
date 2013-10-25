{can} = require 'connect-roles'

User = require '../models/user'

module.exports = (app) ->

  app.get '/', (req, res) ->
    User.count (err, count) ->
      if err? then return next err
      res.locals.users_count = count
      res.render 'index'

  app.get '/errors', (req, res, next) ->
    res.render 'errors'

  app.get '/401', can('do anything'), (req, res, next) ->
    res.send 'You are logged in so I can\'t show you the error.'

  app.get '/403', can('do this'), (req, res, next) ->
    res.send 'You are logged in as admin so I can\'t show you the error.'

  app.get '/500', (req, res, next) ->
    next new Error 'A wild error appears!'
