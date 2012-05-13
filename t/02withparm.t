#!/usr/bin/perl

use Test::More tests => 8;
use Test::Exception;
use Attempt;

use strict;
use warnings;

{
  my $c = 0;

  sub bar
  {
    ok(1,"call test ".($c+1));
    return $c++;
  }
}

my $foo;
lives_ok {
attempt
{
  $foo = bar();
  die "foo is '$foo'" unless $foo > 2;
} tries => 4;
} "dies ok";

is($foo,"3","foo test");

my $baz;
lives_ok {
	$baz = attempt { bar() } tries => 0;
} 'attempt is NOOP with 0 tries';
is $baz, undef, 'left-hand side is undefined after 0 tries';


