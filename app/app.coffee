start = new Date
require './lib/process'
require './lib/pid'

fs = require 'fs'

log4js = require './lib/logger'
serverLogger = log4js.getLogger 'server'
socketLogger = log4js.getLogger 'socket'

config = require './config/app'
loggerConfig = require './config/logger'

if config.socket? then require './lib/socket'

# create and configure the express app
app = require './lib/express'
env = app.settings.env

# create the http and socket.io server
server = require('http').createServer app
io = require('socket.io').listen server, logger: socketLogger, 'log level': log4js.levels[loggerConfig.levels.socket]

# setup controllers
require('./controllers/index') app
require('./controllers/users') app

# setup socket.io controller
# each socket controller is its own instance per socket that connects
io.sockets.on 'connection', (socket) ->
  require('./controllers/socket') socket

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
