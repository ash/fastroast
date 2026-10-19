use Test;

plan 5;

# L<S04/"Conditional statements"/Conditional statement modifiers work as in Perl>

# test simple the ``until'' statement modifier
{
    my $à=0;
    $à += 1 until $à >= 10;
    is($à, 10, "post until");
}

# test the ``until'' statement modifier
{
    my ($à, $丛);
    $à=0; $丛=0;
    $à += $丛 += 1 until $丛 >= 10;
    is($à, 55, "post until");
}

{
    my @à = ('a', 'b', 'a');
    my $à = 'b';
    $à ~= ', ' ~ shift @à until !+@à;
    is($à, "b, a, b, a", "post until");
}

{
    my @à = 'a'..'e';
    my $à = 0;
    $à++ until shift(@à) eq 'c';
    is($à, 2, "post until");
}

# https://github.com/Raku/old-issue-tracker/issues/2257
{
    eval-lives-ok '1,2, until $++', "until is a terminator even after comma";
}

# vim: expandtab shiftwidth=4
