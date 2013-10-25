appdir = "#{process.cwd()}/app"

fs     = require 'fs'

roles = module.exports = require 'connect-roles'

roles.setFailureHandler (req, res, action) ->

  if req.user.isAuthenticated
    res.status 403

    switch req.accepts 'image, html, json, text'

      when 'html'
        res.render 'errors/403', action: action

      when 'json'
        res.send error: '403 Forbidden', action: action

      when 'image'
        res.set 'content-type', 'image/png'
        fs.createReadStream("#{appdir}/assets/img/403.png").pipe res

      when 'text'
        res.set 'content-type', 'text/plain'
        res.send "403 Forbidden.\nYou don't have permission to #{action}."

      else
        res.status 406 # not acceptable
        res.end()

  else
    res.status 401

    switch req.accepts 'image, html, json, text'

      when 'html'
        # either redirect to the login page, or respond with 401.
        res.render 'errors/401'
        # req.session.returnTo = req.originalUrl
        # res.redirect '/users/login'

      when 'json'
        res.send error: '401 Unauthorized'

      when 'image'
        res.set 'content-type', 'image/png'
        fs.createReadStream("#{appdir}/assets/img/401.png").pipe res

      when 'text'
        res.set 'content-type', 'text/plain'
        res.send "401 Unauthorized."

      else
        res.status 406 # not acceptable
        res.end()

# Authorization strategies are checked in order.
# The first one to return true or false results in "allowed" or "denied" respectively.
# Returning null results in the next strategy being tried.

actionsAllowedByAnyone = ['logout']

# checked for all actions
roles.use (req, action) ->
  if not req.user.isAuthenticated           # if you're not authenticated
    false                                   #   then you're not allowed.
  else if action in actionsAllowedByAnyone  # if you're trying to do any action that any authenticated user can do
    true                                    #   then you're allowed.
  else if action in req.user.roles          # if the action you're performing is a role name you have
    true                                    #   then you're allowed.
  else                                      # otherwise
    null                                    #   move on to the next strategy

# checked for specific actions
roles.use 'view secret', (req) ->
  if 'user' in req.user.roles then true else null

# all else fails, are they an admin?
roles.use (req) -> 'admin' in req.user.roles
