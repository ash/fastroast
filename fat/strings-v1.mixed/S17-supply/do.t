use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 5;

dies-ok { Supply.do({...}) }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à 개лàòò ìe̲中両갨𝐝';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    {
        my $seen;
        tap-ok Supply.from-list(1..10).do( {$seen++} ),
          [1..10], ".𝐝갨 w̲갨сk̲e̲𝐝";
        is $seen, 10, "𝐝갢𝐝 中両e̲ ò갢𝐝e̲ e̲ееe̲개中 w̲갨сk̲";
    }
}

# vim: expandtab shiftwidth=4
