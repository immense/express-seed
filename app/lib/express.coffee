rootdir       = "#{process.cwd()}"
appdir        = "#{rootdir}/app"

express       = require 'express'
MongoStore    = require('connect-mongo') express
fs            = require 'fs'

conf          = require "#{appdir}/config/app"
mongo_conf    = require "#{appdir}/config/mongo"

passport      = require "#{appdir}/lib/passport"
roles         = require "#{appdir}/lib/roles"
log4js        = require "#{appdir}/lib/logger"
logger        = log4js.getLogger 'server'

module.exports = app = express()

app.configure ->
  app.set 'env', conf.env
  app.set 'port', if conf.socket? then conf.socket else conf.port
  app.set 'views', "#{appdir}/views"
  app.set 'view engine', 'jade'

  app.use log4js.connectLogger logger, level: 'auto', format: ':method :url :status - :response-time ms'
  app.use express.static "#{rootdir}/public"
  app.use express.favicon "#{appdir}/assets/img/favicon.ico"
  app.use express.compress()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.session
    secret: conf.cookie_secret
    store: new MongoStore
      url: mongo_conf.uri
  app.use passport.initialize()
  app.use passport.session()
  app.use roles
  app.use app.router

  # catch errors and respond with 500
  app.use (err, req, res, next) ->
    res.status 500

    logger.error "\n"+err.stack

    switch req.accepts 'image, html, json, text'

      when 'html'
        res.render 'errors/500', error: err, stack: err.stack

      when 'json'
        res.send error: err.toString(), stack: err.stack

      when 'image'
        res.set 'content-type', 'image/png'
        fs.createReadStream("#{appdir}/assets/img/500.png").pipe res

      when 'text'
        res.set 'content-type', 'text/plain'
        res.send "500 Internal server error.\n#{err.toString()}\n#{err.stack}"

      else
        res.status 406 # not acceptable
        res.end()

  # everything else is a 404
  app.use (req, res) ->
    res.status 404

    switch req.accepts 'image, html, json, text'

      when 'html'
        res.render 'errors/404', url: req.url

      when 'json'
        res.send error: '404 Not found', url: req.url

      when 'image'
        res.set 'content-type', 'image/png'
        fs.createReadStream("#{appdir}/assets/img/404.png").pipe res

      when 'text'
        res.set 'content-type', 'text/plain'
        res.send "404 Not found.\nThe requested URL '#{req.url}' was not found on this server."

      else
        res.status 406 # not acceptable
        res.end()
