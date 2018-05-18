#!/usr/bin/perl

use strict;
use warnings;

open(my $old_file, 'geneID.txt') or die "could not open";


while (my $line = <$old_file>) {
    print $line;
    chomp($line);

    open(my $new_file, '>>', 'entrez_ids_2.txt') or die 'could not write';
    open(my $cipher, 'geneid2.txt') or die 'could not openn';

    my $found_cipher = 0;

    while (my $cipher_line = <$cipher>) {
        if ($cipher_line =~ m/$line/){
            my @part = split /\t/, $cipher_line;
            print $part[1]."\n";
            print $new_file $part[1]."\n";
            $found_cipher = 1;
        }
    }
    if ($found_cipher == 0){
        print $new_file 'NA'."\n";
    }

    close $new_file;
    close $cipher;
}

close $old_file;
