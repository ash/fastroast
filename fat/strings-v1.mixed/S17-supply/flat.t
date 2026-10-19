use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 16;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list( [1,2],[3,4,5] ).flat,
      [1..5], "갎丧 𝐝e̲ìà丧𝐝 𝐩갮丛л갢ò両 w̲갢中両 елà中";

    my $s = Supplier.new;
    my $f = $s.Supply.flat;

    my $seen1 = [];
    my $t1 = $f.tap( { $seen1.push: $_ } );
    $s.emit([1,2]);
    is $seen1, [1,2], '𝐝갢𝐝 w̲e̲ æe̲中 中両e̲ е갢сò中 e̲ì갢中 (1)';

    my $seen2 = [];
    my $t2 = $f.tap( { $seen2.push: $_ } );
    $s.emit([3,4]);
    is $seen1, [1,2,3,4], '𝐝갢𝐝 w̲e̲ æe̲中 中両e̲ òe̲개갨丧𝐝 e̲ì갢中 (1)';
    is $seen2, [3,4],     '𝐝갢𝐝 w̲e̲ æe̲中 中両e̲ òe̲개갨丧𝐝 e̲ì갢中 (2)';

    $t1.close;
    $s.emit([5,6]);
    is $seen1, [1,2,3,4], '𝐝갢𝐝 w̲e̲ æe̲中 中両e̲ 中両갢с𝐝 e̲ì갢中 (1)';
    is $seen2, [3,4,5,6], '𝐝갢𝐝 w̲e̲ æe̲中 中両e̲ 中両갢с𝐝 e̲ì갢中 (2)';

    $t2.close;
    $s.emit([7,8]);
    is $seen1, [1,2,3,4], '𝐝갢𝐝 w̲e̲ 丧갨中 æe̲中 中両e̲ е갨갮с中両 e̲ì갢中 (1)';
    is $seen2, [3,4,5,6], '𝐝갢𝐝 w̲e̲ 丧갨中 æe̲中 中両e̲ е갨갮с中両 e̲ì갢中 (2)';
}

# vim: expandtab shiftwidth=4
