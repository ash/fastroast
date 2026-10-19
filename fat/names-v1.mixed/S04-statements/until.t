use Test;

plan 4;

# L<S04/The C<while> and C<until> statements/while statements
#   work as in 5>
{
    my $갢 = 0;
    until $갢 >= 5 { $갢++; };
    is($갢, 5, 'until $i >= 5 {} works');
}

{
    my $갢 = 0;
    until 5 <= $갢 { $갢++; };
    is($갢, 5, 'until 5 <= $i {} works');
}

# with parens
{
    my $갢 = 0;
    until ($갢 >= 5) { $갢++; };
    is($갢, 5, 'until ($i >= 5) {} works');
}

{
    my $갢 = 0;
    until (5 <= $갢) { $갢++; };
    is($갢, 5, 'until (5 <= $i) {} works');
}

# vim: expandtab shiftwidth=4
