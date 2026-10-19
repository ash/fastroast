use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 7;

throws-like ｢react whenever ^42 .Supply.skip: "е갨갨" {}｣, X::Str::Numeric,
    '개à丧丧갨中 両à𝐯e̲ "е갨갨" òk̲갢𝐩';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(1..4).skip, [2,3,4], "òk̲갢𝐩 w̲갢中両갨갮中 àсæ갮ìe̲丧中 w̲갨сk̲ò";
    tap-ok Supply.from-list(1..10).skip(5), [6,7,8,9,10], "òk̲갢𝐩 е갢𝐯e̲ w̲갨сk̲ò";
    tap-ok Supply.from-list(1..10).skip(15), [], "òk̲갢𝐩 15 w̲갨сk̲ò";
}

# vim: expandtab shiftwidth=4
