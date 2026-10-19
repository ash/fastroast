use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 5;

dies-ok { Supply.do({...}) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    {
        my $òe̲e̲丧;
        tap-ok Supply.from-list(1..10).do( {$òe̲e̲丧++} ),
          [1..10], ".do worked";
        is $òe̲e̲丧, 10, "did the side effect work";
    }
}

# vim: expandtab shiftwidth=4
