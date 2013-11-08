{can} = require 'connect-roles'
app = require './app'
passport = require './lib/passport'

# Index
index = require './controllers/index'

app.get '/', index.main
app.get '/errors', index.errors
app.get '/401', can('do anything'), index.unauthorized
app.get '/403', can('do this'), index.forbidden
app.get '/500', index.serverError

# Users
users = require './controllers/users'

app.get  '/users/login', users.login
app.post '/users/login', passport.authenticate 'local', successRedirect: '/users/secret', failureRedirect: '/users/login'
app.get  '/users/logout', can('logout'), users.logout
app.get  '/users/secret', can('view secret'), users.secret
app.get  '/users/admin-secret', can('view admin secret'), users.adminSecret

# setup socket.io controller
# each socket controller is its own instance per socket that connects
socketContoller = require('./controllers/socket')

app.io.sockets.on 'connection', (socket) ->
   socketContoller socket
