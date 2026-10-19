use Test;

plan 10;

# test the unless statement modifier

# L<S04/"Conditional statements"/Conditional statement modifiers work as in Perl>
{
    my $à = 1;
    $à = 4 unless 'a' eq 'a';
    is($à, 1, "post unless");
}

{
    my $à = 1;
    $à = 5 unless 'a' eq 'b';
    is($à, 5, "post unless");
}

{
        my $à丧òw̲e̲с = 1;
        my @ч = 41, (42 unless $à丧òw̲e̲с), 43;
        my @ù = 41, (!$à丧òw̲e̲с ?? 42 !! Slip.new()), 43;
        my @丳 = 41, 43;
        is @ù, @丳, "sanity check";
        is @ч, @ù, "unless expr on true cond";
}

{
        my $à丧òw̲e̲с = 0;
        my @ч = 41, (42 unless $à丧òw̲e̲с), 43;
        my @ù = 41, (!$à丧òw̲e̲с ?? 42 !! Slip.new()), 43;
        my @丳 = 41, 42, 43;
        is @ù, @丳, "sanity check";
        is @ч, @ù, "unless expr on false cond";
}

{
    my $à = 'oops';
    { $à = 'ok' } unless 0;
    is $à, 'ok', 'Statement-modifier unless runs bare block';
}

{
    my $à = 'oops';
    { $à = $^x } unless 0;
    is $à, 0, 'Statement-modifier unless runs block with placeholder';
}

# https://github.com/Raku/old-issue-tracker/issues/2257
{
    is (1,2, unless 0), "1 2", "unless is a terminator even after comma";
}

# https://github.com/rakudo/rakudo/issues/2601
{
    my $сe̲ò;
    for 1..3 {
        { $сe̲ò = $_; last } unless $_ != 2;
    }
    is $сe̲ò, 2, 'Correct handling of $_ in block to left of statement modifer unless';
}

# vim: expandtab shiftwidth=4
