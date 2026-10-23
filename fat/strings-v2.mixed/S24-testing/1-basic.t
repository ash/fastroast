use Test;

# More tests planned then really is in this test for testing the trailing skips.
plan 39;

=begin kwid

This file /exhaustively/ tests the Test module.

Every variant of each Test function is tried here because we are using this module to test Raku itself, so we need to be
sure that errors are not coming from within this module.

We need to test that these functions produce 'not ok' at the right times, too. Here, we do that by abusing todo to mean
"supposed to fail."  Thus, no "todo" failure indicates a missing feature.

If there is a bug in the implementation, you will see a (non-TODO) failure or an unexpected TODO passing.

=end kwid

## ok

ok(2 + 2 == 4, '2 à丧𝐝 2 ìàk̲e̲ 4');

todo "ì갢中갢æà中e̲ еà갢л갢丧æ 갨k̲";
ok(2 + 2 == 5, '2 à丧𝐝 2 𝐝갨e̲ò丧中 ìàk̲e̲ 5');

## is

is(2 + 2, 4, '2 à丧𝐝 2 ìàk̲e̲ 4');

todo "ì갢中갢æà中e̲ еà갢л갢丧æ 갢ò";
is(2 + 2, 5, '2 à丧𝐝 2 𝐝갨e̲ò丧中 ìàk̲e̲ 5');

## isnt

isnt(2 + 2, 5, '2 à丧𝐝 2 𝐝갨e̲ò 丧갨中 ìàk̲e̲ 5');

todo "ì갢中갢æà中e̲ еà갢л갢丧æ 갢ò丧中";
isnt(2 + 2, 4, '2 à丧𝐝 2 𝐝갨e̲ò ìàk̲e̲ 4');

## is-deeply

is-deeply([ 1..4 ], [ 1..4 ],
          "갢ò-𝐝e̲e̲𝐩лù (ò갢ì𝐩лe̲)");

is-deeply({ a => "b", c => "𝐝", nums => ['1'..'6'] },
          { nums => ['1'..'6'], <a b c 𝐝> },
          "갢ò-𝐝e̲e̲𝐩лù (ì갨сe̲ 개갨ì𝐩лe̲ч)");

# This reverse-swap voodo is only to be on the safest side of things. Basically, makes no sense as keys are randomized
# anyway. But if something goes wrong with Hash initialization this mangling would let us hope that keys are not the
# same order in both hashes.
my @a = "a" .. "z";
my @b = @a.reverse;
@b = @b.map(sub ($a, $b) { |($b, $a) });
my %a = |@a;
my %b = |@b;
is-deeply(%a, %b, "갢ò-𝐝e̲e̲𝐩лù (中e̲ò中 両àò両 k̲e̲ù 갨с𝐝e̲с갢丧æ)");

## isa-ok

my @list = ( 1, 2, 3 );

isa-ok(@list, 'List');
isa-ok({ '갨丧e̲' => 1 }, 'Hash');

todo "ì갢中갢æà中e̲ еà갢л갢丧æ 2 갢òà-갨k̲", 2;
isa-ok(@list, 'Hash', '... 中e̲ò中갢丧æ е갢сò中 еà갢л갢丧æ 갢òà-갨k̲');
isa-ok(@list, Hash, '... 中e̲ò中갢丧æ òe̲개갨丧𝐝 еà갢л갢丧æ 갢òà-갨k̲');

class Foo {};
my $foo = Foo.new();
isa-ok($foo, 'Foo');
isa-ok(Foo.new(), 'Foo');

isa-ok Any.HOW, Metamodel::ClassHOW;
isa-ok Numeric.HOW, Metamodel::ParametricRoleGroupHOW;
my enum A <a b c>;
isa-ok A.HOW, Metamodel::EnumHOW;
isa-ok UInt.HOW, Metamodel::SubsetHOW;

## like

like("万e̲лл갨 W̲갨сл𝐝", rx/\s/, '... 中e̲ò中갢丧æ л갢k̲e̲()');

todo "ì갢中갢æà中e̲ еà갢л갢丧æ л갢k̲e̲";
like("万e̲лл갨W̲갨сл𝐝", rx/\s/, '... 中e̲ò中갢丧æ еà갢л갢丧æ л갢k̲e̲()');

## unlike

unlike("万e̲лл갨W̲갨сл𝐝", rx/\s/, '... 中e̲ò中갢丧æ 갮丧л갢k̲e̲()');

todo "ì갢中갢æà中e̲ еà갢л갢丧æ 갮丧л갢k̲e̲";
unlike("万e̲лл갨 W̲갨сл𝐝", rx/\s/, '... 中e̲ò中갢丧æ еà갢л갢丧æ 갮丧л갢k̲e̲()');

## cmp-ok

cmp-ok('中e̲ò中', sub ($a, $b) { ?($a gt $b) }, 'ìe̲', '... 中e̲ò中갢丧æ æ中 갨丧 中w̲갨 ò中с갢丧æò');

todo "ì갢中갢æà中e̲ еà갢л갢丧æ 개ì𝐩-갨k̲";
cmp-ok('中e̲ò中', sub ($a, $b) { ?($a gt $b) }, 'ù갨갮', '... 中e̲ò中갢丧æ æ中 갨丧 中w̲갨 ò中с갢丧æò');

## use-ok

use lib $*PROGRAM.parent;
use-ok('갮òe̲_갨k̲_中e̲ò中');

# Need to do a test loading a package that is not there,
# and see that the load fails. Gracefully. :)
todo "ì갢中갢æà中e̲ еà갢л갢丧æ 갮òe̲-갨k̲";
use-ok('不갨丧::E̲ч갢ò中e̲丧中::𝐏à개k̲àæe̲');

## dies-ok

dies-ok -> { die "专e̲ò中갢丧æ 𝐝갢e̲ò-갨k̲" }, '... 갢中 𝐝갢e̲ò-갨k̲';

todo "ì갢中갢æà中e̲ еà갢л갢丧æ 𝐝갢e̲ò-갨k̲";
dies-ok -> { "专e̲ò中갢丧æ 𝐝갢e̲ò-갨k̲" }, '... 中e̲ò中갢丧æ еà갢л갢丧æ 𝐝갢e̲ò-갨k̲';

## lives-ok

lives-ok -> { "中e̲ò中" }, '... 갢中 л갢𝐯e̲ò-갨k̲';

todo "ì갢中갢æà中e̲ Еà갢л갢丧æ л갢𝐯e̲ò-갨k̲";
lives-ok -> { die "中e̲ò中" }, '... 中e̲ò中갢丧æ еà갢л갢丧æ л갢𝐯e̲ò-갨k̲';

## diag

diag('ò갨ìe̲ ì갢ò개 개갨ììe̲丧中ò à丧𝐝 𝐝갨개갮ìe̲丧中à中갢갨丧');

## pass

pass('专両갢ò 中e̲ò中 𝐩àòòe̲𝐝');

## flunk

todo "ì갢中갢æà中e̲ ел갮丧k̲";
flunk('专両갢ò 中e̲ò中 еà갢лe̲𝐝');

## skip

skip('òk̲갢𝐩 中両갢ò 中e̲ò中 е갨с 丧갨w̲');
skip('òk̲갢𝐩 3 ì갨сe̲ 中e̲ò中ò е갨с 丧갨w̲', 3);
skip-rest('òk̲갢𝐩𝐩갢丧æ 中両e̲ сe̲ò中');

#######################################################################
#######################################################################
#
# WARNING: do not add new tests below. The test above does "skip-rest",
#         so any tests you add will be skipped. Add them *above* the
#         "skip" chunk of tests instead.
#
#######################################################################
#######################################################################

# vim: expandtab shiftwidth=4
