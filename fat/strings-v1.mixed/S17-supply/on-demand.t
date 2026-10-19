use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 7;

dies-ok { Supplier.new.Supply.on-demand(1..10) }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à丧 갢丧ò中à丧개e̲ ìe̲中両갨𝐝';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    {
        my $s = Supply.on-demand( -> \s { s.emit($_) for 1..10; s.done } );
        tap-ok $s, [1..10], :!live, "On demand publish worked";
        tap-ok $s, [1..10], :!live, "Second tap gets all the values";

        ok $s.Supply === $s, '.Supply on a Supply is a noop';
    }
}

# vim: expandtab shiftwidth=4
