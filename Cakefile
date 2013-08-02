ff = require 'ff'

task 'db:seed', 'seed the database with some data', ->
  User = require './app/models/user'

  f = ff()

  f.next ->
    User.find({}).remove f.wait()

  f.next ->
    users = [
      username: 'admin'
      password: 'p@ssw0rd'
    ,
      username: 'user'
      password: 'p@ssw0rd'
    ]
    User.create users, f.wait()

  f.onComplete (err, requisitions) ->
    if err?
      console.log 'there was an error: ', err
    else
      console.log 'done'
    process.exit()