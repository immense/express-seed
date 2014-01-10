# Express Seed Changelog

## 0.2.2 -> 0.2.3
*Fri Jan 10 13:51:04 2014 -0600*

1. Locked down dependency version numbers; Fixed views for latest jade.
  * __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/984e11d4e8adf16e8ae18c58c0acbb2e2f576936)__
1. Added X-UA-Compatible header to nginx conf; removed meta tag from layouts.
  * __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/93dfcaaa80d68316ba9259cd86c5be7ad3ae8193)__
1. Better mongoose query logging and better static asset cache control.
  * __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/7f9846ed4c988a1deed58b8bd375a78b06d01e3f)__
1. Removed unnecessary options from jade grunt task.
  * __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/a67d97dd789656165312c6ce3653347286a7eb43)__*

## 0.2.1 -> 0.2.2
*Fri Nov 22 11:10:10 2013 -0600*

1. Added customizable 502 bad gateway error page.
  * __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/7a4861f45c79fcbd32bcf97889efb986df413e27)__

## 0.2.0 -> 0.2.1
*Fri Nov 22 10:13:12 2013 -0600*

1. Some nginx config improvements:
  * Removed gzipping from config; it causes etags to be stripped.
  * Use appName as filename for nginx config instead, it's nicer.
  * __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/5db26dbe553cbf5b5fe12308658826ac2b29ce36)__

## 0.1.1 -> 0.2.0
*Fri Nov 8 14:31:53 2013 -0600*

1. Fix deprecation warnings.
  * __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/b4d87e8d3aaaac1b2e40be763c824dd3f300211a)__
1. Refactored controllers to consolidate routing into app/router.coffee.
  * __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/bda6a6a2a4ebf8543dfddaa3e8723d2b8ce16a88)__

## 0.1.0 -> 0.1.1
*Fri Nov 8 11:00:56 2013 -0600*

1. Added branch name to version info output.
  * __[view commit](http://gitlab.immense.net/seeds/express-seed/commit/8d15638d16282fab8f73635c75aa357d0e8b412c)__

## 0.1.0

1. Initial versioned release.
