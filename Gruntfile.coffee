fs = require 'fs'

if fs.existsSync './app/config/app.coffee'
  config = require './app/config/app'

_loadConfig = (path) ->
  glob = require 'glob'

  object = {}

  glob.sync('*', {cwd: path}).forEach (option) ->
    key = option.replace(/\.coffee$/,'')
    object[key] = require(path + option)

  return object

module.exports = (grunt) ->
  config = {}

  # Loads configs from each file in tasks/options/ into config object
  grunt.util._.extend(config, _loadConfig('./tasks/options/'))

  grunt.initConfig config

  # Loads tasks from tasks/ folder
  grunt.loadTasks 'tasks'

  # Imports & loads grunt tasks from package.json
  require('load-grunt-tasks')(grunt)

  grunt.registerTask 'deploy-assets', [
    'clean:pre'
    'copy'
    'less'
    'coffee'
    'concat'
    'jade'
    'clean:post'
  ]

  grunt.registerTask 'setup', [
    'shell:copyConfigs'
  ]

  grunt.registerTask 'default', [
    'deploy-assets'
    'concurrent:dev'
  ]

  grunt.registerTask 'production', [
    'deploy-assets'
    'uglify'
  ]

  # grunt.registerTask 'stop', [
  #   'forever:server:stop'
  # ]
  #
  # grunt.registerTask 'restart', [
  #   'deploy-assets'
  #   'uglify'
  #   'forever:server:stop'
  #   'forever:server:start'
  # ]
