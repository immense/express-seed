rack = require 'asset-rack'

prefix = "#{__dirname}/../.."

buildAssets = ->

  # static assets in /vendor
  vendor = new rack.StaticAssets
    urlPrefix: '/'
    dirname: "#{prefix}/vendor"

  # static assets in /assets
  assets = new rack.StaticAssets
    urlPrefix: '/'
    dirname: "#{prefix}/assets"

  # main app.less file
  styles = new rack.LessAsset
    url: '/css/app.css'
    filename: "#{prefix}/assets/css/app.less"
    compress: process.env.NODE_ENV is 'production'
    paths: ["#{prefix}/assets/css/", "#{prefix}/vendor/css/"]

  # main app.coffee snockets file
  scripts = new rack.SnocketsAsset
    url: '/js/app.js'
    filename: "#{prefix}/assets/js/app.coffee"
    compress: process.env.NODE_ENV is 'production'

  # app_top.coffee snockets file for js that needs to load in the header
  top_scripts = new rack.SnocketsAsset
    url: '/js/app_top.js'
    filename: "#{prefix}/assets/js/app_top.coffee"
    compress: process.env.NODE_ENV is 'production'

  new rack.AssetRack [vendor, assets, styles, scripts, top_scripts]

assets = buildAssets()

if process.env.NODE_ENV isnt 'production'

  {watchTree} = require 'fs-watch-tree'

  watchTree "#{prefix}/vendor", ->
    console.log 'Detected asset change, rebuilding assets.'
    assets = buildAssets()
  watchTree "#{prefix}/assets", ->
    console.log 'Detected asset change, rebuilding assets.'
    assets = buildAssets()

module.exports = ->
  assets.handle.apply assets, arguments