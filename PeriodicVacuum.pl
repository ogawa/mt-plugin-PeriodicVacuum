# PeriodicVacuum - perform DB vacuum periodically.
#
# $Id$
#
# This software is provided as-is. You may use it for commercial or 
# personal use. If you distribute it, please keep this notice intact.
#
# Copyright (c) 2006 Hirotaka Ogawa

package MT::Plugin::PeriodicVacuum;
use strict;
use MT;
use base 'MT::Plugin';

our $VERSION = '0.01';
my $plugin = __PACKAGE__->new({
    name => 'PeriodicVacuum Plugin',
    description => 'A plugin for performing DB vacuum periodically.',
    doc_link => 'http://code.as-is.net/wiki/PeriodicVacuum_Plugin',
    author_name => 'Hirotaka Ogawa',
    author_link => 'http://profile.typekey.com/ogawa/',
    version => $VERSION,
    callbacks => {
	'CMSPostDelete.blog' => \&cb_vacuum,
	'CMSPostDelete.notification' => \&cb_vacuum,
	'CMSPostDelete.author' => \&cb_vacuum,
	'CMSPostDelete.category' => \&cb_vacuum,
	'CMSPostDelete.comment' => \&cb_vacuum,
	'CMSPostDelete.entry' => \&cb_vacuum,
	'CMSPostDelete.ping' => \&cb_vacuum,
	'CMSPostDelete.template' => \&cb_vacuum,
	'CMSPostDelete.tag' => \&cb_vacuum,
    },
    tasks => {
	'PeriodicVacuum' => {
	    name => "Periodic Vacuum (weekly)",
	    frequency => 24 * 60 * 60 * 7,
	    code => \&vacuum,
	},
    },
});
MT->add_plugin($plugin);

sub cb_vacuum { $_[1]->run_tasks('PeriodicVacuum') }

sub vacuum {
    my $driver = MT::Object->driver;
    if ($driver) {
	my $dbh = $driver->{dbh};
	$dbh->do('vacuum;') or return $driver->error($dbh->err);
    }
}

1;
