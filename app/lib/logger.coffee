config = require '../config/logger'
app_config = require '../config/app'
module.exports = log4js = require 'log4js'

appenders = if app_config.env is 'development'
  [ { type: 'console' } ]
else if app_config.env is 'production'
  [ { type: 'file', filename: config.file, backups: config.backups, maxLogSize: config.max_size} ]

log4js.configure appenders: appenders

# set log levels from config
for logger, level of config.levels
  log4js.getLogger(logger).setLevel level
