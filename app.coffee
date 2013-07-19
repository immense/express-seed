start = new Date

fs = require 'fs'

log4js = require './app/lib/logger'
serverLogger = log4js.getLogger 'server'
socketLogger = log4js.getLogger 'socket'

require './app/lib/process'
require './app/lib/pid'
config = require './app/config/app'

if config.socket? then require './app/lib/socket'

express = require 'express'

# create and configure the express app
module.exports = app = express()
require('./app/config/express') app
env = app.settings.env

# create the http and socket.io server
server = require('http').createServer app
io = require('socket.io').listen server, logger: socketLogger, 'log level': log4js.levels[config.logLevel.socket]

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

  port = if config.socket? then 'socket' else 'port'
  time = new Date - start
  serverLogger.info "#{config.appName} started on #{port} #{app.settings.port} (#{env} mode) in #{time}ms"