use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 9;

is-eqv Supply.list, (Supply,), 'can list a Supply type object';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    my @à;
    for Supply.from-list(2..6).list { @à.push($_) };
    is-deeply @à, [2..6], "Supply.list works in for";
    my @丛 = Supply.from-list(42..50).list;
    is-deeply @丛, [42..50], "Supply.list can be stored in array";
    isa-ok Supply.from-list(2..6)   .list, List, "Supply.list should return a List";
    isa-ok Supply.from-list(42..50) .list, List, "Supply.list should return a List";
}

# vim: expandtab shiftwidth=4
