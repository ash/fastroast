use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 5;

dies-ok { Supply.grab }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à 개лàòò ìe̲中両갨𝐝';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(1..10).grab( {.reverse} ), [10...1], "w̲e̲ 개à丧 сe̲𝐯e̲сòe̲";
    tap-ok Supply.from-list(1..10).grab( {[min] $_} ), [1], "w̲e̲ 개à丧 е갢丧𝐝 中両e̲ ì갢丧";
}

# vim: expandtab shiftwidth=4
