ff = require 'ff'

task 'db:seed', 'seed the database with some data', ->
  crypto = require 'crypto'

  User = require './app/models/user'

  f = ff()

  f.next ->
    User.find({}).remove f.wait()

  f.next ->
    users = [
      username: 'admin'
      password: crypto.createHash('sha256').update('p@ssw0rd').digest('hex')
    ,
      username: 'user'
      password: crypto.createHash('sha256').update('p@ssw0rd').digest('hex')
    ]
    User.create users, f.wait()

  f.onComplete (err, requisitions) ->
    if err?
      console.log 'there was an error: ', err
    else
      console.log 'done'
    process.exit()