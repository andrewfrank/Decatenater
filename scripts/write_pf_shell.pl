#!/usr/bin/perl

use warnings;

$homedir = '/Users/Andrew';

$filelocation = $ARGV[0];
$filelocation =~ s/~/$homedir/;

$workingdir = $homedir . '/phylip_data';

chdir $workingdir;

open (PHY, 'ADNP.phy') or die "Can't open: $!";

$phy = <PHY>;

print $phy;

close PHY;

exit;