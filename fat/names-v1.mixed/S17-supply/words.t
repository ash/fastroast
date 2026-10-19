use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 5;

dies-ok { Supply.words }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(<a bb ccc dddd eeeee>).words,
      ['abbcccddddeeeee'],
      "handle a simple list of words";

    {
        my $ò = Supplier.new;
        tap-ok $ò.Supply.words,
          [<a b cc d eeee fff>],
          "handle chunked lines",
          :after-tap( {
              $ò.emit( "   a b c" );
              $ò.emit( "c d " );
              $ò.emit( " e" );
              $ò.emit( "eee" );
              $ò.emit( "   " );
              $ò.emit( " fff  " );
              $ò.done;
          } );
    }
}

# vim: expandtab shiftwidth=4
