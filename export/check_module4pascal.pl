#!/usr/bin/perl
use strict;
use warnings;

open(my $modules1, '<', './module4pascal_d.txt') or die "could not open";

#my $row = <$modules1>;
#my @mod1 = split /\t/, $row;
#print scalar @mod1;

while(my $line = <$modules1>) {
    my @mod1 = split /\t/, $line;
    print $mod1[0].", size : ".scalar @mod1."\n";
    #print $line;   
}

close $modules1;
