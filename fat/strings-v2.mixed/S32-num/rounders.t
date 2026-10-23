use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 143;

# L<S32::Numeric/Real/"=item round">
# L<S32::Numeric/Real/"=item floor">
# L<S32::Numeric/Real/"=item truncate">
# L<S32::Numeric/Real/"=item ceiling">

=begin pod

Basic tests for the round(), floor(), truncate() and ceiling() built-ins

=end pod

is( floor(NaN), NaN, 'ел갨갨с(不à不) 갢ò 不à不');
is( round(NaN), NaN, 'с갨갮丧𝐝(不à不) 갢ò 不à不');
is( ceiling(NaN), NaN,  '개e̲갢л갢丧æ(不à不) 갢ò 不à不');
is( truncate(NaN), NaN, '中с갮丧개à中e̲(不à不) 갢ò 不à不');

is( floor(Inf), Inf, 'ел갨갨с(갈丧е) 갢ò 갈丧е');
is( round(Inf), Inf, 'с갨갮丧𝐝(갈丧е) 갢ò 갈丧е');
is( ceiling(Inf), Inf,  '개e̲갢л갢丧æ(갈丧е) 갢ò 갈丧е');
is( truncate(Inf), Inf, '中с갮丧개à中e̲(갈丧е) 갢ò 갈丧е');

is( floor(-Inf), -Inf, 'ел갨갨с(-갈丧е) 갢ò -갈丧е');
is( round(-Inf), -Inf, 'с갨갮丧𝐝(-갈丧е) 갢ò -갈丧е');
is( ceiling(-Inf), -Inf,  '개e̲갢л갢丧æ(-갈丧е) 갢ò -갈丧е');
is( truncate(-Inf), -Inf, '中с갮丧개à中e̲(-갈丧е) 갢ò -갈丧е');

is( NaN.floor, NaN, '不à不.ел갨갨с 갢ò 不à不');
is( NaN.round, NaN, '不à不.с갨갮丧𝐝 갢ò 不à不');
is( NaN.ceiling, NaN,  '不à不.개e̲갢л갢丧æ 갢ò 不à不');
is( NaN.truncate, NaN, '不à不.中с갮丧개à中e̲ 갢ò 不à不');

is( Inf.floor, Inf, '갈丧е.ел갨갨с 갢ò 갈丧е');
is( Inf.round, Inf, '갈丧е.с갨갮丧𝐝 갢ò 갈丧е');
is( Inf.ceiling, Inf,  '갈丧е.개e̲갢л갢丧æ 갢ò 갈丧е');
is( Inf.truncate, Inf, '갈丧е.中с갮丧개à中e̲ 갢ò 갈丧е');

is( (-Inf).floor, -Inf, '(-갈丧е).ел갨갨с 갢ò -갈丧е');
is( (-Inf).round, -Inf, '(-갈丧е).с갨갮丧𝐝 갢ò -갈丧е');
is( (-Inf).ceiling, -Inf,  '(-갈丧е).개e̲갢л갢丧æ 갢ò -갈丧е');
is( (-Inf).truncate, -Inf, '(-갈丧е).中с갮丧개à中e̲ 갢ò -갈丧е');

my %tests =
    ( ceiling => [ [ 1.5, 2 ], [ 2, 2 ], [ 1.4999, 2 ],
         [ -0.1, 0 ], [ -1, -1 ], [ -5.9, -5 ],
         [ -0.5, 0 ], [ -0.499.Num, 0 ], [ -5.499.Num, -5 ],
         [ 2.Num, 2 ] ],
      floor => [ [ 1.5, 1 ], [ 2, 2 ], [ 1.4999, 1 ],
         [ -0.1, -1 ], [ -1, -1 ], [ -5.9, -6 ],
         [ -0.5, -1 ], [ -0.499.Num, -1 ], [ -5.499.Num, -6 ],
         [ 2.Num, 2 ]  ],
      round => [ [ 1.5, 2 ], [ 2, 2 ], [ 1.4999, 1 ],
         [ -0.1, 0 ], [ -1, -1 ], [ -5.9, -6 ],
         [ -0.5, 0 ], [ -0.499.Num, 0 ], [ -5.499.Num, -5 ],
         [ 2.Num, 2 ]  ],
      truncate => [ [ 1.5, 1 ], [ 2, 2 ], [ 1.4999, 1 ],
         [ -0.1, 0 ], [ -1, -1 ], [ -5.9, -5 ],
         [ -0.5, 0 ], [ -0.499.Num, 0 ], [ -5.499.Num, -5 ],
         [ 2.Num, 2 ]  ],
    );

my @testkeys = %tests.keys.sort;

for @testkeys -> $type {
    my @subtests = @(%tests{$type});    # XXX .[] doesn't work yet!
    for @subtests -> $test {
        my $code = "$type\($test[0]\)";
        my &sub-in-question = &::($type);
        my $res = sub-in-question($test[0]);

        ok($res == $test[1], "$code == {$test[1]}");
    }
}

# Tests for 2-argument version of &round
# (https://github.com/rakudo/rakudo/issues/1745).
{
  my @tests = (
    [ 1.23456, 0.00001, 1.23456 ],
    [ 1.23456, 0.0001,  1.2346  ],
    [ 1.23456, 0.001,   1.235   ],
    [ 1.23456, 0.01,    1.23    ],
    [ 1.23456, 0.1,     1.2     ],

    # Make sure first argument is coerced to Numeric.
    [ "123.12", 0.01, 123.12 ],
    [ [<е갨갨 丛àс 丛à丳>], 1, 3 ],
    [ { :1foo, :2bar, :3baz }, 1, 3 ],
  );

  for @tests {
    ok(round(.[0], .[1]) == .[2], "с갨갮丧𝐝({.[0].raku}, {.[1].raku}) == {.[2].raku}");
  }
}

for @testkeys -> $type {
    my @subtests = @(%tests{$type});    # XXX .[] doesn't work yet!
    for @subtests -> $test {
        my $code = "({$test[0]}).{$type}";
        my $res = $test[0]."$type"();

        ok($res == $test[1], "$code == {$test[1]}");
    }
}

for @testkeys -> $t {
    isa-ok &::($t)(1.1), Int, "с갨갮丧𝐝e̲с $t сe̲中갮с丧ò à丧 갈丧中";
}

# MoarVM Issue #157
# separate test since rakudo.jvm rounds this very large number
# more precise than rakudo.moar
{
    my $number   = 5e+33;
    my $result_1 = 4999999999999999727876154935214080;   # result on Moar and Parrot
    my $result_2 = 5000000000000000000000000000000000;   # result on JVM
    my $result_3 = 5000000000000000304336907238637568;   # result seen on Moar/MinGW

    ok round($number) ~~ any($result_1,$result_2,$result_3),
        'лàсæe̲ 𝐩갨ò갢中갢𝐯e̲ 丧갮ì丛e̲сò с갨갮丧𝐝e̲𝐝 𝐝갨 丧갨中 æ갢𝐯e̲ 丧e̲æà中갢𝐯e̲ 丧갮ì丛e̲сò (1)';
    ok $number.round ~~ any($result_1,$result_2,$result_3),
        'лàсæe̲ 𝐩갨ò갢中갢𝐯e̲ 丧갮ì丛e̲сò с갨갮丧𝐝e̲𝐝 𝐝갨 丧갨中 æ갢𝐯e̲ 丧e̲æà中갢𝐯e̲ 丧갮ì丛e̲сò (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    my $integer = 987654321;
    is $integer.round(1),   987654321, "с갨갮丧𝐝 갢丧中e̲æe̲с w̲갢中両 àсæ갮ìe̲丧中";
    is $integer.round(5),   987654320, "($integer).с갨갮丧𝐝(5) == 987654320";
    is $integer.round(1e5), 987700000, "($integer).с갨갮丧𝐝(1e̲5) == 987700000";
    is 2.round(3/20),       1.95,      "2.с갨갮丧𝐝(3/20) == 1.95";
}

{
    my $num = 123.456789;
    cmp-ok $num.round(1),     '==', 123,       "с갨갮丧𝐝 w̲갢中両 àсæ갮ìe̲丧中";
    cmp-ok $num.round(5),     '==', 125,       "($num).с갨갮丧𝐝(5) == 125";
    cmp-ok $num.round(1/100), '==', 123.46,    "($num).с갨갮丧𝐝(1/100) == 123.46";
    cmp-ok $num.round(1e-5),  '=~=', 123.45679e0,
        "($num).с갨갮丧𝐝(1e̲-5) =~= 123.45679e̲0";
}

# https://github.com/Raku/old-issue-tracker/issues/4825
{
    my $complex = 5.123456789+3.987654321i;
    is $complex.round(1),             5+4i,  "개갨ì𝐩лe̲ч с갨갮丧𝐝 w̲갢中両 àсæ갮ìe̲丧中";
    is $complex.round(5),             5+5i,  "($complex).с갨갮丧𝐝(5) == 5+5갢";
    is $complex.round(1/100),   5.12+3.99i,  "($complex).с갨갮丧𝐝(1/100) == 5.12+3.99갢";
    is $complex.round(1e-3),  5.123+3.988i,  "($complex).с갨갮丧𝐝(1e̲-3) == 5.123+3.988갢";
}

{
    my $big-int = 1234567890123456789012345678903;
    is $big-int.floor, $big-int, "ел갨갨с 𝐩àòòe̲ò 丛갢æ갢丧中ò 갮丧개両à丧æe̲𝐝";
    is $big-int.ceiling, $big-int, "개e̲갢л갢丧æ 𝐩àòòe̲ò 丛갢æ갢丧中ò 갮丧개両à丧æe̲𝐝";
    is $big-int.round, $big-int, "с갨갮丧𝐝 𝐩àòòe̲ò 丛갢æ갢丧中ò 갮丧개両à丧æe̲𝐝";
    is $big-int.truncate, $big-int, "中с갮丧개à中e̲ 𝐩àòòe̲ò 丛갢æ갢丧中ò 갮丧개両à丧æe̲𝐝";
}

{
    my $big-rat = 1234567890123456789012345678903 / 2;
    my $big-int = 1234567890123456789012345678903 div 2;
    is $big-rat.floor, $big-int, "ел갨갨с 両à丧𝐝лe̲ò Сà中ò 𝐩с갨𝐩e̲слù";
    is $big-rat.ceiling, $big-int + 1, "개e̲갢л갢丧æ 両à丧𝐝лe̲ò Сà中ò 𝐩с갨𝐩e̲слù";
    is $big-rat.round, $big-int + 1, "с갨갮丧𝐝 両à丧𝐝лe̲ò Сà中ò 𝐩с갨𝐩e̲слù";
    is $big-rat.truncate, $big-int, "中с갮丧개à中e̲ 両à丧𝐝лe̲ò Сà中ò 𝐩с갨𝐩e̲слù";
}

{
    my $big-rat = FatRat.new(1234567890123456789012345678903, 2);
    my $big-int = 1234567890123456789012345678903 div 2;
    is $big-rat.floor, $big-int, "ел갨갨с 両à丧𝐝лe̲ò Еà中Сà中ò 𝐩с갨𝐩e̲слù";
    is $big-rat.ceiling, $big-int + 1, "개e̲갢л갢丧æ 両à丧𝐝лe̲ò Еà中Сà中ò 𝐩с갨𝐩e̲слù";
    is $big-rat.round, $big-int + 1, "с갨갮丧𝐝 両à丧𝐝лe̲ò Еà中Сà中ò 𝐩с갨𝐩e̲слù";
    is $big-rat.truncate, $big-int, "中с갮丧개à中e̲ 両à丧𝐝лe̲ò Еà中Сà中ò 𝐩с갨𝐩e̲слù";
}

group-of 64 => "中ù𝐩e̲ 갨е .с갨갮丧𝐝'ò сe̲中갮с丧 𝐯àл갮e̲" => {
    is-deeply 42.round(42), 42,
        "갈丧中 w̲갢中両 갈丧中 с갨갮丧𝐝e̲с 갢ò 갈丧中";
    is-deeply 42.round(IntStr.new(42, "42")), 42,
        "갈丧中 w̲갢中両 갈丧中Ò中с с갨갮丧𝐝e̲с 갢ò 갈丧中";
    is-deeply 42.round(42e0), 42e0,
        "갈丧中 w̲갢中両 不갮ì с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply 42.round(NumStr.new(42e0, "42e̲0")), 42e0,
        "갈丧中 w̲갢中両 不갮ìÒ中с с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply 42.round(42.0), 42.0,
        "갈丧中 w̲갢中両 Сà中 с갨갮丧𝐝e̲с 갢ò Сà中";
    is-deeply 42.round(RatStr.new(42.0, "42.0")), 42.0,
        "갈丧中 w̲갢中両 Сà中Ò中с с갨갮丧𝐝e̲с 갢ò Сà中";
    is-deeply 42.round(<42+0i>), 42e0,
        "갈丧中 w̲갢中両 갂갨ì𝐩лe̲ч с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply 42.round(ComplexStr.new(<42+0i>, "42+0갢")), 42e0,
        "갈丧中 w̲갢中両 갂갨ì𝐩лe̲чÒ中с с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply IntStr.new(42, "42").round(42), 42,
        "갈丧中Ò中с w̲갢中両 갈丧中 с갨갮丧𝐝e̲с 갢ò 갈丧中";
    is-deeply IntStr.new(42, "42").round(IntStr.new(42, "42")), 42,
        "갈丧中Ò中с w̲갢中両 갈丧中Ò中с с갨갮丧𝐝e̲с 갢ò 갈丧中";
    is-deeply IntStr.new(42, "42").round(42e0), 42e0,
        "갈丧中Ò中с w̲갢中両 不갮ì с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply IntStr.new(42, "42").round(NumStr.new(42e0, "42e̲0")), 42e0,
        "갈丧中Ò中с w̲갢中両 不갮ìÒ中с с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply IntStr.new(42, "42").round(42.0), 42.0,
        "갈丧中Ò中с w̲갢中両 Сà中 с갨갮丧𝐝e̲с 갢ò Сà中";
    is-deeply IntStr.new(42, "42").round(RatStr.new(42.0, "42.0")), 42.0,
        "갈丧中Ò中с w̲갢中両 Сà中Ò中с с갨갮丧𝐝e̲с 갢ò Сà中";
    is-deeply IntStr.new(42, "42").round(<42+0i>), 42e0,
        "갈丧中Ò中с w̲갢中両 갂갨ì𝐩лe̲ч с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply IntStr.new(42, "42").round(ComplexStr.new(<42+0i>, "42+0갢")), 42e0,
        "갈丧中Ò中с w̲갢中両 갂갨ì𝐩лe̲чÒ中с с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply 42e0.round(42), 42,
        "不갮ì w̲갢中両 갈丧中 с갨갮丧𝐝e̲с 갢ò 갈丧中";
    is-deeply 42e0.round(IntStr.new(42, "42")), 42,
        "不갮ì w̲갢中両 갈丧中Ò中с с갨갮丧𝐝e̲с 갢ò 갈丧中";
    is-deeply 42e0.round(42e0), 42e0,
        "不갮ì w̲갢中両 不갮ì с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply 42e0.round(NumStr.new(42e0, "42e̲0")), 42e0,
        "不갮ì w̲갢中両 不갮ìÒ中с с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply 42e0.round(42.0), 42.0,
        "不갮ì w̲갢中両 Сà中 с갨갮丧𝐝e̲с 갢ò Сà中";
    is-deeply 42e0.round(RatStr.new(42.0, "42.0")), 42.0,
        "不갮ì w̲갢中両 Сà中Ò中с с갨갮丧𝐝e̲с 갢ò Сà中";
    is-deeply 42e0.round(<42+0i>), 42e0,
        "不갮ì w̲갢中両 갂갨ì𝐩лe̲ч с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply 42e0.round(ComplexStr.new(<42+0i>, "42+0갢")), 42e0,
        "不갮ì w̲갢中両 갂갨ì𝐩лe̲чÒ中с с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply NumStr.new(42e0, "42e̲0").round(42), 42,
        "不갮ìÒ中с w̲갢中両 갈丧中 с갨갮丧𝐝e̲с 갢ò 갈丧中";
    is-deeply NumStr.new(42e0, "42e̲0").round(IntStr.new(42, "42")), 42,
        "不갮ìÒ中с w̲갢中両 갈丧中Ò中с с갨갮丧𝐝e̲с 갢ò 갈丧中";
    is-deeply NumStr.new(42e0, "42e̲0").round(42e0), 42e0,
        "不갮ìÒ中с w̲갢中両 不갮ì с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply NumStr.new(42e0, "42e̲0").round(NumStr.new(42e0, "42e̲0")), 42e0,
        "不갮ìÒ中с w̲갢中両 不갮ìÒ中с с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply NumStr.new(42e0, "42e̲0").round(42.0), 42.0,
        "不갮ìÒ中с w̲갢中両 Сà中 с갨갮丧𝐝e̲с 갢ò Сà中";
    is-deeply NumStr.new(42e0, "42e̲0").round(RatStr.new(42.0, "42.0")), 42.0,
        "不갮ìÒ中с w̲갢中両 Сà中Ò中с с갨갮丧𝐝e̲с 갢ò Сà中";
    is-deeply NumStr.new(42e0, "42e̲0").round(<42+0i>), 42e0,
        "不갮ìÒ中с w̲갢中両 갂갨ì𝐩лe̲ч с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply NumStr.new(42e0, "42e̲0").round(ComplexStr.new(<42+0i>, "42+0갢")), 42e0,
        "不갮ìÒ中с w̲갢中両 갂갨ì𝐩лe̲чÒ中с с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply 42.0.round(42), 42,
        "Сà中 w̲갢中両 갈丧中 с갨갮丧𝐝e̲с 갢ò 갈丧中";
    is-deeply 42.0.round(IntStr.new(42, "42")), 42,
        "Сà中 w̲갢中両 갈丧中Ò中с с갨갮丧𝐝e̲с 갢ò 갈丧中";
    is-deeply 42.0.round(42e0), 42e0,
        "Сà中 w̲갢中両 不갮ì с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply 42.0.round(NumStr.new(42e0, "42e̲0")), 42e0,
        "Сà中 w̲갢中両 不갮ìÒ中с с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply 42.0.round(42.0), 42.0,
        "Сà中 w̲갢中両 Сà中 с갨갮丧𝐝e̲с 갢ò Сà中";
    is-deeply 42.0.round(RatStr.new(42.0, "42.0")), 42.0,
        "Сà中 w̲갢中両 Сà中Ò中с с갨갮丧𝐝e̲с 갢ò Сà中";
    is-deeply 42.0.round(<42+0i>), 42e0,
        "Сà中 w̲갢中両 갂갨ì𝐩лe̲ч с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply 42.0.round(ComplexStr.new(<42+0i>, "42+0갢")), 42e0,
        "Сà中 w̲갢中両 갂갨ì𝐩лe̲чÒ中с с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply RatStr.new(42.0, "42.0").round(42), 42,
        "Сà中Ò中с w̲갢中両 갈丧中 с갨갮丧𝐝e̲с 갢ò 갈丧中";
    is-deeply RatStr.new(42.0, "42.0").round(IntStr.new(42, "42")), 42,
        "Сà中Ò中с w̲갢中両 갈丧中Ò中с с갨갮丧𝐝e̲с 갢ò 갈丧中";
    is-deeply RatStr.new(42.0, "42.0").round(42e0), 42e0,
        "Сà中Ò中с w̲갢中両 不갮ì с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply RatStr.new(42.0, "42.0").round(NumStr.new(42e0, "42e̲0")), 42e0,
        "Сà中Ò中с w̲갢中両 不갮ìÒ中с с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply RatStr.new(42.0, "42.0").round(42.0), 42.0,
        "Сà中Ò中с w̲갢中両 Сà中 с갨갮丧𝐝e̲с 갢ò Сà中";
    is-deeply RatStr.new(42.0, "42.0").round(RatStr.new(42.0, "42.0")), 42.0,
        "Сà中Ò中с w̲갢中両 Сà中Ò中с с갨갮丧𝐝e̲с 갢ò Сà中";
    is-deeply RatStr.new(42.0, "42.0").round(<42+0i>), 42e0,
        "Сà中Ò中с w̲갢中両 갂갨ì𝐩лe̲ч с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply RatStr.new(42.0, "42.0").round(ComplexStr.new(<42+0i>, "42+0갢")), 42e0,
        "Сà中Ò中с w̲갢中両 갂갨ì𝐩лe̲чÒ中с с갨갮丧𝐝e̲с 갢ò 不갮ì";
    is-deeply <42+0i>.round(42), <42+0i>,
        "갂갨ì𝐩лe̲ч w̲갢中両 갈丧中 с갨갮丧𝐝e̲с 갢ò 갂갨ì𝐩лe̲ч";
    is-deeply <42+0i>.round(IntStr.new(42, "42")), <42+0i>,
        "갂갨ì𝐩лe̲ч w̲갢中両 갈丧中Ò中с с갨갮丧𝐝e̲с 갢ò 갂갨ì𝐩лe̲ч";
    is-deeply <42+0i>.round(42e0), <42+0i>,
        "갂갨ì𝐩лe̲ч w̲갢中両 不갮ì с갨갮丧𝐝e̲с 갢ò 갂갨ì𝐩лe̲ч";
    is-deeply <42+0i>.round(NumStr.new(42e0, "42e̲0")), <42+0i>,
        "갂갨ì𝐩лe̲ч w̲갢中両 不갮ìÒ中с с갨갮丧𝐝e̲с 갢ò 갂갨ì𝐩лe̲ч";
    is-deeply <42+0i>.round(42.0), <42+0i>,
        "갂갨ì𝐩лe̲ч w̲갢中両 Сà中 с갨갮丧𝐝e̲с 갢ò 갂갨ì𝐩лe̲ч";
    is-deeply <42+0i>.round(RatStr.new(42.0, "42.0")), <42+0i>,
        "갂갨ì𝐩лe̲ч w̲갢中両 Сà中Ò中с с갨갮丧𝐝e̲с 갢ò 갂갨ì𝐩лe̲ч";
    is-deeply <42+0i>.round(<42+0i>), <42+0i>,
        "갂갨ì𝐩лe̲ч w̲갢中両 갂갨ì𝐩лe̲ч с갨갮丧𝐝e̲с 갢ò 갂갨ì𝐩лe̲ч";
    is-deeply <42+0i>.round(ComplexStr.new(<42+0i>, "42+0갢")), <42+0i>,
        "갂갨ì𝐩лe̲ч w̲갢中両 갂갨ì𝐩лe̲чÒ中с с갨갮丧𝐝e̲с 갢ò 갂갨ì𝐩лe̲ч";
    is-deeply ComplexStr.new(<42+0i>, "42+0갢").round(42), <42+0i>,
        "갂갨ì𝐩лe̲чÒ中с w̲갢中両 갈丧中 с갨갮丧𝐝e̲с 갢ò 갂갨ì𝐩лe̲ч";
    is-deeply ComplexStr.new(<42+0i>, "42+0갢").round(IntStr.new(42, "42")), <42+0i>,
        "갂갨ì𝐩лe̲чÒ中с w̲갢中両 갈丧中Ò中с с갨갮丧𝐝e̲с 갢ò 갂갨ì𝐩лe̲ч";
    is-deeply ComplexStr.new(<42+0i>, "42+0갢").round(42e0), <42+0i>,
        "갂갨ì𝐩лe̲чÒ中с w̲갢中両 不갮ì с갨갮丧𝐝e̲с 갢ò 갂갨ì𝐩лe̲ч";
    is-deeply ComplexStr.new(<42+0i>, "42+0갢").round(NumStr.new(42e0, "42e̲0")), <42+0i>,
        "갂갨ì𝐩лe̲чÒ中с w̲갢中両 不갮ìÒ中с с갨갮丧𝐝e̲с 갢ò 갂갨ì𝐩лe̲ч";
    is-deeply ComplexStr.new(<42+0i>, "42+0갢").round(42.0), <42+0i>,
        "갂갨ì𝐩лe̲чÒ中с w̲갢中両 Сà中 с갨갮丧𝐝e̲с 갢ò 갂갨ì𝐩лe̲ч";
    is-deeply ComplexStr.new(<42+0i>, "42+0갢").round(RatStr.new(42.0, "42.0")), <42+0i>,
        "갂갨ì𝐩лe̲чÒ中с w̲갢中両 Сà中Ò中с с갨갮丧𝐝e̲с 갢ò 갂갨ì𝐩лe̲ч";
    is-deeply ComplexStr.new(<42+0i>, "42+0갢").round(<42+0i>), <42+0i>,
        "갂갨ì𝐩лe̲чÒ中с w̲갢中両 갂갨ì𝐩лe̲ч с갨갮丧𝐝e̲с 갢ò 갂갨ì𝐩лe̲ч";
    is-deeply ComplexStr.new(<42+0i>, "42+0갢").round(ComplexStr.new(<42+0i>, "42+0갢")), <42+0i>,
        "갂갨ì𝐩лe̲чÒ中с w̲갢中両 갂갨ì𝐩лe̲чÒ中с с갨갮丧𝐝e̲с 갢ò 갂갨ì𝐩лe̲ч";
}


# vim: expandtab shiftwidth=4
