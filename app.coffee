express = require 'express'
routes = require './routes'
socket = require './routes/socket'

app = module.exports = express()
server = require('http').createServer app

# Hook Socket.io into Express
io = require('socket.io').listen server

# Configuration

app.configure ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.static(__dirname + '/public')
  app.use app.router

app.configure 'development', ->
  app.use express.errorHandler dumpExceptions: true, showStack: true

app.configure 'production', ->
  app.use express.errorHandler()

# Routes

app.get '/', routes.index
#app.get '/partials/:name', routes.partials

# redirect all others to the index (HTML5 history)
app.get '*', routes.index

# Socket.io Communication

io.sockets.on 'connection', socket

# Start server

server.listen 3000, ->
  console.log "Express server listening on port #{this.address().port} in #{app.settings.env} mode"