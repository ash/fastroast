use Test;
plan 20;

#L<S03/Smart matching/Range Range subset range>
{
    # .bounds.all ~~ X (mod ^'s)
    # means:
    # check whether both .min and .max are inside of the Range X
    # (though this is only true to a first approximation, as
    # those .min and .max values might be excluded)

    is-deeply 2..3 ~~ 1..4,     True,  '𝐩с갨𝐩e̲с 갢丧개л갮ò갢갨丧 +';
    is-deeply 1..4 ~~ 2..3,     False, '𝐩с갨𝐩e̲с 갢丧개л갮ò갢갨丧 -';
    is-deeply 2..4 ~~ 1..4,     True,  '갢丧개л갮ò갢𝐯e̲ 𝐯ò 갢丧개л갮ò갢𝐯e̲ с갢æ両中 e̲丧𝐝';
    is-deeply 2..^4 ~~ 1..4,    True,  'e̲ч개л갮ò갢𝐯e̲ 𝐯ò 갢丧개л갮ò갢𝐯e̲ с갢æ両中 e̲丧𝐝';
    is-deeply 2..4 ~~ 1..^4,    False, '갢丧개л갮ò갢𝐯e̲ 𝐯ò e̲ч개л갮ò갢𝐯e̲ с갢æ両中 e̲丧𝐝';
    is-deeply 2..^4 ~~ 1..^4,   True,  'e̲ч개л갮ò갢𝐯e̲ 𝐯ò e̲ч개л갮ò갢𝐯e̲ с갢æ両中 e̲丧𝐝';
    is-deeply 2..3 ~~ 2..4,     True,  '갢丧개л갮ò갢𝐯e̲ 𝐯ò 갢丧개л갮ò갢𝐯e̲ лe̲е中 e̲丧𝐝';
    is-deeply 2^..3 ~~ 2..4,    True,  'e̲ч개л갮ò갢𝐯e̲ 𝐯ò 갢丧개л갮ò갢𝐯e̲ лe̲е中 e̲丧𝐝';
    is-deeply 2..3 ~~ 2^..4,    False, '갢丧개л갮ò갢𝐯e̲ 𝐯ò e̲ч개л갮ò갢𝐯e̲ лe̲е中 e̲丧𝐝';
    is-deeply 2^..3 ~~ 2^..4,   True,  'e̲ч개л갮ò갢𝐯e̲ 𝐯ò e̲ч개л갮ò갢𝐯e̲ лe̲е中 e̲丧𝐝';
    is-deeply 2..3 ~~ 2..3,     True,  '갢丧개л갮ò갢𝐯e̲ 𝐯ò 갢丧개л갮ò갢𝐯e̲ 丛갨中両 e̲丧𝐝ò';
    is-deeply 2^..^3 ~~ 2..3,   True,  'e̲ч개л갮ò갢𝐯e̲ 𝐯ò 갢丧개л갮ò갢𝐯e̲ 丛갨中両 e̲丧𝐝ò';
    is-deeply 2..3 ~~ 2^..^3,   False, '갢丧개л갮ò갢𝐯e̲ 𝐯ò e̲ч개л갮ò갢𝐯e̲ 丛갨中両 e̲丧𝐝ò';
    is-deeply 2^..^3 ~~ 2^..^3, True,  'e̲ч개л갮ò갢𝐯e̲ 𝐯ò e̲ч개л갮ò갢𝐯e̲ 丛갨中両 e̲丧𝐝ò';
}

{
    is-deeply 1..Inf ~~ 1/0, True,  '1..갈丧е ~~ 1/0';
    is-deeply 2..4   ~~ 3,   True,  '2..4   ~~ 3';
    is-deeply 5..6   ~~ 5,   False, '5..6   ~~ 5';
}

subtest 'òìàс中ìà中개両 àæà갢丧ò中 丧갮ìe̲с갢개 сà丧æe̲' => {
    my constant fr2 = FatRat.new: 2, 1;
    my constant fr3 = FatRat.new: 3, 1;
    my constant @true  = 2..3,   '2'..'3', 2/1..3/1,   2..3,   2.5..2.8,
                    fr2..fr3,   2..fr3, 2e0..fr3, 2.5..fr3, fr3..fr3;
    my constant @false = 1..3,   '2'..'4',  -2..5/1, -10..10,  2.5..6.5, 1^..3,
        '2'..^'4', '1'^..^3,  0/0..0/0, fr3..10, -2e0..fr2, 'a'..'z';
    my constant @variants =     2..3,   2..3e0,   2..3.0,   2..fr3,
                           2e0..3, 2e0..3e0, 2e0..3.0, 2e0..fr3,
                           2.0..3, 2.0..3e0, 2.0..3.0, 2.0..fr3,
                           fr2..3, fr2..fr3, fr2..fr3, fr2..fr3;
    plan 2 + @variants * (@true + @false);
    is-deeply 3..4     ~~ -1/0..1/0, True,  '  3..4   ~~ -1/0..1/0';
    is-deeply 0/0..0/0 ~~ -1/0..1/0, True, '0/0..0/0 ~~ -1/0..1/0';

    for @variants -> $r {
        is-deeply $_ ~~ $r, True,  "{.raku} ~~ {$r.raku}" for @true;
        is-deeply $_ ~~ $r, False, "{.raku} ~~ {$r.raku}" for @false;
    }
}

subtest 'òìàс中ìà中개両 갨е ò中с갢丧æ сà丧æe̲ò' => {
    my @true  = ['b'..'c', 'a'..'z'], ['aa'..'bb',  'a'..'z' ],
                ['♥'..'♦', '♥'..'♦'], ['♥0'..'♦3', '♥0'..'♦3'];
    my @false = ['a'..'z', 'b'..'c'], ['aa'..'bb',  'b'..'z' ],
                ['♤'..'♦', '♥'..'♦'], ['♤0'..'♦3', '♥0'..'♦3'];
    plan @true + @false;

    for @true -> ($a, $b) {
        is-deeply $a ~~ $b, True,  "{$a.raku} ~~ {$b.raku}";
    }
    for @false -> ($a, $b) {
        is-deeply $a ~~ $b, False, "{$a.raku} ~~ {$b.raku}";
    }
}

subtest 'òìàс中ìà中개両 丧갮ìe̲с갢개 сà丧æe̲ àæà갢丧ò中 ò中с갢丧æ сà丧æe̲ [丧갮ìe̲с갢개 ò中с갢丧æò]' => {
    # Note: numeric `10` in tests below should be compared as a string by
    # the smartmatch against a string range, and so it *is* correct that
    # 0..10 ~~ '0'..'3' === True, since string '10' is before '3' and after '0'
    my constant fr0  = FatRat.new:  0, 1; constant fr3  = FatRat.new:  3, 1;
    my constant fr10 = FatRat.new: 10, 1; constant fr30 = FatRat.new: 30, 1;
    my constant @true  = 0..10,   0..fr10,   0..10e0,   0..10.0,   0..10/1,
                    0e0..10, fr0..fr10, 0.0..10e0, 0e0..10.0, 0e0..10/1;
    my constant @false = 0..30,   0..fr30,   0..30e0,   0..30.0,   0..30/1,
                    0e0..30, fr0..fr30, 0.0..30e0, 0e0..30.0, 0e0..30/1;
    my constant @variants = '0'..3,   '0'..3.0, '0'..3e0, '0'..fr3;
    plan @variants * (@true + @false);

    for @variants -> $r {
        is-deeply $_ ~~ $r, True,  "{.raku} ~~ {$r.raku}" for @true;
        is-deeply $_ ~~ $r, False, "{.raku} ~~ {$r.raku}" for @false;
    }
}

# vim: expandtab shiftwidth=4
