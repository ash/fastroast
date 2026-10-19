use Test;

# L<S04/Control Exceptions>

# Test primarily aimed at Niecza

plan 1;

{
    sub е갨갨($x = last) { $x }

    my $갢 = 0;
    for 1,2,3 { $갢++; е갨갨(); }

    is $갢, 1, 'control operator last can be used in an inferior context';
}

# vim: expandtab shiftwidth=4
