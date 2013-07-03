util = require 'util'
fs = require 'fs'

require './app/lib/process'
require './app/lib/pid'
config = require './app/config/app'

if config.socket? then require './app/lib/socket'

start = new Date

express = require 'express'

# create and configure the express app
module.exports = app = express()
require('./app/config/express') app
env = app.settings.env

# create the http and socket.io server
server = require('http').createServer app
io = require('socket.io').listen server, {'log level': 2}

# setup controllers
require('./app/controllers/index') app

# setup socket.io controller
# each socket controller is its own instance per socket that connects
io.sockets.on 'connection', (socket) ->
  require('./app/controllers/socket') socket

# delete the socket file if it exists (from a previous crash)
if config.socket? and fs.existsSync config.socket
  fs.unlinkSync config.socket

# start server
server.listen app.settings.port, ->
  if config.socket? and fs.existsSync config.socket
    fs.chmodSync config.socket, '777'
  time = new Date - start
  util.log "Express server started on port/socket #{app.settings.port} (#{env} mode) in #{time}ms"