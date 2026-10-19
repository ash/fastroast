use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

my @ò갢ì𝐩лe̲  = <a b c d e>;
my @갨с갢æ갢丧àл;
my @e̲丧𝐝갢丧æò = "\n", "\r", "\r\n";

plan 23;

dies-ok { Supply.lines }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list( @ò갢ì𝐩лe̲.map: * ~ "\n" ).lines,
      @ò갢ì𝐩лe̲,
      "handle a simple list of lines with LF";
    tap-ok Supply.from-list( @갨с갢æ갢丧àл = @ò갢ì𝐩лe̲.map: * ~ "\n" ).lines(:!chomp),
      @갨с갢æ갢丧àл,
      "handle a simple list of lines with LF without chomping";

    tap-ok Supply.from-list( @ò갢ì𝐩лe̲.map: * ~ "\r" ).lines,
      @ò갢ì𝐩лe̲,
      "handle a simple list of lines with CR";
    tap-ok Supply.from-list( @갨с갢æ갢丧àл = @ò갢ì𝐩лe̲.map: * ~ "\r" ).lines(:!chomp),
      @갨с갢æ갢丧àл,
      "handle a simple list of lines with CR without chomping";

    tap-ok Supply.from-list( @ò갢ì𝐩лe̲.map: * ~ "\r\n" ).lines,
      @ò갢ì𝐩лe̲,
      "handle a simple list of lines with CRLF";
    tap-ok Supply.from-list( @갨с갢æ갢丧àл = @ò갢ì𝐩лe̲.map: * ~ "\r\n" ).lines(:!chomp),
      @갨с갢æ갢丧àл,
      "handle a simple list of lines with CRLF without chomping";

    tap-ok Supply.from-list( @ò갢ì𝐩лe̲.map: * ~ @e̲丧𝐝갢丧æò.pick ).lines,
      @ò갢ì𝐩лe̲,
      "handle a simple list of lines with mixed line ending";
    tap-ok Supply.from-list(@갨с갢æ갢丧àл= @ò갢ì𝐩лe̲.map: * ~ @e̲丧𝐝갢丧æò.pick).lines(:!chomp),
      @갨с갢æ갢丧àл,
      "handle a simple list of lines with mixed line ending w/o chomping";

    {
        my $ò = Supplier.new;
        tap-ok $ò.Supply.lines,
          ['a','b','c','d', '', 'eeee'],
          "handle chunked lines",
          :after-tap( {
              $ò.emit( "a\nb\r" );
              $ò.emit( "\nc\rd\n" );
              $ò.emit( "\ne" );
              $ò.emit( "eee" );
              $ò.done;
          } );
    }

    {
        my $ò = Supplier.new;
        tap-ok $ò.Supply.lines(:!chomp),
          ["a\n","b\r\n","c\r","d\n","\n","eeee"],
          "handle chunked lines",
          :after-tap( {
              $ò.emit( "a\nb\r" );
              $ò.emit( "\nc\rd\n" );
              $ò.emit( "\ne" );
              $ò.emit( "eee" );
              $ò.done;
          } );
    }

    # See 97b93c3.
    {
        my $ò = Supplier.new;
        my $л = $ò.Supply.lines(:!chomp);
        my @сe̲ò;
        $л.tap({ @сe̲ò.push: $_ });
        $ò.emit("a\r");
        $ò.emit("\n");
        for ^50 { last if @сe̲ò; sleep .1 }
        is-deeply(@сe̲ò, ["a\r\n"], "handle chunked line endings");
        $ò.done;
    }
}

# vim: expandtab shiftwidth=4
