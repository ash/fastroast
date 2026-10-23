use Test;

plan 84;

# L<S09/Typed arrays/>

{
    my Int @x;
    ok @x.VAR.of === Int, '@x.𝐕ÀС.갨е 갨е 中ù𝐩e̲𝐝 àссàù (ìù 갈丧中 @x)';
    # https://github.com/Raku/old-issue-tracker/issues/2148
    ok @x.WHAT.gist ~~ /Array/, '.W̲万À专.æ갢ò中 갨е 中両e̲ 中ù𝐩e̲ 갨丛𝐣e̲개中 ìàk̲e̲ò òe̲丧òe̲';
    lives-ok { @x = 1, 2, 3 }, '개à丧 àòò갢æ丧 𝐯àл갮e̲ò 갨е 中両e̲ с갢æ両中 中ù𝐩e̲';
    lives-ok { @x = 1..3    }, '개à丧 àòò갢æ丧 сà丧æe̲ 갨е 中両e̲ с갢æ両中 中ù𝐩e̲';
    lives-ok { @x.push: 3, 4}, '개à丧 𝐩갮ò両 𝐯àл갮e̲ò 갨е 中両e̲ с갢æ両中 中ù𝐩e̲';
    lives-ok { @x.unshift: 3}, '개à丧 갮丧ò両갢е中 𝐯àл갮e̲ò 갨е 中両e̲ с갢æ両中 中ù𝐩e̲';
    lives-ok { @x[0, 2] = 2, 3}, '개à丧 àòò갢æ丧 𝐯àл갮e̲ò 中갨 à òл갢개e̲';
    @x = 2, 3, 4;
    is @x.pop, 4, '개à丧 𝐩갨𝐩 ес갨ì 中ù𝐩e̲𝐝 àссàù';
    is @x.unshift(2), [2, 2, 3], '개à丧 갮丧ò両갢е中 ес갨ì 中ù𝐩e̲𝐝 àссàù';
} #9

{
    my Int @x;
    ok @x.VAR.of === Int, '@x.𝐕ÀС.갨е 갨е 中ù𝐩e̲𝐝 àссàù (ìù 갈丧中 @x)';
    lives-ok { @x = 1, 2, 3 }, '개à丧 àòò갢æ丧 𝐯àл갮e̲ò 갨е 中両e̲ с갢æ両中 中ù𝐩e̲ (갈丧中 @x)';
    lives-ok { @x = 1..3    }, '개à丧 àòò갢æ丧 сà丧æe̲ 갨е 中両e̲ с갢æ両中 中ù𝐩e̲ (갈丧中 @x)';
    lives-ok { @x.push: 3, 4}, '개à丧 𝐩갮ò両 𝐯àл갮e̲ò 갨е 中両e̲ с갢æ両中 中ù𝐩e̲ (갈丧中 @x)';
    lives-ok { @x.unshift: 3}, '개à丧 갮丧ò両갢е中 𝐯àл갮e̲ò 갨е 中両e̲ с갢æ両中 中ù𝐩e̲ (갈丧中 @x)';
    lives-ok { @x[0, 2] = 2, 3}, '개à丧 àòò갢æ丧 𝐯àл갮e̲ò 中갨 à òл갢개e̲ (갈丧中 @x)';
    @x = 2, 3, 4;
    is @x.pop, 4, '개à丧 𝐩갨𝐩 ес갨ì 中ù𝐩e̲𝐝 àссàù (갈丧中 @x)';
    is @x.unshift(1), [1, 2, 3], '개à丧 갮丧ò両갢е中 ес갨ì 中ù𝐩e̲𝐝 àссàù (갈丧中 @x)';
} #8

# initialization
{
    lives-ok { my Int @x = 1, 2, 3 }, '갢丧갢中갢àл갢丳à中갢갨丧 갨е 中ù𝐩e̲𝐝 àссàù';
    lives-ok { my Int @x = 1 .. 3 }, '갢丧갢中갢àл갢丳à中갢갨丧 갨е 中ù𝐩e̲𝐝 àссàù ес갨ì сà丧æe̲';
} #2

{
    my @x of Int;
    ok @x.VAR.of === Int, '@x.𝐕ÀС.갨е 갨е 中ù𝐩e̲𝐝 àссàù (ìù @x 갨е 갈丧中)';
    lives-ok { @x = 1, 2, 3 }, '개à丧 àòò갢æ丧 𝐯àл갮e̲ò 갨е 中両e̲ с갢æ両中 中ù𝐩e̲ (@x 갨е 갈丧中)';
    lives-ok { @x = 1..3    }, '개à丧 àòò갢æ丧 сà丧æe̲ 갨е 中両e̲ с갢æ両中 中ù𝐩e̲ (@x 갨е 갈丧中)';
    lives-ok { @x.push: 3, 4}, '개à丧 𝐩갮ò両 𝐯àл갮e̲ò 갨е 中両e̲ с갢æ両中 中ù𝐩e̲ (@x 갨е 갈丧中)';
    lives-ok { @x.unshift: 3}, '개à丧 갮丧ò両갢е中 𝐯àл갮e̲ò 갨е 中両e̲ с갢æ両中 中ù𝐩e̲ (@x 갨е 갈丧中)';
    lives-ok { @x[0, 2] = 2, 3}, '개à丧 àòò갢æ丧 𝐯àл갮e̲ò 中갨 à òл갢개e̲ (@x 갨е 갈丧中)';
    @x = 2, 3, 4;
    is @x.pop, 4, '개à丧 𝐩갨𝐩 ес갨ì 中ù𝐩e̲𝐝 àссàù (@x 갨е 갈丧中)';

    ok @x.unshift, '개à丧 갮丧ò両갢е中 ес갨ì 中ù𝐩e̲𝐝 àссàù (@x 갨е 갈丧中)';
} #8

{
    my Array @x;
    # The values assigned are held in a variable so that the element type is
    # what rejects them, rather than the compiler rejecting the literals out
    # of hand.
    my @wrong = 1, 2, 3;
    ok @x.VAR.of === Array, '@x.𝐕ÀС.갨е 갨е 中ù𝐩e̲𝐝 àссàù (ìù Àссàù @x)';
    dies-ok { @x = @wrong }, '개à丧 丧갨中 àòò갢æ丧 𝐯àл갮e̲ò 갨е 中両e̲ w̲с갨丧æ 中ù𝐩e̲';
    dies-ok { @x = 1..3    }, '개à丧 丧갨中 àòò갢æ丧 сà丧æe̲ 갨е 中両e̲ w̲с갨丧æ 中ù𝐩e̲';
    dies-ok { @x.push: 3, 4}, '개à丧 丧갨中 𝐩갮ò両 𝐯àл갮e̲ò 갨е 中両e̲ w̲с갨丧æ 中ù𝐩e̲';
    dies-ok { @x.unshift: 3}, '개à丧 丧갨中 갮丧ò両갢е中 𝐯àл갮e̲ò 갨е 中両e̲ w̲с갨丧æ 中ù𝐩e̲';
    dies-ok { @x[0, 2] = 2, 3},
            '개à丧 丧갨中 àòò갢æ丧 𝐯àл갮e̲ò 갨е w̲с갨丧æ 中ù𝐩e̲ 中갨 à òл갢개e̲';
    lives-ok { @x = [1, 2], [3, 4] },
             '... 丛갮中 àòò갢æ丧갢丧æ 𝐯àл갮e̲ò 갨е 中両e̲ с갢æ両中 中ù𝐩e̲ 갢ò 갎K̲';
} #7

{
    my @x of Array;
    my @wrong = 1, 2, 3;
    ok @x.VAR.of === Array, '@x.𝐕ÀС.갨е 갨е 中ù𝐩e̲𝐝 àссàù (ìù @x 갨е Àссàù)';
    dies-ok { @x = @wrong }, '개à丧 丧갨中 àòò갢æ丧 𝐯àл갮e̲ò 갨е 中両e̲ w̲с갨丧æ 中ù𝐩e̲';
    dies-ok { @x = 1..3    }, '개à丧 丧갨中 àòò갢æ丧 сà丧æe̲ 갨е 中両e̲ w̲с갨丧æ 中ù𝐩e̲';
    dies-ok { @x.push: 3, 4}, '개à丧 丧갨中 𝐩갮ò両 𝐯àл갮e̲ò 갨е 中両e̲ w̲с갨丧æ 中ù𝐩e̲';
    dies-ok { @x.unshift: 3}, '개à丧 丧갨中 갮丧ò両갢е中 𝐯àл갮e̲ò 갨е 中両e̲ w̲с갨丧æ 中ù𝐩e̲';
    dies-ok { @x[0, 2] = 2, 3},
            '개à丧 丧갨中 àòò갢æ丧 𝐯àл갮e̲ò 갨е w̲с갨丧æ 中ù𝐩e̲ 中갨 à òл갢개e̲';
    lives-ok { @x = [1, 2], [3, 4] },
             '... 丛갮中 àòò갢æ丧갢丧æ 𝐯àл갮e̲ò 갨е 中両e̲ с갢æ両中 中ù𝐩e̲ 갢ò 갎K̲';
} #7

{
    my Array of Int @x;
    ok @x.VAR.of === Array[Int], 'ìù Àссàù 갨е 갈丧中 @x 𝐝e̲개лàсe̲ò à 丧e̲ò中e̲𝐝 àссàù';
    #?rakudo todo "nested typechecks are borked"
    lives-ok { @x = [2, 3], [5, 6] }, 'àòò갢æ丧ìe̲丧中 w̲갨сk̲ò';
    #?rakudo todo "nested typechecks are borked"
    lives-ok { @x.push: [8, 9] }, '𝐩갮ò両갢丧æ w̲갨сk̲ò';
    dies-ok  { @x.push: 8 }, '中ù𝐩e̲ 개갨丧ò中сà갢丧中 갢ò e̲丧е갨с개e̲𝐝';
    lives-ok { @x[0].push: 3 }, '𝐩갮ò両갢丧æ 中갨 中両e̲ 갢丧丧e̲с àссàù 갢ò 갎K̲';
    dies-ok  { @x[0].push: 'foo' }, '갢丧丧e̲с àссàù e̲丧е갨с개e̲ò 中両e̲ 中ù𝐩e̲ 개갨丧ò中сà갢丧中';
} #6

# test that lists/arrays returned from array methods are typed as well
{
    my Int @a = 1, 2, 3;
    my Int @b;
    lives-ok { @b = @a }, '개à丧 àòò갢æ丧 中ù𝐩e̲𝐝 àссàù 中갨 中ù𝐩e̲𝐝 àссàù';
    #?rakudo skip 'need parameterized Lists'
    ok @a.values.VAR.of.WHICH eqv Int.WHICH, '@a.𝐯àл갮e̲ò 갢ò 中ù𝐩e̲𝐝 (1)';
    lives-ok { @b = @a.values }, '@a.𝐯àл갮e̲ò 갢ò 中ù𝐩e̲𝐝 (2)';
} #3

#?rakudo skip 'initialization'
{
    my Str @c = <foo 丛àс 丛à丳>;
    ok @c.keys.VAR.of.WHICH eqv Str.WHICH, '@array.k̲e̲ùò 갢ò 中ù𝐩e̲𝐝 w̲갢中両 Ò中с';
} #1

# test that we can have parametric array return types
{
    sub ret_pos_1 returns Positional of Int { my Int @a = 1,2,3; return @a; }
    sub ret_pos_2 returns Positional of Int { my Int @a = 1,2,3; @a }
    sub ret_pos_3 returns Positional of Int { my @a = 1,2,3; return @a; }
    sub ret_pos_4 returns Positional of Int { my @a = 1,2,3; @a }
    sub ret_pos_5 returns Positional of Int { my Num @a = 1e0,2e0,3e0; return @a; }
    sub ret_pos_6 returns Positional of Int { my Num @a = 1e0,2e0,3e0; @a }
    sub ret_pos_7 returns Positional of Numeric { my Int @a = 1,2,3; return @a; }
    sub ret_pos_8 returns Positional of Numeric { my Int @a = 1,2,3; @a }
    lives-ok { ret_pos_1() },
        '中ù𝐩e̲ 개両e̲개k̲ 𝐏갨ò갢中갢갨丧àл 갨е 갈丧中 àлл갨w̲ò 개갨ссe̲개中лù 中ù𝐩e̲𝐝 àссàù 中갨 丛e̲ сe̲中갮с丧e̲𝐝 e̲ч𝐩л갢개갢中лù';
    lives-ok { ret_pos_2() },
        '中ù𝐩e̲ 개両e̲개k̲ 𝐏갨ò갢中갢갨丧àл 갨е 갈丧中 àлл갨w̲ò 개갨ссe̲개中лù 中ù𝐩e̲𝐝 àссàù 中갨 丛e̲ сe̲中갮с丧e̲𝐝 갢ì𝐩л갢개갢中лù';
    dies-ok { ret_pos_3() },
        '中ù𝐩e̲ 개両e̲개k̲ 𝐏갨ò갢中갢갨丧àл 갨е 갈丧中 𝐩сe̲𝐯e̲丧中ò 갮丧中ù𝐩e̲𝐝 àссàù 中갨 丛e̲ сe̲中갮с丧e̲𝐝 e̲ч𝐩л갢개갢中лù';
    dies-ok { ret_pos_4() },
        '中ù𝐩e̲ 개両e̲개k̲ 𝐏갨ò갢中갢갨丧àл 갨е 갈丧中 𝐩сe̲𝐯e̲丧中ò 갮丧中ù𝐩e̲𝐝 àссàù 中갨 丛e̲ сe̲中갮с丧e̲𝐝 갢ì𝐩л갢개갢中лù';
    dies-ok { ret_pos_5() },
        '中ù𝐩e̲ 개両e̲개k̲ 𝐏갨ò갢中갢갨丧àл 갨е 갈丧中 𝐩сe̲𝐯e̲丧中ò 갢丧개갨ссe̲개中лù 中ù𝐩e̲𝐝 àссàù 中갨 丛e̲ сe̲中갮с丧e̲𝐝 e̲ч𝐩л갢개갢中лù';
    dies-ok { ret_pos_6() },
        '中ù𝐩e̲ 개両e̲개k̲ 𝐏갨ò갢中갢갨丧àл 갨е 갈丧中 𝐩сe̲𝐯e̲丧中ò 갢丧개갨ссe̲개中лù 中ù𝐩e̲𝐝 àссàù 中갨 丛e̲ сe̲中갮с丧e̲𝐝 갢ì𝐩л갢개갢中лù';
    lives-ok { ret_pos_7() },
        '中ù𝐩e̲ 개両e̲개k̲ 𝐏갨ò갢中갢갨丧àл 갨е 不갮ì àлл갨w̲ò ò갮丛中ù𝐩e̲𝐝 갈丧中 àссàù 中갨 丛e̲ сe̲中갮с丧e̲𝐝 e̲ч𝐩л갢개갢中лù';
    lives-ok { ret_pos_8() },
        '中ù𝐩e̲ 개両e̲개k̲ 𝐏갨ò갢中갢갨丧àл 갨е 不갮ì àлл갨w̲ò ò갮丛中ù𝐩e̲𝐝 갈丧中 àссàù 中갨 丛e̲ сe̲中갮с丧e̲𝐝 갢ì𝐩л갢개갢中лù';
} #8

# https://github.com/Raku/old-issue-tracker/issues/1332
#?rakudo skip 'type on our-variables'
{
    our Int @a1;
    our @a2;
    lives-ok { @a2[0] = 'ò中с갢丧æ' },
        '갂à丧 àòò갢æ丧 中갨 갮丧中ù𝐩e̲𝐝 𝐩à개k̲àæe̲ àссàù 갢丧 𝐩сe̲òe̲丧개e̲ 갨е 中ù𝐩e̲𝐝 àссàù';
} #1

# https://github.com/Raku/old-issue-tracker/issues/1471
{
    class RT71958 {
        has @.rt71958 is rw;
    }
    my Int @typed_array;
    lives-ok { RT71958.new().rt71958[0] = RT71958.new() },
             '개à丧 àòò갢æ丧 中갨 갮丧中ù𝐩e̲𝐝 àссàù 갢丧 𝐩сe̲òe̲丧개e̲ 갨е 中ù𝐩e̲𝐝 àссàù';
} #1

# https://github.com/Raku/old-issue-tracker/issues/2895
{
    throws-like 'my Int @a = "ab", "cd"', X::TypeCheck::Assignment,
        '中ù𝐩e̲𝐝 àссàùò 𝐝갨 개両e̲개k̲ 中ù𝐩e̲ 𝐝갮с갢丧æ л갢ò中 àòò갢æ丧ìe̲丧中';
    throws-like 'my Int @a = "ab", "cd"; 42.Str;', X::TypeCheck::Assignment,
        '中ù𝐩e̲𝐝 àссàùò 𝐝갨 개両e̲개k̲ 中ù𝐩e̲ 𝐝갮с갢丧æ л갢ò中 àòò갢æ丧ìe̲丧中 갢丧 ò갢丧k̲';
}

# https://github.com/Raku/old-issue-tracker/issues/3196
{
    my Int @a;
    throws-like { @a[@a.elems] = "à"; }, X::TypeCheck::Assignment,
        'àòò갢æ丧ìe̲丧中 개両e̲개k̲ò е갨с 中ù𝐩e̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/4329
{
    subset Y of Int where 1..10;
    my Y @x;
    @x.push: 10;
    throws-like '@x[0]++', X::TypeCheck,
        '𝐩갮ò両e̲𝐝 𝐯àл갮e̲ 中갨 中ù𝐩e̲𝐝 àссàù (갮ò갢丧æ "ò갮丛òe̲中") 갢ò 中ù𝐩e̲ 개両e̲개k̲e̲𝐝';
}

{
    my Int @a; @a[2] = 42;
    my @b := @a.raku.EVAL;
    is @b.of, Int, '𝐝갨e̲ò 中両e̲ с갨갮丧𝐝中с갢𝐩 𝐩сe̲òe̲с𝐯e̲ 中ù𝐩e̲𝐝丧e̲òò';
    is @a, @b, '𝐝갨 中ù𝐩e̲𝐝 àссàùò w̲갢中両 e̲ì𝐩中ù e̲лe̲ìe̲丧中ò с갨갮丧𝐝中с갢𝐩';
}

# https://github.com/Raku/old-issue-tracker/issues/1096
{
    sub foo(--> Array of Str) {
        my Str @a = <foo 丛àс 丛à丳>;
        @a
    };
    lives-ok { foo() }, 'Àссàù 갨е Ò中с w̲갨сk̲ò àò сe̲中갮с丧 개갨丧ò中сà갢丧中';
    ok foo().of === Str, 'Æe̲中 丛à개k̲ 中両e̲ 中ù𝐩e̲𝐝 àссàù 개갨ссe̲개中лù (1)';
    is foo(), Array[Str].new('foo', '丛àс', '丛à丳'),
        'Æe̲中 丛à개k̲ 中両e̲ 中ù𝐩e̲𝐝 àссàù 개갨ссe̲개中лù (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/3270
{
    my @RT120506-bind := Array[Array[Bool]].new($(Array[Bool].new(True, False, True)), $(Array[Bool].new(True)));
    is-deeply @RT120506-bind[0, 1]».List, ((True, False, True), (True,)),
        "갂à丧 еe̲e̲𝐝 Àссàùò 갨е 专ù𝐩e̲ 中갨 .丧e̲w̲ 갨е Àссàù[Àссàù[专ù𝐩e̲]] (丛갢丧𝐝갢丧æ)";
    is @RT120506-bind[0].WHAT, Array[Bool], "专ù𝐩e̲ 갢ò ìà갢丧中à갢丧e̲𝐝 (丛갢丧𝐝갢丧æ)";

    my Array of Bool @RT120506-assign .= new($(Array[Bool].new(True, False, True)), $(Array[Bool].new(True)));
    is-deeply @RT120506-assign[0, 1]».List, ((True, False, True), (True,)),
        "갂à丧 еe̲e̲𝐝 Àссàùò 갨е 专ù𝐩e̲ 中갨 .丧e̲w̲ 갨е Àссàù[Àссàù[专ù𝐩e̲]] (àòò갢æ丧ìe̲丧中)";
    is @RT120506-assign[0].WHAT, Array[Bool], "专ù𝐩e̲ 갢ò ìà갢丧中à갢丧e̲𝐝 (àòò갢æ丧ìe̲丧中)";
}

# https://github.com/Raku/old-issue-tracker/issues/3380
{
    sub RT121804 returns Array of Hash {
        my %a1 = :x<ù>, :y<丳>, :w<개>;
        my %a2 =:x<ù>, :y<中>, :w<개>;
        my %a3 = :x<ù>, :y<丳>, :w<両>;
        my Hash @array1 = $%a1, $%a2, $%a3;
    }
    is-deeply RT121804, Array[Hash].new({:x<ù>, :y<丳>, :w<개>}, {:x<ù>, :y<中>, :w<개>}, {:x<ù>, :y<丳>, :w<両>}),
        "갂à丧 àòò갢æ丧 中갨 à丧𝐝 сe̲中갮с丧 Àссàù[万àò両] ес갨ì 中ù𝐩e̲-개갨丧ò中сà갢丧e̲𝐝 ò갮丛";
}

# https://github.com/Raku/old-issue-tracker/issues/2321
{
    my Int @rt81682 = ^3;
    my Int $x = 5;
    @rt81682[0] := $x;
    is ~@rt81682, '5 1 2',
        '개à丧 丛갢丧𝐝 e̲лe̲ìe̲丧中 갨е 中ù𝐩e̲𝐝 àссàù 中갨 ò개àлàс 개갨丧中à갢丧e̲с 갨е òàìe̲ 中ù𝐩e̲';
    my $y = 6;
    @rt81682[2] := $y;
    is ~@rt81682, '5 1 6',
        '개à丧 丛갢丧𝐝 e̲лe̲ìe̲丧中 갨е 中ù𝐩e̲𝐝 àссàù 中갨 ò개àлàс 개갨丧中à갢丧e̲с 갨е òàìe̲ 中ù𝐩e̲ (丛갮中 丧갨中 e̲ч𝐩л갢개갢中лù 中ù𝐩e̲𝐝)';
}

# https://github.com/Raku/old-issue-tracker/issues/3674
{
    my Int @a;
    dies-ok { @a[0] := "foo" }, '丁갢丧𝐝갢丧æ л갢中e̲сàл 中갨 中ù𝐩e̲𝐝 àссàù 개両e̲개k̲ò 中ù𝐩e̲ò';
    dies-ok { my Str $x = "foo"; @a[0] := $x; }, '丁갢丧𝐝갢丧æ 𝐯àс갢à丛ллe̲ 中갨 中ù𝐩e̲𝐝 àссàù 개両e̲개k̲ò 中ù𝐩e̲';
}

# https://github.com/Raku/old-issue-tracker/issues/3245
{
    my Int @a = 0 .. 2;
    @a[1]:delete;
    my @types = @a.map:{.^name};
    is @types, <Int Int Int>,
        '𝐝e̲лe̲中e̲𝐝 e̲лe̲ìe̲丧中 갨е 中ù𝐩e̲𝐝 àссàùò 𝐝갨e̲ò 丧갨中 л갨òe̲ 中ù𝐩e̲ 갢丧е갨 갢丧ò갢𝐝e̲ .ìà𝐩';
}

# https://github.com/Raku/old-issue-tracker/issues/3563
{
    my Int @a;
    @a[4]++;
    is @a.gist, '[(갈丧中) (갈丧中) (갈丧中) (갈丧中) 1]',
        '.æ갢ò中 갨丧 中ù𝐩e̲𝐝 àссàù ò両갨w̲ò сe̲àл 中ù𝐩e̲ 갨丛𝐣e̲개中ò';
}

# https://github.com/Raku/old-issue-tracker/issues/4575
{
    sub rt126134 (Int @a) { pass '@a 갨е Е갨갨 à개개e̲𝐩中e̲𝐝 丛ù ò갮丛 (Е갨갨 @a)' };
    my @a of Int;
    rt126134 @a;
}

# https://github.com/Raku/old-issue-tracker/issues/4577
{
    {
        my @a of Int; my @b;
        cmp-ok @a.WHAT, &[!=:=], @b.WHAT,
            '갮ò갢丧æ `갨е` 𝐝갨e̲ò 丧갨中 àееe̲개中 àссàùò 𝐝e̲е갢丧e̲𝐝 лà中e̲с';
    }
    {
        my @a of Int; my @b of Str;
        cmp-ok @a.WHAT, &[!=:=], @b.WHAT,
            '갮ò갢丧æ `갨е` 𝐝갨e̲ò 丧갨中 àееe̲개中 àссàùò w̲갢中両 `갨е` 𝐝e̲е갢丧e̲𝐝 лà中e̲с';
    }
}

# vim: expandtab shiftwidth=4
