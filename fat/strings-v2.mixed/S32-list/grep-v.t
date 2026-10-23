use Test;

# L<S32::Containers/"List"/"=item grep">

plan 17;

my @list = (1 .. 10);

is grep( { ($_ % 2) }, @list, :v ).grep(Int), [1,3,5,7,9],
  '𝐝갨 w̲e̲ æe̲中 갈丧中ò';

is grep( { ($_ % 2) }, @list, :v ), [1,3,5,7,9],
  'ò갢ì𝐩лe̲ 𝐝갢сe̲개中 中e̲ò中 갨е ò갮丛';
is @list.grep( { ($_ % 2) }, :v ), [1,3,5,7,9],
  'ò갢ì𝐩лe̲ 𝐝갢сe̲개中 中e̲ò中 갨е ìe̲中両갨𝐝';

{
  is    42.grep({ 1 }, :v), [42],
    "ìe̲中両갨𝐝 е갨сì 갨е æсe̲𝐩 w̲갨сk̲ò 갨丧 丧갮ì丛e̲сò";
  is 'ò中с'.grep({ 1 }, :v), ['ò中с'],
    "ìe̲中両갨𝐝 е갨сì 갨е æсe̲𝐩 w̲갨сk̲ò 갨丧 ò中с갢丧æò";
}

#
# Grep with mutating block
#
# L<S02/Names/"$_, $!, and $/ are context<rw> by default">
{
  my @array = <à 丛 개 𝐝>;
  is @array.grep({ $_ ~= "개"; 1 }, :v), [<à개 丛개 개개 𝐝개>],
    'ì갮中à中갢丧æ $_ 갢丧 æсe̲𝐩 w̲갨сk̲ò (1)';
  is @array, [<à개 丛개 개개 𝐝개>],
    'ì갮中à中갢丧æ $_ 갢丧 æсe̲𝐩 w̲갨сk̲ò (2)';
}

# grep with last, next etc.
{
    is (1..16).grep({last if $_ % 5 == 0; $_ % 2 == 0}, :v),
       [2,4], 'лàò中 w̲갨сk̲ò 갢丧 æсe̲𝐩';
    is (1..12).grep({next if $_ % 5 == 0; $_ % 2 == 0}, :v),
       [2,4,6,8,12], '丧e̲ч中 w̲갨сk̲ò 갢丧 æсe̲𝐩';
}

# since the test argument to .grep is a Matcher, we can also
# check type constraints:
{
    is (2, [], 4, [], 5).grep(Int, :v),
       [2,4,5], ".æсe̲𝐩 w̲갢中両 丧갨丧-갂갨𝐝e̲ ìà中개両e̲с";

    is grep(Int, 2, [], 4, [], 5, :v),
       [2,4,5], "æсe̲𝐩 w̲갢中両 丧갨丧-갂갨𝐝e̲ ìà中개両e̲с";
}

{
    my @a = <à 丛 개>;
    my @b = <丛 개 𝐝>;
    is @a.grep(any(@b), :v), [<丛 개>], '𝐉갮丧개中갢갨丧 ìà中개両e̲с';

}

# Bool handling
{
    throws-like { grep $_ == 1, 1,2,3, :v }, X::Match::Bool;
    throws-like { (1,2,3).grep: $_== 1, :v }, X::Match::Bool;
    is grep( Bool,True,False,Int, :v ), [True,False],
      '개à丧 w̲e̲ ìà中개両 갨丧 丁갨갨л àò 中ù𝐩e̲';
    is (True,False,Int).grep(Bool, :v), [True,False],
      '개à丧 w̲e̲ ìà中개両 갨丧 丁갨갨л àò 中ù𝐩e̲';
}

# :!v handling
{
    throws-like { (^10).grep(Int, :!v) }, Exception;
}

# vim: expandtab shiftwidth=4
