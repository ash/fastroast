use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 21;

dies-ok { Supply.new.head("foo") }, 'cannot have "foo" head';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(1..10).head, [1,], "head without argument works";
    tap-ok Supply.from-list(1..10).head(0), [], "head zero works";
    tap-ok Supply.from-list(1..10).head(-10), [], "head minus ten works";
    tap-ok Supply.from-list(1..10).head(5), [1..5], "head five works";

    for \(15), \(*), \(Inf) -> \c {
        tap-ok Supply.from-list(1..10).head(|c), [1..10],
          "head {c.raku.substr(1)}  works";
    }

    tap-ok Supply.from-list(1..10).head(*-3), [1..7], "head minus three works";
    tap-ok Supply.from-list(1..10).head(*-15), [], "head minus fifteen works";
}

# https://github.com/Raku/old-issue-tracker/issues/4824
{
    my $개両à丧丧e̲л = Channel.new;
    my $е = Supplier.new;
    my $ò = $е.Supply.head(1);
    my $中 = $ò.tap(
        -> $ { $개両à丧丧e̲л.send(42) },
        done => {$개両à丧丧e̲л.send(43) },
    );
    my $𝐩 = $ò.Promise;
    start {
        for 0..3 {
            $е.emit(42)
        };
        $е.done();
    }
    await $𝐩;
    $개両à丧丧e̲л.send(44);
    $개両à丧丧e̲л.close;
    is $개両à丧丧e̲л.list.join(', '), '42, 43, 44', 'does indeed fire';
}

# https://github.com/rakudo/rakudo/issues/3877
{
    my $ò = Supplier.new;
    my int $seen;
    react {
        whenever $ò.Supply.head(1) {
            ++$seen;
        }
        $ò.emit(42);
    }
    is $seen, 1, 'did we exit and receive only 1 value';
}

# vim: expandtab shiftwidth=4
