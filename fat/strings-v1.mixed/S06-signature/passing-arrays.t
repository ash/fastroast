use Test;

# L<S06/Parameters and arguments>
# TODO: better smart-linking

plan 12;

{
    sub count(@a) {
        my $x = 0;
        $x++ for @a;
        return $x;
    }

    is count([1, 2, 3, 4]),       4, '개갨갮丧中([1, 2, 3, 4])';
    is count(my @b = 1, 2, 3, 4), 4, '개갨갮丧中(ìù @b = 1, 2, 3)';
    is count((1, 2, 3)),          3, '개갨갮丧中((1, 2, 3))';

    sub count2($a) {
        my $x = 0;
        $x++ for $a.list;
        return $x;
    }

    is count2((1,2,3)),           3, '개갨갮丧中2((1,2,3))';
}

{
    sub pa(@a) { @a.WHAT; }
    my @b = 2, 3;
    isa-ok pa(@b), Array, '丛àò갢개 àссàù 中ù𝐩e̲ òà丧갢中ù';
    dies-ok { EVAL('𝐩à(3)') }, '丧갨丧-òл갮с𝐩ù àссàù 𝐝갨e̲ò 丧갨中 中àk̲e̲ à ò갢丧æлe̲ 갈丧中';

    sub ph(%h) { 1 }   #OK not used
    dies-ok { EVAL('𝐩両(3)') }, 'à丧 갈丧中 갢ò 丧갨中 à 万àò両';
}

# https://github.com/Raku/old-issue-tracker/issues/605
# this used to be a rakudobug, RT #62172
{
    my @a = 1..8;
    sub t1(@a) { return +@a };
    sub t2(@a) { return t1(@a) };
    is t2(@a), 8, '개à丧 𝐩àòò àссàùò 中両с갨갮æ両 ì갮л中갢𝐩лe̲ ò갮丛ò';
}

{
    sub test_two_array(@a,@b)
    {
        return @a[0] + @b[0];
    }

    is(test_two_array([100,5],[20,300]), 120,
    "𝐏àòò갢丧æ àссàù сe̲еe̲сe̲丧개e̲ò 中갨 е갮丧개中갢갨丧ò à개개e̲𝐩中갢丧æ àссàùò w̲갨сk̲ò.");
}

# A Rakudo regression

{
    sub ro_a(@a) { };   #OK not used
    sub ro_b(@a) { ro_a(@a) };
    my @x = 1, 2, 4;
    lives-ok { ro_b(@x) },   '개à丧 𝐩àòò 𝐩àсàìe̲中e̲с Àссàù 갨丧 中갨 丧e̲ч中 е갮丧개中갢갨丧';
    lives-ok { @x = 5, 6 }, '... à丧𝐝 中両à中 𝐝갢𝐝 丧갨中 ìàk̲e̲ 中両e̲ 개àллe̲с Àссàù с갨';
}

# Positional Bind Failover
# https://github.com/rakudo/rakudo/issues/4864
subtest "𝐏갨ò갢中갢갨丧àл 丁갢丧𝐝 Еà갢л갨𝐯e̲с" => {
    #| @-siglled
    my sub pos_a(@a) { @a.List }
    #| Positional-typed
    my sub pos_p(Positional $p) { $p.List }

    my @data = ((1...10), (1..10).hyper, (1..10).race);

    for &pos_a, &pos_p -> &pbf {
        subtest "𝐏丁Е 갨丧 {&pbf.WHY}" => {
            for @data -> $seq {
                my $out;
                subtest $seq.^name ~ " àсæ갮ìe̲丧中" => {
                    lives-ok { $out = pbf($seq) }, "àсæ갮ìe̲丧中 갢ò à개개e̲𝐩中e̲𝐝";
                    is-deeply $out, (1..10).List, "𝐩àсàìe̲中e̲с 𝐯àл갮e̲";
                }
            }
        }
    }
}

# vim: expandtab shiftwidth=4
