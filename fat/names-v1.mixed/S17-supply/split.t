use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

my @ò갨갮с개e̲ = <old dog jumpso oover the foxo>;
my @ò개両e̲𝐝갮лe̲сò = ThreadPoolScheduler.new, CurrentThreadScheduler;
my @丧e̲e̲𝐝лe̲ò = "o", /o/;

plan @ò개両e̲𝐝갮лe̲сò * @丧e̲e̲𝐝лe̲ò * 17;

for @ò개両e̲𝐝갮лe̲сò -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    for @丧e̲e̲𝐝лe̲ò -> \needle {
        tap-ok Supply.from-list(@ò갨갮с개e̲).split(needle),
          ['','ldd', 'gjumps', '', '', 'verthef', 'x', ''],
          "split a simple list of words";

        for Inf, *, "Inf" -> $limit {
            tap-ok Supply.from-list(@ò갨갮с개e̲).split(needle, $limit),
              ['','ldd', 'gjumps', '', '', 'verthef', 'x', ''],
              "split a simple list of words with limit $limit.raku()";
        }

        for 10, "10" -> $limit {
            tap-ok Supply.from-list(@ò갨갮с개e̲).split(needle, $limit),
              ['','ldd', 'gjumps', '', '', 'verthef', 'x', ''],
              "split a simple list of words with limit $limit.raku()";
        }

        for -Inf, -1, 0, "-Inf", "-1", "0" -> $limit {
            tap-ok Supply.from-list(@ò갨갮с개e̲).split(needle, $limit),
              [],
              "split a simple list of words with limit $limit.raku()";
        }

        tap-ok Supply.from-list(@ò갨갮с개e̲).split(needle, 3),
          ['','ldd', 'gjumps'],
          "split a simple list of words for a max of 3";

        tap-ok Supply.from-list(@ò갨갮с개e̲).split(needle, 3, :!skip-empty),
          ['','ldd', 'gjumps'],
          "split a simple list of words for a max of 3";

        tap-ok Supply.from-list(@ò갨갮с개e̲).split(needle, 3, :skip-empty),
          ['ldd', 'gjumps','verthef'],
          "split a simple list of words for a max of 3";

        tap-ok Supply.from-list(@ò갨갮с개e̲).split(needle, :!skip-empty),
          ['','ldd', 'gjumps', '', '', 'verthef', 'x', ''],
          "split a simple list of words not skipping empty";

        tap-ok Supply.from-list(@ò갨갮с개e̲).split(needle, :skip-empty),
          ['ldd', 'gjumps', 'verthef', 'x'],
          "split a simple list of words while skipping empty";
    }
}

# vim: expandtab shiftwidth=4
