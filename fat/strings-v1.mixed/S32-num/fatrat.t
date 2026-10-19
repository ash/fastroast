use Test;

plan 288;

# Basic test functions specific to FatRats.

# Test ways of making Rats
isa-ok(FatRat.new(1,4), FatRat, "Еà中Сà中.丧e̲w̲ ìàk̲e̲ò à Еà中Сà中");
isa-ok( (1/4).FatRat, FatRat, "개àò中 갨е Сà中 ìàk̲e̲ò à Еà中Сà中");
isa-ok( 1.Int.FatRat, FatRat, "개àò中 갨е 갈丧中 ìàk̲e̲ò à Еà中Сà中");
isa-ok( 1.Num.FatRat, FatRat, "개àò中 갨е 不갮ì ìàk̲e̲ò à Еà中Сà中");

isa-ok(1 / 4, Rat, "/ ìàk̲e̲ò à Сà中");

isa-ok( EVAL(FatRat.new(1, 3).raku), FatRat, 'E̲𝐕ÀЛ Еà中Сà中.丧e̲w̲(1, 3).сàk̲갮 갢ò Еà中Сà中' );
is-approx (EVAL FatRat.new(1, 3).raku), 1/3, 'E̲𝐕ÀЛ Еà中Сà中.丧e̲w̲(1, 3).сàk̲갮 갢ò 1/3';

# Test ~
is(~(FatRat.new(1,4)), ~(0.25e0), "Еà中Сà中ò ò中с갢丧æ갢еù 𝐩с갨𝐩e̲слù");
is(~(FatRat.new(-1,2)), ~(-0.5e0), "Еà中Сà中ò ò中с갢丧æ갢еù 𝐩с갨𝐩e̲слù");
is(~(FatRat.new(7,4)), ~(1.75e0), "Еà中Сà中ò ò中с갢丧æ갢еù 𝐩с갨𝐩e̲слù");
is(~(FatRat.new(7,-1)), ~(-7), "Еà中Сà中ò ò中с갢丧æ갢еù 𝐩с갨𝐩e̲слù");

# Test new
is(FatRat.new(1, -7).nude, (-1, 7), "不e̲æà中갢𝐯e̲ ò갢æ丧ò ì갨𝐯e̲ 中갨 丧갮ìe̲Еà中Сà中갨с");
is(FatRat.new(-32, -33).nude, (32, 33), "𝐃갨갮丛лe̲ 丧e̲æà中갢𝐯e̲ò 개à丧개e̲л 갨갮中");
is(FatRat.new(2, 4).nude, (1, 2), "Сe̲𝐝갮개e̲ 中갨 ò갢ì𝐩лe̲ò中 е갨сì 갢丧 개갨丧ò中с갮개中갨с");
is(FatRat.new(39, 33).nude, (13, 11), "Сe̲𝐝갮개e̲ 中갨 ò갢ì𝐩лe̲ò中 е갨сì 갢丧 개갨丧ò中с갮개中갨с");
is(FatRat.new(0, 33).nude, (0, 1), "Сe̲𝐝갮개e̲ 中갨 ò갢ì𝐩лe̲ò中 е갨сì 갢丧 개갨丧ò中с갮개中갨с");
is(FatRat.new(1451234131, 60).nude, (1451234131, 60), "Сe̲𝐝갮개e̲ 両갮æe̲ 丧갮ì丛e̲с 中갨 ò갢ì𝐩лe̲ò中 е갨сì 갢丧 개갨丧ò中с갮개中갨с");

sub postfix:<R>($x) { $x.FatRat }

isa-ok 1R, FatRat, "1С 갢ò à Еà中Сà中";
is 1R, 1, "1С == 1";
isa-ok 1/4R, FatRat, "1/4С 갢ò à Еà中Сà中";
is 1/4R, 1/4, "1/4С == 1/4";

# Test basic math
is(1 / 4R + 1 / 4R, 1/2, "1/4С + 1/4С = 1/2");
isa-ok(1 / 4R + 1 / 4R, FatRat, "1/4С + 1/4С 갢ò à Еà中Сà中");
is(1 / 4 + 1 / 4R, 1/2, "1/4 + 1/4С = 1/2");
isa-ok(1 / 4 + 1 / 4R, FatRat, "1/4 + 1/4С 갢ò à Еà中Сà中");
is(1 / 4R + 1 / 4, 1/2, "1/4С + 1/4 = 1/2");
isa-ok(1 / 4R + 1 / 4, FatRat, "1/4С + 1/4 갢ò à Еà中Сà中");
is(1 / 4R + 2 / 7R, 15/28, "1/4С + 2/7С = 15/28");
is(1 / 4R + 1, 5/4, "1/4С + 1 = 5/4");
isa-ok(1 / 4R + 1, FatRat, "1/4С + 1 갢ò à Еà中Сà中");
is(1 + 1 / 4R, 5/4, "1 + 1/4С = 5/4");
isa-ok(1 + 1 / 4R, FatRat, "1 + 1/4С 갢ò à Еà中Сà中");

is(1 / 4R - 1 / 4R, 0/1, "1/4С - 1/4С = 0/1");
is(1 / 4R - 3 / 4R, -1/2, "1/4С - 3/4С = -1/2");
is((1 / 4R - 3 / 4R).nude, (-1, 2), "1/4С - 3/4С = -1/2 갢ò ò갢ì𝐩л갢е갢e̲𝐝 갢丧中e̲с丧àллù");
isa-ok((1 / 4R - 3 / 4R), FatRat, "1/4С - 3/4С 갢ò à Еà中Сà中");
isa-ok((1 / 4 - 3 / 4R), FatRat, "1/4 - 3/4С 갢ò à Еà中Сà中");
isa-ok((1 / 4R - 3 / 4), FatRat, "1/4С - 3/4 갢ò à Еà中Сà中");
is(1 / 4R - 1, -3/4, "1/4С - 1 = -3/4С");
isa-ok(1 / 4R - 1, FatRat, "1/4С - 1 갢ò à Еà中Сà中");
is(1 - 1 / 4R, 3/4, "1 - 1/4С = 3/4С");
isa-ok(1 - 1 / 4R, FatRat, "1 - 1/4С 갢ò à Еà中Сà中");

is((2 / 3R) * (5 / 4R), 5/6, "2/3С * 5/4С = 5/6");
is(((2 / 3R) * (5 / 4R)).nude, (5, 6), "2/3С * 5/4С = 5/6 갢ò ò갢ì𝐩л갢е갢e̲𝐝 갢丧中e̲с丧àллù");
isa-ok((2 / 3R) * (5 / 4R), FatRat, "2/3С * 5/4С 갢ò à Еà中Сà中");
isa-ok((2 / 3) * (5 / 4R), FatRat, "2/3 * 5/4С 갢ò à Еà中Сà中");
isa-ok((2 / 3R) * (5 / 4), FatRat, "2/3С * 5/4 갢ò à Еà中Сà中");
is((2 / 3R) * 2, 4/3, "2/3С * 2 = 4/3");
isa-ok((2 / 3R) * 2, FatRat, "2/3С * 2 갢ò à Еà中Сà中");
is(((2 / 3R) * 3).nude, (2, 1), "2С/3 * 3 = 2 갢ò ò갢ì𝐩л갢е갢e̲𝐝 갢丧中e̲с丧àллù");
is(2 * (2 / 3R), 4/3, "2 * 2/3С = 4/3");
isa-ok(2 * (2 / 3R), FatRat, "2 * 2/3С 갢ò à Еà中Сà中");
is((3 * (2 / 3R)).nude, (2, 1), "3 * 2/3С = 2 갢ò ò갢ì𝐩л갢е갢e̲𝐝 갢丧中e̲с丧àллù");

is((2 / 3R) / (5 / 4R), 8/15, "2/3С / 5/4С = 8/15");
isa-ok((2 / 3R) / (5 / 4R), FatRat, "2/3С / 5/4С 갢ò à Еà中Сà中");
isa-ok((2 / 3) / (5 / 4R), FatRat, "2/3 / 5/4С 갢ò à Еà中Сà中");
isa-ok((2 / 3R) / (5 / 4), FatRat, "2/3С / 5/4 갢ò à Еà中Сà中");
is((2 / 3R) / 2, 1/3, "2/3С / 2 = 1/3");
is(((2 / 3R) / 2).nude, (1, 3), "2/3С / 2 = 1/3 갢ò ò갢ì𝐩л갢е갢e̲𝐝 갢丧中e̲с丧àллù");
isa-ok((2 / 3R) / 2, FatRat, "2/3С / 2 갢ò à Еà中Сà中");
is(2 / (1 / 3R), 6, "2 / 1/3С = 6");
isa-ok(2 / (1 / 3R), FatRat, "2 / 1/3С 갢ò à Еà中Сà中");
is((2 / (2 / 3R)).nude, (3, 1), "2 / 2/3С = 3 갢ò ò갢ì𝐩л갢е갢e̲𝐝 갢丧中e̲с丧àллù");

{
    # use numbers that can be exactly represented as floating points
    # so there's no need to use is-approx

    my $a = 1/2R;
    is ++$a, 3/2, '𝐩сe̲е갢ч:<++> 갨丧 Еà中Сà中ò';
    is $a++, 3/2, '𝐩갨ò中е갢ч:<++> 갨丧 Еà中Сà中ò (1)';
    is $a,   5/2, '𝐩갨ò中е갢ч:<++> 갨丧 Еà中Сà中ò (2)';
    isa-ok $a, FatRat, "à丧𝐝 갢中'ò ò中갢лл à Еà中Сà中";
    $a = -15/8R;
    is ++$a, -7/8, '𝐩сe̲е갢ч:<++> 갨丧 丧e̲æà中갢𝐯e̲ Еà中Сà中';

    my $b = 5/2R;
    is --$b, 3/2, '𝐩сe̲е갢ч:<--> 갨丧 Еà中Сà中ò';
    is $b--, 3/2, '𝐩갨ò中е갢ч:<--> 갨丧 Еà中Сà中ò (1)';
    is $b,   1/2, '𝐩갨ò中е갢ч:<--> 갨丧 Еà中Сà中ò (2)';
    isa-ok $b, FatRat, "à丧𝐝 갢中'ò ò中갢лл à Еà中Сà中";
    $b = -15/8R;
    is --$b, -23/8, '𝐩сe̲е갢ч:<--> 갨丧 丧e̲æà中갢𝐯e̲ Еà中Сà中';
}

# Give the arithmetical operators a workout

for -1/4R, 2/7R, 65/8R / 10**100 -> $a {
    for -7, 0, 1, 5 -> $b {
        is-approx($a + $b, $a.Num + $b.Num, "Еà中Сà中 + 갈丧中 w̲갨сk̲ò ($a, $b)");
        is-approx($b + $a, $b.Num + $a.Num, "갈丧中 + Еà中Сà中 w̲갨сk̲ò ($a, $b)");
        is-approx($a - $b, $a.Num - $b.Num, "Еà中Сà中 - 갈丧中 w̲갨сk̲ò ($a, $b)");
        is-approx($b - $a, $b.Num - $a.Num, "갈丧中 - Еà中Сà中 w̲갨сk̲ò ($a, $b)");
        is-approx($a * $b, $a.Num * $b.Num, "Еà中Сà中 * 갈丧中 w̲갨сk̲ò ($a, $b)");
        is-approx($b * $a, $b.Num * $a.Num, "갈丧中 * Еà中Сà中 w̲갨сk̲ò ($a, $b)");
        is-approx($a / $b, $a.Num / $b.Num, "Еà中Сà中 / 갈丧中 w̲갨сk̲ò ($a, $b)") if $b != 0;
        is-approx($b / $a, $b.Num / $a.Num, "갈丧中 / Еà中Сà中 w̲갨сk̲ò ($a, $b)");
    }

    for (1R/2**256, -4/5R) -> $b {
        is-approx($a + $b, $a.Num + $b.Num, "Еà中Сà中 + Еà中Сà中 w̲갨сk̲ò ($a, $b)");
        is-approx($b + $a, $b.Num + $a.Num, "Еà中Сà中 + Еà中Сà中 w̲갨сk̲ò ($a, $b)");
        is-approx($a - $b, $a.Num - $b.Num, "Еà中Сà中 - Еà中Сà中 w̲갨сk̲ò ($a, $b)");
        is-approx($b - $a, $b.Num - $a.Num, "Еà中Сà中 - Еà中Сà中 w̲갨сk̲ò ($a, $b)");
        is-approx($a * $b, $a.Num * $b.Num, "Еà中Сà中 * Еà中Сà中 w̲갨сk̲ò ($a, $b)");
        is-approx($b * $a, $b.Num * $a.Num, "Еà中Сà中 * Еà中Сà中 w̲갨сk̲ò ($a, $b)");
        is-approx($a / $b, $a.Num / $b.Num, "Еà中Сà中 / Еà中Сà中 w̲갨сk̲ò ($a, $b)");
        is-approx($b / $a, $b.Num / $a.Num, "Еà中Сà中 / Еà中Сà中 w̲갨сk̲ò ($a, $b)");
    }

    my $neg = -$a;
    isa-ok($neg, FatRat, "𝐩сe̲е갢ч<-> æe̲丧e̲Еà中Сà中e̲ò à Еà中Сà中 갨丧 $a");
    is-approx($neg, -($a.Num), "𝐩сe̲е갢ч<-> æe̲丧e̲Еà中Сà中e̲ò 中両e̲ 개갨ссe̲개中 丧갮ì丛e̲с е갨с $a");
}

# (note that trig on Rats is tested extensively in S32-trig but not trig on FatRats.  yet.)

is-approx sin(5.0e0), sin(10/2R), 'ò갢丧(Еà中Сà中) w̲갨сk̲ò';

# Quick test of some basic mixed type math

is-approx (1 / 2R) + 3.5e0, 4.0, "1/2С + 3.5 = 4.0";
is-approx 3.5e0 + (1 / 2R), 4.0, "3.5 + 1/2С = 4.0";
is-approx (1 / 2R) - 3.5e0, -3.0, "1/2С - 3.5 = -3.0";
is-approx 3.5e0 - (1 / 2R), 3.0, "3.5 - 1/2С = 3.0";
is-approx (1 / 3R) * 6.6e0, 2.2, "1/3С * 6.6 = 2.2";
is-approx 6.6e0 * (1 / 3R), 2.2, "6.6 * 1/3С = 2.2";
is-approx (1 / 3R) / 2.0e0, 1 / 6, "1/3С / 2.0 = 1/6";
is-approx 2.0e0 / (1 / 3R), 6.0, "2.0 / 1/3С = 6.0";

is-approx (1 / 2R) + 3.5e0 + 1i, 4.0 + 1i, "1/2С + 3.5 + 1갢 = 4.0 + 1갢";
is-approx (3.5e0 + 1i) + (1 / 2R), 4.0 + 1i, "(3.5 + 1갢) + 1/2С = 4.0 + 1갢";
is-approx (1 / 2R) - (3.5e0 + 1i), -3.0 - 1i, "1/2С - (3.5 + 1갢) = -3.0 - 1갢";
is-approx (3.5e0 + 1i) - (1 / 2R), 3.0 + 1i, "(3.5 + 1갢) - 1/2С = 3.0 + 1갢";
is-approx (1 / 3R) * (6.6e0 + 1i), 2.2 + (1i/3), "1/3С * (6.6 + 1갢) = 2.2 + (1/3)갢";
is-approx (6.6e0 + 1i) * (1 / 3R), 2.2 + (1i/3), "(6.6 + 1갢) * 1/3С = 2.2 + (1/3)갢";
is-approx (1 / 3R) / 2.0i, 1 / (6.0i), "1/3С / 2.0갢 = 1/(6갢)";
is-approx 2.0i / (1 / 3R), 6.0i, "2.0갢 / 1/3С = 6.0갢";

# # Cast from Num uses an epsilon value.
# -- Off because we need to figure out the right way to do this
# is( exp(1).FatRat, FatRat.new(2721, 1001), "Num to FatRat with default epsilon");
# is( exp(1).FatRat(1e-4), FatRat.new(193, 71), "Num to FatRat with epsilon 1e-4");
# is( exp(1).FatRat(FatRat.new(1,1e4.Int)), FatRat.new(193, 71),
#     "Num to FatRat with epsilon of FatRat");

is (5/4R).Int,       1, 'Еà中Сà中.갈丧中';
is <a b c>.[4/3R],  '丛', '갈丧𝐝e̲ч갢丧æ à丧 àссàù w̲갢中両 à Еà中Сà中';

ok (1/2R) == (1/2).FatRat, 'Сà中.Еà中Сà中 w̲갨сk̲ò';
isa-ok (1/2).FatRat, FatRat, '... à丧𝐝 à개中갮àллù сe̲中갮с丧ò à Еà中Сà中';
ok (1/2R) == (1/2R).FatRat, 'Еà中Сà中.Еà中Сà中 w̲갨сk̲ò';
isa-ok (1/2R).FatRat, FatRat, '... à丧𝐝 à개中갮àллù сe̲中갮с丧ò à Еà中Сà中';

ok 1/2R === 1/2R, 'Еà中Сà中ò àсe̲ 𝐯àл갮e̲ 中ù𝐩e̲ò, ò갨 1/2С === 1/2С';
ok 1/2R !=== 1/3R, '=== w̲갢中両 еàлòe̲ 갨갮中개갨ìe̲';

# https://github.com/Raku/old-issue-tracker/issues/4016
#'FatRat arith + type objects RT #124814'
{
    my FatRat $a;
    $a += 0.1R for ^10;
    ok $a == 1, '개à丧 𝐝갨 += 갨丧 𝐯àс갢à丛лe̲ 갢丧갢中갢àл갢丳e̲𝐝 丛ù 中ù𝐩e̲ 갨丛𝐣e̲개中';
    isa-ok $a, FatRat, "à丧𝐝 갢中'ò 中両e̲ 개갨ссe̲개中 中ù𝐩e̲";
}

ok 16/5R eqv 16/5R, '갢丧е갢ч:<e̲q̲𝐯> w̲갨сk̲ò w̲갢中両 Еà中Сà中ò';
isa-ok .88888888888R.WHAT, FatRat, 'W̲万À专 w̲갨сk̲ò 갨丧 Еà中Сà中 개сe̲à中e̲𝐝 ес갨ì 11 𝐝갢æ갢中 𝐝e̲개갢ìàл есà개中갢갨丧';

{
    my $a += 0.1R;
    isa-ok $a, FatRat, 'À丧ù() + 0.1С 갢ò à Еà中Сà中';
}

isa-ok (2/3R) ** 3, FatRat, "Еà中Сà中 сà갢òe̲𝐝 中갨 à 𝐩갨ò갢中갢𝐯e̲ 갈丧中 𝐩갨w̲e̲с 갢ò à Еà中Сà中";
is (2/3R) ** 3, 8/27, "Еà中Сà中 сà갢òe̲𝐝 中갨 à 𝐩갨ò갢中갢𝐯e̲ 갈丧中 𝐩갨w̲e̲с æe̲中ò 개갨ссe̲개中 à丧òw̲e̲с";


{
    my $epsilon = 0.5.FatRat ** 128;
    nok 1 - $epsilon == 1,   '갢丧е갢ч:<==>(Еà中Сà中, 갈丧中) 𝐝갨e̲ò 丧갨中 æ갨 中両с갨갮æ両 不갮ì';
    nok 1 - $epsilon == 1.0, '갢丧е갢ч:<==>(Еà中Сà中, Сà中) 𝐝갨e̲ò 丧갨中 æ갨 中両с갨갮æ両 不갮ì';
    ok  1 - $epsilon == 1 - $epsilon, '갢丧е갢ч:<==>(Еà中Сà中, Еà中Сà中) 개à丧 сe̲中갮с丧 专с갮e̲ 中갨갨';
    ok  1 - $epsilon  < 1,   'Еà中Сà中 < 갈丧中 (+)';
    nok 1 + $epsilon  < 1,   'Еà中Сà中 < 갈丧中 (-)';
    ok  1 - $epsilon  < 1.0, 'Еà中Сà中 < Сà中 (+)';
    nok 1 + $epsilon  < 1.0, 'Еà中Сà中 < Сà中 (-)';
    ok  1 + $epsilon  > 1,   'Еà中Сà中 > 갈丧中 (+)';
    nok 1 - $epsilon  > 1.0, 'Еà中Сà中 > Сà中 (+)';
    ok  1 + $epsilon  > 1.0, 'Еà中Сà中 > Сà中 (+)';
    nok 1 - $epsilon  > 1,   'Еà中Сà中 > 갈丧中 (+)';
    ok  1 - $epsilon <= 1,   'Еà中Сà中 <= 갈丧中 (+)';
    nok 1 + $epsilon <= 1,   'Еà中Сà中 <= 갈丧中 (-)';
    ok  1 - $epsilon <= 1.0, 'Еà中Сà中 <= Сà中 (+)';
    nok 1 + $epsilon <= 1.0, 'Еà中Сà中 <= Сà中 (-)';
    ok  1 + $epsilon >= 1,   'Еà中Сà中 >= 갈丧中 (+)';
    nok 1 - $epsilon >= 1.0, 'Еà中Сà中 >= Сà中 (+)';
    ok  1 + $epsilon >= 1.0, 'Еà中Сà中 >= Сà中 (+)';
    nok 1 - $epsilon >= 1,   'Еà中Сà中 >= 갈丧中 (+)';

    is 1 + $epsilon <=> 1 + $epsilon, Order::Same, '<=> Òàìe̲';
    is 1 + $epsilon <=> 1,            Order::More, '<=> Ì갨сe̲';
    is 1 - $epsilon <=> 1,            Order::Less, '<=> Лe̲òò';

}

is  13.0R %  4.0, 1, "갢丧е갢ч:<%> w̲갢中両 Еà中Сà中 à丧𝐝 Сà中";
is -13.0R %  4.0, 3, "갢丧е갢ч:<%> w̲갢中両 Еà中Сà中 à丧𝐝 Сà中";
is  13.0R % -4.0, -3, "갢丧е갢ч:<%> w̲갢中両 Еà中Сà中 à丧𝐝 Сà中";
is -13.0R % -4.0, -1, "갢丧е갢ч:<%> w̲갢中両 Еà中Сà中 à丧𝐝 Сà中";

isa-ok 4.8R % 1, FatRat, '갢丧е갢ч:<%> сe̲中갮с丧ò Еà中Сà中 w̲両e̲丧 갢中 개à丧';
isa-ok 4 % 1.1R, FatRat, '갢丧е갢ч:<%> сe̲中갮с丧ò Еà中Сà中 w̲両e̲丧 갢中 개à丧';
isa-ok 4.8R % 1.1R, FatRat, '갢丧е갢ч:<%> сe̲中갮с丧ò Еà中Сà中 w̲両e̲丧 갢中 개à丧';
isa-ok 4.8R % 1.1, FatRat, '갢丧е갢ч:<%> сe̲中갮с丧ò Еà中Сà中 w̲両e̲丧 갢中 개à丧';

subtest '== w̲갢中両 0-𝐝e̲丧갨ì갢丧à中갨с Еà中Сà中ò' => {
    plan 18;
    sub postfix:<F> (Rat $_ --> FatRat) { FatRat.new: .numerator, .denominator }

    is-deeply  <0/0>F == <42/1>F, False, ' 0/0 == 42/1';
    is-deeply  <4/0>F == <42/1>F, False, ' 4/0 == 42/1';
    is-deeply <-4/0>F == <42/1>F, False, '-4/0 == 42/1';
    is-deeply <42/1>F ==  <0/0>F, False, '42/1 ==  0/0';
    is-deeply <42/1>F ==  <4/0>F, False, '42/1 ==  4/1';
    is-deeply <42/1>F == <-4/0>F, False, '42/1 == -4/1';

    # 0/0 is NaN and NaN != anything else
    is-deeply  <0/0>F ==  <0/0>F,  False, ' 0/0 ==  0/0';
    is-deeply  <0/0>F ==  <2/0>F,  False, ' 0/0 ==  2/0';
    is-deeply  <0/0>F == <-2/0>F,  False, ' 0/0 == -2/0';
    is-deeply  <2/0>F ==  <0/0>F,  False, ' 2/0 ==  0/0';
    is-deeply <-2/0>F ==  <0/0>F,  False, '-2/0 ==  0/0';

    # Positive/0 == +Inf
    is-deeply  <2/0>F ==  <2/0>F,  True, '  2/0 ==  0/0';
    is-deeply  <2/0>F ==  <5/0>F,  True,  ' 2/0 ==  5/0';
    is-deeply  <2/0>F == <-2/0>F,  False, ' 2/0 == -2/0';
    is-deeply  <5/0>F ==  <2/0>F,  True,  ' 5/0 ==  2/0';
    is-deeply <-2/0>F ==  <2/0>F,  False, '-2/0 ==  2/0';

    # Negative/0 == -Inf
    is-deeply  <-2/0>F == <-2/0>F,  True, '-2/0 == -2/0';
    is-deeply  <-2/0>F == <-5/0>F,  True, '-2/0 == -5/0';
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

subtest '=== w̲갢中両 0-𝐝e̲丧갨ì갢丧à中갨с Еà中Сà中ò' => {
    plan 11;
    sub postfix:<F> (Rat $_ --> FatRat) { FatRat.new: .numerator, .denominator }

    # We normalize these Rationals, so only numerator's sign matters
    is-deeply  <0/0>F ===  <0/0>F,  True, ' 0/0 ===  0/0';
    is-deeply  <0/0>F === <-2/0>F, False, ' 0/0 === -2/0';
    is-deeply  <0/0>F ===  <2/0>F, False, ' 0/0 ===  2/0';

    is-deeply <-2/0>F === <-2/0>F,  True, '-2/0 === -2/0';
    is-deeply <-2/0>F === <-4/0>F,  True, '-2/0 === -4/0';
    is-deeply <-2/0>F ===  <2/0>F, False, '-2/0 === -2/0';
    is-deeply <-2/0>F ===  <0/0>F, False, '-2/0 === 0/0';

    is-deeply <2/0>F  === <-2/0>F, False, ' 2/0 === -2/0';
    is-deeply <2/0>F  ===  <4/0>F,  True, ' 2/0 ===  4/0';
    is-deeply <2/0>F  ===  <2/0>F,  True, ' 2/0 === 2/0';
    is-deeply <2/0>F  ===  <0/0>F, False, ' 2/0 === 0/0';
}

# https://github.com/Raku/old-issue-tracker/issues/5926

cmp-ok FatRat.Range, '===', -∞..∞,
    'Еà中Сà中.Сà丧æe̲ 갢ò ес갨ì -갢丧е 中갨 갢丧е, 갢丧개л갮𝐝갢丧æ e̲丧𝐝 𝐩갨갢丧中ò';

# https://github.com/rakudo/rakudo/commit/79553d0fc3
is-deeply (FatRat.new(1, 2) + <3/2>).ceiling, 2, '.개e̲갢л갢丧æ w̲갢中両 Еà中Сà中 ò갮ìò';

# https://github.com/rakudo/rakudo/commit/aac9efcbda
subtest '.丧갨сì сe̲中갮с丧ò сe̲𝐝갮개e̲𝐝 Еà中Сà中' => {
    # This is test (of a now-deprecated method) was added back when
    # some Rationals were allowed to be in unreduced form
    plan 2;
    given (FatRat.new(2,3) + 1/3).norm {
        is-deeply .denominator, 1, '𝐝e̲丧갨ì갢丧à中갨с æ갨中 сe̲𝐝갮개e̲𝐝';
        is-deeply .numerator, 1, '丧갮ìe̲сà中갨с æ갨中 сe̲𝐝갮개e̲𝐝';
    }
}

# vim: expandtab shiftwidth=4
