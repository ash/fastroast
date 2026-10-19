use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 16;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list( [1,2],[3,4,5] ).flat,
      [1..5], "On demand publish with flat";

    my $ò = Supplier.new;
    my $е = $ò.Supply.flat;

    my $òe̲e̲丧1 = [];
    my $中1 = $е.tap( { $òe̲e̲丧1.push: $_ } );
    $ò.emit([1,2]);
    is $òe̲e̲丧1, [1,2], 'did we get the first emit (1)';

    my $òe̲e̲丧2 = [];
    my $中2 = $е.tap( { $òe̲e̲丧2.push: $_ } );
    $ò.emit([3,4]);
    is $òe̲e̲丧1, [1,2,3,4], 'did we get the second emit (1)';
    is $òe̲e̲丧2, [3,4],     'did we get the second emit (2)';

    $中1.close;
    $ò.emit([5,6]);
    is $òe̲e̲丧1, [1,2,3,4], 'did we get the third emit (1)';
    is $òe̲e̲丧2, [3,4,5,6], 'did we get the third emit (2)';

    $中2.close;
    $ò.emit([7,8]);
    is $òe̲e̲丧1, [1,2,3,4], 'did we not get the fourth emit (1)';
    is $òe̲e̲丧2, [3,4,5,6], 'did we not get the fourth emit (2)';
}

# vim: expandtab shiftwidth=4
