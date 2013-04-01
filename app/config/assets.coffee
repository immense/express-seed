rack = require 'asset-rack'

assets = [
  # static assets in /vendor
  new rack.StaticAssets({
    urlPrefix: '/'
    dirname: "#{__dirname}/../../vendor"
  }),
  # static assets in /assets
  new rack.StaticAssets({
    urlPrefix: '/'
    dirname: "#{__dirname}/../../assets"
  }),
  # main app.less file
  new rack.LessAsset({
    url: '/css/app.css'
    filename: "#{__dirname}/../../assets/css/app.less"
    compress: process.env.NODE_ENV is 'production'
  }),
  # main app.coffee snockets file
  new rack.SnocketsAsset({
    url: '/js/app.js'
    filename: "#{__dirname}/../../assets/js/app.coffee"
    compress: process.env.NODE_ENV is 'production'
  }),
  # app_top.coffee snockets file for js that needs to load in the header
  new rack.SnocketsAsset({
    url: '/js/app_top.js'
    filename: "#{__dirname}/../../assets/js/app_top.coffee"
    compress: process.env.NODE_ENV is 'production'
  })
]

module.exports = new rack.Rack assets