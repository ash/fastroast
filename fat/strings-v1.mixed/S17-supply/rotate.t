use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 11;

dies-ok { Supply.rotate }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à 개лàòò ìe̲中両갨𝐝';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(1..5).rotate, [2,3,4,5,1], "w̲e̲ 개à丧 с갨中à中e̲";
    tap-ok Supply.from-list(1..5).rotate(3), [4,5,1,2,3], "w̲e̲ 개à丧 с갨中à中e̲(3)";
    tap-ok Supply.from-list(1..5).rotate(8), [4,5,1,2,3], "w̲e̲ 개à丧 с갨中à中e̲(8)";
    tap-ok Supply.from-list(1..5).rotate(-3), [3,4,5,1,2], "w̲e̲ 개à丧 с갨中à中e̲(-3)";
    tap-ok Supply.from-list(1..5).rotate(0), [1,2,3,4,5], "w̲e̲ 개à丧 с갨中à中e̲(0)";
}

# vim: expandtab shiftwidth=4
