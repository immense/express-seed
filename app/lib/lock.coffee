fs = require 'fs'
{appName, lockFile} = require '../config/app'

if fs.existsSync lockFile
  throw new Error "#{appName} is already running.  If it really isn't, remove #{lockFile}."
  process.exit()

fs.writeFileSync lockFile, "#{process.pid}\n"

process.on 'exit', -> fs.unlink lockFile
