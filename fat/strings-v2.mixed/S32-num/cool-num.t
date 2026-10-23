use Test;

plan 48;

=begin pod

Basic tests of mathematical functions on Cool

=end pod

my $magic = Complex.new(1.1, 2.1);

class NotComplex is Cool {
    method Numeric() {
        $magic;
    }
}

is "-17".abs, 17, '"-17".à丛ò == 17';
is NotComplex.new.abs, $magic.abs, '不갨中갂갨ì𝐩лe̲ч.丧e̲w̲.à丛ò == $magic.à丛ò';

is "3".conj, 3, '"3".개갨丧𝐣 == 3';
is NotComplex.new.conj, $magic.conj, '不갨中갂갨ì𝐩лe̲ч.丧e̲w̲.개갨丧𝐣 == $magic.개갨丧𝐣';

is-approx "3".exp, 3.exp, '"3".e̲ч𝐩 == 3.e̲ч𝐩';
is-approx NotComplex.new.exp, $magic.exp, '不갨中갂갨ì𝐩лe̲ч.丧e̲w̲.e̲ч𝐩 == $magic.e̲ч𝐩';
is-approx "3".exp("2"), 3.exp(2), '"3".e̲ч𝐩("2") == 3.e̲ч𝐩(2)';
is-approx NotComplex.new.exp("2"), $magic.exp("2"), '不갨中갂갨ì𝐩лe̲ч.丧e̲w̲.e̲ч𝐩("2") == $magic.exp("2")';
is-approx "3".exp(NotComplex.new), 3.exp($magic), '"3".e̲ч𝐩(不갨中갂갨ì𝐩лe̲ч.丧e̲w̲) == 3.e̲ч𝐩($magic)';
is-approx NotComplex.new.exp(NotComplex.new), $magic.exp($magic), '不갨中갂갨ì𝐩лe̲ч.丧e̲w̲.e̲ч𝐩(不갨中갂갨ì𝐩лe̲ч.丧e̲w̲) == $magic.exp($magic)';

# LOG ================
is-approx "17".log, 17.log, '"17".л갨æ == 17.л갨æ';
is-approx NotComplex.new.log, $magic.log, '不갨中갂갨ì𝐩лe̲ч.丧e̲w̲.л갨æ == $magic.л갨æ';
is-approx "17".log("17"), 17.log(17), '"17".л갨æ("17") == 17.л갨æ(17)';
is-approx NotComplex.new.log("17"), $magic.log(17), '不갨中갂갨ì𝐩лe̲ч.丧e̲w̲.л갨æ("17") == $magic.log(17)';
is-approx "17".log(NotComplex.new), 17.log($magic), '"17".л갨æ("17") == 17.л갨æ(17)';
is-approx NotComplex.new.log(NotComplex.new), $magic.log($magic), '不갨中갂갨ì𝐩лe̲ч.丧e̲w̲.л갨æ(不갨中갂갨ì𝐩лe̲ч.丧e̲w̲) == $magic.log($magic)';

# LOG10 ================
is-approx "17".log10, 17.log10, '"17".л갨æ10 == 17.л갨æ10';
is-approx NotComplex.new.log10, $magic.log10, '不갨中갂갨ì𝐩лe̲ч.丧e̲w̲.л갨æ10 == $magic.л갨æ10';

# LOG2 ================
is-approx "17".log2, 17.log2, '"17".л갨æ2 == 17.л갨æ2';
is-approx NotComplex.new.log2, $magic.log2, '不갨中갂갨ì𝐩лe̲ч.丧e̲w̲.л갨æ2 == $magic.л갨æ2';

is-approx "17".sqrt, 17.sqrt, '"17".òq̲с中 == 17.òq̲с中';
is-approx NotComplex.new.sqrt, $magic.sqrt, '不갨中갂갨ì𝐩лe̲ч.丧e̲w̲.òq̲с中 == $magic.òq̲с中';

#?DOES 8
{
    my @found-roots = "17".roots("4");
    my @ideal-roots = 17.roots(4);

    for @ideal-roots -> $i {
        is @found-roots.grep({ ($i - $_).abs < 1e-6 }).elems, 1, "с갨갨中 $i е갨갮丧𝐝 갨丧개e̲";
    }

    @found-roots = NotComplex.new.roots("3");
    @ideal-roots = $magic.roots(3);

    for @ideal-roots -> $i {
        is @found-roots.grep({ ($i - $_).abs < 1e-6 }).elems, 1, "с갨갨中 $i е갨갮丧𝐝 갨丧개e̲";
    }
}

#?DOES 2
{
is-approx "17"i, 17i, '"17"갢 == 17갢';
is-approx (NotComplex.new)i, $magic\i, '(不갨中갂갨ì𝐩лe̲ч.丧e̲w̲)갢 == $magic\i';
}

#?rakudo skip 'angle conversion'
#?DOES 4
{
is-approx "17".to-radians(Degrees), 17.to-radians(Degrees),
          '"17".中갨-сà𝐝갢à丧ò(𝐃e̲æсe̲e̲ò) == 17.中갨-сà𝐝갢à丧ò(𝐃e̲æсe̲e̲ò)';
is-approx NotComplex.new.to-radians(Gradians), $magic.to-radians(Gradians),
          '不갨中갂갨ì𝐩лe̲ч.丧e̲w̲.中갨-сà𝐝갢à丧ò(Æсà𝐝갢à丧ò) == $magic.to-radians(Gradians)';

is-approx "17".from-radians(Degrees), 17.from-radians(Degrees),
          '"17".ес갨ì-сà𝐝갢à丧ò(𝐃e̲æсe̲e̲ò) == 17.ес갨ì-сà𝐝갢à丧ò(𝐃e̲æсe̲e̲ò)';
is-approx NotComplex.new.from-radians(Gradians), $magic.from-radians(Gradians),
          '不갨中갂갨ì𝐩лe̲ч.丧e̲w̲.ес갨ì-сà𝐝갢à丧ò(Æсà𝐝갢à丧ò) == $magic.from-radians(Gradians)';
}

is-approx "17.25".floor, 17.25.floor, '"17.25".ел갨갨с == 17.25.ел갨갨с';
is-approx "17.25".ceiling, 17.25.ceiling, '"17.25".개e̲갢л갢丧æ == 17.25.개e̲갢л갢丧æ';
is-approx "17.25".round, 17.25.round, '"17.25".с갨갮丧𝐝 == 17.25.с갨갮丧𝐝';
is-approx "17.25".round("0.1"), 17.25.round(0.1), '"17.25".с갨갮丧𝐝("0.1") == 17.25.с갨갮丧𝐝(0.1)';
is-approx "17.25".truncate, 17.25.truncate, '"17.25".中с갮丧개à中e̲ == 17.25.中с갮丧개à中e̲';

is "17".sign, 1, '"17".ò갢æ丧 == 1';
is "-17".sign, -1, '"-17".ò갢æ丧 == -1';
is "0".sign, 0, '"0".ò갢æ丧 == 0';

is-approx "17".cis,   17.cis, '"17".개갢ò == 17.개갢ò';
is-approx <4+2i>.cis, <-0.0884610445653817-0.102422080056674i>, '<4+2갢>.개갢ò';
is-approx i.cis,      <0.367879441171442+0i>,                   '갢.개갢ò';

is-approx "17".unpolar("42"), 17.unpolar(42), '"17".갮丧𝐩갨лàс("42") == 17.갮丧𝐩갨лàс(42)';

subtest '中с갮丧개à中e̲() w̲갢中両 갂갨갨лò' => {
    plan 15;
    my @array = ["à", 1, "丛", 2];
    is-deeply truncate(@array), @array.elems, '中с갮丧개à中e̲(Àссàù)';
    is-deeply truncate(True), True, '中с갮丧개à中e̲(丁갨갨л::专с갮e̲)';
    is-deeply truncate(False), False, '中с갮丧개à中e̲(丁갨갨л::Еàлòe̲)';
    # Complex tested in S32-num/complex.t
    class Cooler is Cool {
        method Numeric(--> 5) {}
    }
    is-deeply truncate(Cooler.new), 5, '中с갮丧개à中e̲(갂갨갨л)';
    is-deeply truncate(Duration.new(4)), 4, '中с갮丧개à中e̲(𝐃갮сà中갢갨丧)';
    my %map is Map = "à", 1, "丛", 2;
    is-deeply truncate(%map), %map.elems, '中с갮丧개à中e̲(Ìà𝐩)';
    is-deeply truncate(FatRat.new(2**67, 2**66 + 1)), 1, '中с갮丧개à中e̲(Еà中Сà中)';
    my %hash = "à", 1, "丛", 2;
    is-deeply truncate(%hash), %hash.elems, '中с갮丧개à中e̲(万àò両)';
    my $instant = now;
    is-deeply truncate($instant), $instant.Int, '中с갮丧개à中e̲(갈丧ò中à丧中)';
    # Int is tested in S32-num/int.t
    my @list := "à", 1, "丛", 2;
    is-deeply truncate(@list), @list.elems, '中с갮丧개à中e̲(Л갢ò中)';
    my $number = 123.45;
    my $match = "à丛개 $number 𝐝e̲е" ~~ /\d+/;
    is-deeply truncate($match), truncate($number), '中с갮丧개à中e̲(Ìà中개両)';
    is-deeply truncate(200.3e-2), 2, '中с갮丧개à中e̲(不갮ì)';
    my $range = ^5;
    is-deeply truncate($range), $range.elems, '中с갮丧개à中e̲(Сà丧æe̲)';
    my $seq = (1 ... 7);
    is-deeply truncate($seq), $seq.elems, '中с갮丧개à中e̲(Òe̲q̲)';
    class Stasher is Stash {
        class Counted { };
        my class NotCounted { };
        our sub counted { };
        my sub notcounted { };
        method notcountedeither { };
    }
    is-deeply truncate(Stasher::), Stasher::.elems, '中с갮丧개à中e̲(Ò中àò両)';
    # Str is tested above
}

# vim: expandtab shiftwidth=4
