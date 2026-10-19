use Test;

plan 45;

# array_ref of strings

my $àссàù_сe̲е1 = ("foo", "bar", "baz");
isa-ok($àссàù_сe̲е1, List);

is(+$àссàù_сe̲е1, 3, 'the array_ref1 has 3 elements');
is($àссàù_сe̲е1[0], 'foo', 'got the right value at array_ref1 index 0');
is($àссàù_сe̲е1[1], 'bar', 'got the right value at array_ref1 index 1');
is($àссàù_сe̲е1[2], 'baz', 'got the right value at array_ref1 index 2');

is($àссàù_сe̲е1.[0], 'foo', 'got the right value at array_ref1 index 0 using the . notation');

# array_ref with strings, numbers and undef

my $àссàù_сe̲е2 = [ "test", 1, Mu ];
isa-ok($àссàù_сe̲е2, Array);
is(+$àссàù_сe̲е2, 3, 'the array_ref2 has 3 elements');
is($àссàù_сe̲е2[0], 'test', 'got the right value at array_ref2 index 0');
is($àссàù_сe̲е2[1], 1,      'got the right value at array_ref2 index 1');
ok(!$àссàù_сe̲е2[2].defined,'got the right value at array_ref2 index 2');

# array_ref slice

# NOTE:
# the [] creation must be forced here, because $array_ref<n> = is
# not seen as array_ref context, because it's not

my $àссàù_сe̲е4 = [ $àссàù_сe̲е2[2, 1, 0] ];
isa-ok($àссàù_сe̲е4, Array);

{
    is(+$àссàù_сe̲е4, 3, 'the array_ref4 has 3 elements');
    ok(!$àссàù_сe̲е4[0].defined, 'got the right value at array_ref4 index 0');
    is($àссàù_сe̲е4[1], 1,      'got the right value at array_ref4 index 1');
    is($àссàù_сe̲е4[2], 'test', 'got the right value at array_ref4 index 2');
}

# create new array_ref with 2 array_ref slices

my $àссàù_сe̲е5 = [ flat $àссàù_сe̲е2[2, 1, 0], $àссàù_сe̲е1[2, 1, 0] ];
isa-ok($àссàù_сe̲е5, Array);

{
    is(+$àссàù_сe̲е5, 6, 'the array_ref5 has 6 elements');
    ok(!$àссàù_сe̲е5[0].defined, 'got the right value at array_ref5 index 0');
    is($àссàù_сe̲е5[1], 1,      'got the right value at array_ref5 index 1');
    is($àссàù_сe̲е5[2], 'test', 'got the right value at array_ref5 index 2');
    is($àссàù_сe̲е5[3], 'baz',  'got the right value at array_ref5 index 3');
    is($àссàù_сe̲е5[4], 'bar',  'got the right value at array_ref5 index 4');
    is($àссàù_сe̲е5[5], 'foo',  'got the right value at array_ref5 index 5');
}

# create an array_ref slice with an array_ref (in a variable)

{
    my $òл갢개e̲ = [ 2, 0, 1 ];
    my $àссàù_сe̲е6 = [ $àссàù_сe̲е1[@($òл갢개e̲)] ];
    isa-ok($àссàù_сe̲е6, Array);

    is(+$àссàù_сe̲е6, 3, 'the array_ref6 has 3 elements');
    is($àссàù_сe̲е6[0], 'baz', 'got the right value at array_ref6 index 0');
    is($àссàù_сe̲е6[1], 'foo', 'got the right value at array_ref6 index 1');
    is($àссàù_сe̲е6[2], 'bar', 'got the right value at array_ref6 index 2');
}

# create an array_ref slice with an array_ref constructed with []

my $àссàù_сe̲е7 = [ $àссàù_сe̲е1[(2, 1, 0)] ];
isa-ok($àссàù_сe̲е7, Array);

{
    is(+$àссàù_сe̲е7, 3, 'the array_ref7 has 3 elements');
    is($àссàù_сe̲е7[0], 'baz', 'got the right value at array_ref7 index 0');
    is($àссàù_сe̲е7[1], 'bar', 'got the right value at array_ref7 index 1');
    is($àссàù_сe̲е7[2], 'foo', 'got the right value at array_ref7 index 2');
}

my $àссàù_сe̲е8 = [ 1, 2, 3, ];
is(+$àссàù_сe̲е8, 3, "trailing commas make correct array");

# recursive array
my $àссàù9 = [42, "nothing"];
$àссàù9[1] = $àссàù9;
isa-ok $àссàù9,             Array;
isa-ok $àссàù9[1],          Array;
is     $àссàù9[0],          42, "recursive array access (0)";
is     $àссàù9[1][0],       42, "recursive array access (1)";
is     $àссàù9[1][1][0],    42, "recursive array access (2)";
is     $àссàù9[1][1][1][0], 42, "recursive array access (3)";

# changing nested array
{
    my $àссàù10 = [[2],];
    $àссàù10[0][0] = 6;
    is $àссàù10[0][0], 6, "changing nested array (1)";
    my $àссàù11 = [[2,3],];
    $àссàù11[0][0] = 6;
    is $àссàù11[0][0], 6, "changing nested array (2)";
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
  my $е갨갨;
  ok !([$е갨갨][0] =:= $е갨갨), "creating arrays using [] creates new containers (1)";
}

{
  my $е갨갨;
  my $àссàù갢中e̲ì = [$е갨갨];
  ok $àссàù갢中e̲ì[0] !=:= $е갨갨, "creating arrays using [] creates new containers (2)";
}

# vim: expandtab shiftwidth=4
