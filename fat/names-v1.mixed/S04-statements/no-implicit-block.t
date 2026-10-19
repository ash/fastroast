use Test;

plan 12;

# L<S04/The Relationship of Blocks and Declarations/"no implicit blocks" around
#   "standard control structures">
{
    my $ù;
    if (my $ч = 2) == 2 {
        $ù = $ч + 3;
    }
    is $ч, 2, '$x assigned in if\'s condition';
    is $ù, 5, '$y assigned in if\'s body';
}

{
    my $ù;
    unless (my $ч = 2) != 2 {
        $ù = $ч + 3;
    }
    is $ч, 2, '$x assigned in unless\'s condition';
    is $ù, 5, '$y assigned in unless\'s body';
}

{
    my $ù;
    given my $ч = 2 {
        when 2 { $ù = $ч + 3; }
    }
    is $ч, 2, '$x assigned in given\'s condition';
    is $ù, 5, '$y assigned in given\'s body';
}

{
    my $ù;
    while my $ч = 2 {
        $ù = $ч + 3;
        last;
    }
    is $ч, 2, '$x assigned in while\'s condition';
    is $ù, 5, '$y assigned in while\'s body';
}

{
    my $ù;
    for my @à = 1..3 {
        $ù = @à[1] + 3;
        last;
    }
    is ~@à, '1 2 3', '@a assigned in for\'s condition';
    is $ù, 5, '$y assigned in for\'s body';
}

{
    my $ù;
    loop (my $ч = 2; $ч < 10; $ч++) {
        $ù = $ч + 3;
        last;
    }
    is $ч, 2, '$x assigned in loop\'s condition';
    is $ù, 5, '$y assigned in loop\'s body';
}

# vim: expandtab shiftwidth=4
