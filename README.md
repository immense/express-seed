# Express Seed Application

A jumping-off point for node+express based web applications.

## included packages:

* Express
* Bootstrap 3
* Font Awesome
* jQuery
* Less
* CoffeeScript
* Jade
* Socket.IO
* Modernizr
* es5-shim
* Knockout
* Mongoose
* Passport

## How to run in development mode:

* clone the app:
  * `git clone gitlab@gitlab.immense.net:seeds/express-seed.git`
  * `cd express-seed`
* install server dependencies:
  * `npm install`
* install client dependencies:
  * `bower install`
* copy the sample config files:
  * `grunt setup`
* edit the config files in app/config to your liking
* run the server using nodemon:
  * `grunt`

## How to deploy production

Note: This deploy process is specific to CentOS machines.

* create a user account on the host machine called `express-seed`
* clone the app into `sites` in the user's home folder:
  * `mkdir sites`
  * `cd sites`
  * `git clone gitlab@gitlab.immense.net:seeds/express-seed.git`
  * `cd express-seed`
* install server dependencies:
  * `npm install`
* install client dependencies:
  * `bower install`
* copy the sample config files:
  * `grunt setup`
* edit the config files in app/config to your liking
  * Note: make sure to change `env` to `production` in `app/config/app.coffee`
* create the init script and activate the service (as root):
  * `su -c "grunt setup-service"`
* start the service (as root):
  * `su -c "service express-seed start"`

## How to update a production deployment

* pull the changes:
  * `git pull`
* install any new dependencies:
  * `npm install`
  * `bower install`
* restart the service as root:
  * `su -c "service express-seed restart"`
