#!/usr/bin/perl
use strict;
use warnings;

open(my $modules1, '<', './module4pascal_d.txt') or die "could not open";

#my $row = <$modules1>;
#my @mod1 = split /\t/, $row;
#print scalar @mod1;

while(my $line = <$modules1>) {
    my @mod1 = split /\t/, $line;
    my $num_modules = scalar @mod1 - 2;
    print $mod1[0].", size : ".$num_modules."\n";


    my @filtered = uniq(@mod1);
    if (@filtered != @mod1) {
        print '\n ALERT !! \n';
    }
}

close $modules1;

#array with uniques only
sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}

