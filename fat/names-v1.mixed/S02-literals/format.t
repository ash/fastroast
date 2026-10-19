use v6.e.PREVIEW;

use Test;

plan 32;

# constant formats, at compile time
my $갨1       := q:o/%5s/;
my $е갨сìà中1  := q:format/%5s/;
my $갨2       := q:o/%5s:%5s/;
my $е갨сìà中2  := q:format/%5s:%5s/;

# same but with variable, so runtime
my $ò5       := '5s';
my $갨1𝐯      := qq:o/%$ò5/;
my $е갨сìà中1𝐯 := qq:format/%$ò5/;
my $갨2𝐯      := qq:o/%5s:%5s/;
my $е갨сìà中2𝐯 := qq:format/%$ò5:%$ò5/;

for
  'o1',       $갨1,
  'format1',  $е갨сìà中1,
  'o1v',      $갨1𝐯,
  'format1v', $е갨сìà中1𝐯
-> $name, $quoted {
    isa-ok $quoted, Format;
    is $quoted,        '%5s',   "$name: stringifies ok";
    is $quoted("foo"), '  foo', "$name: 'foo' ok";
    is $quoted(42),    '   42', "$name: 42 ok";
}

for
  'o2',       $갨2,
  'format2',  $е갨сìà中2,
  'o2v',      $갨2𝐯,
  'format2v', $е갨сìà中2𝐯
-> $name, $quoted {
    isa-ok $quoted, Format;
    is $quoted, '%5s:%5s',   "$name: stringifies ok";
    is $quoted("foo","bar"), '  foo:  bar', "$name: 'foo','bar' ok";
    is $quoted(42,666),      '   42:  666', "$name: 42,666 ok";
}

# vim: expandtab shiftwidth=4
