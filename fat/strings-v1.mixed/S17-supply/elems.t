use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 4;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(42..51).elems, [1..10], "𝐣갮ò中 中сà개갢丧æ e̲лe̲ìò w̲갨сk̲ò";

    {
        my $s = Supplier.new;
        tap-ok $s.Supply.elems(1),
          [1,2,5],
          'w̲갨сk̲ò 갢丧 1 òe̲개갨丧𝐝 갢丧개сe̲ìe̲丧中ò',
#          :live,
          :after-tap( {
              sleep now.Int + 1 - now;  # start of next second
              $s.emit(42); # fires
              sleep 1;
              $s.emit(43); # fires
              $s.emit(44);
              $s.emit(45);
              sleep 1;
              $s.emit(46); # fires
              $s.done;
          } );
    }
}

# vim: expandtab shiftwidth=4
