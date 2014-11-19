# Express Seed Changelog

## 0.5.0 -> 0.6.0
*Wed Nov 19 17:54:29 2014 -0600*

* Added navbar, better user views
	* __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/56be788b91a0c574bef7ebf87304defa62ed6fe9)__

## 0.4.0 -> 0.5.0
*Mon Nov 10 12:44:18 2014 -0600*

* Added autoprefixer
* Updated some packages
* Removed some unused files
	* __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/2ad41d3bf08c3564ed7f33c66c86ccd89857b0c1)__

## 0.3.0 -> 0.4.0
*Thu Nov 6 13:39:28 2014 -0600*

* Fixed application started language
	* __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/b84aa4e545bbc96b094eca94c86c8e7ab9ef6ee1)__


* Updated readme
	* __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/f0cac485d33fd015791aee7fc7c1ee6c59d3f307)__


* Added curl-head to trigger passenger's restart
	* __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/53685cb3d6ed709b995f169f7c605d9b3c019806)__


* Added grunt restart to touch restart.txt on grunt production
	* __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/a0db2294da4dc65c8ad58ad3187b1ad1bdf78469)__


* Added environment detection to setup-nginx task
	* __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/d2bca8bcaca3e6e36e152e8810a265fdece6a9d7)__


* Fixed: write nginx vhost to file with server name
	* __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/8728708fc0c7b953ba6009491a8f8fc52651494b)__


* Switched to use nginx+passenger in production
	* __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/fc010259412bf5449c16e7c26297bb128e976b10)__


* Updated nvm install command in README
	* __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/e4db397047d838045f83698d845abb8327f757f7)__


* Refactored gruntile
* Fixed forever grunt task
	* __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/eb9e92770adb041c821d671badf3cb5d80ad93c6)__


* Updated dependencies to their latest versions
	* __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/1ac9d8797d3a14da9867ca389cfaf2121eea047d)__

## 0.2.6 -> 0.3.0
*Tue Jun 10 15:33:24 2014 -0500*

* Updated dependencies
* Updated express to 4
	* __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/e546017bdf02d1b3136f850f5f3b39106e1038e3)__

## 0.2.5 -> 0.2.6
*Mon May 19 13:22:02 2014 -0500*
1. Fixes grunt-forever

## 0.2.4 -> 0.2.5
*Thu Feb 6 12:37:49 2014 -0600*

1. Updated dependencies.
1. Use latest nodemon.
1. Moved assets out of app folder.
1. Removed socket.io, it's rarely needed in projects based on this seed.
1. Removed responding to errors with images.

## 0.2.3 -> 0.2.4
*Fri Jan 10 13:51:04 2014 -0600*

1. Deployed to github.

## 0.2.2 -> 0.2.3
*Fri Jan 10 13:51:04 2014 -0600*

1. Locked down dependency version numbers; Fixed views for latest jade.
1. Added X-UA-Compatible header to nginx conf; removed meta tag from layouts.
1. Better mongoose query logging and better static asset cache control.
1. Removed unnecessary options from jade grunt task.

## 0.2.1 -> 0.2.2
*Fri Nov 22 11:10:10 2013 -0600*

1. Added customizable 502 bad gateway error page.

## 0.2.0 -> 0.2.1
*Fri Nov 22 10:13:12 2013 -0600*

1. Some nginx config improvements:
  * Removed gzipping from config; it causes etags to be stripped.
  * Use appName as filename for nginx config instead, it's nicer.

## 0.1.1 -> 0.2.0
*Fri Nov 8 14:31:53 2013 -0600*

1. Fix deprecation warnings.
1. Refactored controllers to consolidate routing into app/router.coffee.

## 0.1.0 -> 0.1.1
*Fri Nov 8 11:00:56 2013 -0600*

1. Added branch name to version info output.

## 0.1.0

1. Initial versioned release.
