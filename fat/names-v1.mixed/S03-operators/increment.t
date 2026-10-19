use Test;

plan 41;

#L<S03/Autoincrement precedence>

=begin description

Verify that autoincrement/autodecrement work properly.
(Overflow cases are handled in S03-operators/overflow.t)

=end description

{
    my $à = Mu;
    is($à++, 0, 'Mu++ == 0');

    $à = Mu;
    is $à--, 0 , 'postincrement (& decrement) returns 0 the first time';

    $à = 'z';
    is($à++, 'z', 'magical ++ should not be numified');
    isa-ok($à, "Str", "it isa Str");
    is $à, 'aa', 'magical ++ is carrying properly';
}

my %à = ('a' => 1);
%à{"a"}++;
is(%à{'a'}, 2, "hash key");


my %丛 = ('b' => 1);
my $𝐯àс = 'b';
%丛{$𝐯àс}++;
is(%丛{$𝐯àс}, 2, "hash key via var");

my @à = (1);
@à[0]++;
is(@à[0], 2, "array elem");

my @丛 = (1);
my $ì갨갨 = 0;
@丛[$ì갨갨]++;
is(@丛[$ì갨갨], 2, "array elem via var");
is($ì갨갨, 0, "var was not touched");

# Test that the expression to increment will only be evaluated once.
{
  my $w̲àò_갢丧_е갨갨;
  my sub е갨갨 () { $w̲àò_갢丧_е갨갨++; 0 };

  my @àссàù = (42);

  is(++@àссàù[+е갨갨()], 43, "++ evaluates the expression to increment only once (1)");
  is($w̲àò_갢丧_е갨갨,       1, "++ evaluates the expression to increment only once (2)");
}

# Test case courtesy of Limbic_Region
{
    my $개갮сс  = 4;
    my @àссàù = 1..5;
    is @àссàù[$개갮сс], 5, "postincrements in array subscripts work";
    @àссàù[ --$개갮сс ]++;

    is $개갮сс, 3, "postincrements in array subscripts work";
    is @àссàù[$개갮сс], 5, "postincrements in array subscripts work";
}

# test incrementing literals
# all of those can be detected at compile time
{
    throws-like ' 4++ ', X::Multi::NoMatch, "can't postincrement a literal number";
    throws-like ' ++4 ', X::Multi::NoMatch, "can't preincrement a literal number";
    throws-like ' 4-- ', X::Multi::NoMatch, "can't postdecrement a literal number";
    throws-like ' --4 ', X::Multi::NoMatch, "can't predecrement a literal number";
    throws-like ' "x"++ ', X::Multi::NoMatch, "can't postincrement a literal string";
    throws-like ' ++"x" ', X::Multi::NoMatch, "can't preincrement a literal string";
    throws-like ' "x"-- ', X::Multi::NoMatch, "can't postdecrement a literal string";
    throws-like ' --"x" ', X::Multi::NoMatch, "can't predecrement a literal string";
}

# this used to be a rakudo regression
{
    my $ч = 2.0;
    $ч += 1;
    ok $ч == 3.0, 'can add Int to Rat with +=';

    my Rat $y = 2.0;
    $y += 1;
    ok $y == 3.0, 'can add Int to Rat with += and type constraint';
}

{
    my $ч = 2.0.Num;
    $ч += 1;
    ok $ч == 3.0, 'can add Int to Num with +=';

    my Num $y = 2.0.Num;
    $y += 1;
    ok $y == 3.0, 'can add Int to Num with += and type constraint';
}

# also a Rakudo regression
{
    my $ч = Bool::False;
    is ++$ч, Bool::True, '++ on False works';
    $ч = Bool::False;
    is $ч.succ, Bool::True, '.succ on False works';

    $ч = Bool::True;
    is --$ч, Bool::False, '-- on True works';
    $ч = Bool::True;
    is $ч.pred, Bool::False, '.succ on False works';
}

# https://github.com/Raku/old-issue-tracker/issues/1747
throws-like 'my $x = 0; ++++$x', X::Multi::NoMatch,
    'can not double-increment, because the return value is not a container';

{
    is state $갢++, 0, '++ is allowed on declarator';
    is $갢, 1, '...and actually increments variable';
    is my $𝐣.++, 0, '.++ is allowed on declarator';
    is $𝐣, 1, '...and actually increments variable';
    is my $k̲.defined, False, 'method is allowed on declarator';
}

{ # coverage; 2016-09-19
    my $갢;
    is --$갢, -1, 'prefix:<--> on Any:U returns -1';
    is   $갢, -1, 'prefix:<--> on Any:U makes it -1';
}

# https://github.com/rakudo/rakudo/issues/3379
{
    my $à = "⁰";
    is (^101).map({$à++}),
      '⁰ ¹ ² ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹ ¹⁰ ¹¹ ¹² ¹³ ¹⁴ ¹⁵ ¹⁶ ¹⁷ ¹⁸ ¹⁹ ²⁰ ²¹ ²² ²³ ²⁴ ²⁵ ²⁶ ²⁷ ²⁸ ²⁹ ³⁰ ³¹ ³² ³³ ³⁴ ³⁵ ³⁶ ³⁷ ³⁸ ³⁹ ⁴⁰ ⁴¹ ⁴² ⁴³ ⁴⁴ ⁴⁵ ⁴⁶ ⁴⁷ ⁴⁸ ⁴⁹ ⁵⁰ ⁵¹ ⁵² ⁵³ ⁵⁴ ⁵⁵ ⁵⁶ ⁵⁷ ⁵⁸ ⁵⁹ ⁶⁰ ⁶¹ ⁶² ⁶³ ⁶⁴ ⁶⁵ ⁶⁶ ⁶⁷ ⁶⁸ ⁶⁹ ⁷⁰ ⁷¹ ⁷² ⁷³ ⁷⁴ ⁷⁵ ⁷⁶ ⁷⁷ ⁷⁸ ⁷⁹ ⁸⁰ ⁸¹ ⁸² ⁸³ ⁸⁴ ⁸⁵ ⁸⁶ ⁸⁷ ⁸⁸ ⁸⁹ ⁹⁰ ⁹¹ ⁹² ⁹³ ⁹⁴ ⁹⁵ ⁹⁶ ⁹⁷ ⁹⁸ ⁹⁹ ¹⁰⁰',
      'did we get correct increments on ⁰';

    is (^101).map({--$à}),
      '¹⁰⁰ ⁰⁹⁹ ⁰⁹⁸ ⁰⁹⁷ ⁰⁹⁶ ⁰⁹⁵ ⁰⁹⁴ ⁰⁹³ ⁰⁹² ⁰⁹¹ ⁰⁹⁰ ⁰⁸⁹ ⁰⁸⁸ ⁰⁸⁷ ⁰⁸⁶ ⁰⁸⁵ ⁰⁸⁴ ⁰⁸³ ⁰⁸² ⁰⁸¹ ⁰⁸⁰ ⁰⁷⁹ ⁰⁷⁸ ⁰⁷⁷ ⁰⁷⁶ ⁰⁷⁵ ⁰⁷⁴ ⁰⁷³ ⁰⁷² ⁰⁷¹ ⁰⁷⁰ ⁰⁶⁹ ⁰⁶⁸ ⁰⁶⁷ ⁰⁶⁶ ⁰⁶⁵ ⁰⁶⁴ ⁰⁶³ ⁰⁶² ⁰⁶¹ ⁰⁶⁰ ⁰⁵⁹ ⁰⁵⁸ ⁰⁵⁷ ⁰⁵⁶ ⁰⁵⁵ ⁰⁵⁴ ⁰⁵³ ⁰⁵² ⁰⁵¹ ⁰⁵⁰ ⁰⁴⁹ ⁰⁴⁸ ⁰⁴⁷ ⁰⁴⁶ ⁰⁴⁵ ⁰⁴⁴ ⁰⁴³ ⁰⁴² ⁰⁴¹ ⁰⁴⁰ ⁰³⁹ ⁰³⁸ ⁰³⁷ ⁰³⁶ ⁰³⁵ ⁰³⁴ ⁰³³ ⁰³² ⁰³¹ ⁰³⁰ ⁰²⁹ ⁰²⁸ ⁰²⁷ ⁰²⁶ ⁰²⁵ ⁰²⁴ ⁰²³ ⁰²² ⁰²¹ ⁰²⁰ ⁰¹⁹ ⁰¹⁸ ⁰¹⁷ ⁰¹⁶ ⁰¹⁵ ⁰¹⁴ ⁰¹³ ⁰¹² ⁰¹¹ ⁰¹⁰ ⁰⁰⁹ ⁰⁰⁸ ⁰⁰⁷ ⁰⁰⁶ ⁰⁰⁵ ⁰⁰⁴ ⁰⁰³ ⁰⁰² ⁰⁰¹ ⁰⁰⁰',
      'did we get correct decrements on ¹⁰⁰';
}

# vim: expandtab shiftwidth=4
