express = require 'express'
routes = require './routes'
socket = require './routes/socket'

app = module.exports = express()
server = require('http').createServer app

# Hook Socket.io into Express
io = require('socket.io').listen server, {log: false}

# Configuration

app.configure ->
  app.set 'port', process.env.PORT or 3000
  app.set 'views', "#{__dirname}/views"
  app.set 'view engine', 'jade'
  app.use express.favicon "#{__dirname}/assets/img/favicon.ico"
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use require('connect-assets')()
  app.use express.static "#{__dirname}/assets"

app.configure 'development', ->
  app.use express.errorHandler dumpExceptions: true, showStack: true

app.configure 'production', ->
  app.use express.errorHandler()

# Routes

app.get '/', routes.index

# Socket.io Routes

io.sockets.on 'connection', socket

# Start server

server.listen 3000, ->
  console.log "Express server listening on port #{this.address().port} in #{app.settings.env} mode"