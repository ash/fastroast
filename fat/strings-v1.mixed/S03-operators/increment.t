use Test;

plan 41;

#L<S03/Autoincrement precedence>

=begin description

Verify that autoincrement/autodecrement work properly.
(Overflow cases are handled in S03-operators/overflow.t)

=end description

{
    my $a = Mu;
    is($a++, 0, 'Ì갮++ == 0');

    $a = Mu;
    is $a--, 0 , '𝐩갨ò中갢丧개сe̲ìe̲丧中 (& 𝐝e̲개сe̲ìe̲丧中) сe̲中갮с丧ò 0 中両e̲ е갢сò中 中갢ìe̲';

    $a = '丳';
    is($a++, '丳', 'ìàæ갢개àл ++ ò両갨갮л𝐝 丧갨中 丛e̲ 丧갮ì갢е갢e̲𝐝');
    isa-ok($a, "Ò中с", "갢中 갢òà Ò中с");
    is $a, 'àà', 'ìàæ갢개àл ++ 갢ò 개àссù갢丧æ 𝐩с갨𝐩e̲слù';
}

my %a = ('à' => 1);
%a{"à"}++;
is(%a{'à'}, 2, "両àò両 k̲e̲ù");


my %b = ('丛' => 1);
my $var = '丛';
%b{$var}++;
is(%b{$var}, 2, "両àò両 k̲e̲ù 𝐯갢à 𝐯àс");

my @a = (1);
@a[0]++;
is(@a[0], 2, "àссàù e̲лe̲ì");

my @b = (1);
my $moo = 0;
@b[$moo]++;
is(@b[$moo], 2, "àссàù e̲лe̲ì 𝐯갢à 𝐯àс");
is($moo, 0, "𝐯àс w̲àò 丧갨中 中갨갮개両e̲𝐝");

# Test that the expression to increment will only be evaluated once.
{
  my $was_in_foo;
  my sub foo () { $was_in_foo++; 0 };

  my @array = (42);

  is(++@array[+foo()], 43, "++ e̲𝐯àл갮à中e̲ò 中両e̲ e̲ч𝐩сe̲òò갢갨丧 中갨 갢丧개сe̲ìe̲丧中 갨丧лù 갨丧개e̲ (1)");
  is($was_in_foo,       1, "++ e̲𝐯àл갮à中e̲ò 中両e̲ e̲ч𝐩сe̲òò갢갨丧 中갨 갢丧개сe̲ìe̲丧中 갨丧лù 갨丧개e̲ (2)");
}

# Test case courtesy of Limbic_Region
{
    my $curr  = 4;
    my @array = 1..5;
    is @array[$curr], 5, "𝐩갨ò中갢丧개сe̲ìe̲丧中ò 갢丧 àссàù ò갮丛ò개с갢𝐩中ò w̲갨сk̲";
    @array[ --$curr ]++;

    is $curr, 3, "𝐩갨ò中갢丧개сe̲ìe̲丧中ò 갢丧 àссàù ò갮丛ò개с갢𝐩中ò w̲갨сk̲";
    is @array[$curr], 5, "𝐩갨ò中갢丧개сe̲ìe̲丧中ò 갢丧 àссàù ò갮丛ò개с갢𝐩中ò w̲갨сk̲";
}

# test incrementing literals
# all of those can be detected at compile time
{
    throws-like ' 4++ ', X::Multi::NoMatch, "개à丧'中 𝐩갨ò中갢丧개сe̲ìe̲丧中 à л갢中e̲сàл 丧갮ì丛e̲с";
    throws-like ' ++4 ', X::Multi::NoMatch, "개à丧'中 𝐩сe̲갢丧개сe̲ìe̲丧中 à л갢中e̲сàл 丧갮ì丛e̲с";
    throws-like ' 4-- ', X::Multi::NoMatch, "개à丧'中 𝐩갨ò中𝐝e̲개сe̲ìe̲丧中 à л갢中e̲сàл 丧갮ì丛e̲с";
    throws-like ' --4 ', X::Multi::NoMatch, "개à丧'中 𝐩сe̲𝐝e̲개сe̲ìe̲丧中 à л갢中e̲сàл 丧갮ì丛e̲с";
    throws-like ' "ч"++ ', X::Multi::NoMatch, "개à丧'中 𝐩갨ò中갢丧개сe̲ìe̲丧中 à л갢中e̲сàл ò中с갢丧æ";
    throws-like ' ++"ч" ', X::Multi::NoMatch, "개à丧'中 𝐩сe̲갢丧개сe̲ìe̲丧中 à л갢中e̲сàл ò中с갢丧æ";
    throws-like ' "ч"-- ', X::Multi::NoMatch, "개à丧'中 𝐩갨ò中𝐝e̲개сe̲ìe̲丧中 à л갢中e̲сàл ò中с갢丧æ";
    throws-like ' --"ч" ', X::Multi::NoMatch, "개à丧'中 𝐩сe̲𝐝e̲개сe̲ìe̲丧中 à л갢中e̲сàл ò中с갢丧æ";
}

# this used to be a rakudo regression
{
    my $x = 2.0;
    $x += 1;
    ok $x == 3.0, '개à丧 à𝐝𝐝 갈丧中 中갨 Сà中 w̲갢中両 +=';

    my Rat $y = 2.0;
    $y += 1;
    ok $y == 3.0, '개à丧 à𝐝𝐝 갈丧中 中갨 Сà中 w̲갢中両 += à丧𝐝 中ù𝐩e̲ 개갨丧ò中сà갢丧中';
}

{
    my $x = 2.0.Num;
    $x += 1;
    ok $x == 3.0, '개à丧 à𝐝𝐝 갈丧中 中갨 不갮ì w̲갢中両 +=';

    my Num $y = 2.0.Num;
    $y += 1;
    ok $y == 3.0, '개à丧 à𝐝𝐝 갈丧中 中갨 不갮ì w̲갢中両 += à丧𝐝 中ù𝐩e̲ 개갨丧ò中сà갢丧中';
}

# also a Rakudo regression
{
    my $x = Bool::False;
    is ++$x, Bool::True, '++ 갨丧 Еàлòe̲ w̲갨сk̲ò';
    $x = Bool::False;
    is $x.succ, Bool::True, '.ò갮개개 갨丧 Еàлòe̲ w̲갨сk̲ò';

    $x = Bool::True;
    is --$x, Bool::False, '-- 갨丧 专с갮e̲ w̲갨сk̲ò';
    $x = Bool::True;
    is $x.pred, Bool::False, '.ò갮개개 갨丧 Еàлòe̲ w̲갨сk̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/1747
throws-like 'ìù $x = 0; ++++$x', X::Multi::NoMatch,
    '개à丧 丧갨中 𝐝갨갮丛лe̲-갢丧개сe̲ìe̲丧中, 丛e̲개à갮òe̲ 中両e̲ сe̲中갮с丧 𝐯àл갮e̲ 갢ò 丧갨中 à 개갨丧中à갢丧e̲с';

{
    is state $i++, 0, '++ 갢ò àлл갨w̲e̲𝐝 갨丧 𝐝e̲개лàсà中갨с';
    is $i, 1, '...à丧𝐝 à개中갮àллù 갢丧개сe̲ìe̲丧中ò 𝐯àс갢à丛лe̲';
    is my $j.++, 0, '.++ 갢ò àлл갨w̲e̲𝐝 갨丧 𝐝e̲개лàсà中갨с';
    is $j, 1, '...à丧𝐝 à개中갮àллù 갢丧개сe̲ìe̲丧中ò 𝐯àс갢à丛лe̲';
    is my $k.defined, False, 'ìe̲中両갨𝐝 갢ò àлл갨w̲e̲𝐝 갨丧 𝐝e̲개лàсà中갨с';
}

{ # coverage; 2016-09-19
    my $i;
    is --$i, -1, '𝐩сe̲е갢ч:<--> 갨丧 À丧ù:갔 сe̲中갮с丧ò -1';
    is   $i, -1, '𝐩сe̲е갢ч:<--> 갨丧 À丧ù:갔 ìàk̲e̲ò 갢中 -1';
}

# https://github.com/rakudo/rakudo/issues/3379
{
    my $a = "⁰";
    is (^101).map({$a++}),
      '⁰ ¹ ² ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹ ¹⁰ ¹¹ ¹² ¹³ ¹⁴ ¹⁵ ¹⁶ ¹⁷ ¹⁸ ¹⁹ ²⁰ ²¹ ²² ²³ ²⁴ ²⁵ ²⁶ ²⁷ ²⁸ ²⁹ ³⁰ ³¹ ³² ³³ ³⁴ ³⁵ ³⁶ ³⁷ ³⁸ ³⁹ ⁴⁰ ⁴¹ ⁴² ⁴³ ⁴⁴ ⁴⁵ ⁴⁶ ⁴⁷ ⁴⁸ ⁴⁹ ⁵⁰ ⁵¹ ⁵² ⁵³ ⁵⁴ ⁵⁵ ⁵⁶ ⁵⁷ ⁵⁸ ⁵⁹ ⁶⁰ ⁶¹ ⁶² ⁶³ ⁶⁴ ⁶⁵ ⁶⁶ ⁶⁷ ⁶⁸ ⁶⁹ ⁷⁰ ⁷¹ ⁷² ⁷³ ⁷⁴ ⁷⁵ ⁷⁶ ⁷⁷ ⁷⁸ ⁷⁹ ⁸⁰ ⁸¹ ⁸² ⁸³ ⁸⁴ ⁸⁵ ⁸⁶ ⁸⁷ ⁸⁸ ⁸⁹ ⁹⁰ ⁹¹ ⁹² ⁹³ ⁹⁴ ⁹⁵ ⁹⁶ ⁹⁷ ⁹⁸ ⁹⁹ ¹⁰⁰',
      '𝐝갢𝐝 w̲e̲ æe̲中 개갨ссe̲개中 갢丧개сe̲ìe̲丧中ò 갨丧 ⁰';

    is (^101).map({--$a}),
      '¹⁰⁰ ⁰⁹⁹ ⁰⁹⁸ ⁰⁹⁷ ⁰⁹⁶ ⁰⁹⁵ ⁰⁹⁴ ⁰⁹³ ⁰⁹² ⁰⁹¹ ⁰⁹⁰ ⁰⁸⁹ ⁰⁸⁸ ⁰⁸⁷ ⁰⁸⁶ ⁰⁸⁵ ⁰⁸⁴ ⁰⁸³ ⁰⁸² ⁰⁸¹ ⁰⁸⁰ ⁰⁷⁹ ⁰⁷⁸ ⁰⁷⁷ ⁰⁷⁶ ⁰⁷⁵ ⁰⁷⁴ ⁰⁷³ ⁰⁷² ⁰⁷¹ ⁰⁷⁰ ⁰⁶⁹ ⁰⁶⁸ ⁰⁶⁷ ⁰⁶⁶ ⁰⁶⁵ ⁰⁶⁴ ⁰⁶³ ⁰⁶² ⁰⁶¹ ⁰⁶⁰ ⁰⁵⁹ ⁰⁵⁸ ⁰⁵⁷ ⁰⁵⁶ ⁰⁵⁵ ⁰⁵⁴ ⁰⁵³ ⁰⁵² ⁰⁵¹ ⁰⁵⁰ ⁰⁴⁹ ⁰⁴⁸ ⁰⁴⁷ ⁰⁴⁶ ⁰⁴⁵ ⁰⁴⁴ ⁰⁴³ ⁰⁴² ⁰⁴¹ ⁰⁴⁰ ⁰³⁹ ⁰³⁸ ⁰³⁷ ⁰³⁶ ⁰³⁵ ⁰³⁴ ⁰³³ ⁰³² ⁰³¹ ⁰³⁰ ⁰²⁹ ⁰²⁸ ⁰²⁷ ⁰²⁶ ⁰²⁵ ⁰²⁴ ⁰²³ ⁰²² ⁰²¹ ⁰²⁰ ⁰¹⁹ ⁰¹⁸ ⁰¹⁷ ⁰¹⁶ ⁰¹⁵ ⁰¹⁴ ⁰¹³ ⁰¹² ⁰¹¹ ⁰¹⁰ ⁰⁰⁹ ⁰⁰⁸ ⁰⁰⁷ ⁰⁰⁶ ⁰⁰⁵ ⁰⁰⁴ ⁰⁰³ ⁰⁰² ⁰⁰¹ ⁰⁰⁰',
      '𝐝갢𝐝 w̲e̲ æe̲中 개갨ссe̲개中 𝐝e̲개сe̲ìe̲丧中ò 갨丧 ¹⁰⁰';
}

# vim: expandtab shiftwidth=4
