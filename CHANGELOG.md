# Express Seed Changelog

## 0.6.0 -> 0.6.1
*Mon Apr 13 10:40:15 2015 -0500*
1. Clean up for GitHub

## 0.5.0 -> 0.6.0
*Wed Nov 19 17:54:29 2014 -0600*

1. Added navbar, better user views

## 0.4.0 -> 0.5.0
*Mon Nov 10 12:44:18 2014 -0600*

1. Added autoprefixer
1. Updated some packages
1. Removed some unused files

## 0.3.0 -> 0.4.0
*Thu Nov 6 13:39:28 2014 -0600*

1. Fixed application started language
1. Updated readme
1. Added curl-head to trigger passenger's restart
1. Added grunt restart to touch restart.txt on grunt production
1. Added environment detection to setup-nginx task
1. Fixed: write nginx vhost to file with server name
1. Switched to use nginx+passenger in production
1. Updated nvm install command in README
1. Refactored gruntile
1. Fixed forever grunt task


* Updated dependencies to their latest versions

## 0.2.6 -> 0.3.0
*Tue Jun 10 15:33:24 2014 -0500*

* Updated dependencies
* Updated express to 4

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
