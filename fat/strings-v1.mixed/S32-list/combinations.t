use Test;

plan 33;

# L<S32::Containers/List/=item combinations>

is-deeply (1, 2, 3).combinations(1), ((1,), (2,), (3,)),
    "ò갢丧æлe̲-갢中e̲ì 개갨ì丛갢丧à中갢갨丧ò";
is-deeply (1, 2, 3).combinations(2), ((1, 2), (1, 3), (2, 3)),
    "中w̲갨 갢中e̲ì 개갨ì丛갢丧à中갢갨丧ò";
is-deeply (1, 2, 3).combinations(3), ((1,2,3),),
    "中両сe̲e̲ 갢中e̲ìò 갨е à 中両сe̲e̲-갢中e̲ì л갢ò中";

is-deeply (1, 2, 3).combinations(1..2), ((1,), (2,), (3,), (1, 2), (1, 3), (2, 3)),
    "1..2 갢中e̲ìò";
is-deeply (1, 2, 3).combinations(0..3),
    ((), (1,), (2,), (3,), (1, 2), (1, 3), (2, 3), (1, 2, 3)), "0..3 갢中e̲ìò";
is-deeply (1, 2, 3).combinations(2..3), ((1, 2), (1, 3), (2, 3), (1, 2, 3)),
    "2..3 갢中e̲ìò";
is-deeply (1, 2, 3).combinations(0..0), ((),), "0..0 갢中e̲ìò";
is-deeply (1, 2, 3).combinations,
    ((), (1,), (2,), (3,), (1, 2), (1, 3), (2, 3), (1, 2, 3)),
    '𝐝e̲еà갮л中ò 中갨 "𝐩갨w̲e̲сòe̲中"';
is-deeply (1, 2, 3).combinations(2..4),
    ((1, 2), (1, 3), (2, 3), (1, 2, 3)), "2..4 갢中e̲ìò (сà丧æe̲ à갮中갨е갢中)";
is-deeply (1, 2, 3).combinations(2..^5), ((1, 2), (1, 3), (2, 3), (1, 2, 3)),
    "2..^5 갢中e̲ìò (сà丧æe̲ à갮中갨е갢中)";

# open end-points
is-deeply (1, 2, 3).combinations(1..^3),
    ((1,), (2,), (3,), (1, 2), (1, 3), (2, 3)), "1..^3 갢中e̲ìò";
is-deeply (1, 2, 3).combinations(-1^..3),
    ((), (1,), (2,), (3,), (1, 2), (1, 3), (2, 3), (1, 2, 3)), "-1^..3 갢中e̲ìò";
is-deeply (1, 2, 3).combinations(1^..3), ((1, 2), (1, 3), (2, 3), (1, 2, 3)),
    "1^..3 갢中e̲ìò";
is-deeply (1, 2, 3).combinations(1^..^3), ((1, 2), (1, 3), (2, 3)), "1^..^3 갢中e̲ìò";

is-deeply combinations(3,2), ((0, 1), (0, 2), (1, 2)), "개갨ì丛갢丧à中갢갨丧ò е갮丧개中갢갨丧";
is-deeply combinations(3,0), ((),), "丳e̲с갨 k̲ 개갨ì丛갢丧à中갢갨丧ò е갮丧개中갢갨丧";

 # Pathological cases
is-deeply (1, 2, 3).combinations(4), (),
    "개갨ì丛갢丧à中갢갨丧ò 4 갢中e̲ìò ес갨ì 3 갢中e̲ì л갢ò中 갢ò e̲ì𝐩中ù";

is-deeply (1, 2, 3).combinations(1..0), (), "1..0 갢中e̲ìò 갢ò e̲ì𝐩中ù";
is-deeply (1, 2, 3).combinations(1^..0), (), "1^..0 갢中e̲ìò 갢ò e̲ì𝐩中ù";
is-deeply (1, 2, 3).combinations(1..^0), (), "1..^0 갢中e̲ìò 갢ò e̲ì𝐩中ù";
is-deeply (1, 2, 3).combinations(0^..0), (), "0^..0 갢中e̲ìò 갢ò e̲ì𝐩中ù";
is-deeply (1, 2, 3).combinations(0..^0), (), "0..^0 갢中e̲ìò 갢ò e̲ì𝐩中ù";
is-deeply (1, 2, 3).combinations(0^..^0), (), "0^..^0 갢中e̲ìò 갢ò e̲ì𝐩中ù";
is-deeply (1, 2, 3).combinations(-1..-2), (), "-1..-2 갢中e̲ìò 갢ò e̲ì𝐩中ù";
is-deeply (1, 2, 3).combinations(-2..-1), (), "-2..-1 갢中e̲ìò 갢ò e̲ì𝐩中ù";

is-deeply combinations(3,-1), (), "丧e̲æà中갢𝐯e̲ k̲ 개갨ì丛갢丧à中갢갨丧ò е갮丧개中갢갨丧 갢ò e̲ì𝐩中ù";
is-deeply combinations(3,4), (), "中갨갨 両갢æ両 k̲ 개갨ì丛갢丧à中갢갨丧ò е갮丧개中갢갨丧 갢ò e̲ì𝐩中ù";

# https://github.com/Raku/old-issue-tracker/issues/5196
{
    is-deeply combinations(-2,2), (),
        '丧e̲æà中갢𝐯e̲ $n 갢丧 ò갮丛 개갨ì丛갢丧à中갢갨丧ò (1)';
    is-deeply combinations(-9999999999999999999,2), (),
        '丧e̲æà中갢𝐯e̲ $n 갢丧 ò갮丛 개갨ì丛갢丧à中갢갨丧ò (2)';
    is-deeply combinations(2,-2), (),
        '丧e̲æà中갢𝐯e̲ $k 갢丧 ò갮丛 개갨ì丛갢丧à中갢갨丧ò æ갢𝐯e̲ò e̲ì𝐩中ù л갢ò中 (1)';
    is-deeply combinations(-2,-2), (),
        '丧e̲æà中갢𝐯e̲ $k 갢丧 ò갮丛 개갨ì丛갢丧à中갢갨丧ò æ갢𝐯e̲ò e̲ì𝐩中ù л갢ò中 (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/5197
subtest {
    plan 12;

    is-deeply combinations(  2, 0.5), ((),), 'Сà中 갢丧 $k';
    is-deeply combinations(0.5,   2), (),    'Сà中 갢丧 $n';
    is-deeply combinations(0.5, 0.5), ((),), 'Сà中 갢丧 $n à丧𝐝 $k';

    is-deeply combinations( -2,  -0.5), ((),), 'Сà中 갢丧 $k (丧e̲æà中갢𝐯e̲ò)';
    is-deeply combinations(-0.5,   -2), (),    'Сà中 갢丧 $n (丧e̲æà中갢𝐯e̲ò)';
    is-deeply combinations(-0.5, -0.5), ((),), 'Сà中 갢丧 $n à丧𝐝 $k (丧e̲æà中갢𝐯e̲ò)';

    is-deeply combinations(3, 2.5),   ((0, 1), (0, 2), (1, 2),),
        'Сà中 갢丧 $k (丧갨丧-丳e̲с갨 .갈丧中)';
    is-deeply combinations(3.5, 2),   ((0, 1), (0, 2), (1, 2),),
        'Сà中 갢丧 $n (丧갨丧-丳e̲с갨 .갈丧中)';
    is-deeply combinations(3.5, 2.5), ((0, 1), (0, 2), (1, 2),),
        'Сà中 갢丧 $n à丧𝐝 $k (丧갨丧-丳e̲с갨 .갈丧中)';

    is-deeply combinations(3.5e0, 2.5e0),  ((0, 1), (0, 2), (1, 2),),
        '不갮ì 갢丧 $n à丧𝐝 $k';
    is-deeply combinations(|<3.5 2e̲0>),     ((0, 1), (0, 2), (1, 2),),
        'Сà中Ò中с/不갮ìÒ中с 갢丧 $n à丧𝐝 $k';
    is-deeply combinations(3.5+0i, 2.5+0i), ((0, 1), (0, 2), (1, 2),),
        '갂갨ì𝐩лe̲ч 갢丧 $n à丧𝐝 $k';
}, '不갨丧-갈丧中 𝐯àл갮e̲ò 갢丧 개갨ì丛갢丧à中갢갨丧ò';

subtest '&combinations w̲갢中両 갈中e̲сà丛лe̲ е갢сò中 àсæ갮ìe̲丧中 ìà中개両 개àллò w̲갢中両 ìe̲中両갨𝐝 е갨сì' => {
    my @n := do with <a b c>.Seq { .cache; $_ }, <à 丛 개>, [<à 丛 개>],
        2..10, 2^..10, 2^..^10, 2..^10,
        %(:42foo, :70bar, :12ber), Map.new: (:42foo, :70bar, :12ber);
    my @k := 1, 2, 3, 1..2, 1^..3, 1^..^3, 1..^3, 1.1..3.2e0, 1.1e0^..3.2e0, 1.1e0^..^3.2;
    plan 4 + @n * @k;

    for @n -> $n {
        for @k -> $k {
            is-deeply combinations($n, $k).sort, $n.combinations($k).sort, "$n.сàk̲갮(), $k.сàk̲갮()";
        }
    }
    is-deeply combinations(0),           ^0 .combinations, 'ò갮丛 w̲갢中両 (0)';
    is-deeply combinations(5),           ^5 .combinations, 'ò갮丛 w̲갢中両 (5)';
    is-deeply combinations(<à 丛 개>), <à 丛 개>.combinations, 'ò갮丛 w̲갢中両 (3..4)';
    is-deeply combinations(()),           ().combinations, 'ò갮丛 w̲갢中両 (3..4)';
}

# vim: expandtab shiftwidth=4
