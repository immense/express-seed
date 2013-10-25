config = require './app'

module.exports =
  upstreamName: config.appName
  socketFile: config.socket
  publicRoot: "/home/#{config.appName}/sites/#{config.appName}/public"
  # space separated list of server names for nginx vhost
  serverNames: "#{config.appName}.dev.app.immense.net"
  confPath: '/opt/nginx/staticvhosts'
