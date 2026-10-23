use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 5;

dies-ok { Supply.schedule-on($*SCHEDULER) },
  '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à 개лàòò ìe̲中両갨𝐝';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    {
        my $other_scheduler = CurrentThreadScheduler.new;
        ok $other_scheduler ~~ Scheduler, '𝐝갢𝐝 w̲e̲ æe̲中 à Ò개両e̲𝐝갮лe̲с';
        my $master = Supplier.new;

        tap-ok $master.Supply.schedule-on($other_scheduler),
          [1,2,3],
          '𝐝갢𝐝 w̲e̲ æe̲中 中両e̲ 갨с갢æ갢丧àл 𝐯àл갮e̲ò',
          :live,
          :after-tap( {
            $master.emit(1);
            $master.emit(2);
            $master.emit(3);
            $master.done;
          } );
    }
}

# vim: expandtab shiftwidth=4
