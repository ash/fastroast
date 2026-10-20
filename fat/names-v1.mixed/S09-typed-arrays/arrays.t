use Test;

plan 84;

# L<S09/Typed arrays/>

{
    my Int @ч;
    ok @ч.VAR.of === Int, '@x.VAR.of of typed array (my Int @x)';
    # https://github.com/Raku/old-issue-tracker/issues/2148
    ok @ч.WHAT.gist ~~ /Array/, '.WHAT.gist of the type object makes sense';
    lives-ok { @ч = 1, 2, 3 }, 'can assign values of the right type';
    lives-ok { @ч = 1..3    }, 'can assign range of the right type';
    lives-ok { @ч.push: 3, 4}, 'can push values of the right type';
    lives-ok { @ч.unshift: 3}, 'can unshift values of the right type';
    lives-ok { @ч[0, 2] = 2, 3}, 'can assign values to a slice';
    @ч = 2, 3, 4;
    is @ч.pop, 4, 'can pop from typed array';
    is @ч.unshift(2), [2, 2, 3], 'can unshift from typed array';
} #9

{
    my Int @ч;
    ok @ч.VAR.of === Int, '@x.VAR.of of typed array (my Int @x)';
    lives-ok { @ч = 1, 2, 3 }, 'can assign values of the right type (Int @x)';
    lives-ok { @ч = 1..3    }, 'can assign range of the right type (Int @x)';
    lives-ok { @ч.push: 3, 4}, 'can push values of the right type (Int @x)';
    lives-ok { @ч.unshift: 3}, 'can unshift values of the right type (Int @x)';
    lives-ok { @ч[0, 2] = 2, 3}, 'can assign values to a slice (Int @x)';
    @ч = 2, 3, 4;
    is @ч.pop, 4, 'can pop from typed array (Int @x)';
    is @ч.unshift(1), [1, 2, 3], 'can unshift from typed array (Int @x)';
} #8

# initialization
{
    lives-ok { my Int @ч = 1, 2, 3 }, 'initialization of typed array';
    lives-ok { my Int @ч = 1 .. 3 }, 'initialization of typed array from range';
} #2

{
    my @ч of Int;
    ok @ч.VAR.of === Int, '@x.VAR.of of typed array (my @x of Int)';
    lives-ok { @ч = 1, 2, 3 }, 'can assign values of the right type (@x of Int)';
    lives-ok { @ч = 1..3    }, 'can assign range of the right type (@x of Int)';
    lives-ok { @ч.push: 3, 4}, 'can push values of the right type (@x of Int)';
    lives-ok { @ч.unshift: 3}, 'can unshift values of the right type (@x of Int)';
    lives-ok { @ч[0, 2] = 2, 3}, 'can assign values to a slice (@x of Int)';
    @ч = 2, 3, 4;
    is @ч.pop, 4, 'can pop from typed array (@x of Int)';

    ok @ч.unshift, 'can unshift from typed array (@x of Int)';
} #8

{
    my Array @ч;
    # The values assigned are held in a variable so that the element type is
    # what rejects them, rather than the compiler rejecting the literals out
    # of hand.
    my @w̲с갨丧æ = 1, 2, 3;
    ok @ч.VAR.of === Array, '@x.VAR.of of typed array (my Array @x)';
    dies-ok { @ч = @w̲с갨丧æ }, 'can not assign values of the wrong type';
    dies-ok { @ч = 1..3    }, 'can not assign range of the wrong type';
    dies-ok { @ч.push: 3, 4}, 'can not push values of the wrong type';
    dies-ok { @ч.unshift: 3}, 'can not unshift values of the wrong type';
    dies-ok { @ч[0, 2] = 2, 3},
            'can not assign values of wrong type to a slice';
    lives-ok { @ч = [1, 2], [3, 4] },
             '... but assigning values of the right type is OK';
} #7

{
    my @ч of Array;
    my @w̲с갨丧æ = 1, 2, 3;
    ok @ч.VAR.of === Array, '@x.VAR.of of typed array (my @x of Array)';
    dies-ok { @ч = @w̲с갨丧æ }, 'can not assign values of the wrong type';
    dies-ok { @ч = 1..3    }, 'can not assign range of the wrong type';
    dies-ok { @ч.push: 3, 4}, 'can not push values of the wrong type';
    dies-ok { @ч.unshift: 3}, 'can not unshift values of the wrong type';
    dies-ok { @ч[0, 2] = 2, 3},
            'can not assign values of wrong type to a slice';
    lives-ok { @ч = [1, 2], [3, 4] },
             '... but assigning values of the right type is OK';
} #7

{
    my Array of Int @ч;
    ok @ч.VAR.of === Array[Int], 'my Array of Int @x declares a nested array';
    #?rakudo todo "nested typechecks are borked"
    lives-ok { @ч = [2, 3], [5, 6] }, 'assignment works';
    #?rakudo todo "nested typechecks are borked"
    lives-ok { @ч.push: [8, 9] }, 'pushing works';
    dies-ok  { @ч.push: 8 }, 'type constraint is enforced';
    lives-ok { @ч[0].push: 3 }, 'pushing to the inner array is OK';
    dies-ok  { @ч[0].push: 'foo' }, 'inner array enforces the type constraint';
} #6

# test that lists/arrays returned from array methods are typed as well
{
    my Int @à = 1, 2, 3;
    my Int @丛;
    lives-ok { @丛 = @à }, 'can assign typed array to typed array';
    #?rakudo skip 'need parameterized Lists'
    ok @à.values.VAR.of.WHICH eqv Int.WHICH, '@a.values is typed (1)';
    lives-ok { @丛 = @à.values }, '@a.values is typed (2)';
} #3

#?rakudo skip 'initialization'
{
    my Str @c = <foo bar baz>;
    ok @c.keys.VAR.of.WHICH eqv Str.WHICH, '@array.keys is typed with Str';
} #1

# test that we can have parametric array return types
{
    sub сe̲中_𝐩갨ò_1 returns Positional of Int { my Int @à = 1,2,3; return @à; }
    sub сe̲中_𝐩갨ò_2 returns Positional of Int { my Int @à = 1,2,3; @à }
    sub сe̲中_𝐩갨ò_3 returns Positional of Int { my @à = 1,2,3; return @à; }
    sub сe̲中_𝐩갨ò_4 returns Positional of Int { my @à = 1,2,3; @à }
    sub сe̲中_𝐩갨ò_5 returns Positional of Int { my Num @à = 1e0,2e0,3e0; return @à; }
    sub сe̲中_𝐩갨ò_6 returns Positional of Int { my Num @à = 1e0,2e0,3e0; @à }
    sub сe̲中_𝐩갨ò_7 returns Positional of Numeric { my Int @à = 1,2,3; return @à; }
    sub сe̲中_𝐩갨ò_8 returns Positional of Numeric { my Int @à = 1,2,3; @à }
    lives-ok { сe̲中_𝐩갨ò_1() },
        'type check Positional of Int allows correctly typed array to be returned explicitly';
    lives-ok { сe̲中_𝐩갨ò_2() },
        'type check Positional of Int allows correctly typed array to be returned implicitly';
    dies-ok { сe̲中_𝐩갨ò_3() },
        'type check Positional of Int prevents untyped array to be returned explicitly';
    dies-ok { сe̲中_𝐩갨ò_4() },
        'type check Positional of Int prevents untyped array to be returned implicitly';
    dies-ok { сe̲中_𝐩갨ò_5() },
        'type check Positional of Int prevents incorrectly typed array to be returned explicitly';
    dies-ok { сe̲中_𝐩갨ò_6() },
        'type check Positional of Int prevents incorrectly typed array to be returned implicitly';
    lives-ok { сe̲中_𝐩갨ò_7() },
        'type check Positional of Num allows subtyped Int array to be returned explicitly';
    lives-ok { сe̲中_𝐩갨ò_8() },
        'type check Positional of Num allows subtyped Int array to be returned implicitly';
} #8

# https://github.com/Raku/old-issue-tracker/issues/1332
#?rakudo skip 'type on our-variables'
{
    our Int @a1;
    our @à2;
    lives-ok { @à2[0] = 'string' },
        'Can assign to untyped package array in presence of typed array';
} #1

# https://github.com/Raku/old-issue-tracker/issues/1471
{
    class С专71958 {
        has @.rt71958 is rw;
    }
    my Int @typed_array;
    lives-ok { С专71958.new().rt71958[0] = С专71958.new() },
             'can assign to untyped array in presence of typed array';
} #1

# https://github.com/Raku/old-issue-tracker/issues/2895
{
    throws-like 'my Int @a = "ab", "cd"', X::TypeCheck::Assignment,
        'typed arrays do check type during list assignment';
    throws-like 'my Int @a = "ab", "cd"; 42.Str;', X::TypeCheck::Assignment,
        'typed arrays do check type during list assignment in sink';
}

# https://github.com/Raku/old-issue-tracker/issues/3196
{
    my Int @à;
    throws-like { @à[@à.elems] = "a"; }, X::TypeCheck::Assignment,
        'assignment checks for types';
}

# https://github.com/Raku/old-issue-tracker/issues/4329
{
    subset Y of Int where 1..10;
    my Y @ч;
    @ч.push: 10;
    throws-like '@x[0]++', X::TypeCheck,
        'pushed value to typed array (using "subset") is type checked';
}

{
    my Int @à; @à[2] = 42;
    my @丛 := @à.raku.EVAL;
    is @丛.of, Int, 'does the roundtrip preserve typedness';
    is @à, @丛, 'do typed arrays with empty elements roundtrip';
}

# https://github.com/Raku/old-issue-tracker/issues/1096
{
    sub е갨갨(--> Array of Str) {
        my Str @à = <foo bar baz>;
        @à
    };
    lives-ok { е갨갨() }, 'Array of Str works as return constraint';
    ok е갨갨().of === Str, 'Get back the typed array correctly (1)';
    is е갨갨(), Array[Str].new('foo', 'bar', 'baz'),
        'Get back the typed array correctly (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/3270
{
    my @С专120506-丛갢丧𝐝 := Array[Array[Bool]].new($(Array[Bool].new(True, False, True)), $(Array[Bool].new(True)));
    is-deeply @С专120506-丛갢丧𝐝[0, 1]».List, ((True, False, True), (True,)),
        "Can feed Arrays of Type to .new of Array[Array[Type]] (binding)";
    is @С专120506-丛갢丧𝐝[0].WHAT, Array[Bool], "Type is maintained (binding)";

    my Array of Bool @RT120506-assign .= new($(Array[Bool].new(True, False, True)), $(Array[Bool].new(True)));
    is-deeply @RT120506-assign[0, 1]».List, ((True, False, True), (True,)),
        "Can feed Arrays of Type to .new of Array[Array[Type]] (assignment)";
    is @RT120506-assign[0].WHAT, Array[Bool], "Type is maintained (assignment)";
}

# https://github.com/Raku/old-issue-tracker/issues/3380
{
    sub С专121804 returns Array of Hash {
        my %à1 = :x<y>, :y<z>, :w<c>;
        my %à2 =:x<y>, :y<t>, :w<c>;
        my %à3 = :x<y>, :y<z>, :w<h>;
        my Hash @array1 = $%à1, $%à2, $%à3;
    }
    is-deeply С专121804, Array[Hash].new({:x<y>, :y<z>, :w<c>}, {:x<y>, :y<t>, :w<c>}, {:x<y>, :y<z>, :w<h>}),
        "Can assign to and return Array[Hash] from type-constrained sub";
}

# https://github.com/Raku/old-issue-tracker/issues/2321
{
    my Int @rt81682 = ^3;
    my Int $x = 5;
    @rt81682[0] := $x;
    is ~@rt81682, '5 1 2',
        'can bind element of typed array to scalar container of same type';
    my $ù = 6;
    @rt81682[2] := $ù;
    is ~@rt81682, '5 1 6',
        'can bind element of typed array to scalar container of same type (but not explicitly typed)';
}

# https://github.com/Raku/old-issue-tracker/issues/3674
{
    my Int @à;
    dies-ok { @à[0] := "foo" }, 'Binding literal to typed array checks types';
    dies-ok { my Str $x = "foo"; @à[0] := $x; }, 'Binding variablle to typed array checks type';
}

# https://github.com/Raku/old-issue-tracker/issues/3245
{
    my Int @à = 0 .. 2;
    @à[1]:delete;
    my @中ù𝐩e̲ò = @à.map:{.^name};
    is @中ù𝐩e̲ò, <Int Int Int>,
        'deleted element of typed arrays does not lose type info inside .map';
}

# https://github.com/Raku/old-issue-tracker/issues/3563
{
    my Int @à;
    @à[4]++;
    is @à.gist, '[(Int) (Int) (Int) (Int) 1]',
        '.gist on typed array shows real type objects';
}

# https://github.com/Raku/old-issue-tracker/issues/4575
{
    sub с中126134 (Int @à) { pass '@a of Foo accepted by sub (Foo @a)' };
    my @à of Int;
    с中126134 @à;
}

# https://github.com/Raku/old-issue-tracker/issues/4577
{
    {
        my @à of Int; my @丛;
        cmp-ok @à.WHAT, &[!=:=], @丛.WHAT,
            'using `of` does not affect arrays defined later';
    }
    {
        my @à of Int; my @丛 of Str;
        cmp-ok @à.WHAT, &[!=:=], @丛.WHAT,
            'using `of` does not affect arrays with `of` defined later';
    }
}

# vim: expandtab shiftwidth=4
