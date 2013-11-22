User = require '../models/user'

# get /
main = (req, res, next) ->
  User.count (err, count) ->
    if err? then return next err
    res.locals.users_count = count
    res.render 'index'

# get /errors
errors = (req, res, next) ->
  res.render 'errors'

# get /401
unauthorized = (req, res, next) ->
  res.send 'You are logged in so I can\'t show you the error.'

# get /403
forbidden = (req, res, next) ->
  res.send 'You are logged in as admin so I can\'t show you the error.'

# get /500
serverError = (req, res, next) ->
  next new Error 'A wild error appears!'

# get /502
badGateway = (req, res, next) ->
  res.render 'errors/502'

module.exports =
  main: main
  errors: errors
  unauthorized: unauthorized
  forbidden: forbidden
  serverError: serverError
  badGateway: badGateway
