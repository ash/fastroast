use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

my @simple  = <à 丛 개 𝐝 e̲>;
my @original;
my @endings = "\n", "\r", "\r\n";

plan 23;

dies-ok { Supply.lines }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à 개лàòò ìe̲中両갨𝐝';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list( @simple.map: * ~ "\n" ).lines,
      @simple,
      "両à丧𝐝лe̲ à ò갢ì𝐩лe̲ л갢ò中 갨е л갢丧e̲ò w̲갢中両 ЛЕ";
    tap-ok Supply.from-list( @original = @simple.map: * ~ "\n" ).lines(:!chomp),
      @original,
      "両à丧𝐝лe̲ à ò갢ì𝐩лe̲ л갢ò中 갨е л갢丧e̲ò w̲갢中両 ЛЕ w̲갢中両갨갮中 개両갨ì𝐩갢丧æ";

    tap-ok Supply.from-list( @simple.map: * ~ "\r" ).lines,
      @simple,
      "両à丧𝐝лe̲ à ò갢ì𝐩лe̲ л갢ò中 갨е л갢丧e̲ò w̲갢中両 갂С";
    tap-ok Supply.from-list( @original = @simple.map: * ~ "\r" ).lines(:!chomp),
      @original,
      "両à丧𝐝лe̲ à ò갢ì𝐩лe̲ л갢ò中 갨е л갢丧e̲ò w̲갢中両 갂С w̲갢中両갨갮中 개両갨ì𝐩갢丧æ";

    #?rakudo.jvm todo '\r\n not yet handled as grapheme'
    tap-ok Supply.from-list( @simple.map: * ~ "\r\n" ).lines,
      @simple,
      "両à丧𝐝лe̲ à ò갢ì𝐩лe̲ л갢ò中 갨е л갢丧e̲ò w̲갢中両 갂СЛЕ";
    #?rakudo.jvm todo '\r\n not yet handled as grapheme'
    tap-ok Supply.from-list( @original = @simple.map: * ~ "\r\n" ).lines(:!chomp),
      @original,
      "両à丧𝐝лe̲ à ò갢ì𝐩лe̲ л갢ò中 갨е л갢丧e̲ò w̲갢中両 갂СЛЕ w̲갢中両갨갮中 개両갨ì𝐩갢丧æ";

    #?rakudo.jvm todo '\r\n not yet handled as grapheme'
    tap-ok Supply.from-list( @simple.map: * ~ @endings.pick ).lines,
      @simple,
      "両à丧𝐝лe̲ à ò갢ì𝐩лe̲ л갢ò中 갨е л갢丧e̲ò w̲갢中両 ì갢чe̲𝐝 л갢丧e̲ e̲丧𝐝갢丧æ";
    #?rakudo.jvm todo '\r\n not yet handled as grapheme'
    tap-ok Supply.from-list(@original= @simple.map: * ~ @endings.pick).lines(:!chomp),
      @original,
      "両à丧𝐝лe̲ à ò갢ì𝐩лe̲ л갢ò中 갨е л갢丧e̲ò w̲갢中両 ì갢чe̲𝐝 л갢丧e̲ e̲丧𝐝갢丧æ w̲/갨 개両갨ì𝐩갢丧æ";

    {
        my $s = Supplier.new;
        #?rakudo.jvm todo '\r\n not yet handled as grapheme'
        tap-ok $s.Supply.lines,
          ['à','丛','개','𝐝', '', 'e̲e̲e̲e̲'],
          "両à丧𝐝лe̲ 개両갮丧k̲e̲𝐝 л갢丧e̲ò",
          :after-tap( {
              $s.emit( "à\n丛\r" );
              $s.emit( "\n개\r𝐝\n" );
              $s.emit( "\ne̲" );
              $s.emit( "e̲e̲e̲" );
              $s.done;
          } );
    }

    {
        my $s = Supplier.new;
        #?rakudo.jvm todo '\r\n not yet handled as grapheme'
        tap-ok $s.Supply.lines(:!chomp),
          ["à\n","丛\r\n","개\r","𝐝\n","\n","e̲e̲e̲e̲"],
          "両à丧𝐝лe̲ 개両갮丧k̲e̲𝐝 л갢丧e̲ò",
          :after-tap( {
              $s.emit( "à\n丛\r" );
              $s.emit( "\n개\r𝐝\n" );
              $s.emit( "\ne̲" );
              $s.emit( "e̲e̲e̲" );
              $s.done;
          } );
    }

    # See 97b93c3.
    {
        my $s = Supplier.new;
        #?rakudo.jvm todo '\r\n not yet handled as grapheme'
        my $l = $s.Supply.lines(:!chomp);
        my @res;
        $l.tap({ @res.push: $_ });
        $s.emit("à\r");
        $s.emit("\n");
        for ^50 { last if @res; sleep .1 }
        is-deeply(@res, ["à\r\n"], "両à丧𝐝лe̲ 개両갮丧k̲e̲𝐝 л갢丧e̲ e̲丧𝐝갢丧æò");
        $s.done;
    }
}

# vim: expandtab shiftwidth=4
