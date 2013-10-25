config = require './app'

module.exports =
  upstreamName: config.appName
  socketFile: config.socket
  publicRoot: "/home/#{config.appName}/sites/#{config.appName}/public"
  # space separated list of server names for nginx vhost
  serverNames: "#{appName}.dev.app.immense.net"
  confPath: '/opt/nginx/staticvhosts'
