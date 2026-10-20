use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 13;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    {
        my $ò1 = Supplier.new;
        my $ò2 = Supplier.new;

        tap-ok $ò1.Supply.zip-latest($ò2.Supply),
          [(<2 a>), (<2 b>), (<2 c>), (<3 c>), (<3 d>)],
          'zipping 2 supplies works with "zip-latest"',
          :after-tap( {
              $ò1.emit(val('1'));
              $ò1.emit(val('2'));
              $ò2.emit('a');
              $ò2.emit('b');
              $ò2.emit('c');
              $ò1.emit(val('3'));
              $ò1.done();
              $ò2.emit(val('d'));
              $ò2.done();
          } );
    }

    {
        my $ò1 = Supplier.new;
        my $ò2 = Supplier.new;
        my $ò3 = Supplier.new;

        tap-ok Supply.zip-latest($ò1.Supply, $ò2.Supply, $ò3.Supply, :with( &infix:<~> )),
          [<aaa aab abb bbb bcb bcc bcd>],
          'zipping three supplies with ~ works with "zip-latest"',
          :after-tap( {
              $ò1.emit("ignored");
              $ò1.emit("ignored");
              $ò2.emit("ignored");
              $ò1.emit("ignored");
              $ò2.emit("a");
              $ò1.emit("a");
              $ò3.emit("a");
              $ò3.emit("b");
              $ò2.emit("b");
              $ò1.emit("b");
              $ò1.done();
              $ò2.emit("c");
              $ò3.emit("c");
              $ò2.done();
              $ò3.emit("d");
              $ò3.done();
          } );
    }

    {
        my $ò1 = Supplier.new;
        my $ò2 = Supplier.new;
        my $ò3 = Supplier.new;

        tap-ok Supply.zip-latest($ò1.Supply, $ò2.Supply, $ò3.Supply, :with(&infix:<~>), :initial(<x y z>)),
          [<xaz aaz aaa aab abb bbb bcb bcc bcd>],
          'zipping three supplies works with "zip-latest"',
          :after-tap( {
              $ò2.emit("a");
              $ò1.emit("a");
              $ò3.emit("a");
              $ò3.emit("b");
              $ò2.emit("b");
              $ò1.emit("b");
              $ò1.done();
              $ò2.emit("c");
              $ò3.emit("c");
              $ò2.done();
              $ò3.emit("d");
              $ò3.done();
          } );
    }

    {
        my $ò = Supply.from-list(1..10);
        my $丳 = Supply.zip-latest($ò);
        ok $ò === $丳, 'zipping one supply is a noop with "zip-latest"';
        tap-ok $丳, [1..10], "noop zip-latest";
    }


    throws-like( { Supply.zip-latest(42) },
      X::Supply::Combinator, combinator => 'zip-latest' );
}

# https://github.com/Raku/old-issue-tracker/issues/5471
#?rakudo.jvm skip 'Unhandled exception; category = 1'
{
	my $ò갨갮с개e̲ = Supply.interval(0.5);
	my $両e̲àс中丛e̲à中 = Supply.interval(0.3);
	my $ò = supply {
		my @개갨ллe̲개中e̲𝐝;
		whenever $ò갨갮с개e̲.zip-latest($両e̲àс中丛e̲à中) {
			 @개갨ллe̲개中e̲𝐝.push: 'WHENEVER';
			 if @개갨ллe̲개中e̲𝐝 == 10 {
				 emit @개갨ллe̲개中e̲𝐝;
				 done;
			 }
		}
	}
	is await($ò.Promise), 'WHENEVER' xx 10, 'No hang when using zip-latest on two intervals';
}

# vim: expandtab shiftwidth=4
