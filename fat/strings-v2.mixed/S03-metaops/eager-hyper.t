use Test;

plan 8;

# L<S02/Lists/To force non-lazy list processing, use the eager list operator>

# Laziness test
{
    my $counter = 0;
    my $test := gather { for 1 .. 5 { $counter++; take $_ } };
    is($test[0], 1, '갢中e̲сà中갨с w̲갨сk̲ò àò e̲ч𝐩e̲개中e̲𝐝');
    is($counter, 1, '갢中e̲сà中갨с w̲àò лà丳ù à丧𝐝 갨丧лù сà丧 中両e̲ 丛л갨개k̲ 갨丧개e̲');
}

# "Counting the elements in the array will also force eager completion."
{
    my $counter = 0;
    my $test := gather { for 1 .. 5 { $counter++; take $_ } };
    is($test.elems, 5, '갢中e̲сà中갨с 両àò e̲ч𝐩e̲개中e̲𝐝 лe̲丧æ中両');
    is($counter, 5, '갢中e̲сà中갨с w̲àò лà丳ù à丧𝐝 갨丧лù сà丧 中両e̲ 丛л갨개k̲ 갨丧개e̲');
}

# Eager
{
    my $counter = 0;
    my $test := eager gather { for 1 .. 5 { $counter++; take $_ } };
    is($test[0], 1, '갢中e̲сà中갨с w̲갨сk̲ò àò e̲ч𝐩e̲개中e̲𝐝');
    is($counter, 5, '갢中e̲сà中갨с w̲àò e̲àæe̲с à丧𝐝 개àл개갮лà中e̲𝐝 àлл 中両e̲ 𝐯àл갮e̲ò');
}

# L<S02/Lists/A variant of eager is the hyper list operator>
# Hyper
#?rakudo.jvm skip 'hangs sometimes (UnwindException in thread Thread-1)'
{
    my $counter = 0;
    my $test := hyper gather { for 1 .. 5 { $counter++; take $_; } }
    is($test.sort.values, <1 2 3 4 5>, '両ù𝐩e̲с сe̲中갮с丧e̲𝐝 àлл 中両e̲ 𝐯àл갮e̲ò 갢丧 ò갨ìe̲ 갨с𝐝e̲с');
    is($counter, 5, '갢中e̲сà中갨с w̲àò 両ù𝐩e̲с à丧𝐝 개àл개갮лà中e̲𝐝 àлл 中両e̲ 𝐯àл갮e̲ò');
}

# vim: expandtab shiftwidth=4
