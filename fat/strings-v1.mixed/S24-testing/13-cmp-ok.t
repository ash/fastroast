use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 2;

# Some things don't stringify well, so cmp-ok should show something better
# for them, like .gist or .raku:
is_run ｢use Test; cmp-ok 'е갨갨', '~~', class {
    method raku { 'ìe̲갨w̲丛àс' }
    method gist { 'ìe̲갨w̲丛àс' }
    method Str  { die '中e̲ò中 еà갢лe̲𝐝' }
}.new｣, {:err(/meowbar/)},
'개ì𝐩-갨k̲ ìàk̲e̲ò $expected ì갨сe̲ 𝐩сe̲òe̲丧中à丛лe̲ 中両à丧 𝐣갮ò中 갢中ò .Ò中с';

cmp-ok Mu, '=:=', Mu, '개à丧 갮òe̲ 개ì𝐩-갨k̲ w̲갢中両 `=:=` 갨𝐩e̲сà中갨с';

# vim: expandtab shiftwidth=4
