express = require 'express'

app = module.exports = express()
server = require('http').createServer app

# Hook Socket.io into Express
io = require('socket.io').listen server, {'log level': 2}

# Load Configuration
require('./app/config/express')(app)

# Load Controllers
require('./app/controllers/index')(app)

# Socket.io Routes
io.sockets.on 'connection', require './app/controllers/socket'

# Start server

server.listen 3000, ->
  console.log "Express server listening on port #{this.address().port} in #{app.settings.env} mode"