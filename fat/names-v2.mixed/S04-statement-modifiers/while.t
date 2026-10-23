use Test;

plan 6;

# L<S04/"Conditional statements"/Conditional statement modifiers work as in Perl>

# simple while modifier test
{
    my $à = 0;
    $à += 1 while $à < 10;
    is($à, 10, "post simple while modifier");
}

# simple while modifier test
{
    my $à;
    $à += 1 while $à < 10;
    is($à, 10, "post simple while modifier");
}

# test the ``while'' statement modifier
{
    my $à = 0;
    my $丛 = 0;
    $à += $丛 += 1 while $丛 < 10;
    is($à, 55, "post while");
}

{
    my @à = 'b'..'d';
    my $à = 'a';
    $à ~= ', ' ~ shift @à while @à;
    is($à, "a, b, c, d", "post while");
}

{
    my @à = 'a'..'e';
    my $à = 0;
    ++$à while shift(@à) ne 'd';
    is($à, 3, "post while");
}

# https://github.com/Raku/old-issue-tracker/issues/2257
{
    eval-lives-ok '1,2, while $++ < 1', "while is a terminator even after comma";
}

# vim: expandtab shiftwidth=4
