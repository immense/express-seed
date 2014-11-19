rootdir  = "#{process.cwd()}"
appdir   = "#{rootdir}/app"
app      = require './app'
user     = require './lib/roles'
passport = require './lib/passport'
log4js   = require "#{appdir}/lib/logger"
logger   = log4js.getLogger 'server'

# API Routes

users_api   = require "#{appdir}/controllers/api/users"

## Users
app.get '/api/users',                           users_api.listUsers...
app.get '/api/users/:id',                       users_api.showUser...
app.post '/api/users/create_user',              users_api.createUser...
app.patch '/api/users/:id/update_user',         users_api.updateUser...
app.delete '/api/users/:id/delete_user',        users_api.deleteUser...

# View Routes
index = require './controllers/index'
users = require './controllers/users'

app.get '*', (req, res, next) ->
  res.locals.server_messages = if req.isAuthenticated()
    if (name = req.user.name) and name isnt ''
      {info: "Welcome, #{name}"}
    else
      {info: "Welcome, #{req.user.username}"}
  else
    {warning: "You must log in to continue"}
  next()

## Auth
app.get  '/login', users.login
app.post '/login', passport.authenticate 'local', successRedirect: '/users/secret', failureRedirect: '/login'
app.post '/logout', users.logout

# Index

app.get '/', index.main
app.get '/errors', index.errors
app.get '/401', user.can('view secret'), index.unauthorized
app.get '/403', user.can('do this'), index.forbidden
app.get '/500', index.serverError
app.get '/502', index.badGateway

## Users
app.get '/users',               users.list...
app.get  '/users/secret',       users.secret...
app.get  '/users/admin-secret', users.adminSecret...
app.get '/users/new',           users.newUser...
app.get '/users/:id',           users.editUser...

# catch errors and respond with 500
app.use (err, req, res, next) ->
  res.status 500

  logger.error "\n"+err.stack

  res.format

    html: ->
      res.render 'errors/500', error: err, stack: err.stack

    json: ->
      res.send error: err.toString(), stack: err.stack

    text: ->
      res.set 'content-type', 'text/plain'
      res.send "500 Internal server error.\n#{err.toString()}\n#{err.stack}"

    default: ->
      res.sendStatus 406

# everything else is a 404
app.use (req, res) ->
  res.status 404

  res.format

    html: ->
      res.render 'errors/404', url: req.url

    json: ->
      res.send error: '404 Not found', url: req.url

    text: ->
      res.set 'content-type', 'text/plain'
      res.send "404 Not found.\nThe requested URL '#{req.url}' was not found on this server."

    default: ->
      res.sendStatus 406
