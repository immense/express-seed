module.exports =
  "curl-head":
    command: (url) ->
      fs = require 'fs'
      nginx_conf_file = "#{process.cwd()}/app/config/nginx.coffee"
      if fs.existsSync nginx_conf_file
        {serverNames} = require nginx_conf_file
        if serverNames and (server = serverNames.split(' ')[0])
          "curl -I http://#{server} >/dev/null 2>&1"
        else
          "echo \"serverNames not set in app/config/nginx.coffee\"; exit 1"
      else
        "echo \"app/config/nginx.coffee doesn't exist\"; exit 1"
  copyConfigs:
    command: ->
      files = [
        { source: 'app/config/app.sample.coffee', destination: 'app/config/app.coffee' },
        { source: 'app/config/logger.sample.coffee', destination: 'app/config/logger.coffee' },
        { source: 'app/config/mongo.sample.coffee', destination: 'app/config/mongo.coffee' },
        { source: 'app/config/nginx.sample.coffee', destination: 'app/config/nginx.coffee' }
      ]
      fs = require 'fs'

      files.map (config_file) ->
        if fs.existsSync config_file.source
          "cp \"#{config_file.source}\" \"#{config_file.destination}\";"
        else
          "echo \"#{config_file.source} does not exist\";"
      .join('')
  # this task must be run as root
  activateService:
    command: if config? then "chkconfig #{config.appName} on" else "echo 'no config file'"
  npm:
    command: 'npm prune && npm install'
  bower:
    command: 'bower prune && bower install'
