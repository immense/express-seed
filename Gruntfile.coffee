fs = require 'fs'

if fs.existsSync './app/config/app.coffee'
  config = require './app/config/app'

module.exports = (grunt) ->
  grunt.initConfig {

    # clean up compiled or temporary files
    clean:
      pre: ['public/*']
      pre_images: ['public/img/*']
      post: ['tmp/*']

    # copy static assets into public/
    copy:
      images:
        expand: true
        cwd: 'app/assets/img/'
        src: '**'
        dest: 'public/img/'
      fontAwesome:
        expand: true
        cwd: 'bower_components/font-awesome/fonts/'
        src: '*'
        dest: 'public/fonts/'
      glyphIcons:
        expand: true
        cwd: 'bower_components/bootstrap/fonts/'
        src: '*'
        dest: 'public/fonts/'

    jade:
      compile:
        files:
          'public/502.html': 'app/views/errors/502.jade'

    # compile coffeescript files
    coffee:
      compile:
        expand: true
        cwd: 'app/assets/scripts/'
        src: ['**/*.coffee']
        dest: 'tmp/coffee_output/'
        ext: '.js'

    # compile less files
    less:
      app:
        options:
          paths: [
            'bower_components/bootstrap/less'
            'bower_components/font-awesome/less'
          ]
          compress: config?.env is 'production'
        files:
          'tmp/less_output/app.css': 'app/assets/styles/app.less'

    # concatenate js files
    concat:
      options:
        separator: ';'
      compat_js:
        src: [
          'bower_components/modernizr/modernizr.js'
          'bower_components/response/respond.src.js'
          'bower_components/es5-shim/es5-shim.js'
        ]
        dest: 'public/js/compat.js'
      app_js:
        src: [
          'bower_components/sugar/release/sugar.min.js'
          'bower_components/jquery/jquery.js'
          'bower_components/bootstrap/dist/js/bootstrap.js'
          'bower_components/knockout.js/knockout.js'
          'node_modules/socket.io/node_modules/socket.io-client/dist/socket.io.js'

          'tmp/coffee_output/shoutout.js'
        ]
        dest: 'public/js/app.js'
      app_css:
        options:
          separator: '\n'
        src: [
          'tmp/less_output/app.css'
        ]
        dest: 'public/css/app.css'

    # uglifyjs files
    uglify:
      compat:
        src: 'public/js/compat.js'
        dest: 'public/js/compat.js'
      app:
        src: 'public/js/app.js'
        dest: 'public/js/app.js'

    watch:
      scripts:
        files: ['app/assets/scripts/**/*.coffee']
        tasks: ['coffee', 'concat:app_js', 'clean:post']

      styles:
        files: ['app/assets/styles/**/*.less']
        tasks: ['less', 'concat:app_css', 'clean:post']

      images:
        files: ['app/assets/img/**']
        tasks: ['clean:pre_images', 'copy:images']

      badGateway:
        files: ['app/views/errors/502.jade']
        tasks: ['jade']

      templates:
        files: ['app/views/**']
        options: livereload: true

      livereload:
        files: ['public/**/*']
        options: livereload: true

      gruntfile:
        files: ['Gruntfile.coffee']
        tasks: ['deploy-assets']

      npm:
        files: ['package.json']
        tasks: ['shell:npm']

      bower:
        files: ['bower.json']
        tasks: ['shell:bower']

    nodemon:
      dev:
        options:
          file: 'app/index.coffee'
          watchedFolders: ['app', 'node_modules']

    forever:
      options:
        index: 'app/index.coffee'
        logDir: 'log'
        logFile: 'forever.log'
        errFile: 'forever-err.log'
        command: './node_modules/.bin/coffee'

    concurrent:
      dev:
        tasks: ['nodemon:dev', 'watch']
        options:
          logConcurrentOutput: true

    shell:
      copyConfigs:
        options:
          stdout: true
          stderr: true
        command: """
          cp app/config/app.sample.coffee app/config/app.coffee
          cp app/config/logger.sample.coffee app/config/logger.coffee
          cp app/config/mongo.sample.coffee app/config/mongo.coffee
          cp app/config/nginx.sample.coffee app/config/nginx.coffee
        """
      # this task must be run as root
      activateService:
        options:
          stdout: true
          stderr: true
        command: if config? then "chkconfig #{config.appName} on" else "echo 'no config file'"
      npm:
        options:
          stdout: true
          stderr: true
        command: 'npm prune && npm install'
      bower:
        options:
          stdout: true
          stderr: true
        command: 'bower prune && bower install'
  }

  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-nodemon'
  grunt.loadNpmTasks 'grunt-concurrent'
  grunt.loadNpmTasks 'grunt-forever'
  grunt.loadNpmTasks 'grunt-shell'

  grunt.registerTask 'deploy-assets', [
    'clean:pre'
    'copy'
    'less'
    'coffee'
    'concat'
    'jade'
    'clean:post'
  ]

  grunt.registerTask 'setup', ['shell:copyConfigs']

  # this task must be run as root
  grunt.registerTask 'setup-service', ->
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

  # this task must be run as root
  grunt.registerTask 'setup-nginx', ->
    if fs.existsSync './app/config/nginx.coffee'
      nginx_config = require './app/config/nginx'

    if not nginx_config? then throw new Error 'no nginx.coffee config file.'
    upstreamName = nginx_config.upstreamName
    if not upstreamName? then throw new Error 'no upstreamName defined in app.coffee.'
    socketFile = nginx_config.socketFile
    if not socketFile? then throw new Error 'not configured to run on a unix socket.'
    serverNames = nginx_config.serverNames
    if not serverNames? then throw new Error 'no serverNames defined in app.coffee.'
    publicRoot = nginx_config.publicRoot
    if not publicRoot? then throw new Error 'no publicRoot defined in app.coffee.'
    confPath = nginx_config.confPath
    if not confPath? then throw new Error 'no confPath defined in app.coffee.'
    Mustache = require 'mustache'
    done = @async()

    locals =
      upstreamName: upstreamName
      socketFile: socketFile
      serverNames: serverNames
      publicRoot: publicRoot

    filename = config.appName

    fs.readFile './support/nginx.conf', (err, configContents) ->
      if err? then throw err

      output = Mustache.render configContents.toString(), locals
      fs.writeFile "#{confPath}/#{filename}", output, (err) ->
        if err? then throw err
        console.log "nginx vhost config file written to #{confPath}/#{filename}"
        done()

  grunt.registerTask 'db:seed', ->
    ff = require 'ff'
    User = require './app/models/user'

    f = ff()

    f.next ->
      User.find({}).remove f.wait()

    f.next ->
      users = [
        username: 'admin'
        password: 'p@ssw0rd'
        roles:    ['admin']
      ,
        username: 'user'
        password: 'p@ssw0rd'
        roles:    ['user']
      ]
      User.create users, f.wait()

    f.onComplete (err, requisitions) ->
      if err?
        console.log 'there was an error: ', err
      else
        console.log 'done'
      process.exit()

  grunt.registerTask('default', [
    'deploy-assets'
    'concurrent:dev'
  ])

  grunt.registerTask('production', [
    'deploy-assets'
    'uglify'
    'forever:start'
  ])
  grunt.registerTask('stop', ['forever:stop'])
  grunt.registerTask('restart', ['deploy-assets', 'uglify', 'forever:stop', 'forever:start'])
