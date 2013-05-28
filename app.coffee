start = new Date

express = require 'express'

# create and configure the express app
module.exports = app = express()
require('./app/config/express')(app)
env = app.settings.env

# create the http and socket.io server
server = require('http').createServer app
io = require('socket.io').listen server, {'log level': 2}

# setup controllers
require('./app/controllers/index')(app)

# setup socket.io controller
# each socket controller is its own instance per socket that connects
io.sockets.on 'connection', (socket) ->
  require('./app/controllers/socket')(socket)

# start server
server.listen app.settings.port, ->
  console.log "Express server started on port #{app.settings.port} (#{env} mode) in #{new Date - start}ms"