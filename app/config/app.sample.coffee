appName = 'express-seed'

module.exports =
  appName: appName
  appUser: appName
  port: 3000
  # socket: "/tmp/#{appName}.sock"
  lockFile: "/tmp/#{appName}.lock"
  env: 'development'
  cookie_secret: 'super secret cookie key'
