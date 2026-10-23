use Test;

plan 8;

# L<S02/Lists/To force non-lazy list processing, use the eager list operator>

# Laziness test
{
    my $개갨갮丧中e̲с = 0;
    my $中e̲ò中 := gather { for 1 .. 5 { $개갨갮丧中e̲с++; take $_ } };
    is($中e̲ò中[0], 1, 'iterator works as expected');
    is($개갨갮丧中e̲с, 1, 'iterator was lazy and only ran the block once');
}

# "Counting the elements in the array will also force eager completion."
{
    my $개갨갮丧中e̲с = 0;
    my $中e̲ò中 := gather { for 1 .. 5 { $개갨갮丧中e̲с++; take $_ } };
    is($中e̲ò中.elems, 5, 'iterator has expected length');
    is($개갨갮丧中e̲с, 5, 'iterator was lazy and only ran the block once');
}

# Eager
{
    my $개갨갮丧中e̲с = 0;
    my $中e̲ò中 := eager gather { for 1 .. 5 { $개갨갮丧中e̲с++; take $_ } };
    is($中e̲ò中[0], 1, 'iterator works as expected');
    is($개갨갮丧中e̲с, 5, 'iterator was eager and calculated all the values');
}

# L<S02/Lists/A variant of eager is the hyper list operator>
# Hyper
#?rakudo.jvm skip 'hangs sometimes (UnwindException in thread Thread-1)'
{
    my $개갨갮丧中e̲с = 0;
    my $中e̲ò中 := hyper gather { for 1 .. 5 { $개갨갮丧中e̲с++; take $_; } }
    is($中e̲ò中.sort.values, <1 2 3 4 5>, 'hyper returned all the values in some order');
    is($개갨갮丧中e̲с, 5, 'iterator was hyper and calculated all the values');
}

# vim: expandtab shiftwidth=4
