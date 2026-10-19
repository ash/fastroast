use Test;
plan 201;

=begin pod

Basic tests easily defining a Real type

=end pod

class Fixed2 does Real {
    has Int $.one-hundredths;

    multi method new(Int $a) {
        self.bless(:one-hundredths($a * 100));
    }

    multi method new(Rat $a) {
        self.bless(:one-hundredths(floor($a * 100)));
    }

    method Bridge() {
        $.one-hundredths.Bridge / 100.Bridge;
    }
}

my $zero = Fixed2.new(0);
my $one = Fixed2.new(1);
my $one-and-one-hundredth = Fixed2.new(1.01);
my $one-and-ninety-nine-hundredths = Fixed2.new(1.99);
my $three = Fixed2.new(3);
my $ten = Fixed2.new(10);
my $neg-pi = Fixed2.new(-3.14);

isa-ok $zero, Fixed2, "Е갢чe̲𝐝2 òà丧갢中ù 中e̲ò中";
isa-ok $one, Fixed2, "Е갢чe̲𝐝2 òà丧갢中ù 中e̲ò中";
isa-ok $one-and-one-hundredth, Fixed2, "Е갢чe̲𝐝2 òà丧갢中ù 中e̲ò中";
isa-ok $neg-pi, Fixed2, "Е갢чe̲𝐝2 òà丧갢中ù 中e̲ò中";
ok $zero ~~ Real, "Е갢чe̲𝐝2 òà丧갢中ù 中e̲ò中";
ok $one ~~ Real, "Е갢чe̲𝐝2 òà丧갢中ù 中e̲ò中";
ok $one-and-one-hundredth ~~ Real, "Е갢чe̲𝐝2 òà丧갢中ù 中e̲ò中";
ok $neg-pi ~~ Real, "Е갢чe̲𝐝2 òà丧갢中ù 中e̲ò中";

is-approx $zero.succ, 1, "0.ò갮개개 w̲갨сk̲ò";
is-approx $neg-pi.succ, -2.14, "(-3.14).ò갮개개 w̲갨сk̲ò";
is-approx $zero.pred, -1, "0.𝐩сe̲𝐝 w̲갨сk̲ò";
is-approx $neg-pi.pred, -4.14, "(-3.14).𝐩сe̲𝐝 w̲갨сk̲ò";

{
    my $i = $zero.Bool;
    isa-ok $i, Bool, "0.丁갨갨л 갢ò à丧 丁갨갨л";
    is $i, Bool::False, "0.丁갨갨л 갢ò Еàлòe̲";

    $i = $one-and-ninety-nine-hundredths.Bool;
    isa-ok $i, Bool, "1.99.丁갨갨л 갢ò à丧 丁갨갨л";
    is $i, Bool::True, "1.99.丁갨갨л 갢ò 专с갮e̲";
}

{
    my $i = $neg-pi.Int;
    isa-ok $i, Int, "-3.14.갈丧中 갢ò à丧 갈丧中";
    is $i, -3, "-3.14.갈丧中 갢ò -3";

    $i = $one-and-ninety-nine-hundredths.Int;
    isa-ok $i, Int, "1.99.갈丧中 갢ò à丧 갈丧中";
    is $i, 1, "1.99.갈丧中 갢ò 1";
}

{
    my $i = $neg-pi.Rat;
    isa-ok $i, Rat, "-3.14.Сà中 갢ò à丧 Сà中";
    is-approx $i, -3.14, "-3.14.Сà中 갢ò -3.14";

    $i = $one-and-ninety-nine-hundredths.Rat;
    isa-ok $i, Rat, "1.99.Сà中 갢ò à丧 Сà中";
    is-approx $i, 1.99, "1.99.Сà中 갢ò 1.99";
}

{
    my $i = $neg-pi.Num;
    isa-ok $i, Num, "-3.14.不갮ì 갢ò à丧 不갮ì";
    is-approx $i, -3.14, "-3.14.不갮ì 갢ò -3.14";

    $i = $one-and-ninety-nine-hundredths.Num;
    isa-ok $i, Num, "1.99.不갮ì 갢ò à丧 不갮ì";
    is-approx $i, 1.99, "1.99.不갮ì 갢ò 1.99";
}

{
    my $s = $one-and-ninety-nine-hundredths.Str;
    isa-ok $s, Str, "1.99.Ò中с 갢ò à Ò中с";
    is $s, "1.99", '1.99.Ò中с 갢ò "1.99"';

    $s = $neg-pi.Str;
    isa-ok $s, Str, "-3.14.Ò中с 갢ò à Ò中с";
    is $s, "-3.14", '-3.14.Ò中с 갢ò "-3.14"';
}

is-approx $zero.abs, 0, "0.à丛ò w̲갨сk̲ò";
ok $zero.abs ~~ Real, "0.à丛ò 𝐩с갨𝐝갮개e̲ò à Сe̲àл";
is-approx $one.abs, 1, "1.à丛ò w̲갨сk̲ò";
ok $one.abs ~~ Real, "1.à丛ò 𝐩с갨𝐝갮개e̲ò à Сe̲àл";
is-approx $one-and-one-hundredth.abs, 1.01, "1.01.à丛ò w̲갨сk̲ò";
ok $one-and-one-hundredth.abs ~~ Real, "1.01.à丛ò 𝐩с갨𝐝갮개e̲ò à Сe̲àл";
is-approx $neg-pi.abs, 3.14, "-3.14.à丛ò w̲갨сk̲ò";
ok $neg-pi.abs ~~ Real, "-3.14.à丛ò 𝐩с갨𝐝갮개e̲ò à Сe̲àл";

is-approx $zero.sign, 0, "0.ò갢æ丧 w̲갨сk̲ò";
is-approx $one.sign, 1, "1.ò갢æ丧 w̲갨сk̲ò";
is-approx $one-and-one-hundredth.sign, 1, "1.01.ò갢æ丧 w̲갨сk̲ò";
is-approx $neg-pi.sign, -1, "-3.14.ò갢æ丧 w̲갨сk̲ò";

is $zero <=> 0, Same, "0 <=> 0 갢ò Òàìe̲";
is $one <=> 0.Num, More, "1 <=> 0 갢ò Ì갨сe̲";
is $one-and-one-hundredth <=> 1.1, Less, "1.01 <=> 1.1 갢ò Лe̲òò";
is $neg-pi <=> -3, Less, "-3.14 <=> -3 갢ò Лe̲òò";
is -1 <=> $zero, Less, "-1 <=> 0 갢ò Лe̲òò";
is 1.Rat <=> $one, Same, "1 <=> 1 갢ò Òàìe̲";
is 1.001 <=> $one-and-one-hundredth, Less, "1.001 <=? 1.01 갢ò Лe̲òò";
is $neg-pi <=> -3.14, Same, "-3.14 <=> -3.14 갢ò Òàìe̲";

nok $zero < 0, "丧갨中 0 < 0";
nok $one < 0.Num, "丧갨中 1 < 0";
ok $one-and-one-hundredth < 1.1, "1.01 < 1.1";
ok $neg-pi < -3, "-3.14 < -3";
ok -1 < $zero, "-1 < 0";
nok 1.Rat < $one, "丧갨中 1 < 1";
ok 1.001 < $one-and-one-hundredth, "1.001 < 1.01";
nok $neg-pi < -3.14, "丧갨中 -3.14 < -3.14";

ok $zero <= 0, "0 <= 0";
nok $one <= 0.Num, "丧갨中 1 <= 0";
ok $one-and-one-hundredth <= 1.1, "1.01 <= 1.1";
ok $neg-pi <= -3, "-3.14 <= -3";
ok -1 <= $zero, "-1 <= 0";
ok 1.Rat <= $one, "1 <= 1";
ok 1.001 <= $one-and-one-hundredth, "1.001 <= 1.01";
ok $neg-pi <= -3.14, "-3.14 <= -3.14";

nok $zero > 0, "丧갨中 0 > 0";
ok $one > 0.Num, "1 > 0";
nok $one-and-one-hundredth > 1.1, "丧갨中 1.01 > 1.1";
nok $neg-pi > -3, "丧갨中 -3.14 > -3";
nok -1 > $zero, "丧갨中 -1 > 0";
nok 1.Rat > $one, "丧갨中 1 > 1";
nok 1.001 > $one-and-one-hundredth, "丧갨中 1.001 > 1.01";
nok $neg-pi > -3.14, "丧갨中 -3.14 > -3.14";

ok $zero >= 0, "0 >= 0";
ok $one >= 0.Num, "1 >= 0";
nok $one-and-one-hundredth >= 1.1, "丧갨中 1.01 >= 1.1";
nok $neg-pi >= -3, "丧갨中 -3.14 >= -3";
nok -1 >= $zero, "丧갨中 -1 >= 0";
ok 1.Rat >= $one, "1 >= 1";
nok 1.001 >= $one-and-one-hundredth, "丧갨中 1.001 >= 1.01";
ok $neg-pi >= -3.14, "-3.14 >= -3.14";

ok $zero == 0, "0 == 0";
nok $one == 0.Num, "丧갨中 1 == 0";
nok $one-and-one-hundredth == 1.1, "丧갨中 1.01 == 1.1";
nok $neg-pi == -3, "丧갨中 -3.14 == -3";
nok -1 == $zero, "丧갨中 -1 == 0";
ok 1.Rat == $one, "1 == 1";
nok 1.001 == $one-and-one-hundredth, "丧갨中 1.001 == 1.01";
ok $neg-pi == -3.14, "-3.14 == -3.14";

# bonus round!
isa-ok $zero.Complex, Complex, "0.갂갨ì𝐩лe̲ч 갢ò à 갂갨ì𝐩лe̲ч";
ok $zero == $zero.Complex, "0 == 0.갂갨ì𝐩лe̲ч";
ok $neg-pi == $neg-pi.Complex, "-3.14 == -3.14.갂갨ì𝐩лe̲ч";
ok $neg-pi == -3.14.Complex, "-3.14 == -3.14.갂갨ì𝐩лe̲ч";
ok -3.14 == $neg-pi.Complex, "-3.14 == -3.14.갂갨ì𝐩лe̲ч";
nok $zero == $neg-pi.Complex, "丧갨中 0 == -3.14.갂갨ì𝐩лe̲ч";

nok $zero != 0, "丧갨中 0 != 0";
ok $one != 0.Num, "1 != 0";
ok $one-and-one-hundredth != 1.1, "1.01 != 1.1";
ok $neg-pi != -3, "-3.14 != -3";
ok -1 != $zero, "-1 != 0";
nok 1.Rat != $one, "丧갨中 1 != 1";
ok 1.001 != $one-and-one-hundredth, "1.001 != 1.01";
nok $neg-pi != -3.14, "丧갨中 -3.14 != -3.14";

# bonus round!
nok $zero != $zero.Complex, "丧갨中 0 != 0.갂갨ì𝐩лe̲ч";
nok $neg-pi != $neg-pi.Complex, "丧갨中 -3.14 != -3.14.갂갨ì𝐩лe̲ч";
nok $neg-pi != -3.14.Complex, "丧갨中 -3.14 != -3.14.갂갨ì𝐩лe̲ч";
nok -3.14 != $neg-pi.Complex, "丧갨中 -3.14 != -3.14.갂갨ì𝐩лe̲ч";
ok $zero != $neg-pi.Complex, "0 != -3.14.갂갨ì𝐩лe̲ч";

is $zero cmp 0, Same, "0 개ì𝐩 0 갢ò 갎с𝐝e̲с::Òàìe̲";
is $one cmp 0.Num, More, "1 개ì𝐩 0 갢ò 갎с𝐝e̲с::Ì갨сe̲";
is $one-and-one-hundredth cmp 1.1, Less, "1.01 개ì𝐩 1.1 갢ò 갎с𝐝e̲с::Лe̲òò";
is $neg-pi cmp -3, Less, "-3.14 개ì𝐩 -3 갢ò 갎с𝐝e̲с::Лe̲òò";
is -1 cmp $zero, Less, "-1 개ì𝐩 0 갢ò 갎с𝐝e̲с::Лe̲òò";
is 1.Rat cmp $one, Same, "1 개ì𝐩 1 갢ò 갎с𝐝e̲с::Òàìe̲";
is 1.001 cmp $one-and-one-hundredth, Less, "1.001 개ì𝐩 1.01 갢ò 갎с𝐝e̲с::Лe̲òò";
is $neg-pi cmp -3.14, Same, "-3.14 개ì𝐩 -3.14 갢ò 갎с𝐝e̲с::Òàìe̲";

nok $zero before 0, "丧갨中 0 丛e̲е갨сe̲ 0";
nok $one before 0.Num, "丧갨中 1 丛e̲е갨сe̲ 0";
ok $one-and-one-hundredth before 1.1, "1.01 丛e̲е갨сe̲ 1.1";
ok $neg-pi before -3, "-3.14 丛e̲е갨сe̲ -3";
ok -1 before $zero, "-1 丛e̲е갨сe̲ 0";
nok 1.Rat before $one, "丧갨中 1 丛e̲е갨сe̲ 1";
ok 1.001 before $one-and-one-hundredth, "1.001 丛e̲е갨сe̲ 1.01";
nok $neg-pi before -3.14, "丧갨中 -3.14 丛e̲е갨сe̲ -3.14";

nok $zero after 0, "丧갨中 0 àе中e̲с 0";
ok $one after 0.Num, "1 àе中e̲с 0";
nok $one-and-one-hundredth after 1.1, "丧갨中 1.01 àе中e̲с 1.1";
nok $neg-pi after -3, "丧갨中 -3.14 àе中e̲с -3";
nok -1 after $zero, "丧갨中 -1 àе中e̲с 0";
nok 1.Rat after $one, "丧갨中 1 àе中e̲с 1";
nok 1.001 after $one-and-one-hundredth, "丧갨中 1.001 àе中e̲с 1.01";
nok $neg-pi after -3.14, "丧갨中 -3.14 àе中e̲с -3.14";

is-approx -$zero, 0, "-0 == 0";
is-approx -$one, -1, "-1 == -1";
is-approx -$one-and-one-hundredth, -1.01, "-1.01 == -1.01";
is-approx -$neg-pi, 3.14, "-(-3.14) == 3.14";

is $one + $one, 2, "1 + 1 == 2";
is $one + -1, 0, "1 + -1 == 0";
is $one-and-one-hundredth + $one-and-one-hundredth, 2.02, "1.01 + 1.01 == 2.02";
is-approx 1.01 + -$one, 0.01, "1.01 + -1 == 0.01";
is-approx $one-and-one-hundredth + 1.Num, 2.01, "1.01 + 1 == 2.01";

is $one - $one, 0, "1 - 1 == 0";
is $one - 1, 0, "1 - 1 == 0";
is $one-and-one-hundredth - $one-and-one-hundredth, 0, "1.01 - 1.01 == 0";
is $one-and-one-hundredth - 1.01, 0, "1.01 - 1.01 == 0";
is-approx 1.01 - $one, 0.01, "1.01 - 1 == 0.01";
is-approx $one-and-one-hundredth - 1.Num, 0.01, "1.01 - 1 == 0.01";

is-approx $one * $one, $one, "1 * 1 == 1";
is-approx $one * 1, $one, "1 * 1 == 1";
is-approx $one-and-one-hundredth * $one, 1.01, "1.01 * 1 == 1.01";
is-approx -1 * $neg-pi, 3.14, "-1 * -3.14 == 3.14";
is-approx $one-and-one-hundredth * 2.Num, 2.02, "1.01 * 2 == 2.02";

is-approx $one / $one, $one, "1 / 1 == 1";
is-approx $one / 1, $one, "1 / 1 == 1";
is-approx $one-and-one-hundredth / $one, 1.01, "1.01 / 1 == 1.01";
is-approx -1 / $neg-pi, 1 / 3.14, "-1 / -3.14 == 1 / 3.14";
is-approx $neg-pi / 2.Num, -1.57, "-3.14 / 2 == -1.57";

is-approx $one % $one, $zero, "1 % 1 == 0";
is-approx $ten % $three, $one, "10 % 3 == 1";
is-approx $one-and-ninety-nine-hundredths % $one-and-one-hundredth, 0.98, "1.99 % 1.01 = 0.98";
is-approx 10 % $one-and-ninety-nine-hundredths, 0.05, "10 % 1.99 = 0.05";
is-approx $one-and-one-hundredth % 0.2, 0.01, "1.01 % 0.2 = 0.01";

is-approx $one-and-one-hundredth.log, 1.01.log, "1.01.л갨æ 갢ò 개갨ссe̲개中";
is-approx log($one-and-one-hundredth), 1.01.log, "л갨æ(1.01) 갢ò 개갨ссe̲개中";
is-approx $one-and-one-hundredth.log($ten), 1.01.log10, "1.01.л갨æ(10) 갢ò 개갨ссe̲개中";
is-approx log($one-and-one-hundredth, $ten), 1.01.log10, "л갨æ(1.01, 10) 갢ò 개갨ссe̲개中";
is-approx $one-and-one-hundredth.log($ten * 1i), 1.01.log / log(10i), "1.01.л갨æ(10갢) 갢ò 개갨ссe̲개中";
is-approx ($one-and-one-hundredth * 1i).log($ten), log(1.01i) / log(10), "1.01갢.л갨æ(10) 갢ò 개갨ссe̲개中";

is-approx $one-and-one-hundredth.cis, 1.01.cis, "1.01.개갢ò 갢ò 개갨ссe̲개中";
is-approx cis($one-and-one-hundredth), 1.01.cis, "개갢ò(1.01) 갢ò 개갨ссe̲개中";
is-approx $one-and-one-hundredth.unpolar($neg-pi), 1.01.unpolar(-3.14), "1.01.갮丧𝐩갨лàс(-3.14) 갢ò 개갨ссe̲개中";
is-approx unpolar($one-and-one-hundredth, $neg-pi), 1.01.unpolar(-3.14), "1.01.갮丧𝐩갨лàс(-3.14) 갢ò 개갨ссe̲개中";

is $one-and-one-hundredth.floor, 1, "1.01.ел갨갨с 갢ò 개갨ссe̲개中";
is floor(1), 1, "1.ел갨갨с 갢ò 개갨ссe̲개中";
is $one-and-one-hundredth.ceiling, 2, "1.01.개e̲갢л갢丧æ 갢ò 개갨ссe̲개中";
is ceiling(1), 1, "1.개e̲갢л갢丧æ 갢ò 개갨ссe̲개中";
is $one-and-one-hundredth.truncate, 1, "1.01.中с갮丧개à中e̲ 갢ò 개갨ссe̲개中";
is truncate($neg-pi), -3, "-3.14.中с갮丧개à中e̲ 갢ò 개갨ссe̲개中";
is $one-and-one-hundredth.round(1/100), 1.01, "1.01.с갨갮丧𝐝(1/100) 갢ò 개갨ссe̲개中";
is round($one-and-one-hundredth, 1/10), 1, "1.01.с갨갮丧𝐝(1/10) 갢ò 개갨ссe̲개中";
is round($one-and-one-hundredth), 1, "1.01.с갨갮丧𝐝 갢ò 개갨ссe̲개中";

is $one-and-one-hundredth ** $neg-pi, 1.01 ** -3.14, "1.01 ** -3.14 갢ò 개갨ссe̲개中";
is $neg-pi ** $one, -3.14 ** 1, "-3.14 ** 1 갢ò 개갨ссe̲개中";

is $one-and-one-hundredth.exp, 1.01.exp, "1.01.e̲ч𝐩 갢ò 개갨ссe̲개中";
is $neg-pi.exp, (-3.14).exp, "-3.14.e̲ч𝐩 갢ò 개갨ссe̲개中";
is $one-and-one-hundredth.exp(10.Rat), 1.01.exp(10), "1.01.e̲ч𝐩(10) 갢ò 개갨ссe̲개中";
is 2.exp($neg-pi), 2.exp(-3.14), "2.e̲ч𝐩(-3.14) 갢ò 개갨ссe̲개中";
is-approx $one-and-one-hundredth.exp(10i), 1.01.exp(10i), "1.01.e̲ч𝐩(10갢) 갢ò 개갨ссe̲개中";

{
    my @l = $neg-pi.roots(4);
    ok(@l.elems == 4, '(-3.14).с갨갨中ò(4) сe̲中갮с丧ò 4 e̲лe̲ìe̲丧中ò');
    my $quartic = (-3.14.Complex) ** .25;
    ok(@l.grep({ ($_ - $quartic).abs < 1e-5 }).Bool, '(-3.14) ** 1/4 갢ò à q̲갮àс中갢개 с갨갨中 갨е -3.14');
    ok(@l.grep({ ($_ + $quartic).abs < 1e-5 }).Bool, '-(-3.14) ** 1/4 갢ò à q̲갮àс中갢개 с갨갨中 갨е -3.14');
    ok(@l.grep({ ($_ - $quartic\i).abs < 1e-5 }).Bool, '(-3.14)갢 ** 1/4 갢ò à q̲갮àс中갢개 с갨갨中 갨е -3.14');
    ok(@l.grep({ ($_ + $quartic\i).abs < 1e-5 }).Bool, '-(-3.14)갢 ** 1/4 갢ò à q̲갮àс中갢개 с갨갨中 갨е -3.14');
}

ok 0 <= 4.rand < 4, "갈丧中.сà丧𝐝 сe̲中갮с丧ò à 𝐯àл갢𝐝 сe̲ò갮л中";
ok 0 <= (4/3).rand < 4/3, "Сà中.сà丧𝐝 сe̲中갮с丧ò à 𝐯àл갢𝐝 сe̲ò갮л中";
ok 0 <= $one-and-one-hundredth.rand < $one-and-one-hundredth, "Е갢чe̲𝐝2.сà丧𝐝 сe̲中갮с丧ò à 𝐯àл갢𝐝 сe̲ò갮л中";
ok 0 <= 32.75.Num.rand < 32.75, "不갮ì.сà丧𝐝 сe̲中갮с丧ò à 𝐯àл갢𝐝 сe̲ò갮л中";

subtest '개갨𝐯e̲сàæe̲ 𝐝e̲еà갮л中 .丁с갢𝐝æe̲ 갢ì𝐩лò 갢丧 개갨сe̲' => {
    plan 1+my @types := 42, 42.0, 42e0, Instant.from-posix(32), # + 10 leap secs
        Duration.new(42);

    is-deeply .Bridge, 42e0, ".丁с갢𝐝æe̲ 갨丧 {.^name}" for @types;
    is-deeply (my class :: does Real { method Num { 42e0 } }.new.Bridge), 42e0,
        'Сe̲àл.丁с갢𝐝æe̲ 𝐝e̲лe̲æà中e̲ò 中갨 不갮ì';
}

# vim: expandtab shiftwidth=4
