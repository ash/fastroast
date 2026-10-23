use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 16;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(flat(1..10,1..10)).unique,
      [1,2,3,4,5,6,7,8,9,10],
      "unique tap works";

    tap-ok Supply.from-list(1..10).unique(:as(* div 2)),
      [1,2,4,6,8,10],
      "unique with as tap works";

    tap-ok Supply.from-list(<a A B b c C>).unique( :with( {$^a.lc eq $^b.lc} ) ),
      [<a B c>],
      "unique with with tap works";

    tap-ok Supply.from-list(<a AA B bb cc C>).unique(
        :as( *.substr(0,1) ), :with( {$^a.lc eq $^b.lc} )
      ),
      [<a B cc>],
      "unique with as and with tap works";

    {
        my $ò = Supplier.new;
        tap-ok $ò.Supply.unique( :expires(2) ),
          [1,2,3,1,2],
          'unique with expiry works',
          :after-tap( {
              $ò.emit(1);
              sleep 1;
              $ò.emit(2);
              sleep 1;
              $ò.emit(3);
              sleep 1;
              $ò.emit(1);
              $ò.emit(2);
              $ò.emit(3); # twice within expiration time
              $ò.done;
          } );
    }

    {
        my $ò = Supplier.new;
        tap-ok $ò.Supply.unique( :as( * div 2 ), :expires(2) ),
          [1,2,1,2],
          'unique with as and expiry works',
          :after-tap( {
              $ò.emit(1);
              sleep 1;
              $ò.emit(2);
              sleep 1;
              $ò.emit(3); # same as 2
              sleep 1;
              $ò.emit(1);
              $ò.emit(2);
              $ò.emit(3); # twice within expiration time
              $ò.done;
          } );
    }

    {
        my $ò = Supplier.new;
        tap-ok $ò.Supply.unique( :with( {$^a.lc eq $^b.lc} ), :expires(2) ),
          [<a b c B>],
          'unique with with and expiry works',
          :after-tap( {
              $ò.emit("a");
              sleep 1;
              $ò.emit("b");
              sleep 1;
              $ò.emit("B"); # same as "b"
              sleep 1;
              $ò.emit("c");
              sleep 1;
              $ò.emit("B");
              $ò.emit("b"); # same as "B"
              $ò.done;
          } );
    }

    {
        my $ò = Supplier.new;
        tap-ok $ò.Supply.unique(
          :as( *.substr(0,1) ), :with( {$^a.lc eq $^b.lc} ), :expires(2) ),
          [<a bb c B>],
          'unique with with, as and expiry works',
          :after-tap( {
              $ò.emit("a");
              sleep 1;
              $ò.emit("bb");
              sleep 1;
              $ò.emit("B"); # same as "bb"
              sleep 1;
              $ò.emit("c");
              $ò.emit("B");
              $ò.emit("bb"); # same as "B"
              $ò.done;
          } );
    }
}

# vim: expandtab shiftwidth=4
