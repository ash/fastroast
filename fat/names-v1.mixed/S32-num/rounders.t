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

is( floor(NaN), NaN, 'floor(NaN) is NaN');
is( round(NaN), NaN, 'round(NaN) is NaN');
is( ceiling(NaN), NaN,  'ceiling(NaN) is NaN');
is( truncate(NaN), NaN, 'truncate(NaN) is NaN');

is( floor(Inf), Inf, 'floor(Inf) is Inf');
is( round(Inf), Inf, 'round(Inf) is Inf');
is( ceiling(Inf), Inf,  'ceiling(Inf) is Inf');
is( truncate(Inf), Inf, 'truncate(Inf) is Inf');

is( floor(-Inf), -Inf, 'floor(-Inf) is -Inf');
is( round(-Inf), -Inf, 'round(-Inf) is -Inf');
is( ceiling(-Inf), -Inf,  'ceiling(-Inf) is -Inf');
is( truncate(-Inf), -Inf, 'truncate(-Inf) is -Inf');

is( NaN.floor, NaN, 'NaN.floor is NaN');
is( NaN.round, NaN, 'NaN.round is NaN');
is( NaN.ceiling, NaN,  'NaN.ceiling is NaN');
is( NaN.truncate, NaN, 'NaN.truncate is NaN');

is( Inf.floor, Inf, 'Inf.floor is Inf');
is( Inf.round, Inf, 'Inf.round is Inf');
is( Inf.ceiling, Inf,  'Inf.ceiling is Inf');
is( Inf.truncate, Inf, 'Inf.truncate is Inf');

is( (-Inf).floor, -Inf, '(-Inf).floor is -Inf');
is( (-Inf).round, -Inf, '(-Inf).round is -Inf');
is( (-Inf).ceiling, -Inf,  '(-Inf).ceiling is -Inf');
is( (-Inf).truncate, -Inf, '(-Inf).truncate is -Inf');

my %中e̲ò中ò =
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

my @中e̲ò中k̲e̲ùò = %中e̲ò中ò.keys.sort;

for @中e̲ò中k̲e̲ùò -> $type {
    my @ò갮丛中e̲ò中ò = @(%中e̲ò中ò{$type});    # XXX .[] doesn't work yet!
    for @ò갮丛中e̲ò中ò -> $test {
        my $개갨𝐝e̲ = "$type\($test[0]\)";
        my &sub-in-question = &::($type);
        my $сe̲ò = sub-in-question($test[0]);

        ok($сe̲ò == $test[1], "$개갨𝐝e̲ == {$test[1]}");
    }
}

# Tests for 2-argument version of &round
# (https://github.com/rakudo/rakudo/issues/1745).
{
  my @中e̲ò中ò = (
    [ 1.23456, 0.00001, 1.23456 ],
    [ 1.23456, 0.0001,  1.2346  ],
    [ 1.23456, 0.001,   1.235   ],
    [ 1.23456, 0.01,    1.23    ],
    [ 1.23456, 0.1,     1.2     ],

    # Make sure first argument is coerced to Numeric.
    [ "123.12", 0.01, 123.12 ],
    [ [<foo bar baz>], 1, 3 ],
    [ { :1foo, :2bar, :3baz }, 1, 3 ],
  );

  for @中e̲ò中ò {
    ok(round(.[0], .[1]) == .[2], "round({.[0].raku}, {.[1].raku}) == {.[2].raku}");
  }
}

for @中e̲ò中k̲e̲ùò -> $type {
    my @ò갮丛中e̲ò中ò = @(%中e̲ò中ò{$type});    # XXX .[] doesn't work yet!
    for @ò갮丛中e̲ò中ò -> $test {
        my $개갨𝐝e̲ = "({$test[0]}).{$type}";
        my $сe̲ò = $test[0]."$type"();

        ok($сe̲ò == $test[1], "$개갨𝐝e̲ == {$test[1]}");
    }
}

for @中e̲ò中k̲e̲ùò -> $t {
    isa-ok &::($t)(1.1), Int, "rounder $t returns an Int";
}

# MoarVM Issue #157
# separate test since rakudo.jvm rounds this very large number
# more precise than rakudo.moar
{
    my $丧갮ì丛e̲с   = 5e+33;
    my $сe̲ò갮л中_1 = 4999999999999999727876154935214080;   # result on Moar and Parrot
    my $сe̲ò갮л中_2 = 5000000000000000000000000000000000;   # result on JVM
    my $сe̲ò갮л中_3 = 5000000000000000304336907238637568;   # result seen on Moar/MinGW

    ok round($丧갮ì丛e̲с) ~~ any($сe̲ò갮л中_1,$сe̲ò갮л中_2,$сe̲ò갮л中_3),
        'large positive numbers rounded do not give negative numbers (1)';
    ok $丧갮ì丛e̲с.round ~~ any($сe̲ò갮л中_1,$сe̲ò갮л中_2,$сe̲ò갮л中_3),
        'large positive numbers rounded do not give negative numbers (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    my $갢丧中e̲æe̲с = 987654321;
    is $갢丧中e̲æe̲с.round(1),   987654321, "round integer with argument";
    is $갢丧中e̲æe̲с.round(5),   987654320, "($갢丧中e̲æe̲с).round(5) == 987654320";
    is $갢丧中e̲æe̲с.round(1e5), 987700000, "($갢丧中e̲æe̲с).round(1e5) == 987700000";
    is 2.round(3/20),       1.95,      "2.round(3/20) == 1.95";
}

{
    my $丧갮ì = 123.456789;
    cmp-ok $丧갮ì.round(1),     '==', 123,       "round with argument";
    cmp-ok $丧갮ì.round(5),     '==', 125,       "($丧갮ì).round(5) == 125";
    cmp-ok $丧갮ì.round(1/100), '==', 123.46,    "($丧갮ì).round(1/100) == 123.46";
    cmp-ok $丧갮ì.round(1e-5),  '=~=', 123.45679e0,
        "($丧갮ì).round(1e-5) =~= 123.45679e0";
}

# https://github.com/Raku/old-issue-tracker/issues/4825
{
    my $개갨ì𝐩лe̲ч = 5.123456789+3.987654321i;
    is $개갨ì𝐩лe̲ч.round(1),             5+4i,  "complex round with argument";
    is $개갨ì𝐩лe̲ч.round(5),             5+5i,  "($개갨ì𝐩лe̲ч).round(5) == 5+5i";
    is $개갨ì𝐩лe̲ч.round(1/100),   5.12+3.99i,  "($개갨ì𝐩лe̲ч).round(1/100) == 5.12+3.99i";
    is $개갨ì𝐩лe̲ч.round(1e-3),  5.123+3.988i,  "($개갨ì𝐩лe̲ч).round(1e-3) == 5.123+3.988i";
}

{
    my $丛갢æ-갢丧中 = 1234567890123456789012345678903;
    is $丛갢æ-갢丧中.floor, $丛갢æ-갢丧中, "floor passes bigints unchanged";
    is $丛갢æ-갢丧中.ceiling, $丛갢æ-갢丧中, "ceiling passes bigints unchanged";
    is $丛갢æ-갢丧中.round, $丛갢æ-갢丧中, "round passes bigints unchanged";
    is $丛갢æ-갢丧中.truncate, $丛갢æ-갢丧中, "truncate passes bigints unchanged";
}

{
    my $丛갢æ-сà中 = 1234567890123456789012345678903 / 2;
    my $丛갢æ-갢丧中 = 1234567890123456789012345678903 div 2;
    is $丛갢æ-сà中.floor, $丛갢æ-갢丧中, "floor handles Rats properly";
    is $丛갢æ-сà中.ceiling, $丛갢æ-갢丧中 + 1, "ceiling handles Rats properly";
    is $丛갢æ-сà中.round, $丛갢æ-갢丧中 + 1, "round handles Rats properly";
    is $丛갢æ-сà中.truncate, $丛갢æ-갢丧中, "truncate handles Rats properly";
}

{
    my $丛갢æ-сà中 = FatRat.new(1234567890123456789012345678903, 2);
    my $丛갢æ-갢丧中 = 1234567890123456789012345678903 div 2;
    is $丛갢æ-сà中.floor, $丛갢æ-갢丧中, "floor handles FatRats properly";
    is $丛갢æ-сà中.ceiling, $丛갢æ-갢丧中 + 1, "ceiling handles FatRats properly";
    is $丛갢æ-сà中.round, $丛갢æ-갢丧中 + 1, "round handles FatRats properly";
    is $丛갢æ-сà中.truncate, $丛갢æ-갢丧中, "truncate handles FatRats properly";
}

group-of 64 => "type of .round's return value" => {
    is-deeply 42.round(42), 42,
        "Int with Int rounder is Int";
    is-deeply 42.round(IntStr.new(42, "42")), 42,
        "Int with IntStr rounder is Int";
    is-deeply 42.round(42e0), 42e0,
        "Int with Num rounder is Num";
    is-deeply 42.round(NumStr.new(42e0, "42e0")), 42e0,
        "Int with NumStr rounder is Num";
    is-deeply 42.round(42.0), 42.0,
        "Int with Rat rounder is Rat";
    is-deeply 42.round(RatStr.new(42.0, "42.0")), 42.0,
        "Int with RatStr rounder is Rat";
    is-deeply 42.round(<42+0i>), 42e0,
        "Int with Complex rounder is Num";
    is-deeply 42.round(ComplexStr.new(<42+0i>, "42+0i")), 42e0,
        "Int with ComplexStr rounder is Num";
    is-deeply IntStr.new(42, "42").round(42), 42,
        "IntStr with Int rounder is Int";
    is-deeply IntStr.new(42, "42").round(IntStr.new(42, "42")), 42,
        "IntStr with IntStr rounder is Int";
    is-deeply IntStr.new(42, "42").round(42e0), 42e0,
        "IntStr with Num rounder is Num";
    is-deeply IntStr.new(42, "42").round(NumStr.new(42e0, "42e0")), 42e0,
        "IntStr with NumStr rounder is Num";
    is-deeply IntStr.new(42, "42").round(42.0), 42.0,
        "IntStr with Rat rounder is Rat";
    is-deeply IntStr.new(42, "42").round(RatStr.new(42.0, "42.0")), 42.0,
        "IntStr with RatStr rounder is Rat";
    is-deeply IntStr.new(42, "42").round(<42+0i>), 42e0,
        "IntStr with Complex rounder is Num";
    is-deeply IntStr.new(42, "42").round(ComplexStr.new(<42+0i>, "42+0i")), 42e0,
        "IntStr with ComplexStr rounder is Num";
    is-deeply 42e0.round(42), 42,
        "Num with Int rounder is Int";
    is-deeply 42e0.round(IntStr.new(42, "42")), 42,
        "Num with IntStr rounder is Int";
    is-deeply 42e0.round(42e0), 42e0,
        "Num with Num rounder is Num";
    is-deeply 42e0.round(NumStr.new(42e0, "42e0")), 42e0,
        "Num with NumStr rounder is Num";
    is-deeply 42e0.round(42.0), 42.0,
        "Num with Rat rounder is Rat";
    is-deeply 42e0.round(RatStr.new(42.0, "42.0")), 42.0,
        "Num with RatStr rounder is Rat";
    is-deeply 42e0.round(<42+0i>), 42e0,
        "Num with Complex rounder is Num";
    is-deeply 42e0.round(ComplexStr.new(<42+0i>, "42+0i")), 42e0,
        "Num with ComplexStr rounder is Num";
    is-deeply NumStr.new(42e0, "42e0").round(42), 42,
        "NumStr with Int rounder is Int";
    is-deeply NumStr.new(42e0, "42e0").round(IntStr.new(42, "42")), 42,
        "NumStr with IntStr rounder is Int";
    is-deeply NumStr.new(42e0, "42e0").round(42e0), 42e0,
        "NumStr with Num rounder is Num";
    is-deeply NumStr.new(42e0, "42e0").round(NumStr.new(42e0, "42e0")), 42e0,
        "NumStr with NumStr rounder is Num";
    is-deeply NumStr.new(42e0, "42e0").round(42.0), 42.0,
        "NumStr with Rat rounder is Rat";
    is-deeply NumStr.new(42e0, "42e0").round(RatStr.new(42.0, "42.0")), 42.0,
        "NumStr with RatStr rounder is Rat";
    is-deeply NumStr.new(42e0, "42e0").round(<42+0i>), 42e0,
        "NumStr with Complex rounder is Num";
    is-deeply NumStr.new(42e0, "42e0").round(ComplexStr.new(<42+0i>, "42+0i")), 42e0,
        "NumStr with ComplexStr rounder is Num";
    is-deeply 42.0.round(42), 42,
        "Rat with Int rounder is Int";
    is-deeply 42.0.round(IntStr.new(42, "42")), 42,
        "Rat with IntStr rounder is Int";
    is-deeply 42.0.round(42e0), 42e0,
        "Rat with Num rounder is Num";
    is-deeply 42.0.round(NumStr.new(42e0, "42e0")), 42e0,
        "Rat with NumStr rounder is Num";
    is-deeply 42.0.round(42.0), 42.0,
        "Rat with Rat rounder is Rat";
    is-deeply 42.0.round(RatStr.new(42.0, "42.0")), 42.0,
        "Rat with RatStr rounder is Rat";
    is-deeply 42.0.round(<42+0i>), 42e0,
        "Rat with Complex rounder is Num";
    is-deeply 42.0.round(ComplexStr.new(<42+0i>, "42+0i")), 42e0,
        "Rat with ComplexStr rounder is Num";
    is-deeply RatStr.new(42.0, "42.0").round(42), 42,
        "RatStr with Int rounder is Int";
    is-deeply RatStr.new(42.0, "42.0").round(IntStr.new(42, "42")), 42,
        "RatStr with IntStr rounder is Int";
    is-deeply RatStr.new(42.0, "42.0").round(42e0), 42e0,
        "RatStr with Num rounder is Num";
    is-deeply RatStr.new(42.0, "42.0").round(NumStr.new(42e0, "42e0")), 42e0,
        "RatStr with NumStr rounder is Num";
    is-deeply RatStr.new(42.0, "42.0").round(42.0), 42.0,
        "RatStr with Rat rounder is Rat";
    is-deeply RatStr.new(42.0, "42.0").round(RatStr.new(42.0, "42.0")), 42.0,
        "RatStr with RatStr rounder is Rat";
    is-deeply RatStr.new(42.0, "42.0").round(<42+0i>), 42e0,
        "RatStr with Complex rounder is Num";
    is-deeply RatStr.new(42.0, "42.0").round(ComplexStr.new(<42+0i>, "42+0i")), 42e0,
        "RatStr with ComplexStr rounder is Num";
    is-deeply <42+0i>.round(42), <42+0i>,
        "Complex with Int rounder is Complex";
    is-deeply <42+0i>.round(IntStr.new(42, "42")), <42+0i>,
        "Complex with IntStr rounder is Complex";
    is-deeply <42+0i>.round(42e0), <42+0i>,
        "Complex with Num rounder is Complex";
    is-deeply <42+0i>.round(NumStr.new(42e0, "42e0")), <42+0i>,
        "Complex with NumStr rounder is Complex";
    is-deeply <42+0i>.round(42.0), <42+0i>,
        "Complex with Rat rounder is Complex";
    is-deeply <42+0i>.round(RatStr.new(42.0, "42.0")), <42+0i>,
        "Complex with RatStr rounder is Complex";
    is-deeply <42+0i>.round(<42+0i>), <42+0i>,
        "Complex with Complex rounder is Complex";
    is-deeply <42+0i>.round(ComplexStr.new(<42+0i>, "42+0i")), <42+0i>,
        "Complex with ComplexStr rounder is Complex";
    is-deeply ComplexStr.new(<42+0i>, "42+0i").round(42), <42+0i>,
        "ComplexStr with Int rounder is Complex";
    is-deeply ComplexStr.new(<42+0i>, "42+0i").round(IntStr.new(42, "42")), <42+0i>,
        "ComplexStr with IntStr rounder is Complex";
    is-deeply ComplexStr.new(<42+0i>, "42+0i").round(42e0), <42+0i>,
        "ComplexStr with Num rounder is Complex";
    is-deeply ComplexStr.new(<42+0i>, "42+0i").round(NumStr.new(42e0, "42e0")), <42+0i>,
        "ComplexStr with NumStr rounder is Complex";
    is-deeply ComplexStr.new(<42+0i>, "42+0i").round(42.0), <42+0i>,
        "ComplexStr with Rat rounder is Complex";
    is-deeply ComplexStr.new(<42+0i>, "42+0i").round(RatStr.new(42.0, "42.0")), <42+0i>,
        "ComplexStr with RatStr rounder is Complex";
    is-deeply ComplexStr.new(<42+0i>, "42+0i").round(<42+0i>), <42+0i>,
        "ComplexStr with Complex rounder is Complex";
    is-deeply ComplexStr.new(<42+0i>, "42+0i").round(ComplexStr.new(<42+0i>, "42+0i")), <42+0i>,
        "ComplexStr with ComplexStr rounder is Complex";
}


# vim: expandtab shiftwidth=4
