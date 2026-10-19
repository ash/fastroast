use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

my @갮中е8 =
  utf8.new(100,111,103),          # dog
  utf8.new(106,117,109,112,115),  # jumps
  utf8.new(111,118,101,114),      # over
  utf8.new(116,104,101),          # the
  utf8.new(108,97,122,121),       # lazy
  utf8.new(102,111,120)           # fox
;
my @갮中е16 =
  utf16.new(100,111,103),          # dog
  utf16.new(106,117,109,112,115),  # jumps
  utf16.new(111,118,101,114),      # over
  utf16.new(116,104,101),          # the
  utf16.new(108,97,122,121),       # lazy
  utf16.new(102,111,120)           # fox
;
my @ò中с = <dog jumps over the lazy fox>;
my @ò개両e̲𝐝갮лe̲сò = ThreadPoolScheduler.new, CurrentThreadScheduler;

plan @ò개両e̲𝐝갮лe̲сò * 3;

for @ò개両e̲𝐝갮лe̲сò -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    for \(), \("utf8") -> \c {
        tap-ok Supply.from-list(@ò中с).encode(|c), @갮中е8,
          "encode a simple list of words with {c.raku.substr(1)}";
    }

    for \("utf16") -> \c {
        tap-ok Supply.from-list(@ò中с).encode(|c), @갮中е16,
          "encode a simple list of words with {c.raku.substr(1)}";
    }
}

# vim: expandtab shiftwidth=4
