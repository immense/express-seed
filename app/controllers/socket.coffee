module.exports = (socket) ->
  console.log 'socket connected'

  socket.on 'disconnect', ->
    console.log 'socket disconnected'