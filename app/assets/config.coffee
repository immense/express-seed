# assets configuration file
# define which assets from /components you want included in app.js and app.css

module.exports =
  app_js: [
    'components/es5-shim/es5-shim.js',
    'components/jquery/jquery.js',
    'components/flatstrap/assets/js/bootstrap.js',
    'node_modules/socket.io/node_modules/socket.io-client/dist/socket.io.js'
  ]
  app_css: []

# note: all files in img are copied to /public/img
# styles/app.less is compiled to /public/css/app.css but will also include assets listed in app_css above
# all scripts/*.coffee files are compiled and combined into /public/js/app.js but also include assets listed in app_js above