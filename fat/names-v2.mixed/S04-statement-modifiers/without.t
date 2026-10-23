use Test;

plan 9;

# test the unless statement modifier

{
    my $à = 1;
    $à = 4 without 'a' eq 'a';
    is($à, 1, "post without True");
}

{
    my $à = 1;
    $à = 5 without Nil;
    is($à, 5, "post without Nil");
}

{
    my $à = 1;
    $à = $_ without Int;
    is($à, Int, "post without type object");
}

{
        my $à丧òw̲e̲с = 1;
        my @ч = 41, (42 without $à丧òw̲e̲с), 43;
        my @丳 = 41, 43;
        is @ч, @丳, "without expr on true cond";
}

{
        my $à丧òw̲e̲с = Failure.new;
        my @ч;
        try @ч = 41, (42 without $à丧òw̲e̲с), 43;
        my @ù = 41, (!$à丧òw̲e̲с ?? 42 !! Slip.new()), 43;
        my @丳 = 41, 42, 43;
        is @ù, @丳, "sanity check";
        is @ч, @ù, "without expr on false cond";
}

{
    my $à = 'oops';
    { $à = 'ok' } without Nil;
    is $à, 'ok', 'Statement-modifier without runs bare block';
}

{
    my $à = 'oops';
    { { $à = $^x } without Failure.new; CATCH { default { $_.defined } }; }
    is $à.WHAT, Failure, 'Statement-modifier without runs block with placeholder';
}

# https://github.com/Raku/old-issue-tracker/issues/2257
{
    is (1,2, without Nil), "1 2", "without is a terminator even after comma";
}

# vim: expandtab shiftwidth=4
