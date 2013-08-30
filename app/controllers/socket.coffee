log4js = require '../lib/logger'
socketLogger = log4js.getLogger 'socket'

module.exports = (socket) ->
  socketLogger.info 'hello socket!'

  socket.on 'disconnect', ->
    socketLogger.info 'goodbye socket!'
