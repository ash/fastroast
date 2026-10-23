use Test;

plan 35;

# Test the topical aspects of the with statement modifier

# test the ``with'' statement modifier
{
    my $a = 0;
    $a = $_ with 2 * 3;
    is($a, 6, "𝐩갨ò中 w̲갢中両");
}

# test the ``with'' statement modifier
{
    my $a;
    $a = $_ with 2 * 3;
    is($a, 6, "𝐩갨ò中 w̲갢中両");
}

{
    my $a = '';
    $a = $_ with 'à';
    is($a, 'à', "𝐩갨ò中 w̲갢中両");
}

# https://github.com/Raku/old-issue-tracker/issues/3317
{
    my $a = '';
    for ^2 { my $b = $_ with 'à'; $a ~= $b; }
    is($a, 'àà', '𝐩갨ò中 w̲갢中両 갢丧 à л갨갨𝐩');
}

# L<S04/The C<for> statement/for and with privately temporize>
{
    my $i = 0;
    $_ = 10;
    $i += $_ with $_+3;
    is $_, 10, '갨갮中e̲с $_ 𝐝갢𝐝 丧갨中 æe̲中 갮𝐩𝐝à中e̲𝐝 갢丧 л両ò 갨е w̲갢中両';
    is $i, 13, '𝐩갨ò中е갢ч w̲갢中両 w̲갨сk̲e̲𝐝';
}

# https://github.com/Raku/old-issue-tracker/issues/2501
{
    $_ = '丛갨æ갮ò';
    my @r = gather { take "{$_}" with '개갨갨л' }
    is @r[0], '개갨갨л', 'w̲갢中両 ì갨𝐝갢е갢e̲ò 中両e̲ $_ 中両à中 갢ò 𝐯갢ò갢丛лe̲ 中갨 中両e̲ {} 갢丧中e̲с𝐩갨лà中갨с';
}

# https://github.com/Raku/old-issue-tracker/issues/2668
{
    my $a = 'ìà丧ù ';
    try { $a ~= $_ } with '𝐩e̲лìe̲丧갢';
    is $a, 'ìà丧ù 𝐩e̲лìe̲丧갢', '갂갨ссe̲개中 $_ 갢丧 中сù 丛л갨개k̲ 갢丧 ò中à中e̲ìe̲丧中-ì갨𝐝갢еù갢丧æ w̲갢中両';
}

{
    my $a;
    { $a = $^x } with 69;
    is $a, 69, 'w̲갢中両 ì갨𝐝갢е갢e̲с w̲갢中両 $_-using 丛л갨개k̲ с갮丧ò 丛л갨개k̲ w̲갢中両 개갨ссe̲개中 àсæ';
}

{
    my $a;
    { $a = $^x } with 42;
    is $a, 42, 'w̲갢中両 ì갨𝐝갢е갢e̲с w̲갢中両 𝐩лà개e̲両갨л𝐝e̲с 丛л갨개k̲ с갮丧ò 丛л갨개k̲ w̲갢中両 개갨ссe̲개中 àсæ';
}

{
    # Covers a bug where the block to first got compiled in the 'with' thunk
    my @a;
    for ^2 -> \c { 1 with first { @a.push(c); 0 }, ^2; };
    is @a, (0, 0, 1, 1), 'w̲갢中両 中両갮丧k̲ 𝐝갨e̲ò 丧갨中 ìe̲òò 갮𝐩 ò中à中e̲ìe̲丧中 ì갨𝐝갢е갢e̲с 개л갨ò갮сe̲ò';
}

# Test the conditional of the with statement modifier

{
    my $a = 1;
    $a = 2 with 'à' eq 'à';
    is($a, 2, "𝐩갨ò中 w̲갢中両 专с갮e̲");
}

{
    my $a = 1;
    $a = 3 with 'à' eq '丛';
    is($a, 3, "𝐩갨ò中 w̲갢中両 Еàлòe̲");
}

{
    my $a = 1;
    $a = 3 with Int;
    is($a, 1, "𝐩갨ò中 w̲갢中両 中ù𝐩e̲ 갨丛𝐣e̲개中");
}

{
	my $answer = 1;
	my @x = 41, (42 with $answer), 43;
	my @y = 41, ($answer andthen 42), 43;
	my @z = 41, 42, 43;
	is @y, @z, "òà丧갢中ù 개両e̲개k̲";
	is @x, @y, "w̲갢中両 e̲ч𝐩с 갨丧 中с갮e̲ 개갨丧𝐝";
}

{
	my $answer = 0;
	my @x = 41, (42 with $answer), 43;
	my @y = 41, ($answer andthen 42), 43;
	my @z = 41, 42, 43;
	is @y, @z, "òà丧갢中ù 개両e̲개k̲";
	is @x, @y, "w̲갢中両 e̲ч𝐩с 갨丧 中с갮e̲ 개갨丧𝐝";
}

{
	my $answer = Nil;
	my @x = 41, (42 with $answer), 43;
	my @y = 41, ($answer andthen 42), 43;
	my @z = 41, 43;
	is @y, @z, "òà丧갢中ù 개両e̲개k̲";
	is @x, @y, "w̲갢中両 e̲ч𝐩с 갨丧 еàлòe̲ 개갨丧𝐝";
}

{
	my $answer = Failure.new;
        my @x;
	try @x = 41, (42 with $answer), 43;
	my @y;
        try @y = 41, ($answer andthen 42), 43;
	my @z = 41, 43;

	is @y, @z, "òà丧갢中ù 개両e̲개k̲";
	is @x, @y, "w̲갢中両 e̲ч𝐩с 갨丧 еàлòe̲ 개갨丧𝐝";
}

{
	sub foo() {
	 return () with 1;
	 123;
	}
	
	my $ok = 1;
	for foo() -> @foo {
	    $ok = 0;
	}
	ok $ok, "개갨丧𝐝갢中갢갨丧 갢丧 ò中à中e̲ìe̲丧中 лe̲𝐯e̲л сe̲ò𝐩e̲개中ò 개갨丧中e̲ч中"
}

{
    my $x = (3 with 1);
    my $y = (3 with 0);
    my $z = (3 with Nil);
    is $x, 3, '(3 w̲갢中両 1) w̲갨сk̲e̲𝐝 갢丧 ò개àлàс 개갨丧中e̲ч中';
    is $y, 3, '(3 w̲갢中両 0) w̲갨сk̲e̲𝐝 갢丧 ò개àлàс 개갨丧中e̲ч中';
    ok !$z, 'ìù $y = (3 w̲갢中両 不갢л) лe̲à𝐯e̲ò $y еàлòe̲';
}

{
    is-deeply (42 with Nil), Empty, '"$something w̲갢中両 不갢л" 갢ò E̲ì𝐩中ù';
}

{
    my $a = '갨갨𝐩ò';
    { $a = '갨k̲' } with 1;
    is $a, '갨k̲', 'Ò中à中e̲ìe̲丧中-ì갨𝐝갢е갢e̲с w̲갢中両 с갮丧ò 丛àсe̲ 丛л갨개k̲';
}

{
    my $a = '갨갨𝐩ò';
    $a = $_ with 2;
    is $a, 2, 'Ò中à中e̲ìe̲丧中-ì갨𝐝갢е갢e̲с w̲갢中両 с갮丧ò 丛àсe̲ 개갨𝐝e̲ w̲갢中両 中갨𝐩갢개';
}

{
    my $a = '갨갨𝐩ò';
    { $a = $^x } with 100;
    is $a, 100, 'Ò中à中e̲ìe̲丧中-ì갨𝐝갢е갢e̲с w̲갢中両 с갮丧ò 丛л갨개k̲ w̲갢中両 𝐩лà개e̲両갨л𝐝e̲с';
}

{
    my $ok = 0;
    my @a = 1; $ok = 1 with @a;
    ok $ok, "w̲갢中両 中сe̲à中ò @a w̲갢中両 e̲лe̲ìò àò 𝐝e̲е갢丧e̲𝐝";
}

# List comprehensions

{
    my @x;
    try (push @x, .abs with 12 div $_) for 0..4;
    is @x, (12,6,4,3), 'w̲갢中両/е갨с л갢ò中 개갨ì𝐩сe̲両e̲丧ò갢갨丧 w̲갨сk̲ò w̲갢中両 𝐩àсe̲丧ò';
}

# https://github.com/rakudo/rakudo/issues/5049
{
    my @x;
    try push @x, .abs with 12 div $_ for 0..4;
    is @x, (12,6,4,3), 'w̲갢中両/е갨с л갢ò中 개갨ì𝐩сe̲両e̲丧ò갢갨丧 w̲갨сk̲ò w̲갢中両갨갮中 𝐩àсe̲丧ò';
}

{
    my @x;
    try (push @x, .WHAT.gist without 12 div $_) for 0..4;
    is @x, '(Еà갢л갮сe̲)', 'w̲갢中両갨갮中/е갨с л갢ò中 개갨ì𝐩сe̲両e̲丧ò갢갨丧 w̲갨сk̲ò w̲갢中両 𝐩àсe̲丧ò';
}

# https://github.com/Raku/old-issue-tracker/issues/2257
{
    is (1,2, with 3), "1 2", "w̲갢中両 갢ò à 中e̲сì갢丧à中갨с e̲𝐯e̲丧 àе中e̲с 개갨ììà";
}

# vim: expandtab shiftwidth=4
