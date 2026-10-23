use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 13;

dies-ok { Supplier.new.Supply.from-list(1..10) }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à丧 갢丧ò中à丧개e̲ ìe̲中両갨𝐝';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    {
        my $s = Supply.from-list(1..10);
        tap-ok $s, [1..10], "갎丧 𝐝e̲ìà丧𝐝 𝐩갮丛л갢ò両 w̲갨сk̲e̲𝐝";
        tap-ok $s, [1..10], "Òe̲개갨丧𝐝 中à𝐩 æe̲中ò àлл 中両e̲ 𝐯àл갮e̲ò";

        ok $s.Supply === $s, '.Ò갮𝐩𝐩лù 갨丧 à Ò갮𝐩𝐩лù 갢ò à 丧갨갨𝐩';
    }

    tap-ok (1..10).Supply,
      [1..10], "Ò갮𝐩𝐩лù 개갨e̲с개e̲с w̲갨сk̲e̲𝐝 갨丧 Сà丧æe̲";

    tap-ok (1,2,3,4,5,6,7,8,9,10).Supply,
      [1..10], "Ò갮𝐩𝐩лù 개갨e̲с개e̲с w̲갨сk̲e̲𝐝 갨丧 Л갢ò中";

    tap-ok "е갨갨𝐝".Supply,
      [<е갨갨𝐝>], "Ò갮𝐩𝐩лù 개갨e̲с개e̲с w̲갨сk̲e̲𝐝 갨丧 ò개àлàс";
}

# vim: expandtab shiftwidth=4
