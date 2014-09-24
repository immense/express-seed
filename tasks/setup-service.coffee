module.exports = (grunt) ->
  # this task must be run as root
  grunt.registerTask 'setup-service', ->
    fs = require 'fs'
    if fs.existsSync (conf_file = "#{process.cwd()}/app/config/app.coffee")
      config = require conf_file
    if not config? then throw new Error 'no app.coffee config file.'
    filename = config.appName
    username = config.appUser
    Mustache = require 'mustache'
    done = @async()

    fs.readFile './support/init.sh', (err, initScriptContents) ->
      if err? then throw err

      output = Mustache.render initScriptContents.toString(), applicationName: config.appName, applicationUser: username
      fs.writeFile "/etc/init.d/#{filename}", output, (err) ->
        if err? then throw err
        fs.chmod "/etc/init.d/#{filename}", '755', (err) ->
          if err? then throw err
          console.log "init script written to /etc/init.d/#{filename}"
          grunt.task.run 'shell:activateService'
          done()
