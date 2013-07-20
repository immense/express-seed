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
        cwd: 'components/flatstrap/assets/font/'
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
          paths: ['components/flatstrap/assets/less']
          compress: true
        files:
          'public/css/app.css': 'app/assets/styles/app.less'

    # concatenate js files
    concat:
      options:
        separator: ';'
      app_top:
        src: [
          'components/modernizr/modernizr.js'
        ]
        dest: 'public/js/app_top.js'
      app:
        src: [
          'components/es5-shim/es5-shim.js',
          'components/jquery/jquery.js',
          'components/flatstrap/assets/js/bootstrap.js',
          'node_modules/socket.io/node_modules/socket.io-client/dist/socket.io.js',
          'tmp/coffee_output/*'
        ]
        dest: 'public/js/app.js'

    # uglifyjs files
    # uglify:
    #   app_top:
    #     src: 'tmp/app_top.js'
    #     dest: 'public/js/app_top.js'
    #   app:
    #     src: 'tmp/app.js'
    #     dest: 'public/js/app.js'

    watch:
      options:
        livereload: true

      scripts:
        files: ['app/assets/scripts/**/*.coffee']
        tasks: ['coffee', 'concat', 'clean:post']

      styles:
        files: ['app/assets/styles/**/*.less']
        tasks: ['less']

      images:
        files: ['app/assets/img/**']
        tasks: ['clean:pre_images', 'copy:images']

      templates:
        files: ['app/views/**']

      gruntfile:
        files: ['Gruntfile.coffee']

    nodemon:
      dev:
        options:
          file: 'app.coffee'
          watchedFolders: ['app.coffee', 'app', 'node_modules']

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

  grunt.registerTask('default', [
    'clean:pre',
    'copy',
    'less',
    'coffee',
    'concat',
    # 'uglify',
    'clean:post',
    'concurrent:dev'
  ])

  # grunt.registerTask('production', [
  #   'clean:pre',
  #   'copy',
  #   'less',
  #   'coffee',
  #   'concat',
  #   # 'uglify',
  #   'clean:post',
  #   'forever'
  # ])