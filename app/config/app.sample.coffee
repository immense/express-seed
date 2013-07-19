appName = 'express-seed'

module.exports =
  appName: appName
  port: 3000
  # socket: "/usr/local/var/run/#{appName}.socket"
  pidFile: "/usr/local/var/run/#{appName}.pid"
  env: 'development'

  # log levels per module
  # available levels: (each module only outputs certain levels as marked)
  # TRACE, DEBUG, INFO, WARN, ERROR, FATAL
  logLevel:
    socket:   'DEBUG' # DEBUG and INFO
    server:   'DEBUG' # INFO, WARN, and ERROR