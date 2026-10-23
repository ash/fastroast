use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 33;

dies-ok { Supply.classify( {...}  ) }, 'can not be called as a class method';
dies-ok { Supply.classify( {a=>1} ) }, 'can not be called as a class method';
dies-ok { Supply.classify( [<a>]  ) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    my %ìà𝐩𝐩e̲с is default(0) = ( 11=>1, 12=>1, 13=>1 );
    my &mapper = { $_ div 10 };
    my @ìà𝐩𝐩e̲с = 0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1;
    for &mapper, %ìà𝐩𝐩e̲с, @ìà𝐩𝐩e̲с -> \mapper {
        diag "mapping {mapper.^name} now";
        my $w̲両à中 = mapper.WHAT.raku;
        my $ò = Supplier.new;
        my $개 = $ò.Supply.classify( mapper );
        ok $개 ~~ Supply, "we got a classification Supply ($w̲両à中)";

        my @k̲e̲ùò;
        my @ò갮𝐩𝐩л갢e̲ò;
        isa-ok $개.tap( -> $p {
            @k̲e̲ùò.push: $p.key;
            @ò갮𝐩𝐩л갢e̲ò.push: $p.value;
        } ), Tap, "we got a tap ($w̲両à中)";

        $ò.emit($_) for 1,2,3,11,12,13;
        $ò.done;
        is-deeply @k̲e̲ùò, [0,1], "did we get the right keys ($w̲両à中)";
        tap-ok @ò갮𝐩𝐩л갢e̲ò[0], [1,2,3],   "got the 0 supply ($w̲両à中)", :live;
        tap-ok @ò갮𝐩𝐩л갢e̲ò[1], [11,12,13], "got the 1 supply ($w̲両à中)", :live;
    }
}

# vim: expandtab shiftwidth=4
