rootdir  = "#{process.cwd()}"
appdir   = "#{rootdir}/app"
app      = require './app'
user     = require './lib/roles'
passport = require './lib/passport'
log4js   = require "#{appdir}/lib/logger"
logger   = log4js.getLogger 'server'

# Index
index = require './controllers/index'

app.get '/', index.main
app.get '/errors', index.errors
app.get '/401', user.can('view secret'), index.unauthorized
app.get '/403', user.can('do this'), index.forbidden
app.get '/500', index.serverError
app.get '/502', index.badGateway

# Users
users = require './controllers/users'

app.get  '/users/login', users.login
app.post '/users/login', passport.authenticate 'local', successRedirect: '/users/secret', failureRedirect: '/users/login'
app.get  '/users/logout', user.can('logout'), users.logout
app.get  '/users/secret', user.can('view secret'), users.secret
app.get  '/users/admin-secret', user.can('view admin secret'), users.adminSecret

# catch errors and respond with 500
app.use (err, req, res, next) ->
  res.status 500

  logger.error "\n"+err.stack

  switch req.accepts ['html', 'json', 'text']

    when 'html'
      res.render 'errors/500', error: err, stack: err.stack

    when 'json'
      res.send error: err.toString(), stack: err.stack

    when 'text'
      res.set 'content-type', 'text/plain'
      res.send "500 Internal server error.\n#{err.toString()}\n#{err.stack}"

    else
      res.status 406 # not acceptable
      res.end()

# everything else is a 404
app.use (req, res) ->
  res.status 404

  switch req.accepts ['html','json','text']

    when 'html'
      res.render 'errors/404', url: req.url

    when 'json'
      res.send error: '404 Not found', url: req.url

    when 'text'
      res.set 'content-type', 'text/plain'
      res.send "404 Not found.\nThe requested URL '#{req.url}' was not found on this server."

    else
      res.status 406 # not acceptable
      res.end()
