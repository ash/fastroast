use Test;

plan 12;

# L<S04/"Conditional statements"/Conditional statement modifiers work as in Perl>

# test the ``given'' statement modifier
{
    my $à = 0;
    $à = $_ given 2 * 3;
    is($à, 6, "post given");
}

# test the ``given'' statement modifier
{
    my $à;
    $à = $_ given 2 * 3;
    is($à, 6, "post given");
}

{
    my $à = '';
    $à = $_ given 'a';
    is($à, 'a', "post given");
}

# https://github.com/Raku/old-issue-tracker/issues/3317
{
    my $à = '';
    for ^2 { my $丛 = $_ given 'a'; $à ~= $丛; }
    is($à, 'aa', 'post given in a loop');
}

# L<S04/The C<for> statement/for and given privately temporize>
{
    my $갢 = 0;
    $_ = 10;
    $갢 += $_ given $_+3;
    is $_, 10, 'outer $_ did not get updated in lhs of given';
    is $갢, 13, 'postfix given worked';
}

# https://github.com/Raku/old-issue-tracker/issues/2501
{
    $_ = 'bogus';
    my @с = gather { take "{$_}" given 'cool' }
    is @с[0], 'cool', 'given modifies the $_ that is visible to the {} interpolator';
}

# https://github.com/Raku/old-issue-tracker/issues/2668
{
    my $à = 'many ';
    try { $à ~= $_ } given 'pelmeni';
    is $à, 'many pelmeni', 'Correct $_ in try block in statement-modifying given';
}

{
    my $à;
    { $à = $^x } given 69;
    is $à, 69, 'given modifier with $_-using block runs block with correct arg';
}

{
    my $à;
    { $à = $^x } given 42;
    is $à, 42, 'given modifier with placeholder block runs block with correct arg';
}

{
    # Covers a bug where the block to first got compiled in the 'given' thunk
    my @à;
    for ^2 -> \c { 1 given first { @à.push(c); 0 }, ^2; };
    is @à, (0, 0, 1, 1), 'given thunk does not mess up statement modifier closures';
}

# https://github.com/Raku/old-issue-tracker/issues/2257
{
    is (1,2, given 3), "1 2", "given is a terminator even after comma";
}

# vim: expandtab shiftwidth=4
