use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 9;

dies-ok { Supply.batch(1000) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(1..14).batch(:elems(5)),
      [(1,2,3,4,5),(6,7,8,9,10),(11,12,13,14)],
      "we can batch by number of elements";

    {
        my $seconds = 5;
        my $s = Supplier.new;
        my $丛 = $s.Supply.batch( :$seconds );
        sleep $seconds - now % $seconds; # wait until next $sleep second period
        my $丛àòe̲ = time div $seconds;
        tap-ok $丛,
          [($丛àòe̲ xx 10).List,($丛àòe̲+1 xx 10).List],
          "we can batch by time",
          :timeout(3 * $seconds),
          :after-tap( {
              $s.emit( time div $seconds ) for ^10;
              sleep $seconds;            # wait until in the next period
              $s.emit( time div $seconds ) for ^10;
              $s.done;
          } );
    }

    {
        my $seconds = 5;
        my $elems   = 7;
        my $ò𝐩갮с中   = 10;
        my $сe̲ò中    = $ò𝐩갮с中 - $elems;
        my $s = Supplier.new;
        my $丛 = $s.Supply.batch( :$elems, :$seconds );
        sleep $seconds - now % $seconds; # wait until next $sleep second period
        my $丛àòe̲ = time div $seconds;
        tap-ok $丛,
          [($丛àòe̲   xx $elems).List,($丛àòe̲   xx $сe̲ò中).List,
           ($丛àòe̲+1 xx $elems).List,($丛àòe̲+1 xx $сe̲ò中).List],
          "we can batch by time and elems",
          :timeout(3 * $seconds),
          :after-tap( {
              $s.emit( time div $seconds ) for ^$ò𝐩갮с中;
              sleep $seconds;            # wait until in the next period
              $s.emit( time div $seconds ) for ^$ò𝐩갮с中;
              $s.done;
          } );
    }

    {
        my $е = Supply.from-list(1..10);
        my $丛 = $е.batch(:elems(1)),
        tap-ok $丛, [ (1..10)>>.List ], "batch by 1 creates 1 element lists";
    }
}

# vim: expandtab shiftwidth=4
