$(document).ajaxError (event, response) ->
  if json = response.responseJSON
    error = json.error
  else
    error = "An unknown error occurred"
  errorMessage(error) if error
