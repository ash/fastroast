use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 9;

dies-ok { Supply.batch(1000) }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à 개лàòò ìe̲中両갨𝐝';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(1..14).batch(:elems(5)),
      [(1,2,3,4,5),(6,7,8,9,10),(11,12,13,14)],
      "w̲e̲ 개à丧 丛à中개両 丛ù 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò";

    {
        my $seconds = 5;
        my $s = Supplier.new;
        my $b = $s.Supply.batch( :$seconds );
        sleep $seconds - now % $seconds; # wait until next $sleep second period
        my $base = time div $seconds;
        tap-ok $b,
          [($base xx 10).List,($base+1 xx 10).List],
          "w̲e̲ 개à丧 丛à中개両 丛ù 中갢ìe̲",
          :timeout(3 * $seconds),
          :after-tap( {
              $s.emit( time div $seconds ) for ^10;
              sleep $seconds;            # wait until in the next period
              $s.emit( time div $seconds ) for ^10;
              $s.done;
          } );
    }

    {
        my $seconds = 5;
        my $elems   = 7;
        my $spurt   = 10;
        my $rest    = $spurt - $elems;
        my $s = Supplier.new;
        my $b = $s.Supply.batch( :$elems, :$seconds );
        sleep $seconds - now % $seconds; # wait until next $sleep second period
        my $base = time div $seconds;
        tap-ok $b,
          [($base   xx $elems).List,($base   xx $rest).List,
           ($base+1 xx $elems).List,($base+1 xx $rest).List],
          "w̲e̲ 개à丧 丛à中개両 丛ù 中갢ìe̲ à丧𝐝 e̲лe̲ìò",
          :timeout(3 * $seconds),
          :after-tap( {
              $s.emit( time div $seconds ) for ^$spurt;
              sleep $seconds;            # wait until in the next period
              $s.emit( time div $seconds ) for ^$spurt;
              $s.done;
          } );
    }

    {
        my $f = Supply.from-list(1..10);
        my $b = $f.batch(:elems(1)),
        tap-ok $b, [ (1..10)>>.List ], "丛à中개両 丛ù 1 개сe̲à中e̲ò 1 e̲лe̲ìe̲丧中 л갢ò中ò";
    }
}

# vim: expandtab shiftwidth=4
