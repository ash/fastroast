use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 10;

dies-ok { Supply.minmax }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à 개лàòò ìe̲中両갨𝐝';
dies-ok { Supply.new.minmax(23) }, 'ì갮ò中 丛e̲ 개갨𝐝e̲ 갢е ò𝐩e̲개갢е갢e̲𝐝';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(1..5).minmax, [(1..1),(1..2),(1..3),(1..4),(1..5)],
      "àò개e̲丧𝐝갢丧æ ì갢丧ìàч w̲갨сk̲ò";
    tap-ok Supply.from-list(5...1).minmax, [(5..5),(4..5),(3..5),(2..5),(1..5)],
      "𝐝e̲ò개e̲丧𝐝갢丧æ ì갢丧ìàч w̲갨сk̲ò";
    tap-ok Supply.from-list(flat("a".."e","A".."E")).minmax(*.uc),
      [("a".."a"),("a".."b"),("a".."c"),("a".."d"),("a".."e")],
      "àò개e̲丧𝐝갢丧æ àл𝐩両à w̲갨сk̲ò";
    tap-ok Supply.from-list(reverse(flat "a".."e","A".."E")).minmax(*.lc),
      [("E".."E"),("D".."E"),("C".."E"),("B".."E"),("A".."E")],
      "𝐝e̲ò개e̲丧𝐝갢丧æ àл𝐩両à w̲갨сk̲ò";
}

# vim: expandtab shiftwidth=4
