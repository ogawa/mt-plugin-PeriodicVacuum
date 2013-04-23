# PeriodicVacuum Plugin

A plugin for performing periodic vacuum for Movable Type database.

This plugin is for Movable Type 3.3+, plus SQLite or Postgres. 

## Changes

 * 0.01 (2006-09-16 13:10:03Z):
   * First release.

## Overview

Movable Type database grows large and large, even if you delete spam trackbacks and comments occasionally.  Of course, you can shrink it manually by using SQLite command-line tool or something else, but I believe an avoidable mess should be avoided.

This plugin allows you to automatically perform ''vacuum'' operation once a week, and to keep database small enough.

This plugin is compatible only with Movable Type 3.3 or later, SQLite, and Postgres.  If you are using MySQL, you can easily perform "OPTIMIZE TABLE" via phpMyAdmin.

## Installation

To install this plugin, upload or copy 'PeriodicVacuum.pl' into your Movable Type's plugin directory.  After proper installation, you will see a new "PeriodicVacuum Plugin" listed on the Main Menu of your Movable Type.

After that, the patch enabled.

## See Also

## License

This code is released under the Artistic License. The terms of the Artistic License are described at [http://www.perl.com/language/misc/Artistic.html](http://www.perl.com/language/misc/Artistic.html).

## Author & Copyright

Copyright 2006, Hirotaka Ogawa (hirotaka.ogawa at gmail.com)
