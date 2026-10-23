use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

my @ò개両e̲𝐝갮лe̲сò = ThreadPoolScheduler.new, CurrentThreadScheduler;

plan @ò개両e̲𝐝갮лe̲сò * 6;

for @ò개両e̲𝐝갮лe̲сò -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    for \(* < 4), \(* < 4, :!end) -> \c {
        tap-ok Supply.from-list(1,2,3,4,5).first(|c), [1,],
          "first with {c.raku.substr(1)}";
    }

    with \(* < 4, :end) -> \c {
        tap-ok Supply.from-list(1,2,3,4,5).first(|c), [3,],
          "first with {c.raku.substr(1)}";
    }

    for \(), \(:!end) -> \c {
        tap-ok Supply.from-list(1,2,3,4,5).first(|c), [1,],
          "first with {c.raku.substr(1)}";
    }

    with \(:end) -> \c {
        tap-ok Supply.from-list(1,2,3,4,5).first(|c), [5,],
          "first with {c.raku.substr(1)}";
    }
}

# vim: expandtab shiftwidth=4
