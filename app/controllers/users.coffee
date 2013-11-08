# get /users/login
login = (req, res) ->
  if req.user.isAuthenticated
    res.redirect '/users/secret'
  else
    res.render 'users/login'

# get /users/logout
logout = (req, res) ->
  req.logout()
  res.redirect '/'

# get /users/secret
secret = (req, res) ->
  res.render 'users/secret'

# get /users/admin-secret
adminSecret = (req, res) ->
  res.render 'users/admin-secret'

module.exports =
  login: login
  logout: logout
  secret: secret
  adminSecret: adminSecret
