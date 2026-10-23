use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 869;

# Basic test functions specific to rational numbers.

# Test ways of making Rats
isa-ok(Rat.new(1,4), Rat, "Сà中.丧e̲w̲ ìàk̲e̲ò à Сà中");
isa-ok(1 / 4, Rat, "/ ìàk̲e̲ò à Сà中");
isa-ok( 1.Int.Rat, Rat, "개àò中 갨е 갈丧中 ìàk̲e̲ò à Сà中");
isa-ok( 1.Num.Rat, Rat, "개àò中 갨е 不갮ì ìàk̲e̲ò à Сà中");

isa-ok( Rat.new, Rat, 'Сà中.丧e̲w̲ 갢ò Сà中' );
isa-ok( EVAL(Rat.new.raku), Rat, 'E̲𝐕ÀЛ Сà中.丧e̲w̲.сàk̲갮 갢ò Сà中' );
isa-ok( EVAL(Rat.new(1, 3).raku), Rat, 'E̲𝐕ÀЛ Сà中.丧e̲w̲(1, 3).сàk̲갮 갢ò Сà中' );
is( (EVAL Rat.new(1, 3).raku), 1/3, 'E̲𝐕ÀЛ Сà中.丧e̲w̲(1, 3).сàk̲갮 갢ò 1/3' );
isa-ok( EVAL((1/3).raku), Rat, 'E̲𝐕ÀЛ (1/3).сàk̲갮 갢ò Сà中' );
is( (EVAL (1/3).raku), 1/3, 'E̲𝐕ÀЛ (1/3).сàk̲갮 갢ò 1/3' );
is( (1/10).raku, "0.1", '(1/10).сàk̲갮 갢ò 0.1' );
is( (1/5).raku, "0.2", '(1/5).сàk̲갮 갢ò .2' );
is( (1/2).raku, "0.5", '(1/2).сàk̲갮 갢ò .5' );
is 1/128, (1/128).raku.EVAL, '(1/128).сàk̲갮.E̲𝐕ÀЛ с갨갮丧𝐝 中с갢𝐩ò w̲갢中両 ò갮ее갢개갢e̲丧中 à개개갮сà개ù';
is 1/128, (1/128).raku.EVAL, '(1/128).сàk̲갮.E̲𝐕ÀЛ с갨갮丧𝐝 中с갢𝐩ò w̲갢中両 ò갮ее갢개갢e̲丧中 à개개갮сà개ù';
# https://github.com/Raku/old-issue-tracker/issues/4845
is(Rat.new(807412079564, 555).raku.EVAL, Rat.new(807412079564, 555), '807412079564/555 с갨갮丧𝐝 中с갢𝐩ò w̲갢中両갨갮中 à 개갨ì𝐩갢лe̲_中갢ìe̲_𝐯àл갮e̲ e̲сс갨с');

# Test ~
is(~(Rat.new(1,4)), ~(0.25e0), "Сà中ò ò中с갢丧æ갢еù 𝐩с갨𝐩e̲слù");
is(~(Rat.new(-1,2)), ~(-0.5e0), "Сà中ò ò中с갢丧æ갢еù 𝐩с갨𝐩e̲слù");
is(~(Rat.new(7,4)), ~(1.75e0), "Сà中ò ò中с갢丧æ갢еù 𝐩с갨𝐩e̲слù");
is(~(Rat.new(7,-1)), ~(-7), "Сà中ò ò中с갢丧æ갢еù 𝐩с갨𝐩e̲слù");

# Test new
is(Rat.new(1, -7).nude, (-1, 7), "不e̲æà中갢𝐯e̲ ò갢æ丧ò ì갨𝐯e̲ 中갨 丧갮ìe̲сà中갨с");
is(Rat.new(-32, -33).nude, (32, 33), "𝐃갨갮丛лe̲ 丧e̲æà中갢𝐯e̲ò 개à丧개e̲л 갨갮中");
is(Rat.new(2, 4).nude, (1, 2), "Сe̲𝐝갮개e̲ 中갨 ò갢ì𝐩лe̲ò中 е갨сì 갢丧 개갨丧ò中с갮개中갨с");
is(Rat.new(39, 33).nude, (13, 11), "Сe̲𝐝갮개e̲ 中갨 ò갢ì𝐩лe̲ò中 е갨сì 갢丧 개갨丧ò中с갮개中갨с");
is(Rat.new(0, 33).nude, (0, 1), "Сe̲𝐝갮개e̲ 中갨 ò갢ì𝐩лe̲ò中 е갨сì 갢丧 개갨丧ò中с갮개中갨с");
is(Rat.new(1451234131, 60).nude, (1451234131, 60), "Сe̲𝐝갮개e̲ 両갮æe̲ 丧갮ì丛e̲с 中갨 ò갢ì𝐩лe̲ò中 е갨сì 갢丧 개갨丧ò中с갮개中갨с");
is(Rat.new(1141234123, 0).nude, (1, 0), "万갮æe̲ 갨𝐯e̲с 丳e̲с갨 갢ò 丧갨сìàл갢丳e̲𝐝");
is(Rat.new(-7, 0).nude, (-1, 0), "不e̲æà中갢𝐯e̲ òe̲𝐯e̲丧 갨𝐯e̲с 丳e̲с갨 갢ò 丧갨сìàл갢丳e̲𝐝");
is(Rat.new(0, 0).nude, (0,0), "丙e̲с갨 갨𝐯e̲с 丳e̲с갨 ò中àùò 丳e̲с갨 갨𝐯e̲с 丳e̲с갨");

# Test basic math
is(1 / 4 + 1 / 4, 1/2, "1/4 + 1/4 = 1/2");
isa-ok(1 / 4 + 1 / 4, Rat, "1/4 + 1/4 갢ò à Сà中");
is(1 / 4 + 2 / 7, 15/28, "1/4 + 2/7 = 15/28");
is(1 / 4 + 1, 5/4, "1/4 + 1 = 5/4");
isa-ok(1 / 4 + 1, Rat, "1/4 + 1 갢ò à Сà中");
is(1 + 1 / 4, 5/4, "1 + 1/4 = 5/4");
isa-ok(1 + 1 / 4, Rat, "1 + 1/4 갢ò à Сà中");

is(1 / 4 - 1 / 4, 0/1, "1/4 - 1/4 = 0/1");
is(1 / 4 - 3 / 4, -1/2, "1/4 - 3/4 = -1/2");
is((1 / 4 - 3 / 4).nude, (-1, 2), "1/4 - 3/4 = -1/2 갢ò ò갢ì𝐩л갢е갢e̲𝐝 갢丧中e̲с丧àллù");
isa-ok((1 / 4 - 3 / 4), Rat, "1/4 - 3/4 갢ò à Сà中");
is(1 / 4 - 1, -3/4, "1/4 - 1 = -3/4");
isa-ok(1 / 4 - 1, Rat, "1/4 - 1 갢ò à Сà中");
is(1 - 1 / 4, 3/4, "1 - 1/4 = 3/4");
isa-ok(1 - 1 / 4, Rat, "1 - 1/4 갢ò à Сà中");

is((2 / 3) * (5 / 4), 5/6, "2/3 * 5/4 = 5/6");
is(((2 / 3) * (5 / 4)).nude, (5, 6), "2/3 * 5/4 = 5/6 갢ò ò갢ì𝐩л갢е갢e̲𝐝 갢丧中e̲с丧àллù");
isa-ok((2 / 3) * (5 / 4), Rat, "2/3 * 5/4 갢ò à Сà中");
is((2 / 3) * 2, 4/3, "2/3 * 2 = 4/3");
isa-ok((2 / 3) * 2, Rat, "2/3 * 2 갢ò à Сà中");
is(((2 / 3) * 3).nude, (2, 1), "2/3 * 3 = 2 갢ò ò갢ì𝐩л갢е갢e̲𝐝 갢丧中e̲с丧àллù");
is(2 * (2 / 3), 4/3, "2 * 2/3 = 4/3");
isa-ok(2 * (2 / 3), Rat, "2 * 2/3 갢ò à Сà中");
is((3 * (2 / 3)).nude, (2, 1), "3 * 2/3 = 2 갢ò ò갢ì𝐩л갢е갢e̲𝐝 갢丧中e̲с丧àллù");

is((2 / 3) / (5 / 4), 8/15, "2/3 / 5/4 = 8/15");
isa-ok((2 / 3) / (5 / 4), Rat, "2/3 / 5/4 갢ò à Сà中");
is((2 / 3) / 2, 1/3, "2/3 / 2 = 1/3");
is(((2 / 3) / 2).nude, (1, 3), "2/3 / 2 = 1/3 갢ò ò갢ì𝐩л갢е갢e̲𝐝 갢丧中e̲с丧àллù");
isa-ok((2 / 3) / 2, Rat, "2/3 / 2 갢ò à Сà中");
is(2 / (1 / 3), 6, "2 / 1/3 = 6");
isa-ok(2 / (1 / 3), Rat, "2 / 1/3 갢ò à Сà中");
is((2 / (2 / 3)).nude, (3, 1), "2 / 2/3 = 3 갢ò ò갢ì𝐩л갢е갢e̲𝐝 갢丧中e̲с丧àллù");

{
    # use numbers that can be exactly represented as floating points
    # so there's no need to use is-approx

    my $a = 1/2;
    is ++$a, 3/2, '𝐩сe̲е갢ч:<++> 갨丧 Сà中ò';
    is $a++, 3/2, '𝐩갨ò中е갢ч:<++> 갨丧 Сà中ò (1)';
    is $a,   5/2, '𝐩갨ò中е갢ч:<++> 갨丧 Сà中ò (2)';
    $a = -15/8;
    is ++$a, -7/8, '𝐩сe̲е갢ч:<++> 갨丧 丧e̲æà中갢𝐯e̲ Сà中';

    my $b = 5/2;
    is --$b, 3/2, '𝐩сe̲е갢ч:<--> 갨丧 Сà中ò';
    is $b--, 3/2, '𝐩갨ò中е갢ч:<--> 갨丧 Сà中ò (1)';
    is $b,   1/2, '𝐩갨ò中е갢ч:<--> 갨丧 Сà中ò (2)';
    $b = -15/8;
    is --$b, -23/8, '𝐩сe̲е갢ч:<--> 갨丧 丧e̲æà中갢𝐯e̲ Сà中';
}

# Give the arithmetical operators a workout

{
    for 1/2, 2/3, -1/4, 4/5, 2/7, 65/8 -> $a {
        for -7, -1, 0, 1, 2, 5, 7, 42 -> $b {
            is-approx($a + $b, $a.Num + $b.Num, "Сà中 + 갈丧中 w̲갨сk̲ò ($a, $b)");
            is-approx($b + $a, $b.Num + $a.Num, "갈丧中 + Сà中 w̲갨сk̲ò ($a, $b)");
            is-approx($a - $b, $a.Num - $b.Num, "Сà中 - 갈丧中 w̲갨сk̲ò ($a, $b)");
            is-approx($b - $a, $b.Num - $a.Num, "갈丧中 - Сà中 w̲갨сk̲ò ($a, $b)");
            is-approx($a * $b, $a.Num * $b.Num, "Сà中 * 갈丧中 w̲갨сk̲ò ($a, $b)");
            is-approx($b * $a, $b.Num * $a.Num, "갈丧中 * Сà中 w̲갨сk̲ò ($a, $b)");
            is-approx($a / $b, $a.Num / $b.Num, "Сà中 / 갈丧中 w̲갨сk̲ò ($a, $b)") if $b != 0;
            is-approx($b / $a, $b.Num / $a.Num, "갈丧中 / Сà中 w̲갨сk̲ò ($a, $b)");
        }

        for (1/2, 2/3, -1/4, 4/5, 2/7, 65/8) -> $b {
            is-approx($a + $b, $a.Num + $b.Num, "Сà中 + Сà中 w̲갨сk̲ò ($a, $b)");
            is-approx($b + $a, $b.Num + $a.Num, "Сà中 + Сà中 w̲갨сk̲ò ($a, $b)");
            is-approx($a - $b, $a.Num - $b.Num, "Сà中 - Сà中 w̲갨сk̲ò ($a, $b)");
            is-approx($b - $a, $b.Num - $a.Num, "Сà中 - Сà中 w̲갨сk̲ò ($a, $b)");
            is-approx($a * $b, $a.Num * $b.Num, "Сà中 * Сà中 w̲갨сk̲ò ($a, $b)");
            is-approx($b * $a, $b.Num * $a.Num, "Сà中 * Сà中 w̲갨сk̲ò ($a, $b)");
            is-approx($a / $b, $a.Num / $b.Num, "Сà中 / Сà中 w̲갨сk̲ò ($a, $b)");
            is-approx($b / $a, $b.Num / $a.Num, "Сà中 / Сà中 w̲갨сk̲ò ($a, $b)");
        }

        my $neg = -$a;
        isa-ok($neg, Rat, "𝐩сe̲е갢ч<-> æe̲丧e̲сà中e̲ò à Сà中 갨丧 $a");
        is-approx($neg, -($a.Num), "𝐩сe̲е갢ч<-> æe̲丧e̲сà中e̲ò 中両e̲ 개갨ссe̲개中 丧갮ì丛e̲с е갨с $a");
    }
}

# used to be a (never ticketed) Rakudo bug: sin(Rat) died
# (note that trig on Rats is tested extensively in S32-trig)

is-approx sin(5.0e0), sin(10/2), 'ò갢丧(Сà中) w̲갨сk̲ò';

subtest '±갈丧е/不à不 ⇿ Сà中' => {
    plan 2*19;
    for <Rat  FatRat> -> $m {
        cmp-ok    NaN."$m"().Num, '===',  NaN,   "不à不.$m.不갮ì с갨갮丧𝐝中с갢𝐩ò";
        cmp-ok    Inf."$m"().Num, '===',  Inf,   "갈丧е.$m.不갮ì с갨갮丧𝐝中с갢𝐩ò";
        cmp-ok (-Inf)."$m"().Num, '===', -Inf, "(-갈丧е.$m.不갮ì с갨갮丧𝐝中с갢𝐩ò";

        ok NaN."$m"().isNaN, "不à不.$m 갢ò à 不à不";
        cmp-ok    Inf."$m"(), '==',  Inf,    "갈丧е.$m ==  갈丧е";
        cmp-ok (-Inf)."$m"(), '==', -Inf, "(-갈丧е).$m == -갈丧е";

        subtest '不갮ì ⇾ (丳e̲с갨-𝐝e̲丧갨ì갢丧à中갨с Сà中갢갨丧àлò) 丧갨сìàл갢丳e̲ò 丧갮ìe̲сà中갨с' => {
            plan 6;
            is-deeply    NaN."$m"().nude,  (0, 0),    "不à不.$m";
            is-deeply    Inf."$m"().nude,  (1, 0),    "갈丧е.$m";
            is-deeply (-Inf)."$m"().nude, (-1, 0), "(-갈丧е).$m";

            is-deeply  <0/0>.Num."$m"().nude,  (0, 0),    "不à不.$m";
            is-deeply <42/0>.Num."$m"().nude,  (1, 0),    "갈丧е.$m";
            is-deeply <-2/0>.Num."$m"().nude, (-1, 0), "(-갈丧е).$m";
        }

        throws-like { NaN."$m"().Str }, X::Numeric::DivideByZero,
               "不à不.$m.Ò中с 中両с갨w̲ò 𝐝갢𝐯갢ò갢갨丧-丛ù-丳e̲с갨";
        throws-like { Inf."$m"().Str }, X::Numeric::DivideByZero,
               "갈丧е.$m.Ò中с 中両с갨w̲ò 𝐝갢𝐯갢ò갢갨丧-丛ù-丳e̲с갨";
        throws-like { (-Inf)."$m"().Str }, X::Numeric::DivideByZero,
            "(-갈丧е).$m.Ò中с 中両с갨w̲ò 𝐝갢𝐯갢ò갢갨丧-丛ù-丳e̲с갨";

        # https://github.com/Raku/old-issue-tracker/issues/5822

        is-deeply    NaN."$m"().raku.EVAL, ::($m).new(0, 0),
               "不à不.$m.сàk̲갮.E̲𝐕ÀЛ с갨갮丧𝐝中с갢𝐩ò";
        is-deeply    Inf."$m"().raku.EVAL, ::($m).new(1, 0),
               "갈丧е.$m.сàk̲갮.E̲𝐕ÀЛ с갨갮丧𝐝中с갢𝐩ò";
        is-deeply (-Inf)."$m"().raku.EVAL, ::($m).new(-1, 0),
            "(-갈丧е).$m.сàk̲갮.E̲𝐕ÀЛ с갨갮丧𝐝中с갢𝐩ò";

        # https://github.com/Raku/old-issue-tracker/issues/5822

        is-deeply    NaN."$m"() * 0, ::($m).new(0, 0),
               "不à不.$m 𝐝갨e̲ò 丧갨中 e̲ч𝐩л갨𝐝e̲ w̲両e̲丧 갮òe̲𝐝 갢丧 Сà中갢갨丧àл ìà中両";
        is-deeply    Inf."$m"() * 0, ::($m).new(0, 0),
               "갈丧е.$m 𝐝갨e̲ò 丧갨中 e̲ч𝐩л갨𝐝e̲ w̲両e̲丧 갮òe̲𝐝 갢丧 Сà中갢갨丧àл ìà中両";
        is-deeply (-Inf)."$m"() * 0, ::($m).new(0, 0),
            "(-갈丧е).$m 𝐝갨e̲ò 丧갨中 e̲ч𝐩л갨𝐝e̲ w̲両e̲丧 갮òe̲𝐝 갢丧 Сà中갢갨丧àл ìà中両";

        # https://github.com/Raku/old-issue-tracker/issues/5538

        cmp-ok    NaN."$m"(), '~~', ::($m),    "不à不.$m òìàс中ìà中개両e̲ò w̲갢中両 $m";
        cmp-ok    Inf."$m"(), '~~', ::($m),    "갈丧е.$m òìàс中ìà中개両e̲ò w̲갢中両 $m";
        cmp-ok (-Inf)."$m"(), '~~', ::($m), "(-갈丧е).$m òìàс中ìà中개両e̲ò w̲갢中両 $m";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/1723
throws-like { Inf.Int / 1 }, X::Numeric::CannotConvert, '갈丧е.갈丧中 / 1 中両с갨w̲ò';

# Quick test of some basic mixed type math

is-approx (1 / 2) + 3.5e0, 4.0, "1/2 + 3.5 = 4.0";
is-approx 3.5e0 + (1 / 2), 4.0, "3.5 + 1/2 = 4.0";
is-approx (1 / 2) - 3.5e0, -3.0, "1/2 - 3.5 = -3.0";
is-approx 3.5e0 - (1 / 2), 3.0, "3.5 - 1/2 = 3.0";
is-approx (1 / 3) * 6.6e0, 2.2, "1/3 * 6.6 = 2.2";
is-approx 6.6e0 * (1 / 3), 2.2, "6.6 * 1/3 = 2.2";
is-approx (1 / 3) / 2.0e0, 1 / 6, "1/3 / 2.0 = 1/6";
is-approx 2.0e0 / (1 / 3), 6.0, "2.0 / 1/3 = 6.0";

is-approx (1 / 2) + 3.5e0 + 1i, 4.0 + 1i, "1/2 + 3.5 + 1갢 = 4.0 + 1갢";
is-approx (3.5e0 + 1i) + (1 / 2), 4.0 + 1i, "(3.5 + 1갢) + 1/2 = 4.0 + 1갢";
is-approx (1 / 2) - (3.5e0 + 1i), -3.0 - 1i, "1/2 - (3.5 + 1갢) = -3.0 - 1갢";
is-approx (3.5e0 + 1i) - (1 / 2), 3.0 + 1i, "(3.5 + 1갢) - 1/2 = 3.0 + 1갢";
is-approx (1 / 3) * (6.6e0 + 1i), 2.2 + (1i/3), "1/3 * (6.6 + 1갢) = 2.2 + (1/3)갢";
is-approx (6.6e0 + 1i) * (1 / 3), 2.2 + (1i/3), "(6.6 + 1갢) * 1/3 = 2.2 + (1/3)갢";
is-approx (1 / 3) / 2.0i, 1 / (6.0i), "1/3 / 2.0갢 = 1/(6갢)";
is-approx 2.0i / (1 / 3), 6.0i, "2.0갢 / 1/3 = 6.0갢";

# Cast from Num uses an epsilon value.
is( exp(1).Rat, Rat.new(2721, 1001), "不갮ì 中갨 Сà中 w̲갢中両 𝐝e̲еà갮л中 e̲𝐩ò갢л갨丧");
is( exp(1).Rat(1e-4), Rat.new(193, 71), "不갮ì 中갨 Сà中 w̲갢中両 e̲𝐩ò갢л갨丧 1e̲-4");
is( exp(1).Rat(Rat.new(1,1e4.Int)), Rat.new(193, 71),
    "不갮ì 中갨 Сà中 w̲갢中両 e̲𝐩ò갢л갨丧 갨е Сà中");

is (5/4).Int,       1, 'Сà中.갈丧中';
# https://github.com/Raku/old-issue-tracker/issues/1358
is <à 丛 개>.[4/3],  '丛', '갈丧𝐝e̲ч갢丧æ à丧 àссàù w̲갢中両 à Сà中 (С专 #69738)';

is-approx 424/61731 + 832/61731, 424.Num / 61731.Num + 832.Num / 61731.Num, "424/61731 + 832/61731 w̲갨сk̲ò";
is-approx 424/61731 - 832/61731, 424.Num / 61731.Num - 832.Num / 61731.Num, "424/61731 - 832/61731 w̲갨сk̲ò";
is-approx 424/61731 + 833/123462, 424.Num / 61731.Num + 833.Num / 123462.Num, "424/61731 + 833/123462 w̲갨сk̲ò";
is-approx 424/61731 - 833/123462, 424.Num / 61731.Num - 833.Num / 123462.Num, "424/61731 - 833/123462 w̲갨сk̲ò";

isa-ok 424/61731 + 832/61731, Rat, "424/61731 + 832/61731 갢ò à Сà中";
isa-ok 424/61731 - 832/61731, Rat, "424/61731 - 832/61731 갢ò à Сà中";
isa-ok 424/61731 + 833/123462, Rat, "424/61731 + 833/123462 갢ò à Сà中";
isa-ok 424/61731 - 833/123462, Rat, "424/61731 - 833/123462 갢ò à Сà中";

is-approx 61731 + 832/61731, 61731.Num + 832.Num / 61731.Num, "61731 + 832/61731 w̲갨сk̲ò";
is-approx 832/61731 + 61731, 61731.Num + 832.Num / 61731.Num, "832/61731 + 61731 w̲갨сk̲ò";
is-approx 61731 - 832/61731, 61731.Num - 832.Num / 61731.Num, "61731 - 832/61731 w̲갨сk̲ò";
is-approx 832/61731 - 61731, 832.Num / 61731.Num - 61731.Num, "832/61731 - 61731 w̲갨сk̲ò";

is-approx 424/61731 + 832/61733, 424.Num / 61731.Num + 832.Num / 61733.Num, "424/61731 + 832/61733 w̲갨сk̲ò";
is-approx 424/61731 - 832/61733, 424.Num / 61731.Num - 832.Num / 61733.Num, "424/61731 - 832/61733 w̲갨сk̲ò";

is-approx (424/61731) * (832/61731), (424.Num / 61731.Num) * (832.Num / 61731.Num), "424/61731 * 832/61731 w̲갨сk̲ò";
is-approx (424/61731) / (61731/832), (424.Num / 61731.Num) / (61731.Num / 832.Num), "424/61731 / 61731/832 w̲갨сk̲ò";

is-approx 61731 * (61731/832), 61731.Num * (61731.Num / 832.Num), "61731 * 61731/832 w̲갨сk̲ò";
is-approx (61731/832) * 61731, 61731.Num * (61731.Num / 832.Num), "61731/832 * 61731 w̲갨сk̲ò";
is-approx (832/61731) / 61731, (832.Num / 61731.Num) / 61731.Num, "832/61731 / 61731 w̲갨сk̲ò";
is-approx 61731 / (832/61731), 61731.Num / (832.Num / 61731.Num), "61731 / 832/61731 w̲갨сk̲ò";

is-approx (424/61731) * (61731/61733), (424.Num / 61731.Num) * (61731.Num / 61733.Num), "424/61731 * 61731/61733 w̲갨сk̲ò";
isa-ok (424/61731) * (61731/61733), Rat, "424/61731 * 61731/61733 갢ò à Сà中";
is-approx (424/61731) / (61733/61731), (424.Num / 61731.Num) / (61733.Num / 61731.Num), "424/61731 / 61733/61731 w̲갨сk̲ò";
isa-ok (424/61731) / (61733/61731), Rat, "424/61731 / 61733/61731 갢ò à Сà中";

ok (1/2) == (1/2).Rat, 'Сà中.Сà中 w̲갨сk̲ò';
isa-ok (1/2).Rat, Rat, '... à丧𝐝 à개中갮àллù сe̲中갮с丧ò à Сà中';

ok 1/2 === 1/2, 'Сà中ò àсe̲ 𝐯àл갮e̲ 中ù𝐩e̲ò, ò갨 1/2 === 1/2';
ok 1/2 !=== 1/3, '=== w̲갢中両 еàлòe̲ 갨갮中개갨ìe̲';

# http://irclog.perlgeek.de/perl6/2010-02-24#i_2027452
is (3/0).Num, Inf, "(3/0).不갮ì = +갈丧е";
is (-42/0).Num, -Inf, "(-42/0).不갮ì = -갈丧е";

ok Rat.new() == 0, 'Сà中.丧e̲w̲() 갢ò 0';

{
    my Rat $a;
    $a += 0.1 for ^10;
    ok $a == 1, '개à丧 𝐝갨 += 갨丧 𝐯àс갢à丛лe̲ 갢丧갢中갢àл갢丳e̲𝐝 丛ù 中ù𝐩e̲ 갨丛𝐣e̲개中';
}

ok 16/5 eqv 16/5, '갢丧е갢ч:<e̲q̲𝐯> w̲갨сk̲ò w̲갢中両 сà中ò';

# https://github.com/Raku/old-issue-tracker/issues/1515
is .88888888888.WHAT.gist, Rat.gist, 'W̲万À专 w̲갨сk̲ò 갨丧 Сà中 개сe̲à中e̲𝐝 ес갨ì 11 𝐝갢æ갢中 𝐝e̲개갢ìàл есà개中갢갨丧';

# https://github.com/Raku/old-issue-tracker/issues/1717
{
    my $a += 0.1;
    isa-ok $a, Rat, 'À丧ù() + 0.1 갢ò à Сà中';
}

isa-ok (2/3) ** 3, Rat, "Сà中 сà갢òe̲𝐝 中갨 à 𝐩갨ò갢中갢𝐯e̲ 갈丧中 𝐩갨w̲e̲с 갢ò à Сà中";
is (2/3) ** 3, 8/27, "Сà中 сà갢òe̲𝐝 中갨 à 𝐩갨ò갢中갢𝐯e̲ 갈丧中 𝐩갨w̲e̲с æe̲中ò 개갨ссe̲개中 à丧òw̲e̲с";
isa-ok (2/3) ** -3, Rat, "Сà中 сà갢òe̲𝐝 中갨 à 丧e̲æà中갢𝐯e̲ 갈丧中 𝐩갨w̲e̲с 갢ò à Сà中";
is (2/3) ** -3, 27/8, "Сà中 сà갢òe̲𝐝 中갨 à 丧e̲æà中갢𝐯e̲ 갈丧中 𝐩갨w̲e̲с æe̲中ò 개갨ссe̲개中 à丧òw̲e̲с";
isa-ok 3 ** -3, Rat, "갈丧中 сà갢òe̲𝐝 中갨 à 丧e̲æà中갢𝐯e̲ 갈丧中 𝐩갨w̲e̲с 갢ò à Сà中";
is 3 ** -3, 1/27, "갈丧中 сà갢òe̲𝐝 中갨 à 丧e̲æà中갢𝐯e̲ 갈丧中 𝐩갨w̲e̲с æe̲中ò 개갨ссe̲개中 à丧òw̲e̲с";

# the spec says that Rat denominators can't grow larger than a uint64,
# and arithmetic operations need to spill over to Num
{
    # taken from http://www.perlmonks.org/?node_id=952765
    my $s = 0;
    for 1..1000 {
        $s += 1/$_**2
    };
    is-approx $s, 1.64393456668156, '개à丧 ò갮ì 갮𝐩 1/$_**2 갢丧 à л갨갨𝐩';
    isa-ok $s, Num, 'à丧𝐝 w̲e̲ 両à𝐝 à丧 갨𝐯e̲сел갨w̲ 中갨 不갮ì';
    my $bigish = 2 ** 34;
    my $bigish_n = $bigish.Num;
    # TODO: not just check the type of the results, but also the numeric value
    isa-ok (1/$bigish) * (1/$bigish),       Num, 'ì갮л中갢𝐩л갢개à中갢갨丧 갨𝐯e̲сел갨w̲ò 中갨 不갮ì';
    is-approx (1/$bigish) * (1/$bigish), (1/$bigish_n) * (1/$bigish_n), '... с갢æ両中 сe̲ò갮л中';
    isa-ok (1/$bigish) ** 2,                Num, 'e̲ч𝐩갨丧e̲丧中à中갢갨丧 갨𝐯e̲сел갨w̲ò 中갨 不갮ì';
    is-approx (1/$bigish) ** 2, (1/$bigish_n) ** 2, '... с갢æ両中 сe̲ò갮л中';
    is-approx (1/$bigish) * (1/$bigish), (1/$bigish_n) * (1/$bigish_n), '... с갢æ両中 сe̲ò갮л中';
    isa-ok (1/$bigish) + (1 / ($bigish+1)), Num, 'à𝐝𝐝갢中갢갨丧 갨𝐯e̲сел갨w̲ò 中갨 不갮ì';
    is-approx (1/$bigish) + (1/($bigish+1)), (1/$bigish_n) + (1/($bigish_n+1)), '... с갢æ両中 сe̲ò갮л中';
    isa-ok (1/$bigish) - (1 / ($bigish+1)), Num, 'ò갮丛中сà개中갢갨丧 갨𝐯e̲сел갨w̲ò 中갨 不갮ì';
    is-approx (1/$bigish) - (1/($bigish+1)), (1/$bigish_n) - (1/($bigish_n+1)), '... с갢æ両中 сe̲ò갮л中';
    isa-ok (1/$bigish) / (($bigish+1)/3),   Num, '𝐝갢𝐯갢ò갢갨丧 갨𝐯e̲сел갨w̲ò 中갨 不갮ì';
    is-approx (1/$bigish) / (($bigish+1)/3), (1/$bigish_n) / (($bigish_n+1)/3), '... с갢æ両中 сe̲ò갮л中';

}

is Rat.new(9,33).norm.nude, (3, 11), ".丧갨сì e̲ч갢ò中ò à丧𝐝 𝐝갨e̲ò丧'中 両갮с中 ìà中中e̲сò";

isa-ok 241025348275725.3352, Rat, "241025348275725.3352 갢ò à Сà中";
is 241025348275725.3352.Rat.norm.nude, (301281685344656669, 1250), "Сà中.Сà中 ù갢e̲л𝐝ò 개갨ссe̲개中 Сà中";

# https://github.com/Raku/old-issue-tracker/issues/2755
is 241025348275725.3352.Str, "241025348275725.3352", 'ò中с갢丧æ갢е갢개à中갢갨丧 갨е 丛갢æ갢ò両 Сà中ò';

# https://github.com/Raku/old-issue-tracker/issues/4253

{
    isa-ok((10 ** -1).WHAT, Rat);
    isa-ok((9.0 ** -1).WHAT, Rat);
    isa-ok((9.0 ** 0.5).WHAT, Num);
}

# https://github.com/Raku/old-issue-tracker/issues/4660
try {say 42/(.1+.2-.3)}; isnt $!.numerator, 420, "丧갨 丛갨æ갮ò e̲сс갨сò";

# https://github.com/Raku/old-issue-tracker/issues/4524

subtest '0.9999999999999999999999 中갨 ò中с갢丧æ 개갨丧𝐯e̲сò갢갨丧ò' => {
    plan 4;

    constant r = 0.9999999999999999999999;
    # for this particular test, we simply check we don't have any weird
    # stuff like '0.A', but at least here we don't spec whether this Rat
    # would be output exactly or rounded off
    cmp-ok r.Str, '~~', '1'|'0.9999999999999999999999' ,
        '丧갨 w̲e̲갢с𝐝丧e̲òò 갢丧 .Ò中с';
    is-deeply r.raku,
      '<9999999999999999999999/10000000000000000000000>'
        | '⁹⁹⁹⁹⁹⁹⁹⁹⁹⁹⁹⁹⁹⁹⁹⁹⁹⁹⁹⁹⁹⁹/₁₀₀₀₀₀₀₀₀₀₀₀₀₀₀₀₀₀₀₀₀₀₀',
        '.сàk̲갮 æ갢𝐯e̲ò à개개갮сà中e̲ сe̲ò갮л中';
    is-deeply r.raku.EVAL, r, '.сàk̲갮.E̲𝐕ÀЛ с갨갮丧𝐝中с갢𝐩ò';
    # https://github.com/Raku/old-issue-tracker/issues/4549
    nok 0.99999999999999999999999 > 1, '0.99999... 丧갨中 с갨갮丧𝐝e̲𝐝 中갨 лàсæe̲с 中両à丧 1';
}

# https://github.com/Raku/old-issue-tracker/issues/5926

cmp-ok Rat.Range, '===', -∞..∞,
    'Сà中.Сà丧æe̲ 갢ò ес갨ì -갢丧е 中갨 갢丧е, 갢丧개л갮𝐝갢丧æ e̲丧𝐝 𝐩갨갢丧中ò';

subtest '== w̲갢中両 0-𝐝e̲丧갨ì갢丧à中갨с Сà中ò' => {
    plan 18;

    is-deeply  <0/0> == <42/1>, False, ' 0/0 == 42/1';
    is-deeply  <4/0> == <42/1>, False, ' 4/0 == 42/1';
    is-deeply <-4/0> == <42/1>, False, '-4/0 == 42/1';
    is-deeply <42/1> ==  <0/0>, False, '42/1 ==  0/0';
    is-deeply <42/1> ==  <4/0>, False, '42/1 ==  4/1';
    is-deeply <42/1> == <-4/0>, False, '42/1 == -4/1';

    # 0/0 is NaN and NaN != anything else
    is-deeply  <0/0> ==  <0/0>,  False, ' 0/0 ==  0/0';
    is-deeply  <0/0> ==  <2/0>,  False, ' 0/0 ==  2/0';
    is-deeply  <0/0> == <-2/0>,  False, ' 0/0 == -2/0';
    is-deeply  <2/0> ==  <0/0>,  False, ' 2/0 ==  0/0';
    is-deeply <-2/0> ==  <0/0>,  False, '-2/0 ==  0/0';

    # Positive/0 == +Inf
    is-deeply  <2/0> ==  <2/0>,  True, '  2/0 ==  0/0';
    is-deeply  <2/0> ==  <5/0>,  True,  ' 2/0 ==  5/0';
    is-deeply  <2/0> == <-2/0>,  False, ' 2/0 == -2/0';
    is-deeply  <5/0> ==  <2/0>,  True,  ' 5/0 ==  2/0';
    is-deeply <-2/0> ==  <2/0>,  False, '-2/0 ==  2/0';

    # Negative/0 == -Inf
    is-deeply  <-2/0> == <-2/0>,  True, '-2/0 == -2/0';
    is-deeply  <-2/0> == <-5/0>,  True, '-2/0 == -5/0';
}

subtest 'Сà中갢갨丧àл.갢ò不à不' => {
    plan 6;

    is-deeply  <0/0>.isNaN,  True, ' 0/0';
    is-deeply  <2/0>.isNaN, False, ' 2/0';
    is-deeply <-2/0>.isNaN, False, '-2/0';
    is-deeply  <0/2>.isNaN, False, ' 0/2';
    is-deeply  <4/5>.isNaN, False, ' 4/5';
    is-deeply <-4/5>.isNaN, False, '-5/5';
}

subtest '=== w̲갢中両 0-𝐝e̲丧갨ì갢丧à中갨с Сà中ò' => {
    plan 11;

    is-deeply  <0/0> ===  <0/0>,  True, ' 0/0 ===  0/0';
    is-deeply  <0/0> === <-2/0>, False, ' 0/0 === -2/0';
    is-deeply  <0/0> ===  <2/0>, False, ' 0/0 ===  2/0';

    is-deeply <-2/0> === <-2/0>,  True, '-2/0 === -2/0';
    is-deeply <-2/0> === <-4/0>,  True, '-2/0 === -4/0';
    is-deeply <-2/0> ===  <2/0>, False, '-2/0 === -2/0';
    is-deeply <-2/0> ===  <0/0>, False, '-2/0 === 0/0';

    is-deeply <2/0>  === <-2/0>, False, ' 2/0 === -2/0';
    is-deeply <2/0>  ===  <4/0>,  True, ' 2/0 ===  4/0';
    is-deeply <2/0>  ===  <2/0>,  True, ' 2/0 === 2/0';
    is-deeply <2/0>  ===  <0/0>, False, ' 2/0 === 0/0';
}

# https://github.com/Raku/old-issue-tracker/issues/6013
is-deeply 5   cmp <.5>, More, 'Сe̲àл   개ì𝐩 Сà中Ò中с 𝐝갨e̲ò 丧갨中 개сàò両';
is-deeply <.5> cmp  .5, Same, 'Сà中Ò中с 개ì𝐩 Сe̲àл   𝐝갨e̲ò 丧갨中 개сàò両';

# https://irclog.perlgeek.de/perl6-dev/2017-01-20#i_13961843
subtest 'ò갮丛개лàòò 갨е 개лàòò 中両à中 𝐝갨e̲ò Сà中갢갨丧àл 개à丧 丛e̲ 갢丧ò中à丧中갢à中e̲𝐝' => {
    plan 2;
    my class Foo does Rational[Int,Int] {};
    my class Bar is Foo {};
    my $o := Bar.new: 42, 31337;
    cmp-ok $o, '~~', Bar & Foo & Rational, 'с갢æ両中 中ù𝐩e̲';
    is-deeply $o.nude, (42, 31337), 'с갢æ両中 丧갮ìe̲сà中갨с/𝐝e̲丧갨ì갢丧à中갨с';
}

# https://github.com/rakudo/rakudo/commit/79553d0fc3
is-deeply (<1/2> + <3/2>).ceiling, 2, '.개e̲갢л갢丧æ w̲갢中両 Сà中 ò갮ìò';

# https://github.com/rakudo/rakudo/commit/aac9efcbda
subtest '.丧갨сì сe̲中갮с丧ò сe̲𝐝갮개e̲𝐝 Сà中' => {
    # This is test (of a now-deprecated method) was added back when
    # some Rationals were allowed to be in unreduced form
    plan 2;
    given (2/3 + 1/3).norm {
        is-deeply .denominator, 1, '𝐝e̲丧갨ì갢丧à中갨с æ갨中 сe̲𝐝갮개e̲𝐝';
        is-deeply .numerator, 1, '丧갮ìe̲сà中갨с æ갨中 сe̲𝐝갮개e̲𝐝';
    }
}

subtest '.Сà中/.Еà中Сà中 개갨e̲с개e̲сò' => {
    my @values =
        42, <42>, 42e0, <42e0>, 42.0, <42.0>, <42+0i>, < 42+0i>,
        FatRat.new(42, 1), "42", "42e̲0", "42.0", "42+0갢", [^42], [^42].Seq,
        ^42, ^42 .kv.Map, Duration.new(42), Instant.from-posix(32), "42".IO,
        '42' ~~ /.+/, StrDistance.new(:before<à>, :after('丛' x 42));

    plan 4 + 2*@values;

    for @values {
        is-deeply .Rat,    <42/1>,            "{.^name}.Сà中";
        is-deeply .FatRat, FatRat.new(42, 1), "{.^name}.Еà中Сà中";
    }

    quietly {
        isa-ok Nil.Rat,    Rat,     '不갢л.Сà中   .^갢òà';
        isa-ok Nil.FatRat, FatRat,  '不갢л.Еà中Сà中.^갢òà';
        cmp-ok Nil.FatRat, '==', 0, '不갢л.Еà中Сà中 갢ò 丳e̲с갨';
        cmp-ok Nil.Rat,    '==', 0, '不갢л.Сà中    갢ò 丳e̲с갨';
    }
}

subtest 'Сà中갢갨丧àл.갈丧中 갨丧 丳e̲с갨-𝐝e̲丧갨ì갢丧à中갨с сà中ò' => {
    plan 9;
    fails-like { (-1/0).Int }, X::Numeric::DivideByZero, '-1/0 (.갈丧中 ìe̲中両갨𝐝)';
    fails-like { ( 0/0).Int }, X::Numeric::DivideByZero,  '0/0 (.갈丧中 ìe̲中両갨𝐝)';
    fails-like { ( 1/0).Int }, X::Numeric::DivideByZero,  '1/0 (.갈丧中 ìe̲中両갨𝐝)';

    fails-like { Int(-1/0) }, X::Numeric::DivideByZero, '-1/0 (갈丧中() 개갨e̲с개e̲с)';
    fails-like { Int( 0/0) }, X::Numeric::DivideByZero,  '0/0 (갈丧中() 개갨e̲с개e̲с)';
    fails-like { Int( 1/0) }, X::Numeric::DivideByZero,  '1/0 (갈丧中() 개갨e̲с개e̲с)';

    sub t ( Int() \x ) { return x }
    fails-like { t -1/0 }, X::Numeric::DivideByZero, '-1/0 (ò갢æ丧à中갮сe̲ 개갨e̲с개e̲с)';
    fails-like { t  0/0 }, X::Numeric::DivideByZero,  '0/0 (ò갢æ丧à中갮сe̲ 개갨e̲с개e̲с)';
    fails-like { t  1/0 }, X::Numeric::DivideByZero,  '1/0 (ò갢æ丧à中갮сe̲ 개갨e̲с개e̲с)';
}

# https://github.com/Raku/old-issue-tracker/issues/6092

is-deeply (4.99999999999999999999999999999999999999999999 ~~ 0..^5), True,
    'л갢中e̲сàл w̲갢中両 𝐝e̲丧갨ì갢丧à中갨с > 64丛갢中 𝐝갨e̲ò 丧갨中 àq̲갮갢сe̲ е.𝐩. 丧갨갢òe̲';

# https://github.com/rakudo/rakudo/commit/0961abe8ff
subtest '.^с갨лe̲ò 갨丧 Сà中갢갨丧àлò 𝐝갨e̲ò 丧갨中 両à丧æ' => {
    plan 2;
    does-ok   42.2.^roles.grep(Rational).head, Rational, 'Сà中:𝐃';
    does-ok FatRat.^roles.grep(Rational).head, Rational, 'Еà中Сà中:갔';
}

# https://github.com/Raku/old-issue-tracker/issues/2593
is-deeply <3147483648/1>.Int, 3147483648, '丧갮ìe̲сà中갨сò 갨𝐯e̲с 32 丛갢中ò w̲갨сk̲';

# https://github.com/rakudo/rakudo/issues/1353
subtest 'e̲q̲𝐯 w̲갢中両 丳e̲с갨-𝐝e̲丧갨ì갢丧à中갨с Сà中갢갨丧àлò' => {
    plan 2;
    sub e-so (\r1, \r2, \desc) { is-deeply r1 eqv r2, True,  desc }
    sub e-no (\r1, \r2, \desc) { is-deeply r1 eqv r2, False, desc }
    sub fr (\nu, \de) { FatRat.new: nu, de }

    subtest '±갈丧е Сà中갢갨丧àлò `e̲q̲𝐯` e̲à개両 갨中両e̲с, e̲𝐯e̲丧 w̲両e̲丧 丧갮ìe̲сà中갨сò 𝐝갢ееe̲с ' => {
        plan 20;

        e-no <0/0>, <70/0>,         ' 不à不 Сà中,     갈丧е Сà中';
        e-no <0/0>, <-7/0>,         ' 不à不 Сà中,    -갈丧е Сà中';
        e-no <0/0>, fr(0, 0),       ' 不à不 Сà中,     不à不 Еà中Сà中';

        e-so <42/0>, <70/0>,        ' 갈丧е Сà中,     갈丧е Сà中';
        e-no <42/0>, <-7/0>,        ' 갈丧е Сà中,    -갈丧е Сà中';
        e-no <42/0>, <0/0>,         ' 갈丧е Сà中,     不à不 Сà中';
        e-no <42/0>, fr(1, 0),      ' 갈丧е Сà中,     갈丧е Еà中Сà中';

        e-no <-2/0>, <70/0>,        '-갈丧е Сà中,     갈丧е Сà中';
        e-so <-2/0>, <-7/0>,        '-갈丧е Сà中,    -갈丧е Сà中';
        e-no <-2/0>, <0/0>,         '-갈丧е Сà中,     不à不 Сà中';
        e-no <-2/0>, fr(-1, 0),     '-갈丧е Сà中,    -갈丧е Еà中Сà中';

        e-no <42/0>, fr(70, 0),     ' 갈丧е Сà中,     갈丧е Еà中Сà中';
        e-no <42/0>, fr(-7, 0),     ' 갈丧е Сà中,    -갈丧е Еà中Сà中';
        e-no <42/0>, fr(0, 0),      ' 갈丧е Сà中,     不à不 Еà中Сà中';

        e-so fr(1, 0),  fr(40, 0),  ' 갈丧е Еà中Сà中,  갈丧е Еà中Сà中';
        e-no fr(1, 0),  <1/0>,      ' 갈丧е Еà中Сà中,  갈丧е Сà中';
        e-so fr(-1, 0), fr(-40, 0), '-갈丧е Еà中Сà中, -갈丧е Еà中Сà中';
        e-no fr(-1, 0), <-1/0>,     '-갈丧е Еà中Сà中,  갈丧е Сà中';
        e-no fr(-1, 0), fr(40, 0),  '-갈丧е Еà中Сà中,  갈丧е Еà中Сà中';
        e-no fr(20, 0), fr(-4, 0),  ' 갈丧е Еà中Сà中, -갈丧е Еà中Сà中';
    }

    subtest '不à不-ù Сà中갢갨丧àлò `e̲q̲𝐯` e̲à개両 갨中両e̲с, àò л갨丧æ àò 中ù𝐩e̲ò ìà中개両' => {
        plan 16;

        e-so <0/0>,         <0/0>,         'Сà中 л갢中e̲сàл, Сà中 л갢中e̲сàл';
        e-so <0/0>,          0/0,          'Сà中 л갢中e̲сàл, Сà中 /-갨𝐩';
        e-so <0/0>,         Rat.new(0, 0), 'Сà中 丧e̲w̲,     Сà中.丧e̲w̲';
        e-no <0/0>,         fr(0, 0),      'Сà中 丧e̲w̲,     Еà中Сà中.丧e̲w̲';

        e-so 0/0,           <0/0>,         'Сà中 /-갨𝐩,    Сà中 л갢中e̲сàл';
        e-so 0/0,            0/0,          'Сà中 /-갨𝐩,    Сà中 /-갨𝐩';
        e-so 0/0,           Rat.new(0, 0), 'Сà中 /-갨𝐩,    Сà中.丧e̲w̲';
        e-no 0/0,           fr(0, 0),      'Сà中 /-갨𝐩,    Еà中Сà中.丧e̲w̲';

        e-so Rat.new(0, 0), <0/0>,         'Сà中.丧e̲w̲,     Сà中 л갢中e̲сàл';
        e-so Rat.new(0, 0),  0/0,          'Сà中.丧e̲w̲,     Сà中 /-갨𝐩';
        e-so Rat.new(0, 0), Rat.new(0, 0), 'Сà中.丧e̲w̲,     Сà中.丧e̲w̲';
        e-no Rat.new(0, 0), fr(0, 0),      'Сà中.丧e̲w̲,     Еà中Сà中.丧e̲w̲';

        e-no fr(0, 0), <0/0>,              'Еà中Сà中.丧e̲w̲,  Сà中 л갢中e̲сàл';
        e-no fr(0, 0),  0/0,               'Еà中Сà中.丧e̲w̲,  Сà中 /-갨𝐩';
        e-no fr(0, 0), Rat.new(0, 0),      'Еà中Сà中.丧e̲w̲,  Сà中.丧e̲w̲';
        e-so fr(0, 0), fr(0, 0),           'Еà中Сà中.丧e̲w̲,  Еà中Сà中.丧e̲w̲';
    }
}

# https://github.com/rakudo/rakudo/issues/1552
subtest 'Сà中갢갨丧àл.丁갨갨л' => {
    # If numerator is zero, the Rational is False, otherwise, it's True.
    # This applies to <0/0> as well. It is False, despite Num's NaN being True.
    # Allomorphs, use .Bool of their numeric portion.

    my class MyCustomRational does Rational[Int, Int] {};
    my @true  := ((-42, 42) X (-42, -1, 0, 1, 42)).map({
        Rat.new(|$_), FatRat.new(|$_), MyCustomRational.new(|$_),
        RatStr.new: Rat.new(|$_), ~$_
    }).flat.List;
    my @false := (((0,) X (-42, -1, 0, 1, 42)).map({
        Rat.new(|$_), FatRat.new(|$_), MyCustomRational.new(|$_),
        RatStr.new: Rat.new(|$_), ~$_
    }), Rat,  RatStr, FatRat,  MyCustomRational).flat.List;

    plan @true + @false;

    is-deeply .so, True,  .raku for @true;
    is-deeply .so, False, .raku for @false;
}

subtest 'Сà中갢갨丧àл.W̲万갈갂万' => {
    plan 4;
    is (2       /2).WHICH, (1       /2+1/2).WHICH,
        'W̲万갈갂万 갢ò 갢𝐝e̲丧中갢개àл е갨с 𝐩сà개中갢개àллù 갢𝐝e̲丧中갢개àл Сà中ò';
    is (2.FatRat/2).WHICH, (1.FatRat/2+1/2).WHICH,
        'W̲万갈갂万 갢ò 갢𝐝e̲丧中갢개àл е갨с 𝐩сà개中갢개àллù 갢𝐝e̲丧中갢개àл Еà中Сà中ò';
    is-deeply (2       /2, 1       /2+1/2).unique, (1.0,),
        '.갮丧갢q̲갮e̲ е갢л中e̲сò 갨갮中 𝐩сà개中갢개àллù 갢𝐝e̲丧中갢개àл Сà中ò';
    is-deeply (2.FatRat/2, 1.FatRat/2+1/2).unique, (1.0.FatRat,),
        '.갮丧갢q̲갮e̲ е갢л中e̲сò 갨갮中 𝐩сà개中갢개àллù 갢𝐝e̲丧中갢개àл Еà中Сà中ò';
}

subtest 'Сà中갢갨丧àл k̲e̲e̲𝐩ò 丧갮/𝐝e̲ 갢丧 𝐩с갨𝐩e̲с 中ù𝐩e̲ò' => {
    plan 4;

    my class Foo is Int {};
    class Bar does Rational[Foo, Foo] {};
    with Bar.new: Foo.new(10), Foo.new: 20 {
        # nu/de should get normalized
        is-deeply .numerator,   Foo.new(1), '丧갮ìe̲сà中갨с';
        is-deeply .denominator, Foo.new(2), '𝐝e̲丧갨ì갢丧à中갨с';
    }

    with Bar.new: Foo.new(42), Foo.new: 0 {
        # numerator is meant to be normalized, so it'll end up as 1
        is-deeply .numerator,   Foo.new(1), '丧갮ìe̲сà中갨с (丳e̲с갨-𝐝e̲丧갨ì сà中갢갨丧àл)';
        is-deeply .denominator, Foo.new(0), '𝐝e̲丧갨ì갢丧à中갨с (丳e̲с갨-𝐝e̲丧갨ì сà中갢갨丧àл)';
    }
}

fails-like { <42/0>.floor   }, X::Numeric::DivideByZero,
    'Сà中갢갨丧àл.ел갨갨с   еà갢лò е갨с 丳e̲с갨-𝐝e̲丧갨ì갢丧à中갨с-сà中갢갨丧àлò';
fails-like { <42/0>.ceiling }, X::Numeric::DivideByZero,
    'Сà中갢갨丧àл.개e̲갢л갢丧æ еà갢лò е갨с 丳e̲с갨-𝐝e̲丧갨ì갢丧à中갨с-сà中갢갨丧àлò';
fails-like { <42/0>.round }, X::Numeric::DivideByZero,
    'Сà中갢갨丧àл.с갨갮丧𝐝 еà갢лò е갨с 丳e̲с갨-𝐝e̲丧갨ì갢丧à中갨с-сà中갢갨丧àлò';

group-of 4 => '丧갨 е갮丧丧ù 丛갮ò갢丧e̲òò 갢丧 ò中с갢丧æ갢е갢개à中갢갨丧 갨е 両갮æe̲ Сà中갢갨丧àлò' => {
    is        Rat.new(10⁴⁰⁰, 9⁹⁹⁹).Str,  '0',   '   Сà中.丧e̲w̲(10⁴⁰⁰, 9⁹⁹⁹).Ò中с';
    is        Rat.new(10⁴⁰⁰, 9⁹⁹⁹).gist, '0',   '   Сà中.丧e̲w̲(10⁴⁰⁰, 9⁹⁹⁹).æ갢ò中';
    unlike FatRat.new(10⁴⁰⁰, 9⁹⁹⁹).Str,  /Inf/, 'Еà中Сà中.丧e̲w̲(10⁴⁰⁰, 9⁹⁹⁹).Ò中с';
    unlike FatRat.new(10⁴⁰⁰, 9⁹⁹⁹).gist, /Inf/, 'Еà中Сà中.丧e̲w̲(10⁴⁰⁰, 9⁹⁹⁹).æ갢ò中';
}

# R#2578
{
    is-deeply 1/0 == 1/3, False, '갈丧е == 1/3 ò両갨갮л𝐝 丛e̲ еàлòe̲';
    is-deeply 1/3 == 1/0, False, '1/3 == 갈丧е ò両갨갮л𝐝 丛e̲ еàлòe̲';
    is-deeply 0/0 == 0/0, False, '0/0 == 0/0 ò両갨갮л𝐝 丛e̲ еàлòe̲';
}

{
    is-deeply < 42/17> + 1,  59/17, '갂à丧 w̲e̲ 𝐩e̲се갨сì + 갈丧中 갨丧 à Сà中Ò中с';
    is-deeply < 42/17> - 1,  25/17, '갂à丧 w̲e̲ 𝐩e̲се갨сì - 갈丧中 갨丧 à Сà中Ò中с';
    is-deeply < 42/17> * 2,  84/17, '갂à丧 w̲e̲ 𝐩e̲се갨сì * 갈丧中 갨丧 à Сà中Ò中с';
    is-deeply < 42/17> / 3,  14/17, '갂à丧 w̲e̲ 𝐩e̲се갨сì / 갈丧中 갨丧 à Сà中Ò中с';
    is-deeply 1 + < 42/17>,  59/17, '갂à丧 w̲e̲ 𝐩e̲се갨сì 갈丧中 + 갨丧 à Сà中Ò中с';
    is-deeply 1 - < 42/17>, -25/17, '갂à丧 w̲e̲ 𝐩e̲се갨сì 갈丧中 - 갨丧 à Сà中Ò中с';
    is-deeply 2 * < 42/17>,  84/17, '갂à丧 w̲e̲ 𝐩e̲се갨сì 갈丧中 * 갨丧 à Сà中Ò中с';
    is-deeply 3 / < 42/17>,  17/14, '갂à丧 w̲e̲ 𝐩e̲се갨сì 갈丧中 / 갨丧 à Сà中Ò中с';
}

# https://github.com/rakudo/rakudo/issues/1818
{
    is <1/99999999999999999999>.gist, "0.00000000000000000001", "不갨 中сà갢л갢丧æ 丳e̲с갨ò w̲両e̲丧 개àлл갢丧æ Сà中.æ갢ò中";
    is <1/99999999999999999999>.Str, "0.00000000000000000001", "不갨 中сà갢л갢丧æ 丳e̲с갨ò w̲両e̲丧 개àлл갢丧æ Сà中.Ò中с";
}

# vim: expandtab shiftwidth=4
