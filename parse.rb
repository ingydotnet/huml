#!/usr/bin/env ruby

require 'pegex'
require 'yaml'

grammar = <<'...'

top: block

block:
  block_open
  ( block | phrase | assign )*
  block_close

block_open: /~ <PERCENT> <name> ( <DOT> <name> )? ~ <LCURLY> <NL> /

block_close: /~ <RCURLY> ~/

name: / ( <ALPHA> <WORD>*) /

phrase: / ~ <PERCENT> <name> <NL> /
assign: / ~ <PERCENT> <name> ( <DOT> <name> )? <EQUAL> ~~ <string> <NL> /

string: / ~ <DOUBLE> ([^ <DOUBLE> ]*) <DOUBLE> /
...

input = File.read("test1.huml")

ENV['RUBY_PEGEX_DEBUG'] = '1'

puts YAML.dump pegex(grammar).parse(input)

# vim: set sw=2 lisp:
