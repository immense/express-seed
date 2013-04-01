express = require 'express'
connect = require 'connect'

module.exports = (app) ->

  assets = require './assets.coffee'

  app.configure ->
    app.set 'port', process.env.PORT or 3000
    app.set 'views', "#{__dirname}/../views"
    app.set 'view engine', 'jade'
    app.use express.logger()
    app.use connect.compress()
    app.use express.favicon "#{__dirname}/../../assets/img/favicon.ico"
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use assets
    app.use app.router

  app.configure 'development', ->
    app.use express.errorHandler dumpExceptions: true, showStack: true

  app.configure 'production', ->
    app.use express.errorHandler()

    # set up 404 routes
    app.use (req, res) ->
      res.status 404

      # respond with html page
      if req.accepts 'html'
        res.render 'errors/404', { url: req.url }
        return

      # respond with json
      if req.accepts 'json'
        res.send { error: '404 Not found', url: req.url }
        return

      # default to plain-text. send()
      res.type('txt')
        .send "404 Not found.\nThe requested URL '#{req.url}' was not found on this server."