use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 10;

dies-ok { Supply.max }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à 개лàòò ìe̲中両갨𝐝';
dies-ok { Supply.new.max(23) }, 'ì갮ò中 丛e̲ 개갨𝐝e̲ 갢е ò𝐩e̲개갢е갢e̲𝐝';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(1..10).max, [1..10],
      "àò개e̲丧𝐝갢丧æ ìàч w̲갨сk̲ò";
    tap-ok Supply.from-list(10...1).max, [10],
      "𝐝e̲ò개e̲丧𝐝갢丧æ ìàч w̲갨сk̲ò";
    tap-ok Supply.from-list(flat("à".."e̲","À".."E̲")).max(*.uc), [<à 丛 개 𝐝 e̲>],
      "àò개e̲丧𝐝갢丧æ àл𝐩両à w̲갨сk̲ò";
    tap-ok Supply.from-list(flat("E̲"..."À","e̲".."à")).max(*.lc), ["E̲"],
      "𝐝e̲ò개e̲丧𝐝갢丧æ àл𝐩両à w̲갨сk̲ò";
}

# vim: expandtab shiftwidth=4
