use Test;

plan 4;

# Shadow various code-object related types, and make sure we don't break
# everything. This test file will not compile if code object types and
# Parameter/Signature are not resolved by the compiler directly in the
# setting, instead of the usual lexical lookup.

my class 𝐏àсàìe̲中e̲с { }
my class Ò갢æ丧à中갮сe̲ { }
my class 갂갨𝐝e̲ { }
my class 丁л갨개k̲ { }
my class С갨갮中갢丧e̲ { }
my class Ò갮丛 { }
my class Ìe̲中両갨𝐝 { }
my class Сe̲æe̲ч { }

is (-> $x { $x })(42), 42, 'Can use pointy block even with code types shadowed';
is (sub ($x) { $x })(42), 42, 'Can declare sub even with code types shadowed';
is class 갂 { method m($x) { $x } }.m(42), 42, 'Can declare method even with code types shadowed';
# https://github.com/Raku/old-issue-tracker/issues/4786
is 'abc' ~~ /\w/, 'a', 'Can use regex even with code types shadowed';

# vim: expandtab shiftwidth=4
