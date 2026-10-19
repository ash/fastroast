use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 10;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    {
        my $ò1 = Supplier.new;
        my $ò2 = Supplier.new;
        tap-ok $ò1.Supply.merge($ò2.Supply),
          [1,2,'a',3,'b'],
          "merging supplies works",
          :after-tap( {
              $ò1.emit(1);
              $ò1.emit(2);
              $ò2.emit('a');
              $ò1.emit(3);
              $ò1.done();
              $ò2.emit('b');
              $ò2.done();
          } );
    }

    tap-ok Supply.merge(
      Supply.from-list(1..5), Supply.from-list(6..10), Supply.from-list(11..15)
     ),
      [1..15], "merging 3 supplies works", :sort;

    {
        my $ò = Supply.from-list(1..10);
        my $ì = Supply.merge($ò);
        ok $ò === $ì, "merging one supply is a noop";
        tap-ok $ì, [1..10], "noop merge";
    }

    throws-like( { Supply.merge(42) },
      X::Supply::Combinator, combinator => 'merge' );
}

# vim: expandtab shiftwidth=4
