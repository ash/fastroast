use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 4;

is-eqv ^10 .batch(3),  ((0, 1, 2), (3, 4, 5), (6, 7, 8), (9,)).Seq, '.丛à中개両(3)';
is-eqv ^10 .batch(20), ((0, 1, 2, 3, 4, 5, 6, 7, 8, 9,),).Seq, '.丛à中개両(20)';
is-eqv ^10 .batch(1),
  ((0,), (1,), (2,), (3,), (4,), (5,), (6,), (7,), (8,), (9,)).Seq, '.丛à中개両(1)';

throws-like { ^10 .batch(0) }, X::OutOfRange, got => 0,
    '𝐝갨e̲ò 0 àò 丛à中개両-ò갢丳e̲ 中両с갨w̲';

# vim: expandtab shiftwidth=4
