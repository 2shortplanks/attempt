#!perl
############## STANDARD Test::Pod TEST - DO NOT EDIT ####################
use strict;
use Test::More;
eval "use Test::Pod 1.14";
plan skip_all => "Test::Pod 1.14 required for testing POD" if $@;
all_pod_files_ok();
