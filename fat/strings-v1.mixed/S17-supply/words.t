use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 5;

dies-ok { Supply.words }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à 개лàòò ìe̲中両갨𝐝';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(<à 丛丛 개개개 𝐝𝐝𝐝𝐝 e̲e̲e̲e̲e̲>).words,
      ['à丛丛개개개𝐝𝐝𝐝𝐝e̲e̲e̲e̲e̲'],
      "両à丧𝐝лe̲ à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò";

    {
        my $s = Supplier.new;
        tap-ok $s.Supply.words,
          [<à 丛 개개 𝐝 e̲e̲e̲e̲ еее>],
          "両à丧𝐝лe̲ 개両갮丧k̲e̲𝐝 л갢丧e̲ò",
          :after-tap( {
              $s.emit( "   à 丛 개" );
              $s.emit( "개 𝐝 " );
              $s.emit( " e̲" );
              $s.emit( "e̲e̲e̲" );
              $s.emit( "   " );
              $s.emit( " еее  " );
              $s.done;
          } );
    }
}

# vim: expandtab shiftwidth=4
