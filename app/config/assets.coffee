rack = require 'asset-rack'

conf = require './app'

cwd = process.cwd()

buildAssets = ->

  # static assets in /vendor
  vendor = new rack.StaticAssets
    urlPrefix: '/'
    dirname: "#{cwd}/vendor"

  # static assets in /assets
  assets = new rack.StaticAssets
    urlPrefix: '/'
    dirname: "#{cwd}/assets"

  # main app.less file
  styles = new rack.LessAsset
    url: '/css/app.css'
    filename: "#{cwd}/assets/css/app.less"
    compress: conf.env is 'production'
    paths: ["#{cwd}/assets/css/", "#{cwd}/vendor/css/"]

  # main app.coffee snockets file
  scripts = new rack.SnocketsAsset
    url: '/js/app.js'
    filename: "#{cwd}/assets/js/app.coffee"
    compress: conf.env is 'production'

  # app_top.coffee snockets file for js that needs to load in the header
  top_scripts = new rack.SnocketsAsset
    url: '/js/app_top.js'
    filename: "#{cwd}/assets/js/app_top.coffee"
    compress: conf.env is 'production'

  new rack.AssetRack [vendor, assets, styles, scripts, top_scripts]

assets = buildAssets()

if conf.env is 'development'
  gaze = require 'gaze'

  gaze ["#{cwd}/vendor/**/{*.js,*.css,*.less}", "#{cwd}/assets/**/{*.coffee,*.less}"], (err) ->
    @on 'all', (event, filepath) ->
      console.log "#{filepath} was #{event}, rebuilding assets."
      assets = buildAssets()

module.exports = ->
  assets.handle.apply assets, arguments