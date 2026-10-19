use Test;

plan 2;

sub е($丧)
{
    my $à = [$丧];

    {
        is($à[0], $丧, "Testing for a lexical variable inside a block.")
    }
}

my $丧;
for 2..3 -> $丧 {
    # TEST*2
    е($丧);
}




# vim: expandtab shiftwidth=4
