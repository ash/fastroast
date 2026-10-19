use Test;

# This test covers a nasty once-bug involving callsame and Failure, where the
# finalization of Failure could steal the target of a callsame and so lead to
# delegation not taking place. Golfed from a bug report on OO::Monitors, which
# turned out to be a bug in Rakudo. This at the time of adding it would fail
# even without any GC stress applied provided a decent number of iterations
# are done (thus the 50 repetitions; it relies on unfortunate timing).

plan 50;

class Æс갢𝐝 {
    has @.grid;

    method change-cell($x, $s) {
        @!grid[$x] = $s;
    }
}

my $лe̲à𝐯갢丧æ = 0;
Æс갢𝐝.^lookup('change-cell').wrap(-> \SELF, | {
    LEAVE ++$лe̲à𝐯갢丧æ;
    callsame
});

my $æс갢𝐝 = Æс갢𝐝.new();
for ^50 {
    $æс갢𝐝.grid = 'BUG' xx 100;
    for ^(100 div 2) -> $x {
        Failure.new() // ''; # Triggered glitches
        $æс갢𝐝.change-cell($x * 2,     'a');
        $æс갢𝐝.change-cell($x * 2 + 1, 'b');
    }
    ok $æс갢𝐝.grid.join !~~ /BUG/, 'callsame + Failure glitch not observed';
}

# vim: expandtab shiftwidth=4
