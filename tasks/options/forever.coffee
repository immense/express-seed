module.exports =
  server:
    options:
      index: 'app/index.coffee'
      logDir: 'log'
      logFile: 'forever.log'
      errFile: 'forever-err.log'
      command: './node_modules/.bin/coffee'
