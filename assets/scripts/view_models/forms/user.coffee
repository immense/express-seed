class @UserFormView

  serialize: ->
    username: @username()
    roles: [@role()]

  blank_user: {username:  '', role: 'user'}

  constructor: (id) ->
    if id?
      user_req = $.getJSON "/api/users/#{id}"
      user_req.done (user) =>
        @init user
    else
      @init @blank_user

  init: (user) ->
    @_id        = user._id
    @username   = ko.observable(user.username).extend required: "Username cannot be blank"
    @role       = ko.observable(user.roles[0]).extend required: 'Role cannot be blank'

    @roles_immybox = [
      'admin'
      'user'
    ].map (role) -> {text: role, value: role}

    @attempted = ko.observable false

    @errors = ko.observable({})
    @num_errors = ko.observable()

    ko.computed =>
      [errors, num_errors] = [{}, 0]
      ['username', 'role']
        .filter (attr) =>
          @[attr].hasError()
        .forEach (attr) =>
          errors[attr] = @[attr].validationMessage()
          num_errors += 1

      @errors errors
      @num_errors num_errors
      if @attempted()
        if num_errors is 0
          clearAllMessages()
        else
          errorMessage "Some fields require attention before this form can be submitted"

    $('.cloak').removeClass('cloak')

    ko.applyBindings @

  save: ->
    @attempted true
    if @num_errors() is 0
      if @_id
        req = $.patchJSON "/api/users/#{@_id}/update_user", @serialize()
        req.done (user) ->
          if user.error?
            errorMessage 'Failed to save user'
          else
            successMessage 'User saved'
      else
        req = $.postJSON '/api/users/create_user', @serialize()
        req.done (user) ->
          if user.error?
            errorMessage 'Failed to create new user'
          else
            successMessage "User created"
            window.location = '/users'
