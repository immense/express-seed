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

* clone the app and install dependencies:

```bash
git clone gitlab@gitlab.immense.net:seeds/express-seed.git
cd express-seed
npm install
bower install
```

* copy the sample config files:

```bash
grunt setup
```

* edit the config files in app/config to your liking

* seed the database

```bash
grunt db:seed
```

* run the server using nodemon:

```bash
grunt
```

## How to deploy production

Note: This deploy process is specific to CentOS machines.

* create a user account on the host machine called `express-seed` and set it up:

```bash
adduser express-seed
chmod 755 /home/express-seed
su - express-seed
curl https://raw.github.com/creationix/nvm/master/install.sh | sh
source ~/.bash_profile
nvm install 0.10
nvm alias default 0.10
npm install -g forever grunt-cli bower coffee-script
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub
```

* copy the key into a new deploy key for this app in gitlab

* clone the app into `sites` in the user's home folder and install dependencies:

```bash
mkdir sites
cd sites
git clone gitlab@gitlab.immense.net:seeds/express-seed.git
cd express-seed
npm install
bower install
```

* copy the sample config files:

```bash
grunt setup
```

* edit the config files in app/config to your liking
  * Note: make sure to change `env` to `production` in `app/config/app.coffee`

* seed the database

```bash
grunt db:seed
```

* create the init script and activate the service:
  * **Note**: the rest of these commands have to be run as root

```bash
su -c "grunt setup-service"
su -c "service express-seed start"
```

* set up the nginx config and reload the nginx config

```bash
su -c "grunt setup-nginx"
su -c "ensite express-seed.dev.app.immense.net"
su -c "service nginx reload"
```

## How to update a production deployment

* pull the changes:

```bash
git pull
```

* install any new dependencies:

```bash
npm install
bower install
```

* restart the service **as root**:

```bash
su -c "service express-seed restart"
```
