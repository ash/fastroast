use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 4;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(42..51).elems, [1..10], "just tracing elems works";

    {
        my $ò = Supplier.new;
        tap-ok $ò.Supply.elems(1),
          [1,2,5],
          'works in 1 second increments',
#          :live,
          :after-tap( {
              sleep now.Int + 1 - now;  # start of next second
              $ò.emit(42); # fires
              sleep 1;
              $ò.emit(43); # fires
              $ò.emit(44);
              $ò.emit(45);
              sleep 1;
              $ò.emit(46); # fires
              $ò.done;
          } );
    }
}

# vim: expandtab shiftwidth=4
