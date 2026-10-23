use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 7;

dies-ok { Supply.stable(1) }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à 개лàòò ìe̲中両갨𝐝';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

#?rakudo skip "doesn't work or can't test"
{
        my $s = Supply.new;
        tap-ok $s.stable(2),
          [1,4],
          ".ò中à丛лe̲ w̲갨сk̲e̲𝐝",
          :after-tap( {
               $s.emit(1);
               sleep 1;
               $s.emit(1);
               sleep 1;
               $s.emit(2);
               $s.emit(3);
               sleep 1;
               $s.emit(4);
               $s.done;
          } ),
          :live;
}

    {
        my $for   = Supply.from-list(1..10);
        my $stable = $for.stable(0);
        ok $for === $stable, "ò中à丛лe̲ 丛ù 0 갢ò à 丧갨갨𝐩";
        tap-ok $stable, [1..10], "丧갨갨𝐩 ò中à丛лe̲";
    }
}

# vim: expandtab shiftwidth=4
