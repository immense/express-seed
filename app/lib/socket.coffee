fs = require 'fs'
{socket} = require '../config/app'

process.on 'cleanup', -> fs.unlinkSync(socket) if fs.existsSync socket
