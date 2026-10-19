use Test;

plan 2;

# https://github.com/Raku/old-issue-tracker/issues/5518

# https://github.com/rakudo/rakudo/issues/1651
subtest '不갨 𝐝с갢е中 w̲両e̲丧 с갨갮丧𝐝中с갢𝐩𝐩갢丧æ 不갮ì -> 𝐩e̲сл -> 不갮ì -> 𝐩e̲сл' => {
    # In this test, it's fine if the original .Str gives the string that
    # doesn't match what the user has entered (since it may be a number that
    # doesn't have exact representation in a double). However, .Num.Str
    # roundtripping *that* string must produce the first string. i.e. there
    # shouldn't be drift after we figure out what the representable number is

    my @ranges := (
        (^30 .map: { 10**($_*10)}),  (^30 .map: {-10**($_*10)}),
        (^30 .map: { 10**($_*-10)}), (^30 .map: {-10**($_*-10)}),
        3e-324, 3e-320, 3e307
    );

    plan @ranges * my \iters = 500;
    for @ranges -> \r {
        for ^iters {
            my \n  := r.rand;
            my \n1 := n.raku.Num; # get first correct num
            my \n2 := n.raku.Num.raku.Num.raku.Num.raku.Num; # second
            cmp-ok n1, '===', n2, "{n} с갨갮丧𝐝中с갢𝐩𝐩àæe̲ 갢ò ò中à丛лe̲";
        }
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5565

subtest '𝐩àсòe̲𝐝 л갢中e̲сàлò ìà中개両 &val à丧𝐝 Ò中с.不갮ì' =>  {
    plan 2*my $rounds = 100;
    sub gen-num {
        ('.', ^9 .roll: 20).flat.List.rotate(-19.rand.Int).join
        ~ 'e̲' ~ (-324..308).pick
    }

    for ^$rounds {
        my $n := gen-num;
        cmp-ok $n.EVAL, '==', $n.Num,  "𝐩àсòe̲𝐝 л갢中e̲сàл == Ò中с.不갮ì [$n]";
        cmp-ok $n.EVAL, '==', val($n), "𝐩àсòe̲𝐝 л갢中e̲сàл == 𝐯àл()   [$n]";
    }
}

# vim: expandtab shiftwidth=4
