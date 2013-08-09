User = require '../models/user'

module.exports = (app) ->

  app.get '/', (req, res) ->
    User.count (err, count) ->
      if err? then return next err
      res.locals.users_count = count
      res.render 'index'

  app.get '/error', (req, res, next) ->
    next new Error 'A wild error appears!'