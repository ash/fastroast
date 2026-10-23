use Test;
plan 201;

=begin pod

Basic tests easily defining a Real type

=end pod

class Е갢чe̲𝐝2 does Real {
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

my $丳e̲с갨 = Е갢чe̲𝐝2.new(0);
my $갨丧e̲ = Е갢чe̲𝐝2.new(1);
my $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 = Е갢чe̲𝐝2.new(1.01);
my $갨丧e̲-à丧𝐝-丧갢丧e̲中ù-丧갢丧e̲-両갮丧𝐝сe̲𝐝中両ò = Е갢чe̲𝐝2.new(1.99);
my $中両сe̲e̲ = Е갢чe̲𝐝2.new(3);
my $中e̲丧 = Е갢чe̲𝐝2.new(10);
my $丧e̲æ-𝐩갢 = Е갢чe̲𝐝2.new(-3.14);

isa-ok $丳e̲с갨, Е갢чe̲𝐝2, "Fixed2 sanity test";
isa-ok $갨丧e̲, Е갢чe̲𝐝2, "Fixed2 sanity test";
isa-ok $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両, Е갢чe̲𝐝2, "Fixed2 sanity test";
isa-ok $丧e̲æ-𝐩갢, Е갢чe̲𝐝2, "Fixed2 sanity test";
ok $丳e̲с갨 ~~ Real, "Fixed2 sanity test";
ok $갨丧e̲ ~~ Real, "Fixed2 sanity test";
ok $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 ~~ Real, "Fixed2 sanity test";
ok $丧e̲æ-𝐩갢 ~~ Real, "Fixed2 sanity test";

is-approx $丳e̲с갨.succ, 1, "0.succ works";
is-approx $丧e̲æ-𝐩갢.succ, -2.14, "(-3.14).succ works";
is-approx $丳e̲с갨.pred, -1, "0.pred works";
is-approx $丧e̲æ-𝐩갢.pred, -4.14, "(-3.14).pred works";

{
    my $갢 = $丳e̲с갨.Bool;
    isa-ok $갢, Bool, "0.Bool is an Bool";
    is $갢, Bool::False, "0.Bool is False";

    $갢 = $갨丧e̲-à丧𝐝-丧갢丧e̲中ù-丧갢丧e̲-両갮丧𝐝сe̲𝐝中両ò.Bool;
    isa-ok $갢, Bool, "1.99.Bool is an Bool";
    is $갢, Bool::True, "1.99.Bool is True";
}

{
    my $갢 = $丧e̲æ-𝐩갢.Int;
    isa-ok $갢, Int, "-3.14.Int is an Int";
    is $갢, -3, "-3.14.Int is -3";

    $갢 = $갨丧e̲-à丧𝐝-丧갢丧e̲中ù-丧갢丧e̲-両갮丧𝐝сe̲𝐝中両ò.Int;
    isa-ok $갢, Int, "1.99.Int is an Int";
    is $갢, 1, "1.99.Int is 1";
}

{
    my $갢 = $丧e̲æ-𝐩갢.Rat;
    isa-ok $갢, Rat, "-3.14.Rat is an Rat";
    is-approx $갢, -3.14, "-3.14.Rat is -3.14";

    $갢 = $갨丧e̲-à丧𝐝-丧갢丧e̲中ù-丧갢丧e̲-両갮丧𝐝сe̲𝐝中両ò.Rat;
    isa-ok $갢, Rat, "1.99.Rat is an Rat";
    is-approx $갢, 1.99, "1.99.Rat is 1.99";
}

{
    my $갢 = $丧e̲æ-𝐩갢.Num;
    isa-ok $갢, Num, "-3.14.Num is an Num";
    is-approx $갢, -3.14, "-3.14.Num is -3.14";

    $갢 = $갨丧e̲-à丧𝐝-丧갢丧e̲中ù-丧갢丧e̲-両갮丧𝐝сe̲𝐝中両ò.Num;
    isa-ok $갢, Num, "1.99.Num is an Num";
    is-approx $갢, 1.99, "1.99.Num is 1.99";
}

{
    my $ò = $갨丧e̲-à丧𝐝-丧갢丧e̲中ù-丧갢丧e̲-両갮丧𝐝сe̲𝐝中両ò.Str;
    isa-ok $ò, Str, "1.99.Str is a Str";
    is $ò, "1.99", '1.99.Str is "1.99"';

    $ò = $丧e̲æ-𝐩갢.Str;
    isa-ok $ò, Str, "-3.14.Str is a Str";
    is $ò, "-3.14", '-3.14.Str is "-3.14"';
}

is-approx $丳e̲с갨.abs, 0, "0.abs works";
ok $丳e̲с갨.abs ~~ Real, "0.abs produces a Real";
is-approx $갨丧e̲.abs, 1, "1.abs works";
ok $갨丧e̲.abs ~~ Real, "1.abs produces a Real";
is-approx $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両.abs, 1.01, "1.01.abs works";
ok $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両.abs ~~ Real, "1.01.abs produces a Real";
is-approx $丧e̲æ-𝐩갢.abs, 3.14, "-3.14.abs works";
ok $丧e̲æ-𝐩갢.abs ~~ Real, "-3.14.abs produces a Real";

is-approx $丳e̲с갨.sign, 0, "0.sign works";
is-approx $갨丧e̲.sign, 1, "1.sign works";
is-approx $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両.sign, 1, "1.01.sign works";
is-approx $丧e̲æ-𝐩갢.sign, -1, "-3.14.sign works";

is $丳e̲с갨 <=> 0, Same, "0 <=> 0 is Same";
is $갨丧e̲ <=> 0.Num, More, "1 <=> 0 is More";
is $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 <=> 1.1, Less, "1.01 <=> 1.1 is Less";
is $丧e̲æ-𝐩갢 <=> -3, Less, "-3.14 <=> -3 is Less";
is -1 <=> $丳e̲с갨, Less, "-1 <=> 0 is Less";
is 1.Rat <=> $갨丧e̲, Same, "1 <=> 1 is Same";
is 1.001 <=> $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両, Less, "1.001 <=? 1.01 is Less";
is $丧e̲æ-𝐩갢 <=> -3.14, Same, "-3.14 <=> -3.14 is Same";

nok $丳e̲с갨 < 0, "not 0 < 0";
nok $갨丧e̲ < 0.Num, "not 1 < 0";
ok $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 < 1.1, "1.01 < 1.1";
ok $丧e̲æ-𝐩갢 < -3, "-3.14 < -3";
ok -1 < $丳e̲с갨, "-1 < 0";
nok 1.Rat < $갨丧e̲, "not 1 < 1";
ok 1.001 < $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両, "1.001 < 1.01";
nok $丧e̲æ-𝐩갢 < -3.14, "not -3.14 < -3.14";

ok $丳e̲с갨 <= 0, "0 <= 0";
nok $갨丧e̲ <= 0.Num, "not 1 <= 0";
ok $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 <= 1.1, "1.01 <= 1.1";
ok $丧e̲æ-𝐩갢 <= -3, "-3.14 <= -3";
ok -1 <= $丳e̲с갨, "-1 <= 0";
ok 1.Rat <= $갨丧e̲, "1 <= 1";
ok 1.001 <= $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両, "1.001 <= 1.01";
ok $丧e̲æ-𝐩갢 <= -3.14, "-3.14 <= -3.14";

nok $丳e̲с갨 > 0, "not 0 > 0";
ok $갨丧e̲ > 0.Num, "1 > 0";
nok $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 > 1.1, "not 1.01 > 1.1";
nok $丧e̲æ-𝐩갢 > -3, "not -3.14 > -3";
nok -1 > $丳e̲с갨, "not -1 > 0";
nok 1.Rat > $갨丧e̲, "not 1 > 1";
nok 1.001 > $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両, "not 1.001 > 1.01";
nok $丧e̲æ-𝐩갢 > -3.14, "not -3.14 > -3.14";

ok $丳e̲с갨 >= 0, "0 >= 0";
ok $갨丧e̲ >= 0.Num, "1 >= 0";
nok $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 >= 1.1, "not 1.01 >= 1.1";
nok $丧e̲æ-𝐩갢 >= -3, "not -3.14 >= -3";
nok -1 >= $丳e̲с갨, "not -1 >= 0";
ok 1.Rat >= $갨丧e̲, "1 >= 1";
nok 1.001 >= $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両, "not 1.001 >= 1.01";
ok $丧e̲æ-𝐩갢 >= -3.14, "-3.14 >= -3.14";

ok $丳e̲с갨 == 0, "0 == 0";
nok $갨丧e̲ == 0.Num, "not 1 == 0";
nok $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 == 1.1, "not 1.01 == 1.1";
nok $丧e̲æ-𝐩갢 == -3, "not -3.14 == -3";
nok -1 == $丳e̲с갨, "not -1 == 0";
ok 1.Rat == $갨丧e̲, "1 == 1";
nok 1.001 == $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両, "not 1.001 == 1.01";
ok $丧e̲æ-𝐩갢 == -3.14, "-3.14 == -3.14";

# bonus round!
isa-ok $丳e̲с갨.Complex, Complex, "0.Complex is a Complex";
ok $丳e̲с갨 == $丳e̲с갨.Complex, "0 == 0.Complex";
ok $丧e̲æ-𝐩갢 == $丧e̲æ-𝐩갢.Complex, "-3.14 == -3.14.Complex";
ok $丧e̲æ-𝐩갢 == -3.14.Complex, "-3.14 == -3.14.Complex";
ok -3.14 == $丧e̲æ-𝐩갢.Complex, "-3.14 == -3.14.Complex";
nok $丳e̲с갨 == $丧e̲æ-𝐩갢.Complex, "not 0 == -3.14.Complex";

nok $丳e̲с갨 != 0, "not 0 != 0";
ok $갨丧e̲ != 0.Num, "1 != 0";
ok $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 != 1.1, "1.01 != 1.1";
ok $丧e̲æ-𝐩갢 != -3, "-3.14 != -3";
ok -1 != $丳e̲с갨, "-1 != 0";
nok 1.Rat != $갨丧e̲, "not 1 != 1";
ok 1.001 != $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両, "1.001 != 1.01";
nok $丧e̲æ-𝐩갢 != -3.14, "not -3.14 != -3.14";

# bonus round!
nok $丳e̲с갨 != $丳e̲с갨.Complex, "not 0 != 0.Complex";
nok $丧e̲æ-𝐩갢 != $丧e̲æ-𝐩갢.Complex, "not -3.14 != -3.14.Complex";
nok $丧e̲æ-𝐩갢 != -3.14.Complex, "not -3.14 != -3.14.Complex";
nok -3.14 != $丧e̲æ-𝐩갢.Complex, "not -3.14 != -3.14.Complex";
ok $丳e̲с갨 != $丧e̲æ-𝐩갢.Complex, "0 != -3.14.Complex";

is $丳e̲с갨 cmp 0, Same, "0 cmp 0 is Order::Same";
is $갨丧e̲ cmp 0.Num, More, "1 cmp 0 is Order::More";
is $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 cmp 1.1, Less, "1.01 cmp 1.1 is Order::Less";
is $丧e̲æ-𝐩갢 cmp -3, Less, "-3.14 cmp -3 is Order::Less";
is -1 cmp $丳e̲с갨, Less, "-1 cmp 0 is Order::Less";
is 1.Rat cmp $갨丧e̲, Same, "1 cmp 1 is Order::Same";
is 1.001 cmp $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両, Less, "1.001 cmp 1.01 is Order::Less";
is $丧e̲æ-𝐩갢 cmp -3.14, Same, "-3.14 cmp -3.14 is Order::Same";

nok $丳e̲с갨 before 0, "not 0 before 0";
nok $갨丧e̲ before 0.Num, "not 1 before 0";
ok $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 before 1.1, "1.01 before 1.1";
ok $丧e̲æ-𝐩갢 before -3, "-3.14 before -3";
ok -1 before $丳e̲с갨, "-1 before 0";
nok 1.Rat before $갨丧e̲, "not 1 before 1";
ok 1.001 before $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両, "1.001 before 1.01";
nok $丧e̲æ-𝐩갢 before -3.14, "not -3.14 before -3.14";

nok $丳e̲с갨 after 0, "not 0 after 0";
ok $갨丧e̲ after 0.Num, "1 after 0";
nok $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 after 1.1, "not 1.01 after 1.1";
nok $丧e̲æ-𝐩갢 after -3, "not -3.14 after -3";
nok -1 after $丳e̲с갨, "not -1 after 0";
nok 1.Rat after $갨丧e̲, "not 1 after 1";
nok 1.001 after $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両, "not 1.001 after 1.01";
nok $丧e̲æ-𝐩갢 after -3.14, "not -3.14 after -3.14";

is-approx -$丳e̲с갨, 0, "-0 == 0";
is-approx -$갨丧e̲, -1, "-1 == -1";
is-approx -$갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両, -1.01, "-1.01 == -1.01";
is-approx -$丧e̲æ-𝐩갢, 3.14, "-(-3.14) == 3.14";

is $갨丧e̲ + $갨丧e̲, 2, "1 + 1 == 2";
is $갨丧e̲ + -1, 0, "1 + -1 == 0";
is $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 + $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両, 2.02, "1.01 + 1.01 == 2.02";
is-approx 1.01 + -$갨丧e̲, 0.01, "1.01 + -1 == 0.01";
is-approx $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 + 1.Num, 2.01, "1.01 + 1 == 2.01";

is $갨丧e̲ - $갨丧e̲, 0, "1 - 1 == 0";
is $갨丧e̲ - 1, 0, "1 - 1 == 0";
is $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 - $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両, 0, "1.01 - 1.01 == 0";
is $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 - 1.01, 0, "1.01 - 1.01 == 0";
is-approx 1.01 - $갨丧e̲, 0.01, "1.01 - 1 == 0.01";
is-approx $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 - 1.Num, 0.01, "1.01 - 1 == 0.01";

is-approx $갨丧e̲ * $갨丧e̲, $갨丧e̲, "1 * 1 == 1";
is-approx $갨丧e̲ * 1, $갨丧e̲, "1 * 1 == 1";
is-approx $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 * $갨丧e̲, 1.01, "1.01 * 1 == 1.01";
is-approx -1 * $丧e̲æ-𝐩갢, 3.14, "-1 * -3.14 == 3.14";
is-approx $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 * 2.Num, 2.02, "1.01 * 2 == 2.02";

is-approx $갨丧e̲ / $갨丧e̲, $갨丧e̲, "1 / 1 == 1";
is-approx $갨丧e̲ / 1, $갨丧e̲, "1 / 1 == 1";
is-approx $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 / $갨丧e̲, 1.01, "1.01 / 1 == 1.01";
is-approx -1 / $丧e̲æ-𝐩갢, 1 / 3.14, "-1 / -3.14 == 1 / 3.14";
is-approx $丧e̲æ-𝐩갢 / 2.Num, -1.57, "-3.14 / 2 == -1.57";

is-approx $갨丧e̲ % $갨丧e̲, $丳e̲с갨, "1 % 1 == 0";
is-approx $中e̲丧 % $中両сe̲e̲, $갨丧e̲, "10 % 3 == 1";
is-approx $갨丧e̲-à丧𝐝-丧갢丧e̲中ù-丧갢丧e̲-両갮丧𝐝сe̲𝐝中両ò % $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両, 0.98, "1.99 % 1.01 = 0.98";
is-approx 10 % $갨丧e̲-à丧𝐝-丧갢丧e̲中ù-丧갢丧e̲-両갮丧𝐝сe̲𝐝中両ò, 0.05, "10 % 1.99 = 0.05";
is-approx $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 % 0.2, 0.01, "1.01 % 0.2 = 0.01";

is-approx $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両.log, 1.01.log, "1.01.log is correct";
is-approx log($갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両), 1.01.log, "log(1.01) is correct";
is-approx $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両.log($中e̲丧), 1.01.log10, "1.01.log(10) is correct";
is-approx log($갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両, $中e̲丧), 1.01.log10, "log(1.01, 10) is correct";
is-approx $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両.log($中e̲丧 * 1i), 1.01.log / log(10i), "1.01.log(10i) is correct";
is-approx ($갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 * 1i).log($中e̲丧), log(1.01i) / log(10), "1.01i.log(10) is correct";

is-approx $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両.cis, 1.01.cis, "1.01.cis is correct";
is-approx cis($갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両), 1.01.cis, "cis(1.01) is correct";
is-approx $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両.unpolar($丧e̲æ-𝐩갢), 1.01.unpolar(-3.14), "1.01.unpolar(-3.14) is correct";
is-approx unpolar($갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両, $丧e̲æ-𝐩갢), 1.01.unpolar(-3.14), "1.01.unpolar(-3.14) is correct";

is $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両.floor, 1, "1.01.floor is correct";
is floor(1), 1, "1.floor is correct";
is $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両.ceiling, 2, "1.01.ceiling is correct";
is ceiling(1), 1, "1.ceiling is correct";
is $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両.truncate, 1, "1.01.truncate is correct";
is truncate($丧e̲æ-𝐩갢), -3, "-3.14.truncate is correct";
is $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両.round(1/100), 1.01, "1.01.round(1/100) is correct";
is round($갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両, 1/10), 1, "1.01.round(1/10) is correct";
is round($갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両), 1, "1.01.round is correct";

is $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両 ** $丧e̲æ-𝐩갢, 1.01 ** -3.14, "1.01 ** -3.14 is correct";
is $丧e̲æ-𝐩갢 ** $갨丧e̲, -3.14 ** 1, "-3.14 ** 1 is correct";

is $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両.exp, 1.01.exp, "1.01.exp is correct";
is $丧e̲æ-𝐩갢.exp, (-3.14).exp, "-3.14.exp is correct";
is $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両.exp(10.Rat), 1.01.exp(10), "1.01.exp(10) is correct";
is 2.exp($丧e̲æ-𝐩갢), 2.exp(-3.14), "2.exp(-3.14) is correct";
is-approx $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両.exp(10i), 1.01.exp(10i), "1.01.exp(10i) is correct";

{
    my @л = $丧e̲æ-𝐩갢.roots(4);
    ok(@л.elems == 4, '(-3.14).roots(4) returns 4 elements');
    my $q̲갮àс中갢개 = (-3.14.Complex) ** .25;
    ok(@л.grep({ ($_ - $q̲갮àс中갢개).abs < 1e-5 }).Bool, '(-3.14) ** 1/4 is a quartic root of -3.14');
    ok(@л.grep({ ($_ + $q̲갮àс中갢개).abs < 1e-5 }).Bool, '-(-3.14) ** 1/4 is a quartic root of -3.14');
    ok(@л.grep({ ($_ - $q̲갮àс中갢개\i).abs < 1e-5 }).Bool, '(-3.14)i ** 1/4 is a quartic root of -3.14');
    ok(@л.grep({ ($_ + $q̲갮àс中갢개\i).abs < 1e-5 }).Bool, '-(-3.14)i ** 1/4 is a quartic root of -3.14');
}

ok 0 <= 4.rand < 4, "Int.rand returns a valid result";
ok 0 <= (4/3).rand < 4/3, "Rat.rand returns a valid result";
ok 0 <= $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両.rand < $갨丧e̲-à丧𝐝-갨丧e̲-両갮丧𝐝сe̲𝐝中両, "Fixed2.rand returns a valid result";
ok 0 <= 32.75.Num.rand < 32.75, "Num.rand returns a valid result";

subtest 'coverage default .Bridge impls in core' => {
    plan 1+my @中ù𝐩e̲ò := 42, 42.0, 42e0, Instant.from-posix(32), # + 10 leap secs
        Duration.new(42);

    is-deeply .Bridge, 42e0, ".Bridge on {.^name}" for @中ù𝐩e̲ò;
    is-deeply (my class :: does Real { method Num { 42e0 } }.new.Bridge), 42e0,
        'Real.Bridge delegates to Num';
}

# vim: expandtab shiftwidth=4
