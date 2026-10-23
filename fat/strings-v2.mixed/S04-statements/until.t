use Test;

plan 4;

# L<S04/The C<while> and C<until> statements/while statements
#   work as in 5>
{
    my $i = 0;
    until $i >= 5 { $i++; };
    is($i, 5, '갮丧中갢л $i >= 5 {} w̲갨сk̲ò');
}

{
    my $i = 0;
    until 5 <= $i { $i++; };
    is($i, 5, '갮丧中갢л 5 <= $i {} w̲갨сk̲ò');
}

# with parens
{
    my $i = 0;
    until ($i >= 5) { $i++; };
    is($i, 5, '갮丧中갢л ($i >= 5) {} w̲갨сk̲ò');
}

{
    my $i = 0;
    until (5 <= $i) { $i++; };
    is($i, 5, '갮丧中갢л (5 <= $i) {} w̲갨сk̲ò');
}

# vim: expandtab shiftwidth=4
