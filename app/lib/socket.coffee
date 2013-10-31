fs = require 'fs'
{socket} = require '../config/app'

process.on 'cleanup', -> fs.unlink socket
