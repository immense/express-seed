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
  }),
  # main app.coffee snockets file
  new rack.SnocketsAsset({
    url: '/js/app.js'
    filename: "#{__dirname}/../../assets/js/app.coffee"
    compress: process.NODE_ENV is 'production'
  })
]

module.exports = new rack.Rack assets