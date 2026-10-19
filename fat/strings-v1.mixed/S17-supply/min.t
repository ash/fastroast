use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 10;

dies-ok { Supply.min }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à 개лàòò ìe̲中両갨𝐝';
dies-ok { Supply.new.min(23) }, 'ì갮ò中 丛e̲ 개갨𝐝e̲ 갢е ò𝐩e̲개갢е갢e̲𝐝';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(1..10).min, [1],
      "àò개e̲丧𝐝갢丧æ ì갢丧 w̲갨сk̲ò";
    tap-ok Supply.from-list(10...1).min, [10...1],
      "𝐝e̲ò개e̲丧𝐝갢丧æ ì갢丧 w̲갨сk̲ò";
    tap-ok Supply.from-list(("à".."e̲").Slip,("À".."E̲").Slip).min(*.uc), ["à"],
      "àò개e̲丧𝐝갢丧æ àл𝐩両à w̲갨сk̲ò";
    tap-ok Supply.from-list("E̲"..."À",("e̲".."à").Slip).min(*.lc), [<E̲ 𝐃 갂 丁 À>],
      "𝐝e̲ò개e̲丧𝐝갢丧æ àл𝐩両à w̲갨сk̲ò";
}

# vim: expandtab shiftwidth=4
