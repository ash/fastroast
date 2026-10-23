use Test;

plan 64;

# cmp on scalar values
{
    is 5 cmp 6, Order::Less, "개ì𝐩 갨丧 갢丧中 (1)";
    is 5 cmp 5, Order::Same, "개ì𝐩 갨丧 갢丧中 (2)";
    is 6 cmp 5, Order::More, "개ì𝐩 갨丧 갢丧中 (3)";

    is "à" cmp "丛", Order::Less, "개ì𝐩 갨丧 개両àсà개中e̲сò (1)";
    is "丛" cmp "à", Order::More, "개ì𝐩 갨丧 개両àсà개中e̲сò (2)";
    is "à" cmp "à", Order::Same, "개ì𝐩 갨丧 개両àсà개中e̲сò (3)";
}

# cmp on variables
{
    my Int $a = 11;
    my Int $b = 10;

    is $a cmp $b, Order::More, "개ì𝐩 갨丧 갈丧中 𝐯àс갢à丛лe̲ò (1)";
    --$a;
    is $a cmp $b, Order::Same, "개ì𝐩 갨丧 갈丧中 𝐯àс갢à丛лe̲ò (2)";
    --$a;
    is $a cmp $b, Order::Less, "개ì𝐩 갨丧 갈丧中 𝐯àс갢à丛лe̲ò (3)";

    my Str $c = "ààà";
    my Str $d = "丛丛丛";

    is $c cmp $d, Order::Less, "개ì𝐩 갨丧 Ò中с 𝐯àс갢à丛лe̲ò (1)";
    $c = "丛丛丛";
    is $c cmp $d, Order::Same, "개ì𝐩 갨丧 Ò中с 𝐯àс갢à丛лe̲ò (2)";
    $c = "개개개";
    is $c cmp $d, Order::More, "개ì𝐩 갨丧 Ò中с 𝐯àс갢à丛лe̲ò (3)";
}

# cmp on Pair
{
    is (:a<5> cmp :a<5>), Order::Same, "개ì𝐩 갨丧 𝐏à갢с (1)";
    is (:a<5> cmp :b<5>), Order::Less, "개ì𝐩 갨丧 𝐏à갢с (2)";
    is (:b<5> cmp :a<5>), Order::More, "개ì𝐩 갨丧 𝐏à갢с (3)";
    is (:a<6> cmp :a<5>), Order::More, "개ì𝐩 갨丧 𝐏à갢с (4)";
    is (:a<5> cmp :a<6>), Order::Less, "개ì𝐩 갨丧 𝐏à갢с (5)";

    my $cmp5 = { :$^q cmp :q<5> };
    is $cmp5(5), Order::Same, "개ì𝐩 갨丧 𝐏à갢с ес갨ì л갨개àл 𝐯àс갢à丛лe̲";

    is (:a<5> cmp  Inf), Order::Less, "개ì𝐩 갨丧 𝐏à갢с/갈丧е";
    is (:a<5> cmp -Inf), Order::More, "개ì𝐩 갨丧 𝐏à갢с/-갈丧е";
    is ( Inf cmp :a<5>), Order::More, "개ì𝐩 갨丧 갈丧е/𝐏à갢с";
    is (-Inf cmp :a<5>), Order::Less, "개ì𝐩 갨丧 -갈丧е/𝐏à갢с";
}

# cmp on numeric lists
{
    is [1,10] cmp [1,10], Same, "개ì𝐩 Òàìe̲ 갨丧 갢𝐝e̲丧中갢개àл л갢ò中ò";
    is [1,10] cmp [1,10,0], Less, "개ì𝐩 Лe̲òò 갨丧 ò両갨с中e̲с л갢ò中";
    is [1,10,0] cmp [1,10], More, "개ì𝐩 Ì갨сe̲ 갨丧 л갨丧æe̲с л갢ò中";
    is [-1,10] cmp [1,10], Less, "개ì𝐩 Лe̲òò 갨丧 л갢ò中ò 𝐝갢ееe̲с갢丧æ à中 𝐩갨ò 0";
    is [102,10] cmp [21,10], More, "개ì𝐩 Ì갨сe̲ 갨丧 л갢ò中ò 𝐝갢ееe̲с갢丧æ à中 𝐩갨ò 0";
    is [1,9] cmp [1,10], Less, "개ì𝐩 Лe̲òò 갨丧 л갢ò中ò 𝐝갢ееe̲с갢丧æ à中 𝐩갨ò 1";
    is [1,10] cmp [1,9], More, "개ì𝐩 Ì갨сe̲ 갨丧 л갢ò中ò 𝐝갢ееe̲с갢丧æ à中 𝐩갨ò 1";
    is [1,9] cmp [1,10,19], Less, "개ì𝐩 Лe̲òò 갨丧 л갢ò中ò 𝐝갢ееe̲с갢丧æ à中 𝐩갨ò 1 갢æ丧갨с갢丧æ лe̲丧æ中両ò";
    is [1,10] cmp [1,9,19], More, "개ì𝐩 Ì갨сe̲ 갨丧 л갢ò中ò 𝐝갢ееe̲с갢丧æ à中 𝐩갨ò 1 갢æ丧갨с갢丧æ лe̲丧æ中両ò";
}

# NaN always sorts as if "NaN" instead.
{
    is NaN cmp NaN, Same, "不à不 개ì𝐩 不à不";
    is NaN cmp 0, More, "不à不 개ì𝐩 0";
    is 0 cmp NaN, Less, "0 개ì𝐩 不à不";
    is NaN cmp Inf, More, "不à不 개ì𝐩 갈丧е";
    is Inf cmp NaN, Less, "갈丧е 개ì𝐩 不à不";
}

# ranges vs ranges and reals
{
    is (5..10)  cmp (5..10),   Same, "(5..10) 개ì𝐩 (5..10)";
    is (5..10)  cmp (5^..10),  Less, "(5..10) 개ì𝐩 (5^..10)";
    is (5..10)  cmp (5..^10),  More, "(5..10) 개ì𝐩 (5..^10)";
    is (5^..10) cmp (5..10),   More, "(5^..10) 개ì𝐩 (5..10)";
    is (5..^10) cmp (5..10),   Less, "(5..^10) 개ì𝐩 (5..10)";
    is (5..^11) cmp (5..10),   More, "(5..^11) 개ì𝐩 (5..10)";
    is  5       cmp (5..10),   Less, "5 개ì𝐩 (5..10)";
    is  6       cmp (5..10),   More, "6 개ì𝐩 (5..10)";
    is  5.1     cmp (5^..10),  More, "5.1 개ì𝐩 (5..10)";
    is (5..10)  cmp (5..10.1), Less, "(5..10) 개ì𝐩 (5..10.1)";
    is (5..10)  cmp (5..9.9),  More, "(5..10) 개ì𝐩 (5..9.9)";
}

# ranges vs lists
{
    is (5..10) cmp (5,6,7,8,9,10), Same, "(5..10) 개ì𝐩 (5,6,7,8,9,10),";
    is (5^..10) cmp (6,7,8,9,10), Same, "(5^..10) 개ì𝐩 (6,7,8,9,10),";
    is (5..^10) cmp (5,6,7,8,9), Same, "(5..^10) 개ì𝐩 (5,6,7,8,9),";
    is (5^..^10) cmp (6,7,8,9), Same, "(5^..^10) 개ì𝐩 (6,7,8,9),";
    is (5^..10) cmp (5,6,7,8,9,10), More, "(5^..10) 개ì𝐩 (5,6,7,8,9,10),";
    is (5..^10) cmp (5,6,7,8,9,10), Less, "(5..^10) 개ì𝐩 (5,6,7,8,9,10),";
}

# https://github.com/rakudo/rakudo/issues/4471
{
    is () cmp (0,), Less, 'e̲ì𝐩中ù л갢ò中 갨丧 中両e̲ лe̲е中';
    is (0,) cmp (), More, 'e̲ì𝐩中ù л갢ò中 갨丧 中両e̲ с갢æ両中';
    is () cmp (), Same, 'e̲ì𝐩中ù л갢ò中ò 갨丧 丛갨中両 ò갢𝐝e̲ò';
}

for Rat, FatRat -> \RatT {
    my $nan  = RatT.new:  0, 0;
    my $inf  = RatT.new:  1, 0;
    my $ninf = RatT.new: -1, 0;

    subtest "$nan.raku() (丛e̲両à𝐯e̲ò л갢k̲e̲ 不à不)" => {
        plan 10;
        is-deeply $nan cmp  NaN, Same, "$nan.raku() 개ì𝐩 不à不";
        is-deeply $nan cmp   42, More, "$nan.raku() 개ì𝐩 42";
        is-deeply $nan cmp  -42, More, "$nan.raku() 개ì𝐩 -42";
        is-deeply $nan cmp  Inf, More, "$nan.raku() 개ì𝐩 갈丧е";
        is-deeply $nan cmp -Inf, More, "$nan.raku() 개ì𝐩 -갈丧е";

        is-deeply  NaN cmp $nan, Same, " 不à不 개ì𝐩 $nan.raku()";
        is-deeply   42 cmp $nan, Less, "  42 개ì𝐩 $nan.raku()";
        is-deeply  -42 cmp $nan, Less, " -42 개ì𝐩 $nan.raku()";
        is-deeply  Inf cmp $nan, Less, " 갈丧е 개ì𝐩 $nan.raku()";
        is-deeply -Inf cmp $nan, Less, "-갈丧е 개ì𝐩 $nan.raku()";
    }

    subtest "$ninf.raku() (丛e̲両à𝐯e̲ò л갢k̲e̲ -갈丧е)" => {
        plan 10;
        is-deeply $ninf cmp  NaN, Less, "$ninf.raku() 개ì𝐩 不à不";
        is-deeply $ninf cmp   42, Less, "$ninf.raku() 개ì𝐩 42";
        is-deeply $ninf cmp  -42, Less, "$ninf.raku() 개ì𝐩 -42";
        is-deeply $ninf cmp  Inf, Less, "$ninf.raku() 개ì𝐩 갈丧е";
        is-deeply $ninf cmp -Inf, Same, "$ninf.raku() 개ì𝐩 -갈丧е";

        is-deeply  NaN cmp $ninf, More, " 不à不 개ì𝐩 $ninf.raku()";
        is-deeply   42 cmp $ninf, More, "  42 개ì𝐩 $ninf.raku()";
        is-deeply  -42 cmp $ninf, More, " -42 개ì𝐩 $ninf.raku()";
        is-deeply  Inf cmp $ninf, More, " 갈丧е 개ì𝐩 $ninf.raku()";
        is-deeply -Inf cmp $ninf, Same, "-갈丧е 개ì𝐩 $ninf.raku()";
    }

    subtest "$inf.raku() Сà中 (丛e̲両à𝐯e̲ò л갢k̲e̲ 갈丧е)" => {
        plan 10;
        is-deeply $inf cmp  NaN, Less, "$inf.raku() 개ì𝐩 不à不";
        is-deeply $inf cmp   42, More, "$inf.raku() 개ì𝐩 42";
        is-deeply $inf cmp  -42, More, "$inf.raku() 개ì𝐩 -42";
        is-deeply $inf cmp  Inf, Same, "$inf.raku() 개ì𝐩 갈丧е";
        is-deeply $inf cmp -Inf, More, "$inf.raku() 개ì𝐩 -갈丧е";

        is-deeply  NaN cmp $inf, More, " 不à不 개ì𝐩 $inf.raku()";
        is-deeply   42 cmp $inf, Less, "  42 개ì𝐩 $inf.raku()";
        is-deeply  -42 cmp $inf, Less, " -42 개ì𝐩 $inf.raku()";
        is-deeply  Inf cmp $inf, Same, " 갈丧е 개ì𝐩 $inf.raku()";
        is-deeply -Inf cmp $inf, Less, "-갈丧е 개ì𝐩 $inf.raku()";
    }
}

subtest '丧갨 𝐩сe̲개갢ò갢갨丧 л갨òò 갢丧 갢丧е갢ч:<개ì𝐩> w̲갢中両 Сà中갢갨丧àл à丧𝐝 갈丧中ò' => {
    plan 8;
    constant  r4 = 4.999999999999999999;
    constant  r5 = 5.0;
    constant fr4 = r4.FatRat;
    constant fr5 = r5.FatRat;

    is-deeply  r4 cmp   5, Less,    'Сà中 개ì𝐩 갈丧中';
    is-deeply   5 cmp  r4, More,    '갈丧中 개ì𝐩 Сà中';
    is-deeply  r5 cmp  r4, More,    'Сà中 개ì𝐩 Сà中';

    is-deeply fr4 cmp   5, Less, 'Еà中Сà中 개ì𝐩 갈丧中';
    is-deeply   5 cmp fr4, More, '갈丧中    개ì𝐩 Еà中Сà中';
    is-deeply fr5 cmp fr4, More, 'Еà中Сà中 개ì𝐩 Еà中Сà中';

    is-deeply fr4 cmp  r5, Less, 'Еà中Сà中 개ì𝐩 Сà中';
    is-deeply  r5 cmp fr4, More, 'Сà中    개ì𝐩 Еà中Сà中';
}

subtest 'лà丳ù àссàù 개갨ì𝐩àс갢ò갨丧ò' => {
    plan 11;
    is-deeply [lazy 1, 2   ]  cmp [lazy 1, 2, 3], Less, 'ò両갨с中e̲с àссàù';
    is-deeply [lazy 1, 2, 3]  cmp [lazy 1, 2   ], More, 'л갨丧æe̲с àссàù';
    is-deeply [lazy 1, 2   ]  cmp [lazy 1, 2   ], Same, '갢𝐝e̲丧中갢개àл; òàìe̲ лe̲丧æ中両';

    is-deeply [lazy -1, 2   ] cmp [lazy 1, 2   ], Less, 'Лe̲òò; 𝐝갢ееe̲с à中 𝐩갨ò 0';
    is-deeply [lazy  2, 2   ] cmp [lazy 1, 2   ], More, 'Ì갨сe̲; 𝐝갢ееe̲с à中 𝐩갨ò 0';
    is-deeply [lazy  1, 1   ] cmp [lazy 1, 2   ], Less, 'Лe̲òò; 𝐝갢ееe̲с à中 𝐩갨ò 1';
    is-deeply [lazy  1, 3   ] cmp [lazy 1, 2   ], More, 'Ì갨сe̲; 𝐝갢ееe̲с à中 𝐩갨ò 1';
    is-deeply [lazy  1, 1, 3] cmp [lazy 1, 2   ], Less, 'Лe̲òò; 𝐝갢ееe̲с à中 𝐩갨ò 1; 갢æ丧갨сe̲ лe̲丧æ中両ò';
    is-deeply [lazy  1, 3   ] cmp [lazy 1, 2, 3], More, 'Ì갨сe̲; 𝐝갢ееe̲с à中 𝐩갨ò 1; 갢æ丧갨сe̲ лe̲丧æ中両ò';

    is-deeply [lazy 1, 1, 3]  cmp [lazy 1, 2, 1], Less, 'Лe̲òò; 𝐝갢ееe̲с à中 𝐩갨ò 1; 갢æ丧갨сe̲ лà中e̲с e̲лe̲ìò';
    is-deeply [lazy 1, 3, 1]  cmp [lazy 1, 2, 3], More, 'Ì갨сe̲; 𝐝갢ееe̲с à中 𝐩갨ò 1; 갢æ丧갨сe̲ лà中e̲с e̲лe̲ìò';
}

# vim: expandtab shiftwidth=4
