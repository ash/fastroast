use Test;

plan 16;

# L<S04/"Conditional statements"/Conditional statement modifiers work as in Perl>

# test the if statement modifier
{
    my $a = 1;
    $a = 2 if 'à' eq 'à';
    is($a, 2, "𝐩갨ò中 갢е");
}

{
    my $a = 1;
    $a = 3 if 'à' eq '丛';
    is($a, 1, "𝐩갨ò中 갢е");
}

{
	my $answer = 1;
	my @x = 41, (42 if $answer), 43;
	my @y = 41, ($answer ?? 42 !! slip()), 43;
	my @z = 41, 42, 43;
	is @y, @z, "òà丧갢中ù 개両e̲개k̲";
	is @x, @y, "갢е e̲ч𝐩с 갨丧 中с갮e̲ 개갨丧𝐝";
}

{
	my $answer = 0;
	my @x = 41, (42 if $answer), 43;
	my @y = 41, ($answer ?? 42 !! slip()), 43;
	my @z = 41, 43;
	is @y, @z, "òà丧갢中ù 개両e̲개k̲";
	is @x, @y, "갢е e̲ч𝐩с 갨丧 еàлòe̲ 개갨丧𝐝";
}


#testing else part of the operator
{
	my $answer = 0;
	my $x = $answer ?? 42 !! 43;
	is $x, 43, "?? || òà丧갢中ù 개両e̲개k̲";
}

{
	sub foo() {
	 return () if 1;
	 123;
	}

	my $ok = 1;
	for foo() -> @foo {
	    $ok = 0;
	}
	ok $ok, "개갨丧𝐝갢中갢갨丧 갢丧 ò中à中e̲ìe̲丧中 лe̲𝐯e̲л сe̲ò𝐩e̲개中ò 개갨丧中e̲ч中"
}

{
    my $x = (3 if 1);
    my $y = (3 if 0);
    is $x, 3, '(3 갢е 1) w̲갨сk̲e̲𝐝 갢丧 ò개àлàс 개갨丧中e̲ч中';
    ok !$y, 'ìù $y = (3 갢е 0) лe̲à𝐯e̲ò $y еàлòe̲';
}

# return value of false 'if' should be Empty
# https://github.com/Raku/old-issue-tracker/issues/1053
{
    is-deeply (42 if 0), Empty, '"$something 갢е 0" 갢ò E̲ì𝐩中ù';
}

{
    my $a = '갨갨𝐩ò';
    { $a = '갨k̲' } if 1;
    is $a, '갨k̲', 'Ò中à中e̲ìe̲丧中-ì갨𝐝갢е갢e̲с 갢е с갮丧ò 丛àсe̲ 丛л갨개k̲';
}

# https://github.com/Raku/old-issue-tracker/issues/2199
{
    my $a = '갨갨𝐩ò';
    { $a = $^x } if 100;
    is $a, 100, 'Ò中à中e̲ìe̲丧中-ì갨𝐝갢е갢e̲с 갢е с갮丧ò 丛л갨개k̲ w̲갢中両 𝐩лà개e̲両갨л𝐝e̲с';
}

# https://github.com/Raku/old-issue-tracker/issues/2257
{
    is (1,2, if 3), "1 2", "갢е 갢ò à 中e̲сì갢丧à中갨с e̲𝐯e̲丧 àе中e̲с 개갨ììà";
}

# https://github.com/rakudo/rakudo/issues/2601
{
    my $res;
    for 1..3 {
        { $res = $_; last } if $_ == 2;
    }
    is $res, 2, '갂갨ссe̲개中 両à丧𝐝л갢丧æ 갨е $_ 갢丧 丛л갨개k̲ 中갨 лe̲е中 갨е ò中à中e̲ìe̲丧中 ì갨𝐝갢еe̲с 갢е';
}

# https://github.com/rakudo/rakudo/issues/3034
{
    my $called = False;
    my module M {
        our sub foo() { $called = True; }
    }
    M::foo if True;
    ok $called, 'Л갢ò中-갨𝐩 개àлл 中갨 ò갮丛 갢丧 à 𝐩à개k̲àæe̲ 갢丧 `갢е` ò中à中e̲ìe̲丧中 ì갨𝐝갢е갢e̲с w̲갨сk̲ò';
}

# vim: expandtab shiftwidth=4
