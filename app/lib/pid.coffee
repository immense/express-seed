fs        = require 'fs'
{appName} = require '../config/app'
PID_FILE  = "/usr/local/var/run/#{appName}.pid"

fs.writeFileSync PID_FILE, "#{process.pid}\n"

process.on 'uncaughtException', (err) ->
  console.error '[uncaughtException]', err
  process.exit 1

process.on 'SIGTERM', ->
  console.log 'caught SIGTERM'
  process.exit 0

process.on 'SIGINT', ->
  console.log 'caught SIGINT'
  process.exit 0

process.on 'exit', ->
  console.log('exiting...')
  fs.unlink PID_FILE