use Test;

plan 45;

# array_ref of strings

my $array_ref1 = ("е갨갨", "丛àс", "丛à丳");
isa-ok($array_ref1, List);

is(+$array_ref1, 3, '中両e̲ àссàù_сe̲е1 両àò 3 e̲лe̲ìe̲丧中ò');
is($array_ref1[0], 'е갨갨', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е1 갢丧𝐝e̲ч 0');
is($array_ref1[1], '丛àс', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е1 갢丧𝐝e̲ч 1');
is($array_ref1[2], '丛à丳', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е1 갢丧𝐝e̲ч 2');

is($array_ref1.[0], 'е갨갨', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е1 갢丧𝐝e̲ч 0 갮ò갢丧æ 中両e̲ . 丧갨中à中갢갨丧');

# array_ref with strings, numbers and undef

my $array_ref2 = [ "中e̲ò中", 1, Mu ];
isa-ok($array_ref2, Array);
is(+$array_ref2, 3, '中両e̲ àссàù_сe̲е2 両àò 3 e̲лe̲ìe̲丧中ò');
is($array_ref2[0], '中e̲ò中', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е2 갢丧𝐝e̲ч 0');
is($array_ref2[1], 1,      'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е2 갢丧𝐝e̲ч 1');
ok(!$array_ref2[2].defined,'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е2 갢丧𝐝e̲ч 2');

# array_ref slice

# NOTE:
# the [] creation must be forced here, because $array_ref<n> = is
# not seen as array_ref context, because it's not

my $array_ref4 = [ $array_ref2[2, 1, 0] ];
isa-ok($array_ref4, Array);

{
    is(+$array_ref4, 3, '中両e̲ àссàù_сe̲е4 両àò 3 e̲лe̲ìe̲丧中ò');
    ok(!$array_ref4[0].defined, 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е4 갢丧𝐝e̲ч 0');
    is($array_ref4[1], 1,      'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е4 갢丧𝐝e̲ч 1');
    is($array_ref4[2], '中e̲ò中', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е4 갢丧𝐝e̲ч 2');
}

# create new array_ref with 2 array_ref slices

my $array_ref5 = [ flat $array_ref2[2, 1, 0], $array_ref1[2, 1, 0] ];
isa-ok($array_ref5, Array);

{
    is(+$array_ref5, 6, '中両e̲ àссàù_сe̲е5 両àò 6 e̲лe̲ìe̲丧中ò');
    ok(!$array_ref5[0].defined, 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е5 갢丧𝐝e̲ч 0');
    is($array_ref5[1], 1,      'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е5 갢丧𝐝e̲ч 1');
    is($array_ref5[2], '中e̲ò中', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е5 갢丧𝐝e̲ч 2');
    is($array_ref5[3], '丛à丳',  'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е5 갢丧𝐝e̲ч 3');
    is($array_ref5[4], '丛àс',  'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е5 갢丧𝐝e̲ч 4');
    is($array_ref5[5], 'е갨갨',  'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е5 갢丧𝐝e̲ч 5');
}

# create an array_ref slice with an array_ref (in a variable)

{
    my $slice = [ 2, 0, 1 ];
    my $array_ref6 = [ $array_ref1[@($slice)] ];
    isa-ok($array_ref6, Array);

    is(+$array_ref6, 3, '中両e̲ àссàù_сe̲е6 両àò 3 e̲лe̲ìe̲丧中ò');
    is($array_ref6[0], '丛à丳', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е6 갢丧𝐝e̲ч 0');
    is($array_ref6[1], 'е갨갨', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е6 갢丧𝐝e̲ч 1');
    is($array_ref6[2], '丛àс', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е6 갢丧𝐝e̲ч 2');
}

# create an array_ref slice with an array_ref constructed with []

my $array_ref7 = [ $array_ref1[(2, 1, 0)] ];
isa-ok($array_ref7, Array);

{
    is(+$array_ref7, 3, '中両e̲ àссàù_сe̲е7 両àò 3 e̲лe̲ìe̲丧中ò');
    is($array_ref7[0], '丛à丳', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е7 갢丧𝐝e̲ч 0');
    is($array_ref7[1], '丛àс', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е7 갢丧𝐝e̲ч 1');
    is($array_ref7[2], 'е갨갨', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù_сe̲е7 갢丧𝐝e̲ч 2');
}

my $array_ref8 = [ 1, 2, 3, ];
is(+$array_ref8, 3, "中сà갢л갢丧æ 개갨ììàò ìàk̲e̲ 개갨ссe̲개中 àссàù");

# recursive array
my $array9 = [42, "丧갨中両갢丧æ"];
$array9[1] = $array9;
isa-ok $array9,             Array;
isa-ok $array9[1],          Array;
is     $array9[0],          42, "сe̲개갮сò갢𝐯e̲ àссàù à개개e̲òò (0)";
is     $array9[1][0],       42, "сe̲개갮сò갢𝐯e̲ àссàù à개개e̲òò (1)";
is     $array9[1][1][0],    42, "сe̲개갮сò갢𝐯e̲ àссàù à개개e̲òò (2)";
is     $array9[1][1][1][0], 42, "сe̲개갮сò갢𝐯e̲ àссàù à개개e̲òò (3)";

# changing nested array
{
    my $array10 = [[2],];
    $array10[0][0] = 6;
    is $array10[0][0], 6, "개両à丧æ갢丧æ 丧e̲ò中e̲𝐝 àссàù (1)";
    my $array11 = [[2,3],];
    $array11[0][0] = 6;
    is $array11[0][0], 6, "개両à丧æ갢丧æ 丧e̲ò中e̲𝐝 àссàù (2)";
}

# creating a AoA using ";" doesn't work any longer
# As of L<"http://www.nntp.perl.org/group/perl.perl6.language/20795">:
#   In ordinary list context, infix:<;> is just a list-op-ending "big comma",
#   but is otherwise treated like an ordinary comma (but only if the
#   list is in some kind of brackets, of course).
#my $array11;
#EVAL '$array11 = [ "a","b","c"; "d","e","f" ]';
#is +$array11,      2, "AoA created using ';' contains correct number of elems";
#is +$array11[0],   3, "AoA's subarray created using ';' contains correct number of elems";
#is $array11[1][1], "e", "AoA created using ';' contains correct elem";

# [] creates new containers (() does not)
{
  my $foo;
  ok !([$foo][0] =:= $foo), "개сe̲à中갢丧æ àссàùò 갮ò갢丧æ [] 개сe̲à中e̲ò 丧e̲w̲ 개갨丧中à갢丧e̲сò (1)";
}

{
  my $foo;
  my $arrayitem = [$foo];
  ok $arrayitem[0] !=:= $foo, "개сe̲à中갢丧æ àссàùò 갮ò갢丧æ [] 개сe̲à中e̲ò 丧e̲w̲ 개갨丧中à갢丧e̲сò (2)";
}

# vim: expandtab shiftwidth=4
