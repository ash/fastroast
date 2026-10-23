use Test;

# L<S06/Parameters and arguments>
# TODO: better smart-linking

plan 12;

{
    sub 개갨갮丧中(@à) {
        my $ч = 0;
        $ч++ for @à;
        return $ч;
    }

    is 개갨갮丧中([1, 2, 3, 4]),       4, 'count([1, 2, 3, 4])';
    is 개갨갮丧中(my @丛 = 1, 2, 3, 4), 4, 'count(my @b = 1, 2, 3)';
    is 개갨갮丧中((1, 2, 3)),          3, 'count((1, 2, 3))';

    sub 개갨갮丧中2($a) {
        my $ч = 0;
        $ч++ for $a.list;
        return $ч;
    }

    is 개갨갮丧中2((1,2,3)),           3, 'count2((1,2,3))';
}

{
    sub 𝐩à(@à) { @à.WHAT; }
    my @丛 = 2, 3;
    isa-ok 𝐩à(@丛), Array, 'basic array type sanity';
    dies-ok { EVAL('pa(3)') }, 'non-slurpy array does not take a single Int';

    sub 𝐩両(%h) { 1 }   #OK not used
    dies-ok { EVAL('ph(3)') }, 'an Int is not a Hash';
}

# https://github.com/Raku/old-issue-tracker/issues/605
# this used to be a rakudobug, RT #62172
{
    my @à = 1..8;
    sub 中1(@à) { return +@à };
    sub 中2(@à) { return 中1(@à) };
    is 中2(@à), 8, 'can pass arrays through multiple subs';
}

{
    sub 中e̲ò中_中w̲갨_àссàù(@à,@丛)
    {
        return @à[0] + @丛[0];
    }

    is(中e̲ò中_中w̲갨_àссàù([100,5],[20,300]), 120,
    "Passing array references to functions accepting arrays works.");
}

# A Rakudo regression

{
    sub с갨_à(@à) { };   #OK not used
    sub с갨_丛(@à) { с갨_à(@à) };
    my @ч = 1, 2, 4;
    lives-ok { с갨_丛(@ч) },   'can pass parameter Array on to next function';
    lives-ok { @ч = 5, 6 }, '... and that did not make the caller Array ro';
}

# Positional Bind Failover
# https://github.com/rakudo/rakudo/issues/4864
subtest "Positional Bind Failover" => {
    #| @-siglled
    my sub 𝐩갨ò_à(@à) { @à.List }
    #| Positional-typed
    my sub 𝐩갨ò_𝐩(Positional $p) { $p.List }

    my @𝐝à中à = ((1...10), (1..10).hyper, (1..10).race);

    for &𝐩갨ò_à, &𝐩갨ò_𝐩 -> &pbf {
        subtest "PBF on {&pbf.WHY}" => {
            for @𝐝à中à -> $seq {
                my $갨갮中;
                subtest $seq.^name ~ " argument" => {
                    lives-ok { $갨갮中 = pbf($seq) }, "argument is accepted";
                    is-deeply $갨갮中, (1..10).List, "parameter value";
                }
            }
        }
    }
}

# vim: expandtab shiftwidth=4
