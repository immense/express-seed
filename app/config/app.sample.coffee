appName = 'express-seed'

module.exports =
  appName: appName
  appUser: appName
  port: 3000
  # socket: "/usr/local/var/run/#{appName}.socket"
  pidFile: "/usr/local/var/run/#{appName}.pid"
  env: 'development'
  cookie_secret: 'super secret cookie key'
