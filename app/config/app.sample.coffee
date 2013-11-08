pkg = require '../../package.json'

conf =
  appName: pkg.name
  appUser: pkg.name
  version: pkg.version
  port: 3000
  # socket: "/tmp/#{pkg.name}.sock"
  env: 'development'
  cookie_secret: 'super secret cookie key'

# get latest git commit hash if in dev environment
if conf.env is 'development'
  require('child_process').exec 'git rev-parse --short HEAD', (err, stdout, stderr) ->
    conf.hash = stdout
    conf.hashLink = "#{pkg.repository.web}/commit/#{stdout}"

module.exports = conf
