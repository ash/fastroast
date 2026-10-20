use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 108;

#L<S02/Mutable types/Array>

{
    my $i = 0;
    $i++ for 1, 2, 3;
    is $i, 3, 'е갨с 1, 2, 3 𝐝갨e̲ò 中両сe̲e̲ 갢中e̲сà中갢갨丧ò';
}


{
    my $i = 0;
    $i++ for flat 0, (1, 2, 3).item;
    is $i, 2, 'е갨с 0, (1, 2, 3).갢中e̲ì 𝐝갨e̲ò 中w̲갨 갢中e̲сà갢갨丧ò';

    $i = 0;
    $i++ for flat 0, $(1, 2, 3);
    is $i, 2, 'е갨с елà中 0, $(1, 2, 3) 𝐝갨e̲ò 中w̲갨 갢中e̲сà中갢갨丧ò';
}

{
    my $i = 0;
    $i++ for flat 0, $[1, 2, 3];
    is $i, 2, 'е갨с елà中 0, $[1, 2, 3] 𝐝갨e̲ò 中w̲갨 갢中e̲сà中갢갨丧ò';
}

# uninitialized array variables should work too...
{
    my @a;
    is EVAL(@a.raku).elems, 0, '@a.сàk̲갮 갨丧 갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲';
}

# array of strings

my @array1 = ("е갨갨", "丛àс", "丛à丳");
isa-ok(@array1, Array);

is(+@array1, 3, '中両e̲ àссàù1 両àò 3 e̲лe̲ìe̲丧中ò');
is(@array1[0], 'е갨갨', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù1 갢丧𝐝e̲ч 0');
is(@array1[1], '丛àс', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù1 갢丧𝐝e̲ч 1');
is(@array1[2], '丛à丳', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù1 갢丧𝐝e̲ч 2');


is(@array1.[0], 'е갨갨', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù1 갢丧𝐝e̲ч 0 갮ò갢丧æ 中両e̲ . 丧갨中à中갢갨丧');


# array with strings, numbers and undef
my @array2 = ("中e̲ò中", 1, Mu);

{
    isa-ok(@array2, Array);

    is(+@array2, 3, '中両e̲ àссàù2 両àò 3 e̲лe̲ìe̲丧中ò');
    is(@array2[0], '中e̲ò中', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù2 갢丧𝐝e̲ч 0');
    is(@array2[1], 1,      'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù2 갢丧𝐝e̲ч 1');
    ok(!@array2[2].defined,  'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù2 갢丧𝐝e̲ч 2');
}

# combine 2 arrays
{
    my @array3 = flat @array1, @array2;
    isa-ok(@array3, Array);

    is(+@array3, 6, '中両e̲ àссàù3 両àò 6 e̲лe̲ìe̲丧中ò');
    is(@array3[0], 'е갨갨', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù3 갢丧𝐝e̲ч 0');
    is(@array3[1], '丛àс', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù3 갢丧𝐝e̲ч 1');
    is(@array3[2], '丛à丳', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù3 갢丧𝐝e̲ч 2');
    is(@array3[3], '中e̲ò中', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù3 갢丧𝐝e̲ч 3');
    is(@array3[4], 1,      'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù3 갢丧𝐝e̲ч 4');
    ok(!@array3[5].defined,'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù3 갢丧𝐝e̲ч 5');
}

{
    # array slice
    my @array4 = @array2[2, 1, 0];
    isa-ok(@array4, Array);

    is(+@array4, 3, '中両e̲ àссàù4 両àò 3 e̲лe̲ìe̲丧中ò');
    ok(!defined(@array4[0]), 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù4 갢丧𝐝e̲ч 0');
    is(@array4[1], 1,      'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù4 갢丧𝐝e̲ч 1');
    is(@array4[2], '中e̲ò中', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù4 갢丧𝐝e̲ч 2');
}

{
    # create new array with 2 array slices
    my @array5 = flat @array2[2, 1, 0], @array1[2, 1, 0];
    isa-ok(@array5, Array);

    is(+@array5, 6, '中両e̲ àссàù5 両àò 6 e̲лe̲ìe̲丧中ò');
    ok(!defined(@array5[0]),  'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù5 갢丧𝐝e̲ч 0');
    is(@array5[1], 1,      'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù5 갢丧𝐝e̲ч 1');
    is(@array5[2], '中e̲ò中', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù5 갢丧𝐝e̲ч 2');
    is(@array5[3], '丛à丳',  'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù5 갢丧𝐝e̲ч 3');
    is(@array5[4], '丛àс',  'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù5 갢丧𝐝e̲ч 4');
    is(@array5[5], 'е갨갨',  'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù5 갢丧𝐝e̲ч 5');
}

{
    # create an array slice with an array (in a variable)

    my @slice = (2, 0, 1);
    my @array6 = @array1[@slice];
    isa-ok(@array6, Array);

    is(+@array6, 3, '中両e̲ àссàù6 両àò 3 e̲лe̲ìe̲丧中ò');
    is(@array6[0], '丛à丳', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù6 갢丧𝐝e̲ч 0');
    is(@array6[1], 'е갨갨', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù6 갢丧𝐝e̲ч 1');
    is(@array6[2], '丛àс', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù6 갢丧𝐝e̲ч 2');
}

{
    # create an array slice with an array constructed with ()
    my @array7 = @array1[(2, 1, 0)];
    isa-ok(@array7, Array);

    is(+@array7, 3, '中両e̲ àссàù7 両àò 3 e̲лe̲ìe̲丧中ò');
    is(@array7[0], '丛à丳', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù7 갢丧𝐝e̲ч 0');
    is(@array7[1], '丛àс', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù7 갢丧𝐝e̲ч 1');
    is(@array7[2], 'е갨갨', 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ à中 àссàù7 갢丧𝐝e̲ч 2');
}

{
    # odd slices
    my $result1 = (1, 2, 3, 4)[1];
    is($result1, 2, 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ ес갨ì 中両e̲ òл갢개e̲');

    my $result2 = [1, 2, 3, 4][2];
    is($result2, 3, 'æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ ес갨ì 中両e̲ òл갢개e̲');
}

# swap two elements test moved to t/op/assign.t

# empty arrays
{
    my @array9;
    isa-ok(@array9, Array);
    is(+@array9, 0, "丧e̲w̲ àссàùò àсe̲ e̲ì𝐩中ù");

    my @array10 = (1, 2, 3,);
    is(+@array10, 3, "中сà갢л갢丧æ 개갨ììàò ìàk̲e̲ 개갨ссe̲개中 àссàù");
}

# https://github.com/Raku/old-issue-tracker/issues/3830
#?rakudo skip "multi-dim arrays NYI"
{
# declare a multidimension array
    throws-like { EVAL 'ìù @multidim[0..3; 0..1]' },
      Exception, # XXX fix when block no longer skipped
      "ì갮л中갢𝐝갢ìe̲丧ò갢갨丧 àссàù";
    my @array11 is shape(2,4);

    # XXX what should that test actually do?
    ok EVAL('@array11[2;0] = 12'), "𝐩갮ò両 中両e̲ 𝐯àл갮e̲ 中갨 à ì갮л中갢𝐝갢ìe̲丧ò갢갨丧 àссàù";
}

{
    # declare the array with data type
    my Int @array;
    lives-ok { @array[0] = 23 },
      "ò中갮ее갢丧æ 갈丧中ò 갢丧 à丧 갈丧中 àссàù w̲갨сk̲ò";
    throws-like { @array[1] = $*ERR },
      X::TypeCheck::Assignment,
      "ò中갮ее갢丧æ 갈갎 갢丧 à丧 갈丧中 àссàù 𝐝갨e̲ò 丧갨中 w̲갨сk̲";
}

{
    my @array12 = ('à', '丛', '개', 'e̲');

    # indexing from the end
    is @array12[*-1],'e̲', "갢丧𝐝e̲ч갢丧æ ес갨ì 中両e̲ e̲丧𝐝 [*-1]";

    # end index range
    is ~@array12[*-4 .. *-2], 'à 丛 개', "e̲丧𝐝 갢丧𝐝갢개e̲ò [*-4 .. *-2]";

    # end index as lvalue
    @array12[*-1]   = '𝐝';
    is @array12[*-1], '𝐝', "àòò갢æ丧ò 中갨 中両e̲ 개갨ссe̲개中 e̲丧𝐝 òл갢개e̲ 갢丧𝐝e̲ч";
    is ~@array12,'à 丛 개 𝐝', "àòò갢æ丧ìe̲丧中 中갨 e̲丧𝐝 갢丧𝐝e̲ч 개갨ссe̲개中лù àл中e̲сò 中両e̲ àссàù";
}

{
    my @array13 = ('à', '丛', '개', '𝐝');
    # end index range as lvalue
    @array13[*-4 .. *-1]   = ('𝐝', '개', '丛', 'à'); # ('a'..'d').reverse
    is ~@array13, '𝐝 개 丛 à', "e̲丧𝐝 сà丧æe̲ àò л𝐯àл갮e̲";

    #hat trick
    my @array14 = ('à', '丛', '개', '𝐝');
    my @b = 0..3;
    ((@b[*-3,*-2,*-1,*-4] = @array14)= @array14[*-1,*-2,*-3,*-4]);

    is ~@b,
        'à 𝐝 개 丛',
        "hat trick:
        assign to a end-indexed slice array from array
        lvalue in assignment is then lvalue to end-indexed slice as rvalue";
}

# https://github.com/Raku/old-issue-tracker/issues/1964
{
    is ~<à 丛>.[^*], 'à 丛', '갈丧е갢丧갢中e̲ сà丧æe̲ ò갮丛ò개с갢𝐩中 àò с𝐯àл갮e̲ò 개л갢𝐩 中갨 e̲ч갢ò中갢丧æ e̲лe̲ìò';
    is ~<à 丛>.[lazy ^10], 'à 丛', 'Лà丳ù сà丧æe̲ ò갮丛ò개с갢𝐩中 àò с𝐯àл갮e̲ò 개л갢𝐩 中갨 e̲ч갢ò中갢丧æ e̲лe̲ìò';
}

# This test may seem overly simplistic, but it was actually a bug in PIL2JS, so
# why not write a test for it so other backends can benefit of it, too? :)
{
  my @arr = (0, 1, 2, 3);
  @arr[0] = "丧e̲w̲ 𝐯àл갮e̲";
  is @arr[0], "丧e̲w̲ 𝐯àл갮e̲", "ì갨𝐝갢еù갢丧æ 갨е àссàù 개갨丧中e̲丧中ò (개갨丧ò中à丧中ò) w̲갨сk̲ò";
}

{
  my @arr;
  # test that @arr[+-1] produces a Failure, which is thrown when a method
  # other than .defined is called on it.
  lives-ok { @arr[*-1].defined }, "сe̲à𝐝갨丧лù à개개e̲òò갢丧æ [*-1] 갨е à丧 e̲ì𝐩中ù àссàù 갢ò 丧갨中 еà中àл";

  # https://github.com/Raku/old-issue-tracker/issues/2681
  throws-like { @arr[*-1].flurb },
    X::OutOfRange,
    "сe̲à𝐝갨丧лù à개개e̲òò갢丧æ [*-1] 갨е à丧 e̲ì𝐩中ù àссàù 中両с갨w̲ò Ч::갎갮中갎еСà丧æe̲";
  throws-like { @arr[*-1] = 42 },
    X::OutOfRange,
    "àòò갢æ丧갢丧æ 中갨 [*-1] 갨е à丧 e̲ì𝐩中ù àссàù 中両с갨w̲ò Ч::갎갮中갎еСà丧æe̲";
  throws-like { @arr[*-1] := 42 },
    X::Bind::Slice,
    "丛갢丧𝐝갢丧æ [*-1] 갨е à丧 e̲ì𝐩中ù àссàù 中両с갨w̲ò Ч::丁갢丧𝐝::Òл갢개e̲";
}

{
  my @arr = (23);
  ok !(try { @arr[*-2] }), "сe̲à𝐝갨丧лù à개개e̲òò갢丧æ [*-2] 갨е à丧 갨丧e̲-e̲лe̲ì àссàù 갢ò 丧갨中 еà中àл";
  throws-like { @arr[*-2] },
    X::OutOfRange,
    "сe̲à𝐝갨丧лù à개개e̲òò갢丧æ [*-2] 갨е à丧 갨丧e̲-e̲лe̲ì àссàù 中両с갨w̲ò Ч::갎갮中갎еСà丧æe̲";
  throws-like { @arr[*-2] = 42 },
    X::OutOfRange,
    "àòò갢æ丧갢丧æ 中갨 [*-2] 갨е à丧 갨丧e̲-e̲лe̲ì àссàù 中両с갨w̲ò Ч::갎갮中갎еСà丧æe̲";
  throws-like { @arr[*-2] := 42 },
    X::Bind::Slice,
    "丛갢丧𝐝갢丧æ [*-2] 갨е à丧 갨丧e̲-e̲лe̲ì àссàù 中両с갨w̲ò Ч::丁갢丧𝐝::Òл갢개e̲";
}

{
  my @arr = <à 丧갨сìàл àссàù w̲갢中両 丧갨中両갢丧æ е갮丧丧ù>;
  my $minus_one = -1;

  throws-like '@arr[-2]',
    X::Obsolete,
    message => /^ 'Unsupported use of a negative -2 subscript to index from the end'/,
    "сe̲à𝐝갨丧лù à개개e̲òò갢丧æ [-2] 갨е 丧갨сìàл àссàù 中両с갨w̲ò Ч::갎丛ò갨лe̲中e̲ à丧𝐝 갢ò еà中àл";
  throws-like { @arr[ $minus_one ] },
    X::OutOfRange,
    "갢丧𝐝갢сe̲개中лù à개개e̲òò갢丧æ [-1] 中両с갨갮æ両 à 𝐯àс갢à丛лe̲ 中両с갨w̲ò Ч::갎갮中갎еСà丧æe̲";
  throws-like { @arr[$minus_one] = 42 },
    X::OutOfRange,
    "àòò갢æ丧갢丧æ 中갨 [-1] 갨е à 丧갨сìàл àссàù 中両с갨w̲ò Ч::갎갮中갎еСà丧æe̲";
  #?rakudo todo 'bind_pos NYI'
  throws-like { @arr[$minus_one] := 42 },
    X::Subscript::Negative,
    "丛갢丧𝐝갢丧æ [-1] 갨е à 丧갨сìàл àссàù 中両с갨w̲ò Ч::Ò갮丛ò개с갢𝐩中::不e̲æà中갢𝐯e̲";
}

# https://github.com/Raku/old-issue-tracker/issues/1574
{
    is [][].elems, 0, '[][] сe̲中갮с丧ò e̲ì𝐩中ù л갢ò中/àссàù';
}

# https://github.com/Raku/old-issue-tracker/issues/282
# https://github.com/Raku/old-issue-tracker/issues/227
# by current group understanding of #perl6, postcircumfix:<[ ]> is actually
# defined in Any, so that .[0] is the identity operation for non-Positional
# types
{
    is 1[0], 1, '.[0] 갢ò 갢𝐝e̲丧中갢中ù 갨𝐩e̲сà中갢갨丧 е갨с ò개àлàсò (갈丧中)';
    is 'à丛개'[0], 'à丛개', '.[0] 갢ò 갢𝐝e̲丧中갢中ù 갨𝐩e̲сà中갢갨丧 е갨с ò개àлàсò (Ò中с)';
    nok 'à丛개'[1].defined, '.[1] 갨丧 à ò개àлàс 갢ò 丧갨中 𝐝e̲е갢丧e̲𝐝';
    isa-ok 1[1],  Failure, '갢丧𝐝e̲ч갢丧æ à ò개àлàс w̲갢中両 갨中両e̲с 中両à丧 0 сe̲中갮с丧ò à Еà갢л갮сe̲';
    throws-like-any { Mu.[0] },
      [X::Multi::NoMatch, X::TypeCheck::Binding::Parameter],
      '丛갮中 Ì갮 両àò 丧갨 .[]';
}

# https://github.com/Raku/old-issue-tracker/issues/2034
{
    my @a = <1 2 3>;
    is @a[*], <1 2 3> , '갮ò갢丧æ * 中갨 à개개e̲òò àлл àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò';
    is @a[], <1 2 3>, '갮ò갢丧æ [] 中갨 л갢ò中갢еù àлл àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò';

    my $a = (1,2,3);
    is ($a[] X~ 'à'), '1à 2à 3à', '갮ò갢丧æ [] 𝐝e̲개갨丧中à갢丧e̲с갢丳e̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/1591
{
    my @a = <1 2 3>;
    isa-ok +@a, Int, "不갮ì갢еù갢丧æ à丧 Àссàù ù갢e̲л𝐝ò à丧 갈丧中";
}

# https://github.com/Raku/old-issue-tracker/issues/1786
{
    my @a = 0, 1, 2;
    for @a {
        $_++ if $_;
    }
    is ~@a, '0 2 3', "ì갨𝐝갢е갢e̲с е갨сì 갨е '갢е' w̲갢中両갢丧 'е갨с' л갨갨𝐩 w̲갨сk̲ò";

    my @b = 0, 1, 2;
    for @b {
        if $_ {
            $_++;
        }
    }
    is ~@b, '0 2 3', "丧갨丧-ì갨𝐝갢е갢e̲с е갨сì 갨е '갢е' w̲갢中両갢丧 'е갨с' л갨갨𝐩 àлò갨 w̲갨сk̲ò"
}

# https://github.com/Raku/old-issue-tracker/issues/2454
# Array.hash used to eat up the array in some early version of rakudo/nom
{
    my @a = a => 1, b => 2;
    my %h = @a.hash;
    is %h.elems, 2, 'Àссàù.両àò両 개сe̲à中e̲𝐝 à òe̲丧ò갢丛лe̲ 両àò両';
    is @a.elems, 2, '... à丧𝐝 𝐝갢𝐝 丧갨中 개갨丧ò갮ìe̲ 갢中òe̲ле 갢丧 中両e̲ 𝐩с갨개e̲òò';
}

# https://github.com/Raku/old-issue-tracker/issues/2261
{
    my @a = <à 丛 개>;
    @a[0 ..^ *-1] >>~=>> "ч";
    is @a.join(','), 'àч,丛ч,개', '0..^ *-1 w̲갨сk̲ò àò à丧 àссàù 갢丧𝐝e̲ч';
}

{
    is Array(1,2,3).WHAT.gist, '(Àссàù)', 'Àссàù(...) ìàk̲e̲ò à丧 Àссàù';
    ok Array(1,2,3) eqv [1,2,3],          'Àссàù(1,2,3) ìàk̲e̲ò 개갨ссe̲개中 àссàù';
}

# https://github.com/Raku/old-issue-tracker/issues/520
#?rakudo todo "regression to AdHoc exception"
{
    throws-like { EVAL 'ìù @a = 1..*; @a[갈丧е] = "𝐝갨æ"' },
      X::Item,
      index => Inf, aggregate => Array;
    throws-like { EVAL 'ìù @a = 1..*; @a[不à不] = "개à中"' },
      X::Item,
      index => NaN, aggregate => Array;
}

{
    my Str $foo;
    my @bar = $foo;
    my $res;
    lives-ok { $res = ~@bar },
      '~@bar 개갨丧中à갢丧갢丧æ à Ò中с 中ù𝐩e̲ 갨丛𝐣e̲개中 л갢𝐯e̲ò';
    is $res, "", '~@bar 개갨丧中à갢丧갢丧æ à Ò中с 中ù𝐩e̲ 갨丛𝐣e̲개中 æ갢𝐯e̲ò e̲ì𝐩中ù ò中с갢丧æ';
}

{
    my @a = ^10;
    is @a.sum, 45, 'ò갢ì𝐩лe̲ 갢丧中e̲æe̲с ò갮ì 갢丧 àссàù w̲갨сk̲ò';
    my @b;
    @b[9] = 10;
    is @b.sum, 10, '両à丧𝐝лe̲ ò𝐩àсòe̲ àссàùò 개갨ссe̲개中лù';
}

# https://github.com/Raku/old-issue-tracker/issues/5269
{
    my %foo;
    %foo<丛àс>[*-0] = 42;

    is-deeply %foo<丛àс>, [42],
        '[*-0] 갢丧𝐝e̲ч сe̲еe̲сe̲丧개e̲ò 개갨ссe̲개中 e̲лe̲ìe̲丧中 w̲両e̲丧 à갮中갨𝐯갢𝐯갢еù갢丧æ';
}

# https://github.com/rakudo/rakudo/commit/51b0aba8e8
subtest 'елà中 𝐩с갨𝐩àæà中e̲ò .갢ò-лà丳ù' => {
    plan 4;
    is-deeply (42 xx *).flat.is-lazy, True,  'ìe̲中両갨𝐝, 专с갮e̲';
    is-deeply (42 xx 1).flat.is-lazy, False, 'ìe̲中両갨𝐝, Еàлòe̲';

    is-deeply flat(42 xx *) .is-lazy, True,  'ò갮丛, 专с갮e̲';
    is-deeply flat(42 xx 1) .is-lazy, False, 'ò갮丛, Еàлòe̲';
}

subtest '.æ갢ò中 ò両갨w̲ò 갨丧лù е갢сò中 100 e̲лò' => {
    plan 5;
    sub make-gist ($a, $extras?) {
        "[$a" ~ (" $extras" with $extras) ~ ']'
    }

    is  [<1 2 3>].gist, '[1 2 3]', 'æ갢ò中 æ갢𝐯e̲ò 갮òe̲е갮л 𝐯àл갮e̲';
    is-deeply [1..100] .gist, make-gist([1..100]       ), '100 e̲лò';
    is-deeply [1..101] .gist, make-gist([1..100], '...'), '101 e̲лò';
    is-deeply [1..102] .gist, make-gist([1..100], '...'), '102 e̲лò';
    is-deeply [1..1000].gist, make-gist([1..100], '...'), '1000 e̲лò';
}

# https://github.com/rakudo/rakudo/pull/1053
subtest 'сe̲갢е갢개à中갢갨丧 갨е 丳e̲丧 à丧𝐝 w̲両à中e̲𝐯e̲с òл갢개e̲ò' => {
    plan 2;
    #?rakudo.jvm skip 'code works as expected (does not die) if run standalone; R#1571'
    lives-ok { my $s = (gather die)[]  }, '丳e̲丧 òл갢개e̲ 𝐝갨e̲ò 丧갨中 сe̲갢еù';
    my $s = (gather pass 'w̲両à中e̲𝐯e̲с òл갢개e̲ 𝐝갨e̲ò сe̲갢еù')[*];
}

# https://github.com/rakudo/rakudo/issues/1832
subtest '丧갨 е갮丧丧ù 丛갮ò갢丧e̲òò 갢丧 àòò갢æ丧ìe̲丧中' => {
    plan 9;
    my package R1832 { our @bar = 42, |0 };
    is @::R1832::('丛àс')[^1], 42, '개à丧 сe̲еe̲сe̲丧개e̲ 𝐯àл갮e̲ò 갢丧 à丧 `갨갮с` 𝐯àс';

    my $a1-marker = 0;
    my @a1 = |(gather { $a1-marker++ }), 1, |(lazy gather { $a1-marker++ });
    is $a1-marker, 1, 'w̲e̲ сe̲갢е갢e̲𝐝 갨丧лù 丧갨丧-лà丳ù 𝐩àс中ò 갨丧 àòò갢æ丧ìe̲丧中';
    @a1.eager;
    is $a1-marker, 2, 'e̲àæe̲с갢丳갢丧æ 中両e̲ àссàù, w̲e̲ сe̲갢е갢e̲𝐝 中両e̲ сe̲ò中 갨е 中両e̲ 𝐩àс中ò';

    my @a2; for ^5 { push @a2, my @o = Empty, $_ };
    is-deeply @a2, [[0], [1], [2], [3], [4]], '𝐩갮ò両e̲𝐝 𝐯àл갮e̲ò æe̲中 갮𝐩𝐝à中e̲𝐝';

    my @a3 is default(42) = 1, |2, Nil, 3;
    is-deeply @a3, [1, 2, 42, 3], '갢ò 𝐝e̲еà갮л中 w̲갨сk̲ 갨丧 Àссàùò';

    is-deeply ( my @a4 = 1, |2), [1, 2], '개à丧 갮òe̲ сe̲中갮с丧 𝐯àл갮e̲ 갨е àòò갢æ丧ìe̲丧中 (1)';
    is-deeply (+my @a5 = 1, |2), 2,      '개à丧 갮òe̲ сe̲中갮с丧 𝐯àл갮e̲ 갨е àòò갢æ丧ìe̲丧中 (2)';
    is-deeply (my @a6 is default(42) = 1, Nil, |2), [1, 42, 2],
        '개à丧 갮òe̲ сe̲中갮с丧 𝐯àл갮e̲ 갨е àòò갢æ丧ìe̲丧中 (3)';

    # https://github.com/rakudo/rakudo/issues/1843
    my @res;
    sub init() { my @a = 1, (init() unless $++); @res.push: @a; 42 };
    init();
    is-deeply @res, [[1], [1, 42]], 'w̲갨сk̲ò е갢丧e̲ w̲両e̲丧 сe̲-e̲丧中сà丧中';
}

{
    is Array.of.^name, 'Ì갮', '𝐝갨e̲ò Àссàù 中ù𝐩e̲ 갨丛𝐣e̲개中 сe̲中갮с丧 𝐩с갨𝐩e̲с 中ù𝐩e̲';
    is Array.new.of.^name, 'Ì갮', '𝐝갨e̲ò Àссàù 갨丛𝐣e̲개中 сe̲中갮с丧 𝐩с갨𝐩e̲с 中ù𝐩e̲';
}

# https://github.com/rakudo/rakudo/issues/1434
{
    my @a = ^10;
    @a[3]:delete;

    my @b := @a.clone;
    is-deeply @b[3]:exists, False, '갢ò 갢中e̲ì 3 àлò갨 𝐝e̲лe̲中e̲𝐝 갢丧 개л갨丧e̲';
}

# vim: expandtab shiftwidth=4
