# concatenate js files
module.exports =
  options:
    separator: ';'
  compat_js:
    src: [
      'bower_components/modernizr/modernizr.js'
      'bower_components/respond/dest/respond.src.js'
      'bower_components/es5-shim/es5-shim.js'
    ]
    dest: 'public/js/compat.js'
  app_js:
    src: [
      'bower_components/sugar/release/sugar.min.js'
      'bower_components/jquery/dist/jquery.js'
      'bower_components/bootstrap/dist/js/bootstrap.js'
      'bower_components/knockout.js/knockout.js'

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
