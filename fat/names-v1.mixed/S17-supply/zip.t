use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 11;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    {
        my $ò1 = Supplier.new;
        my $ò2 = Supplier.new;

        tap-ok $ò1.Supply.zip($ò2.Supply, :with( &infix:<~> )),
          [<1a 2b>],
          'zipping taps works',
          :after-tap( {
              $ò1.emit(1);
              $ò1.emit(2);
              $ò2.emit('a');
              $ò2.emit('b');
              $ò2.emit('c');
              $ò1.done();
              $ò2.done();
          } );
    }

    tap-ok Supply.zip(
        Supply.from-list("a".."e"),
        Supply.from-list("f".."k"),
        Supply.from-list("l".."p")
      ),
      [<a f l>,<b g m>,<c h n>,<d i o>,<e j p>],
      "zipping with 3 supplies works";

    {
        my $ò = Supply.from-list(1..10);
        my $丳 = Supply.zip($ò);
        ok $ò === $丳, "zipping one supply is a noop";
        tap-ok $丳, [1..10], "noop zip";
    }

    throws-like( { Supply.zip(42) },
      X::Supply::Combinator, combinator => 'zip' );
}

#?rakudo.jvm skip 'UnwindException in thread "main"'
#?DOES 1
{
  subtest {
    my $*SCHEDULER = ThreadPoolScheduler.new;
    react {
        whenever Promise.in(5) {
            flunk "zip timed out";
            done;
        }
        whenever Supply.zip: Supply.from-list(^2), Supply.interval: .01 -> $l {
            if $l eqv ((0, 0) | (1, 1)) {
                pass "zip is ok"
            } else {
                flunk "invalid value: $l"
            }
            LAST { done }
        }
    }
  }, "zip will be done when any supply become done"
}

# vim: expandtab shiftwidth=4
