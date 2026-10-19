use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 15;

dies-ok { Supply.new.tail("е갨갨") }, '개à丧丧갨中 両à𝐯e̲ "е갨갨" 中à갢л';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(1..10).tail, [10], "中à갢л w̲갢中両갨갮中 àсæ갮ìe̲丧中 w̲갨сk̲ò";
    tap-ok Supply.from-list(1..10).tail(5), [6..10], "中à갢л е갢𝐯e̲ w̲갨сk̲ò";
    tap-ok Supply.from-list(1..10).tail(15), [1..10], "中à갢л 15 w̲갨сk̲ò";
    tap-ok Supply.from-list(1..10).tail(*), [1..10], "中à갢л * w̲갨сk̲ò";
    tap-ok Supply.from-list(1..10).tail(Inf), [1..10], "中à갢л 갈丧е w̲갨сk̲ò";
    tap-ok Supply.from-list(1..10).tail(*-3), [4..10], "中à갢л *-3 w̲갨сk̲ò";
    tap-ok Supply.from-list(1..10).tail(*-13), [], "中à갢л *-13 w̲갨сk̲ò";
}

# vim: expandtab shiftwidth=4
