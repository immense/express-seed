express = require 'express'

module.exports = (app) ->

  assets = require './assets.coffee'

  app.configure ->
    app.set 'port', process.env.PORT or 3000
    app.set 'views', "#{__dirname}/../views"
    app.set 'view engine', 'jade'
    app.use express.favicon "#{__dirname}/../../assets/img/favicon.ico"
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use assets
    app.use app.router

  app.configure 'development', ->
    app.use express.errorHandler dumpExceptions: true, showStack: true

  app.configure 'production', ->
    app.use express.errorHandler()