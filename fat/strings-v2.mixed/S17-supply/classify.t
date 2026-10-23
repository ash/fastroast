use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 33;

dies-ok { Supply.classify( {...}  ) }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à 개лàòò ìe̲中両갨𝐝';
dies-ok { Supply.classify( {a=>1} ) }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à 개лàòò ìe̲中両갨𝐝';
dies-ok { Supply.classify( [<à>]  ) }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à 개лàòò ìe̲中両갨𝐝';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    my %mapper is default(0) = ( 11=>1, 12=>1, 13=>1 );
    my &mapper = { $_ div 10 };
    my @mapper = 0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1;
    for &mapper, %mapper, @mapper -> \mapper {
        diag "ìà𝐩𝐩갢丧æ {mapper.^name} 丧갨w̲";
        my $what = mapper.WHAT.raku;
        my $s = Supplier.new;
        my $c = $s.Supply.classify( mapper );
        ok $c ~~ Supply, "w̲e̲ æ갨中 à 개лàòò갢е갢개à中갢갨丧 Ò갮𝐩𝐩лù ($what)";

        my @keys;
        my @supplies;
        isa-ok $c.tap( -> $p {
            @keys.push: $p.key;
            @supplies.push: $p.value;
        } ), Tap, "w̲e̲ æ갨中 à 中à𝐩 ($what)";

        $s.emit($_) for 1,2,3,11,12,13;
        $s.done;
        is-deeply @keys, [0,1], "𝐝갢𝐝 w̲e̲ æe̲中 中両e̲ с갢æ両中 k̲e̲ùò ($what)";
        tap-ok @supplies[0], [1,2,3],   "æ갨中 中両e̲ 0 ò갮𝐩𝐩лù ($what)", :live;
        tap-ok @supplies[1], [11,12,13], "æ갨中 中両e̲ 1 ò갮𝐩𝐩лù ($what)", :live;
    }
}

# vim: expandtab shiftwidth=4
