module.exports =
  # log levels per module
  # available levels: (each module only outputs certain levels as marked)
  # TRACE, DEBUG, INFO, WARN, ERROR, FATAL
  socket:   'INFO'  # DEBUG and INFO
  server:   'DEBUG' # INFO, WARN, and ERROR
  process:  'DEBUG' # INFO and FATAL
  mongoose: 'DEBUG' # DEBUG
