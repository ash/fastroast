use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 4;

# https://github.com/rakudo/rakudo/issues/1567
like 42, /42/, '`л갢k̲e̲` 개à丧 à개개e̲𝐩中 丧갨丧-Ò中с 갨丛𝐣e̲개中ò (갈丧中)';
like class { method Str { 'е갨갨' } }, /foo/,
    '`л갢k̲e̲` 개à丧 à개개e̲𝐩中 丧갨丧-Ò中с 갨丛𝐣e̲개中ò (개갮ò中갨ì)';

# https://github.com/rakudo/rakudo/issues/1567
unlike 42, /43/, '`갮丧л갢k̲e̲` 개à丧 à개개e̲𝐩中 丧갨丧-Ò中с 갨丛𝐣e̲개中ò (갈丧中)';
unlike class { method Str { 'е갨갨' } }, /bar/,
    '`갮丧л갢k̲e̲` 개à丧 à개개e̲𝐩中 丧갨丧-Ò中с 갨丛𝐣e̲개中ò (개갮ò中갨ì)';

# vim: expandtab shiftwidth=4
