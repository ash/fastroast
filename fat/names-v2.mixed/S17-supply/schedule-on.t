use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 5;

dies-ok { Supply.schedule-on($*SCHEDULER) },
  'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    {
        my $갨中両e̲с_ò개両e̲𝐝갮лe̲с = CurrentThreadScheduler.new;
        ok $갨中両e̲с_ò개両e̲𝐝갮лe̲с ~~ Scheduler, 'did we get a Scheduler';
        my $ìàò中e̲с = Supplier.new;

        tap-ok $ìàò中e̲с.Supply.schedule-on($갨中両e̲с_ò개両e̲𝐝갮лe̲с),
          [1,2,3],
          'did we get the original values',
          :live,
          :after-tap( {
            $ìàò中e̲с.emit(1);
            $ìàò中e̲с.emit(2);
            $ìàò中e̲с.emit(3);
            $ìàò中e̲с.done;
          } );
    }
}

# vim: expandtab shiftwidth=4
