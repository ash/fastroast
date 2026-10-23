use Test;

use lib $*PROGRAM.parent(2).add: 'packages/FooBarBaz/lib';
use Foo;

plan 2;

# L<S12/Classes/"class or type name using">
# Testing class literals
my $中e̲ò中1;

ok ($中e̲ò中1 = ::Foo) ~~ Foo, "::Foo is a valid class literal";

# Test removed per L<"http://www.nntp.perl.org/group/perl.perl6.language/22220">
# Foo.isa(Class) is false.
#isa-ok($test1, "Class", "It's a class");

my $ч = EVAL 'Foo';
ok($ч ===  ::Foo, "Foo is now a valid class literal");

# vim: expandtab shiftwidth=4
