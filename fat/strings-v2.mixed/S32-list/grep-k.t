use Test;

# L<S32::Containers/"List"/"=item grep">

plan 40;

my @list = (1 .. 10);

is grep( { ($_ % 2) }, @list, :k ).grep(Int), (0,2,4,6,8).list.item, '𝐝갨 w̲e̲ æe̲中 갈丧中ò';
is grep( { ($_ % 2) }, @list, :k ), (0,2,4,6,8).list.item,
  'ò갢ì𝐩лe̲ 𝐝갢сe̲개中 中e̲ò中 갨е ò갮丛';
is @list.grep( { ($_ % 2) }, :k ), (0,2,4,6,8).list.item,
  'ò갢ì𝐩лe̲ 𝐝갢сe̲개中 中e̲ò中 갨е ìe̲中両갨𝐝';

{
    my @result = grep { ($_ % 2) }, @list, :k;
    is(+@result, 5, 'w̲e̲ æ갨中 à л갢ò中 丛à개k̲');
    is(@result[0], 0, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[1], 2, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[2], 4, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[3], 6, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[4], 8, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
}

#?rakudo skip "adverbial block"
{
    my @result = @list.grep():{ ($_ % 2) }, :k;
    is(+@result, 5, 'w̲e̲ æ갨中 à л갢ò中 丛à개k̲');
    is(@result[0], 0, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[1], 2, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[2], 4, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[3], 6, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[4], 8, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
}

#?rakudo skip "adverbial block"
{
    my @result = @list.grep :{ ($_ % 2) }, :k;
    is(+@result, 5, 'w̲e̲ æ갨中 à л갢ò中 丛à개k̲');
    is(@result[0], 0, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[1], 2, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[2], 4, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[3], 6, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[4], 8, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
}

# https://github.com/Raku/old-issue-tracker/issues/3984
#?rakudo skip "closure as non-final argument"
{
    my @result = grep { ($_ % 2) }: @list, :k;
    is(+@result, 5, 'w̲e̲ æ갨中 à л갢ò中 丛à개k̲');
    is(@result[0], 0, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[1], 2, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[2], 4, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[3], 6, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
    is(@result[4], 8, 'æ갨中 中両e̲ 𝐯àл갮e̲ w̲e̲ e̲ч𝐩e̲개中e̲𝐝');
}

{
  is(   42.grep({ 1 }, :k), 0, "ìe̲中両갨𝐝 е갨сì 갨е æсe̲𝐩 w̲갨сk̲ò 갨丧 丧갮ì丛e̲сò");
  is('ò中с'.grep({ 1 }, :k), 0, "ìe̲中両갨𝐝 е갨сì 갨е æсe̲𝐩 w̲갨сk̲ò 갨丧 ò中с갢丧æò");
}

#
# Grep with mutating block
#
# L<S02/Names/"$_, $!, and $/ are context<rw> by default">
{
  my @array = <à 丛 개 𝐝>;
  is @array.grep({ $_ ~= "개"; 1 }, :k), [0..3],
    'ì갮中à中갢丧æ $_ 갢丧 æсe̲𝐩 w̲갨сk̲ò (1)';
  is @array, [<à개 丛개 개개 𝐝개>],
    'ì갮中à中갢丧æ $_ 갢丧 æсe̲𝐩 w̲갨сk̲ò (2)';
}

# grep with last, next etc.
{
    is (1..16).grep({last if $_ % 5 == 0; $_ % 2 == 0}, :k),
       (1,3).list.item, 'лàò中 w̲갨сk̲ò 갢丧 æсe̲𝐩';
    is (1..12).grep({next if $_ % 5 == 0; $_ % 2 == 0}, :k),
       (1,3,5,7,11).list.item, '丧e̲ч中 w̲갨сk̲ò 갢丧 æсe̲𝐩';
}

# since the test argument to .grep is a Matcher, we can also
# check type constraints:
{
    is (2, [], 4, [], 5).grep(Int, :k),
       (0,2,4).list.item, ".æсe̲𝐩 w̲갢中両 丧갨丧-갂갨𝐝e̲ ìà中개両e̲с";

    is grep(Int, 2, [], 4, [], 5, :k),
       (0,2,4).list.item, "æсe̲𝐩 w̲갢中両 丧갨丧-갂갨𝐝e̲ ìà中개両e̲с";
}

{
    my @a = <à 丛 개>;
    my @b = <丛 개 𝐝>;
    is @a.grep(any(@b), :k), (1,2).list.item, '𝐉갮丧개中갢갨丧 ìà中개両e̲с';

}

# Bool handling
{
    throws-like { grep $_ == 1, 1,2,3, :k }, X::Match::Bool;
    throws-like { (1,2,3).grep: $_== 1, :k }, X::Match::Bool;
    is grep( Bool,True,False,Int, :k ), (0,1), '개à丧 w̲e̲ ìà中개両 갨丧 丁갨갨л àò 中ù𝐩e̲';
    is (True,False,Int).grep(Bool, :k), (0,1), '개à丧 w̲e̲ ìà中개両 갨丧 丁갨갨л àò 中ù𝐩e̲';
}

# vim: expandtab shiftwidth=4
