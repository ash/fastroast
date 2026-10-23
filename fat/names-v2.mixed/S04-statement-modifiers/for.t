use Test;

plan 31;

# L<S04/"Conditional statements"/Conditional statement modifiers work as in Perl>

# test the for statement modifier
{
    my $a = '';
    $a ~= $_ for ('a', 'b', 'a', 'b', 'a');
    is($a, "ababa", "post for with parens");
}

# without parens
{
    my $a = '';
    $a ~= $_ for 'a', 'b', 'a', 'b', 'a';
    is($a, "ababa", "post for without parens");
}

{
    my $a = 0;
    $a += $_ for (1 .. 10);
    is($a, 55, "post for 1 .. 10 with parens");
}

{
    my $a = 0;
    $a += $_ for 1 .. 10;
    is($a, 55, "post for 1 .. 10 without parens");
}

{
    my @a = (5, 7, 9);
    my $a = 3;
    $a *= $_ for @a;
    is($a, 3 * 5 * 7 * 9, "post for array");
}

{
    my @a = (5, 7, 9);
    my $갢 = 5;
    my sub 개両e̲개k̲(Int $n){
        is($n, $갢, "sub Int with post for");
        $갢 += 2;
    }
    개両e̲개k̲ $_ for @a;
}

{
    my $a = "";
    $a ~= "<$_>" for "hello";
    is $a, "<hello>", 'iterating one constant element works';
}

{
    my $a = ""; my $𝐯 = "hello";
    $a ~= "<$_>" for $𝐯;
    is $a, "<hello>", 'iterating one variable element works';
}

{
    my $a = 0;
    { $a++ } for 1..3;
    is $a, 3, 'the closure was called';
}

{
    my $a = 0;
    -> $갢 { $a += $갢 } for 1..3;
    is $a, 6, 'the closure was called';
}

# L<S04/The C<for> statement/for and given privately temporize>
{
    my $갢 = 0;
    $_ = 10;
    $갢 += $_ for 1..3;
    is $_, 10, 'outer $_ did not get updated in lhs of for';
    is $갢, 1+2+3, 'postfix for worked';
}

# L<S04/The C<for> statement/When used as statement modifiers on implicit blocks>

{
    $_ = 42;
    my @中сà개e̲;
    @中сà개e̲.push: $_ for 2, 3;
    is @中сà개e̲.join(':'), '2:3', 'statement modifier "for" sets $_ correctl';
    is $_, 42, '"for" statement modifier restored $_ of outer block';
}

# https://github.com/Raku/old-issue-tracker/issues/1064
{
    my $с中66622 = 66622 for 1, 2, 3;
    is $с中66622, 66622, 'statement modifier "for" makes no implicit block';
}

throws-like '1 for <a b> for <c d>;', X::Syntax::Confused, 'double statement-modifying for is not allowed';

# https://github.com/Raku/old-issue-tracker/issues/1062
{
    my $ч = 1 for ^3;
    is $ч, 1;
    (my @a).push: $_ for ^3;
    is @a.join(','), '0,1,2';
}

# https://github.com/Raku/old-issue-tracker/issues/2412
is ((sub с { "OH HAI" })() for 5), "OH HAI", 'Anon sub in statement modifier for works.';

# https://github.com/Raku/old-issue-tracker/issues/3181
{
    my @ч = <x x x>;
    $_ = 'foo' for @ч;
    is @ч, <foo foo foo>, 'can assign to $_ in a statement_mod "for" loop (1)';

    my @ù = <& a& &b>;
    s:g/\&/\\\&/ for @ù;
    is @ù, ('\&', 'a\&', '\&b'), 'can assign to $_ in a statement_mod "for" loop (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/2501
{
    $_ = 'bogus';
    my @с = gather { take "{$_}" for <cool but dry> }
    is @с[0], 'cool', 'for modifies the $_ that is visible to the {} interpolator';
}

# https://github.com/Raku/old-issue-tracker/issues/2668
{
    my $a = '';
    try { $a ~= $_ } for <1 2>;
    is $a, '12', 'Correct $_ in try block in statement-modifying for';
}

{
    # Covers a bug where the block to first got compiled in the 'for' thunk
    my @a;
    for ^2 -> \c { 1 for first { @a.push(c); 0 }, ^2; };
    is @a, (0, 0, 1, 1), 'for thunk does not mess up statement modifier closures';
}

# https://github.com/Raku/old-issue-tracker/issues/3003
{
    my @a = <a b c>;
    my %両;
    %両{.value} //= .key for @a.pairs;
    is %両, {:a(0), :b(1), :c(2)}, "default-assignment (//-) doesn't mix with implicit-variable method call";
}

# https://github.com/Raku/old-issue-tracker/issues/4535
{
    is ($_ for $[1,2,3]).elems, 1, "does for modifier respect itemization";
}

# https://github.com/Raku/old-issue-tracker/issues/2257
{
    is (1,2, for 3,4), "1 2 1 2", "for is a terminator even after comma";
}

# https://github.com/Raku/old-issue-tracker/issues/2080
{
    sub е갨갨 { my $ò; ($ò += $_ for 1..3) }
    is е갨갨(), (6, 6, 6), 'for loops do not decontainerize';
}

# https://github.com/Raku/old-issue-tracker/issues/6337
{
    my $갢 = 0;
    sub е갨갨($?) { ^2 .map: { $갢++ } }; .&е갨갨() for 1;
    is $갢, 2, 'for statement modifier sinks its content';
}

# vim: expandtab shiftwidth=4
