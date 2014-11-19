appdir = "#{process.cwd()}/app"
user   = require "#{appdir}/lib/roles"

# get /login
login = (req, res) ->
  if req.isAuthenticated()
    res.redirect '/users/secret'
  else
    res.render 'users/login'

# post /logout
logout = (req, res) ->
  req.logout()
  res.redirect '/'

# get /users
list = (req, res) ->
  res.pushTag 'users'
  res.pushTag 'list-users'
  res.render 'users/index'

# get /users/new
newUser = (req, res) ->
  res.pushTag 'users'
  res.pushTag 'new-user'
  res.render 'users/new'

# get /users/:id
editUser = (req, res) ->
  res.pushTag 'users'
  res.pushTag 'list-users'
  res.render 'users/edit', id: req.params.id

# get /users/secret
secret = (req, res) ->
  res.render 'users/secret'

# get /users/admin-secret
adminSecret = (req, res) ->
  res.render 'users/admin-secret'

module.exports =
  login: [login]
  logout: [user.can('logout'), logout]
  list: [user.can('view users'), list]
  newUser: [user.can('create users'), newUser]
  editUser: [user.can('edit users'), editUser]
  secret: [user.can('view secret'), secret]
  adminSecret: [user.can('view admin secret'), adminSecret]
