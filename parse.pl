#!/usr/bin/env perl

use strict;
use lib "$ENV{HOME}/src/pegex-pm/lib";

use Pegex;
use YAML::XS;
use IO::All;

my $grammar = <<'...';

top: block

block:
  block-open
  ( block | phrase | assign )*
  block-close

block-open: /- PERCENT name ( DOT name )? - LCURLY NL /

block-close: /- RCURLY -/

name: / ( ALPHA WORD*) /

phrase: / - PERCENT name NL /
assign: / - PERCENT name ( DOT name )? EQUAL + string NL /

string: / - DOUBLE ([^ DOUBLE ]*) DOUBLE /
...

my $input = io("test1.huml")->all;

$ENV{PERL_PEGEX_DEBUG} = 1;
print YAML::XS::Dump pegex($grammar)->parse($input);

# vim: set sw=2 lisp:
