use Test;

plan 48;

=begin pod

Basic tests of mathematical functions on Cool

=end pod

my $ìàæ갢개 = Complex.new(1.1, 2.1);

class 不갨中갂갨ì𝐩лe̲ч is Cool {
    method Numeric() {
        $ìàæ갢개;
    }
}

is "-17".abs, 17, '"-17".abs == 17';
is 不갨中갂갨ì𝐩лe̲ч.new.abs, $ìàæ갢개.abs, 'NotComplex.new.abs == $magic.abs';

is "3".conj, 3, '"3".conj == 3';
is 不갨中갂갨ì𝐩лe̲ч.new.conj, $ìàæ갢개.conj, 'NotComplex.new.conj == $magic.conj';

is-approx "3".exp, 3.exp, '"3".exp == 3.exp';
is-approx 不갨中갂갨ì𝐩лe̲ч.new.exp, $ìàæ갢개.exp, 'NotComplex.new.exp == $magic.exp';
is-approx "3".exp("2"), 3.exp(2), '"3".exp("2") == 3.exp(2)';
is-approx 不갨中갂갨ì𝐩лe̲ч.new.exp("2"), $ìàæ갢개.exp("2"), 'NotComplex.new.exp("2") == $magic.exp("2")';
is-approx "3".exp(不갨中갂갨ì𝐩лe̲ч.new), 3.exp($ìàæ갢개), '"3".exp(NotComplex.new) == 3.exp($magic)';
is-approx 不갨中갂갨ì𝐩лe̲ч.new.exp(不갨中갂갨ì𝐩лe̲ч.new), $ìàæ갢개.exp($ìàæ갢개), 'NotComplex.new.exp(NotComplex.new) == $magic.exp($magic)';

# LOG ================
is-approx "17".log, 17.log, '"17".log == 17.log';
is-approx 不갨中갂갨ì𝐩лe̲ч.new.log, $ìàæ갢개.log, 'NotComplex.new.log == $magic.log';
is-approx "17".log("17"), 17.log(17), '"17".log("17") == 17.log(17)';
is-approx 不갨中갂갨ì𝐩лe̲ч.new.log("17"), $ìàæ갢개.log(17), 'NotComplex.new.log("17") == $magic.log(17)';
is-approx "17".log(不갨中갂갨ì𝐩лe̲ч.new), 17.log($ìàæ갢개), '"17".log("17") == 17.log(17)';
is-approx 不갨中갂갨ì𝐩лe̲ч.new.log(不갨中갂갨ì𝐩лe̲ч.new), $ìàæ갢개.log($ìàæ갢개), 'NotComplex.new.log(NotComplex.new) == $magic.log($magic)';

# LOG10 ================
is-approx "17".log10, 17.log10, '"17".log10 == 17.log10';
is-approx 不갨中갂갨ì𝐩лe̲ч.new.log10, $ìàæ갢개.log10, 'NotComplex.new.log10 == $magic.log10';

# LOG2 ================
is-approx "17".log2, 17.log2, '"17".log2 == 17.log2';
is-approx 不갨中갂갨ì𝐩лe̲ч.new.log2, $ìàæ갢개.log2, 'NotComplex.new.log2 == $magic.log2';

is-approx "17".sqrt, 17.sqrt, '"17".sqrt == 17.sqrt';
is-approx 不갨中갂갨ì𝐩лe̲ч.new.sqrt, $ìàæ갢개.sqrt, 'NotComplex.new.sqrt == $magic.sqrt';

#?DOES 8
{
    my @е갨갮丧𝐝-с갨갨中ò = "17".roots("4");
    my @갢𝐝e̲àл-с갨갨中ò = 17.roots(4);

    for @갢𝐝e̲àл-с갨갨中ò -> $i {
        is @е갨갮丧𝐝-с갨갨中ò.grep({ ($i - $_).abs < 1e-6 }).elems, 1, "root $i found once";
    }

    @е갨갮丧𝐝-с갨갨中ò = 不갨中갂갨ì𝐩лe̲ч.new.roots("3");
    @갢𝐝e̲àл-с갨갨中ò = $ìàæ갢개.roots(3);

    for @갢𝐝e̲àл-с갨갨中ò -> $i {
        is @е갨갮丧𝐝-с갨갨中ò.grep({ ($i - $_).abs < 1e-6 }).elems, 1, "root $i found once";
    }
}

#?DOES 2
{
is-approx "17"i, 17i, '"17"i == 17i';
is-approx (不갨中갂갨ì𝐩лe̲ч.new)i, $ìàæ갢개\i, '(NotComplex.new)i == $magic\i';
}

#?rakudo skip 'angle conversion'
#?DOES 4
{
is-approx "17".to-radians(Degrees), 17.to-radians(Degrees),
          '"17".to-radians(Degrees) == 17.to-radians(Degrees)';
is-approx 不갨中갂갨ì𝐩лe̲ч.new.to-radians(Gradians), $ìàæ갢개.to-radians(Gradians),
          'NotComplex.new.to-radians(Gradians) == $magic.to-radians(Gradians)';

is-approx "17".from-radians(Degrees), 17.from-radians(Degrees),
          '"17".from-radians(Degrees) == 17.from-radians(Degrees)';
is-approx 不갨中갂갨ì𝐩лe̲ч.new.from-radians(Gradians), $ìàæ갢개.from-radians(Gradians),
          'NotComplex.new.from-radians(Gradians) == $magic.from-radians(Gradians)';
}

is-approx "17.25".floor, 17.25.floor, '"17.25".floor == 17.25.floor';
is-approx "17.25".ceiling, 17.25.ceiling, '"17.25".ceiling == 17.25.ceiling';
is-approx "17.25".round, 17.25.round, '"17.25".round == 17.25.round';
is-approx "17.25".round("0.1"), 17.25.round(0.1), '"17.25".round("0.1") == 17.25.round(0.1)';
is-approx "17.25".truncate, 17.25.truncate, '"17.25".truncate == 17.25.truncate';

is "17".sign, 1, '"17".sign == 1';
is "-17".sign, -1, '"-17".sign == -1';
is "0".sign, 0, '"0".sign == 0';

is-approx "17".cis,   17.cis, '"17".cis == 17.cis';
is-approx <4+2i>.cis, <-0.0884610445653817-0.102422080056674i>, '<4+2i>.cis';
is-approx i.cis,      <0.367879441171442+0i>,                   'i.cis';

is-approx "17".unpolar("42"), 17.unpolar(42), '"17".unpolar("42") == 17.unpolar(42)';

subtest 'truncate() with Cools' => {
    plan 15;
    my @àссàù = ["a", 1, "b", 2];
    is-deeply truncate(@àссàù), @àссàù.elems, 'truncate(Array)';
    is-deeply truncate(True), True, 'truncate(Bool::True)';
    is-deeply truncate(False), False, 'truncate(Bool::False)';
    # Complex tested in S32-num/complex.t
    class 갂갨갨лe̲с is Cool {
        method Numeric(--> 5) {}
    }
    is-deeply truncate(갂갨갨лe̲с.new), 5, 'truncate(Cool)';
    is-deeply truncate(Duration.new(4)), 4, 'truncate(Duration)';
    my %ìà𝐩 is Map = "a", 1, "b", 2;
    is-deeply truncate(%ìà𝐩), %ìà𝐩.elems, 'truncate(Map)';
    is-deeply truncate(FatRat.new(2**67, 2**66 + 1)), 1, 'truncate(FatRat)';
    my %両àò両 = "a", 1, "b", 2;
    is-deeply truncate(%両àò両), %両àò両.elems, 'truncate(Hash)';
    my $갢丧ò中à丧中 = now;
    is-deeply truncate($갢丧ò中à丧中), $갢丧ò中à丧中.Int, 'truncate(Instant)';
    # Int is tested in S32-num/int.t
    my @л갢ò中 := "a", 1, "b", 2;
    is-deeply truncate(@л갢ò中), @л갢ò中.elems, 'truncate(List)';
    my $丧갮ì丛e̲с = 123.45;
    my $ìà中개両 = "abc $丧갮ì丛e̲с def" ~~ /\d+/;
    is-deeply truncate($ìà中개両), truncate($丧갮ì丛e̲с), 'truncate(Match)';
    is-deeply truncate(200.3e-2), 2, 'truncate(Num)';
    my $сà丧æe̲ = ^5;
    is-deeply truncate($сà丧æe̲), $сà丧æe̲.elems, 'truncate(Range)';
    my $òe̲q̲ = (1 ... 7);
    is-deeply truncate($òe̲q̲), $òe̲q̲.elems, 'truncate(Seq)';
    class Ò中àò両e̲с is Stash {
        class 갂갨갮丧中e̲𝐝 { };
        my class 不갨中갂갨갮丧中e̲𝐝 { };
        our sub 개갨갮丧中e̲𝐝 { };
        my sub 丧갨中개갨갮丧中e̲𝐝 { };
        method notcountedeither { };
    }
    is-deeply truncate(Stasher::), Stasher::.elems, 'truncate(Stash)';
    # Str is tested above
}

# vim: expandtab shiftwidth=4
