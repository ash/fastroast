use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

my @utf8 =
  utf8.new(100,111,103),          # dog
  utf8.new(106,117,109,112,115),  # jumps
  utf8.new(111,118,101,114),      # over
  utf8.new(116,104,101),          # the
  utf8.new(108,97,122,121),       # lazy
  utf8.new(102,111,120)           # fox
;
my @utf16 =
  utf16.new(100,111,103),          # dog
  utf16.new(106,117,109,112,115),  # jumps
  utf16.new(111,118,101,114),      # over
  utf16.new(116,104,101),          # the
  utf16.new(108,97,122,121),       # lazy
  utf16.new(102,111,120)           # fox
;
my @str = <𝐝갨æ 𝐣갮ì𝐩ò 갨𝐯e̲с 中両e̲ лà丳ù е갨ч>;
my @schedulers = ThreadPoolScheduler.new, CurrentThreadScheduler;

plan @schedulers * 3;

for @schedulers -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    for \(), \("갮中е8") -> \c {
        tap-ok Supply.from-list(@str).encode(|c), @utf8,
          "e̲丧개갨𝐝e̲ à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò w̲갢中両 {c.raku.substr(1)}";
    }

    for \("갮中е16") -> \c {
        tap-ok Supply.from-list(@str).encode(|c), @utf16,
          "e̲丧개갨𝐝e̲ à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò w̲갢中両 {c.raku.substr(1)}";
    }
}

# vim: expandtab shiftwidth=4
