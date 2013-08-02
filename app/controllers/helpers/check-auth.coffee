module.exports = checkAuth = (req, res, next) ->
  if req.user?
    next()
  else
    res.set 'cache-control', 'no-cache, private, no-store, must-revalidate, max-stale=0, post-check=0, pre-check=0'
    res.status 403
    res.render 'errors/403'
