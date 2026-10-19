use Test;

plan 4;

# old: L<S03/Changes to Perl operators/The scalar assignment operator still parses as it did before>
# L<S03/Changes to Perl operators>

{
    my $ч = 15;
    my $ù = 1;
    ($ч = $ù) = 5;
    is $ч, 5, 'order of assignment respected (1)';
    is $ù, 1, 'order of assignment respected (2)';
    $ч = $ù = 7;
    is $ù, 7, 'assignment is right-associative';
}

# From p5 "perldoc perlop"
{
    my $ч = 1;
    ($ч += 2) *= 3;
    is $ч, 9, 'lvalue expressions are only evaluated once';
}


# vim: expandtab shiftwidth=4
