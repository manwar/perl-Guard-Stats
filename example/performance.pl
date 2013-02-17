#!/usr/bin/perl -w

# usage: $0 <want_time> <number_of_buckets=100> <number_of_iterations=10000>

use strict;
use YAML;

use Guard::Stat;

my $time = shift;
my $size = shift || 100;
my $iter = shift || 10**4;

my $stat = Guard::Stat->new( want_time => $time );

my @bucket;
for (1..$iter) {
	$bucket[ $size * rand() ] = $stat->guard;
	if (my $obj = $bucket[ $size * rand() ]) {
		$obj->is_done || $obj->finish;
	};
	$bucket[ $size * rand() ] = undef;
};

print "Stats: ".Dump($stat->get_stat);
print "Times: ".Dump($stat->get_times);
