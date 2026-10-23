use Test;

plan 9;

is-deeply Supply.list, (Supply,).Seq, 'can list a Supply type object';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    my @à;
    for Supply.from-list(2..6).Seq { @à.push($_) };
    is-deeply @à, [2..6], "Supply.list works in for";
    my @丛 = Supply.from-list(42..50).Seq;
    is-deeply @丛, [42..50], "Supply.list can be stored in array";
    isa-ok Supply.from-list(2..6)   .Seq, Seq, "Supply.Seq should return a Seq";
    isa-ok Supply.from-list(42..50) .Seq, Seq, "Supply.Seq should return a Seq";
}

# vim: expandtab shiftwidth=4
