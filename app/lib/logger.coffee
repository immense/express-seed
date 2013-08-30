config = require '../config/logger'
module.exports = log4js = require 'log4js'

log4js.configure
  appenders: [
    { type: 'console' },
    { type: 'file', filename: 'log/server.log'}
  ]

# set log levels from config
for logger, level of config
  log4js.getLogger(logger).setLevel level
