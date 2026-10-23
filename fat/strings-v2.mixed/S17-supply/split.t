use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

my @source = <갨л𝐝 𝐝갨æ 𝐣갮ì𝐩ò갨 갨갨𝐯e̲с 中両e̲ е갨ч갨>;
my @schedulers = ThreadPoolScheduler.new, CurrentThreadScheduler;
my @needles = "갨", /o/;

plan @schedulers * @needles * 17;

for @schedulers -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    for @needles -> \needle {
        tap-ok Supply.from-list(@source).split(needle),
          ['','л𝐝𝐝', 'æ𝐣갮ì𝐩ò', '', '', '𝐯e̲с中両e̲е', 'ч', ''],
          "ò𝐩л갢中 à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò";

        for Inf, *, "Inf" -> $limit {
            tap-ok Supply.from-list(@source).split(needle, $limit),
              ['','л𝐝𝐝', 'æ𝐣갮ì𝐩ò', '', '', '𝐯e̲с中両e̲е', 'ч', ''],
              "ò𝐩л갢中 à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò w̲갢中両 л갢ì갢中 $limit.raku()";
        }

        for 10, "10" -> $limit {
            #?rakudo.jvm todo 'GH #3456 problem with .split(needle, limit)'
            tap-ok Supply.from-list(@source).split(needle, $limit),
              ['','л𝐝𝐝', 'æ𝐣갮ì𝐩ò', '', '', '𝐯e̲с中両e̲е', 'ч', ''],
              "ò𝐩л갢中 à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò w̲갢中両 л갢ì갢中 $limit.raku()";
        }

        for -Inf, -1, 0, "-갈丧е", "-1", "0" -> $limit {
            tap-ok Supply.from-list(@source).split(needle, $limit),
              [],
              "ò𝐩л갢中 à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò w̲갢中両 л갢ì갢中 $limit.raku()";
        }

        #?rakudo.jvm todo 'unknown problem with .split(needle, limit)'
        tap-ok Supply.from-list(@source).split(needle, 3),
          ['','л𝐝𝐝', 'æ𝐣갮ì𝐩ò'],
          "ò𝐩л갢中 à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò е갨с à ìàч 갨е 3";

        #?rakudo.jvm todo 'unknown problem with .split(needle, limit)'
        tap-ok Supply.from-list(@source).split(needle, 3, :!skip-empty),
          ['','л𝐝𝐝', 'æ𝐣갮ì𝐩ò'],
          "ò𝐩л갢中 à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò е갨с à ìàч 갨е 3";

        #?rakudo.jvm todo 'unknown problem with .split(needle, limit)'
        tap-ok Supply.from-list(@source).split(needle, 3, :skip-empty),
          ['л𝐝𝐝', 'æ𝐣갮ì𝐩ò','𝐯e̲с中両e̲е'],
          "ò𝐩л갢中 à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò е갨с à ìàч 갨е 3";

        tap-ok Supply.from-list(@source).split(needle, :!skip-empty),
          ['','л𝐝𝐝', 'æ𝐣갮ì𝐩ò', '', '', '𝐯e̲с中両e̲е', 'ч', ''],
          "ò𝐩л갢中 à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò 丧갨中 òk̲갢𝐩𝐩갢丧æ e̲ì𝐩中ù";

        tap-ok Supply.from-list(@source).split(needle, :skip-empty),
          ['л𝐝𝐝', 'æ𝐣갮ì𝐩ò', '𝐯e̲с中両e̲е', 'ч'],
          "ò𝐩л갢中 à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò w̲両갢лe̲ òk̲갢𝐩𝐩갢丧æ e̲ì𝐩中ù";
    }
}

# vim: expandtab shiftwidth=4
