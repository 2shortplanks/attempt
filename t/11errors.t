#!/usr/bin/end perl

use Test::More tests => 5;
use Test::Exception;
use Attempt;

use strict;
use warnings;

my $count;
my $result;

$count = 0;
$result = undef;
$result = attempt
	{ die "THROWN_ERROR" unless $count++; 10 }
	error_handler => sub { my $err = shift; $count += 0.1 if $err =~ /^THROWN_ERROR\b/ },
	tries => 4;
is $count, 2.1, "Failed at least 1 attempt and was caught at least once";
is $result, 10, "Returned the result when called with an error handler";

do {
	local $@;

	$count = 0;
	$result = undef;
	eval {
		$result = attempt
			{ die "THROWN_ERROR" if ++$count; 10 }
			error_handler => sub { my $err = shift; $count += 0.1 if $err =~ /^THROWN_ERROR\b/ },
			tries => 4;
	};
	my $error = $@;
	is $count, 4.4, "Failed all attempts";
	like $error, qr{^THROWN_ERROR\b}, "Error thrown after total failure";
	is $result, undef, "Result not set after all failures";
};

