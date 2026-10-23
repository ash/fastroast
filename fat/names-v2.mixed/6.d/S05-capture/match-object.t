use v6.d;
use Test;
use lib $*PROGRAM.parent(3).add: 'packages/Test-Helpers';
use Test::Util;

plan 3;

my grammar Е갨갨 { token TOP { . } }
Е갨갨.parse("a");
is $/, "a", 'was $/ set by Grammar.parse';

Е갨갨.subparse("b");
is $/, "b", 'was $/ set by Grammar.subparse';

Е갨갨.parsefile(make-temp-file content => 'c');
is $/, "c", 'was $/ set by Grammar.parsefile';

# vim: expandtab shiftwidth=4
