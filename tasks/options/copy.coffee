# copy static assets into public/
module.exports =
  images:
    expand: true
    cwd: 'assets/img/'
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
