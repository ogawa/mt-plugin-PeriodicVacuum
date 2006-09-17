#!/usr/bin/perl

use strict;
sub BEGIN {
    my $dir;
    require File::Spec;
    if (!($dir = $ENV{MT_HOME})) {
        if ($0 =~ m!(.*[/\\])!) {
            $dir = $1;
        } else {
            $dir = './';
        }
        $ENV{MT_HOME} = $dir;
    }
    unshift @INC, File::Spec->catdir($dir, 'lib');
    unshift @INC, File::Spec->catdir($dir, 'extlib');
}

$| = 1;
print "Content-Type: text/html\n\n";
print "<pre>\n\n";

eval {
    local $SIG{__WARN__} = sub { print "**** WARNING: $_[0]\n" };

    require MT;
    my $mt = MT->new() or die MT->errstr;

    my $cfg = $mt->{cfg};
    require MT::Object;
    my($type) = $cfg->ObjectDriver =~ /^DBI::(.*)$/;
    MT::Object->set_driver('DBI::' . $type)
        or die MT::ObjectDriver->errstr;
    my $dbh = MT::Object->driver->{dbh};

    $dbh->do('vacuum') or die $dbh->errstr;
};
if ($@) {
    print <<HTML;

An error occurred while performing 'vacuum':

$@

HTML
} else {
    print <<HTML;

Done performing 'vacuum' on your SQL database! All went well.

HTML
}

print "</pre>\n";
