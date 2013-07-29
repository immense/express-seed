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
        cwd: 'bower_components/font-awesome/font/'
        src: '*'
        dest: 'public/font/'

    # compile coffeescript files
    coffee:
      compile:
        expand: true
        flatten: true
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
          compress: config.env is 'production'
        files:
          'tmp/less_output/app.css': 'app/assets/styles/app.less'

    # concatenate js files
    concat:
      options:
        separator: ';'
      app_top_js:
        src: [
          'bower_components/modernizr/modernizr.js'
        ]
        dest: 'public/js/app_top.js'
      app_js:
        src: [
          'bower_components/es5-shim/es5-shim.js'
          'bower_components/jquery/jquery.js'
          'bower_components/flatstrap/assets/js/bootstrap.js'
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
      app_top:
        src: 'public/js/app_top.js'
        dest: 'public/js/app_top.js'
      app:
        src: 'public/js/app.js'
        dest: 'public/js/app.js'

    watch:
      scripts:
        files: ['app/assets/scripts/**/*.coffee']
        tasks: ['coffee', 'concat:app_top_js', 'concat:app_js', 'clean:post']

      styles:
        files: ['app/assets/styles/**/*.less']
        tasks: ['less', 'concat:app_css', 'clean:post']

      images:
        files: ['app/assets/img/**']
        tasks: ['clean:pre_images', 'copy:images']

      templates:
        files: ['app/views/**']
        options: livereload: true

      livereload:
        files: ['public/**/*']
        options: livereload: true

      gruntfile:
        files: ['Gruntfile.coffee']

    nodemon:
      dev:
        options:
          file: 'app/app.coffee'
          watchedFolders: ['app', 'node_modules']

    forever:
      options:
        index: 'app/app.coffee'
        logDir: 'log'
        logFile: 'forever.log'
        errFile: 'forever-err.log'
        command: './node_modules/.bin/coffee'

    concurrent:
      dev:
        tasks: ['nodemon:dev', 'watch']
        options:
          logConcurrentOutput: true
  }

  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-nodemon'
  grunt.loadNpmTasks 'grunt-concurrent'
  grunt.loadNpmTasks 'grunt-forever'

  grunt.registerTask 'deploy-assets', [
    'clean:pre'
    'copy'
    'less'
    'coffee'
    'concat'
    'clean:post'
  ]

  if config.env is 'development'

    grunt.registerTask('default', [
      'deploy-assets'
      'concurrent:dev'
    ])

  else if config.env is 'production'

    grunt.registerTask('default', [
      'deploy-assets'
      'uglify'
      'forever:start'
    ])

    grunt.registerTask('start', ['forever:start'])
    grunt.registerTask('stop', ['forever:stop'])
    grunt.registerTask('restart', ['deploy-assets', 'uglify', 'forever:restart'])