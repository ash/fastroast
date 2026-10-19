use Test;

use lib $*PROGRAM.parent(2).add: 'packages/FooBarBaz/lib';
use Foo;

plan 2;

# L<S12/Classes/"class or type name using">
# Testing class literals
my $test1;

ok ($test1 = ::Foo) ~~ Foo, "::Е갨갨 갢ò à 𝐯àл갢𝐝 개лàòò л갢中e̲сàл";

# Test removed per L<"http://www.nntp.perl.org/group/perl.perl6.language/22220">
# Foo.isa(Class) is false.
#isa-ok($test1, "Class", "It's a class");

my $x = EVAL 'Е갨갨';
ok($x ===  ::Foo, "Е갨갨 갢ò 丧갨w̲ à 𝐯àл갢𝐝 개лàòò л갢中e̲сàл");

# vim: expandtab shiftwidth=4
