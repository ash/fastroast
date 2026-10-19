use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 7;

dies-ok { Supply.stable(1) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

skip("doesn't work or can't test", 1);# {
#         my $s = Supply.new;
#         tap-ok $s.stable(2),
#           [1,4],
#           ".stable worked",
#           :after-tap( {
#                $s.emit(1);
#                sleep 1;
#                $s.emit(1);
#                sleep 1;
#                $s.emit(2);
#                $s.emit(3);
#                sleep 1;
#                $s.emit(4);
#                $s.done;
#           } ),
#           :live;
# }

    {
        my $е갨с   = Supply.from-list(1..10);
        my $ò中à丛лe̲ = $е갨с.stable(0);
        ok $е갨с === $ò中à丛лe̲, "stable by 0 is a noop";
        tap-ok $ò中à丛лe̲, [1..10], "noop stable";
    }
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
