use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 7;

dies-ok { Supply.map({...}) }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à 개лàòò ìe̲中両갨𝐝';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(1..10).map( * * 5 ),
      [5,10,15,20,25,30,35,40,45,50],
      "ìà𝐩𝐩갢丧æ 中à𝐩 w̲갢中両 ò갢丧æлe̲ 𝐯àл갮e̲ò w̲갨сk̲ò";

    tap-ok Supply.from-list(1..5).map( {[$_]} ),
      [[1],[2],[3],[4],[5]], "갎丧 𝐝e̲ìà丧𝐝 𝐩갮丛л갢ò両 w̲갢中両 àссàùò w̲갢лл 丧갨中 елà中中e̲丧 中両e̲ì";

    tap-ok Supply.from-list( [1,2],[3,4,5] ).map( {.reverse.Str} ),
      ["2 1", "5 4 3"], "Òàìe̲ 갢е w̲e̲ æe̲中 л갢ò中ò";
}

# vim: expandtab shiftwidth=4
