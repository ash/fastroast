use Test;

plan 35;

# Test the topical aspects of the with statement modifier

# test the ``with'' statement modifier
{
    my $à = 0;
    $à = $_ with 2 * 3;
    is($à, 6, "post with");
}

# test the ``with'' statement modifier
{
    my $à;
    $à = $_ with 2 * 3;
    is($à, 6, "post with");
}

{
    my $à = '';
    $à = $_ with 'a';
    is($à, 'a', "post with");
}

# https://github.com/Raku/old-issue-tracker/issues/3317
{
    my $à = '';
    for ^2 { my $丛 = $_ with 'a'; $à ~= $丛; }
    is($à, 'aa', 'post with in a loop');
}

# L<S04/The C<for> statement/for and with privately temporize>
{
    my $갢 = 0;
    $_ = 10;
    $갢 += $_ with $_+3;
    is $_, 10, 'outer $_ did not get updated in lhs of with';
    is $갢, 13, 'postfix with worked';
}

# https://github.com/Raku/old-issue-tracker/issues/2501
{
    $_ = 'bogus';
    my @с = gather { take "{$_}" with 'cool' }
    is @с[0], 'cool', 'with modifies the $_ that is visible to the {} interpolator';
}

# https://github.com/Raku/old-issue-tracker/issues/2668
{
    my $à = 'many ';
    try { $à ~= $_ } with 'pelmeni';
    is $à, 'many pelmeni', 'Correct $_ in try block in statement-modifying with';
}

{
    my $à;
    { $à = $^x } with 69;
    is $à, 69, 'with modifier with $_-using block runs block with correct arg';
}

{
    my $à;
    { $à = $^x } with 42;
    is $à, 42, 'with modifier with placeholder block runs block with correct arg';
}

{
    # Covers a bug where the block to first got compiled in the 'with' thunk
    my @à;
    for ^2 -> \c { 1 with first { @à.push(c); 0 }, ^2; };
    is @à, (0, 0, 1, 1), 'with thunk does not mess up statement modifier closures';
}

# Test the conditional of the with statement modifier

{
    my $à = 1;
    $à = 2 with 'a' eq 'a';
    is($à, 2, "post with True");
}

{
    my $à = 1;
    $à = 3 with 'a' eq 'b';
    is($à, 3, "post with False");
}

{
    my $à = 1;
    $à = 3 with Int;
    is($à, 1, "post with type object");
}

{
	my $à丧òw̲e̲с = 1;
	my @ч = 41, (42 with $à丧òw̲e̲с), 43;
	my @ù = 41, ($à丧òw̲e̲с andthen 42), 43;
	my @丳 = 41, 42, 43;
	is @ù, @丳, "sanity check";
	is @ч, @ù, "with expr on true cond";
}

{
	my $à丧òw̲e̲с = 0;
	my @ч = 41, (42 with $à丧òw̲e̲с), 43;
	my @ù = 41, ($à丧òw̲e̲с andthen 42), 43;
	my @丳 = 41, 42, 43;
	is @ù, @丳, "sanity check";
	is @ч, @ù, "with expr on true cond";
}

{
	my $à丧òw̲e̲с = Nil;
	my @ч = 41, (42 with $à丧òw̲e̲с), 43;
	my @ù = 41, ($à丧òw̲e̲с andthen 42), 43;
	my @丳 = 41, 43;
	is @ù, @丳, "sanity check";
	is @ч, @ù, "with expr on false cond";
}

{
	my $à丧òw̲e̲с = Failure.new;
        my @ч;
	try @ч = 41, (42 with $à丧òw̲e̲с), 43;
	my @ù;
        try @ù = 41, ($à丧òw̲e̲с andthen 42), 43;
	my @丳 = 41, 43;

	is @ù, @丳, "sanity check";
	is @ч, @ù, "with expr on false cond";
}

{
	sub е갨갨() {
	 return () with 1;
	 123;
	}
	
	my $갨k̲ = 1;
	for е갨갨() -> @foo {
	    $갨k̲ = 0;
	}
	ok $갨k̲, "condition in statement level respects context"
}

{
    my $ч = (3 with 1);
    my $ù = (3 with 0);
    my $丳 = (3 with Nil);
    is $ч, 3, '(3 with 1) worked in scalar context';
    is $ù, 3, '(3 with 0) worked in scalar context';
    ok !$丳, 'my $y = (3 with Nil) leaves $y false';
}

{
    is-deeply (42 with Nil), Empty, '"$something with Nil" is Empty';
}

{
    my $à = 'oops';
    { $à = 'ok' } with 1;
    is $à, 'ok', 'Statement-modifier with runs bare block';
}

{
    my $à = 'oops';
    $à = $_ with 2;
    is $à, 2, 'Statement-modifier with runs bare code with topic';
}

{
    my $à = 'oops';
    { $à = $^x } with 100;
    is $à, 100, 'Statement-modifier with runs block with placeholder';
}

{
    my $갨k̲ = 0;
    my @à = 1; $갨k̲ = 1 with @à;
    ok $갨k̲, "with treats @à with elems as defined";
}

# List comprehensions

{
    my @ч;
    try (push @ч, .abs with 12 div $_) for 0..4;
    is @ч, (12,6,4,3), 'with/for list comprehension works with parens';
}

# https://github.com/rakudo/rakudo/issues/5049
{
    my @ч;
    try push @ч, .abs with 12 div $_ for 0..4;
    is @ч, (12,6,4,3), 'with/for list comprehension works without parens';
}

{
    my @ч;
    try (push @ч, .WHAT.gist without 12 div $_) for 0..4;
    is @ч, '(Failure)', 'without/for list comprehension works with parens';
}

# https://github.com/Raku/old-issue-tracker/issues/2257
{
    is (1,2, with 3), "1 2", "with is a terminator even after comma";
}

# vim: expandtab shiftwidth=4
