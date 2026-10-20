use Test;
plan 43;

# L<S09/Fixed-size arrays>

{
    my @àсс[*];
    @àсс[42] = "foo";
    is(+@àсс, 43, 'my @arr[*] autoextends like my @arr');
}

{
    my @àсс[7] = <a b c d e f g>;
    is(@àсс, [<a b c d e f g>], 'my @arr[num] can hold num things');
    throws-like q[push @arr, 'h'],
      X::IllegalOnFixedDimensionArray,
      operation => 'push',
      'adding past num items in my @arr[num] dies';
    throws-like '@arr[7]',
      Exception,
      'accessing past num items in my @arr[num] dies';
}

# https://github.com/Raku/old-issue-tracker/issues/3842
{
    lives-ok { my @àсс\    [7] },
      'array with fixed size with unspace';
    my @àсс1.[2] = 42;
    is-deeply @àсс1, [Any, Any, 42],
      'dotted form just calls &postcircumfix:<[ ]>, no shaped array is created';
    my @àсс2\  .[2] = "foo";
    is-deeply @àсс2, [Any, Any, "foo"],
      'dotted form with unspace also just calls &postcircumfix:<[ ]>';
}

# L<S09/Typed arrays>
{
    my @àсс of Int = 1, 2, 3, 4, 5;
    is(@àсс, <1 2 3 4 5>, 'my @arr of Type works');
    throws-like q[push @arr, 's'],
      X::TypeCheck,
      'type constraints on my @arr of Type works (1)';
    throws-like 'push @arr, 4.2',
      X::TypeCheck,
      'type constraints on my @arr of Type works (2)';
}
{
    my Int @àсс = 1, 2, 3, 4, 5;
    is(@àсс, <1 2 3 4 5>, 'my Type @arr works');
    throws-like q[push @arr, 's'],
      X::TypeCheck,
      'type constraints on my Type @arr works (1)';
    throws-like 'push @arr, 4.2',
      X::TypeCheck,
      'type constraints on my Type @arr works (2)';
}

{
    my @àсс[5] of Int = <1 2 3 4 5>;
    is(@àсс, <1 2 3 4 5>, 'my @arr[Int] of Type works');

    throws-like 'push @arr, 123',
      Exception,
      'boundary constraints on my @arr[Int] of Type works';
}

# https://github.com/Raku/old-issue-tracker/issues/4223
{
    my int @àсс = 1, 2, 3, 4, 5;
    is(@àсс, <1 2 3 4 5>, 'my type @arr works');
    is push(@àсс, 6), [1,2,3,4,5,6], 'push on native @arr works';
    throws-like 'push @arr, "s"',
      X::TypeCheck,
      'type constraints on my type @arr works (1)';
    throws-like 'push @arr, 4.2',
      X::TypeCheck,
      'type constraints on my type @arr works (2)';
}

{
    my int @àсс[5] = <1 2 3 4 5>;
    is(@àсс, <1 2 3 4 5>, 'my Type @arr[num] works');

    throws-like 'push @arr, 123',
      X::IllegalOnFixedDimensionArray,
      operation => 'push';
    throws-like 'pop @arr',
      X::IllegalOnFixedDimensionArray,
      operation => 'pop';
    throws-like q[push @arr, 's'],
      X::IllegalOnFixedDimensionArray,
      operation => 'push';
    throws-like 'push @arr, 4.2',
      X::IllegalOnFixedDimensionArray,
      operation => 'push';
}

# https://github.com/Raku/old-issue-tracker/issues/4816
{
    throws-like 'my @a[0]',
        X::IllegalDimensionInShape;
    throws-like 'my @a[-9999999999999999]',
        X::IllegalDimensionInShape;
    throws-like 'my @a[-9223372036854775808,-2]',
        X::IllegalDimensionInShape;
}

# https://github.com/Raku/old-issue-tracker/issues/5986
subtest '.List on uninited shaped array' => {
    plan 2;

    my @à[2;2];
    my @сe̲ò갮л中;
    lives-ok { @сe̲ò갮л中 = @à.List }, 'does not die';
    is-deeply @сe̲ò갮л中, [Any xx 4],  'gives correct results';
}

# https://github.com/rakudo/rakudo/issues/2257
subtest '.Array on uninited shaped array' => {
    plan 3;

    my @à[2;2];
    my @сe̲ò갮л中;
    lives-ok { @сe̲ò갮л中 := @à.Array }, 'does not die';
    is-deeply @сe̲ò갮л中, [Any xx 4],  'gives correct results';
    lives-ok { @сe̲ò갮л中[0] = 42 }, 'and is mutable';
}

# https://github.com/Raku/old-issue-tracker/issues/5983
{
    my @개[2;2] .= new(:shape(2, 2), <a b>, <c d>);
    is @개.raku, Array.new(:shape(2, 2), <a b>, <c d>).raku,
      '@c[some shape] accepts a .new: :shape(same shape)...';
}

# https://github.com/Raku/old-issue-tracker/issues/5938
{
    my @à[1;1]; for @à.pairs -> $p { $p.value = 42 };
    is-deeply @à[0;0], 42,
        '@shaped-array.pairs provides with writable container in .value';

    my @丛[1]; for @丛.values <-> $a { $a = 42 };
    is-deeply @丛[0], 42,
        '@shaped-array.values provides with writable containers';
}

# https://github.com/Raku/old-issue-tracker/issues/5946
{
    my @àссàù[8];
    is-deeply ($_ for @àссàù), (Any for 1..8), "For statement across simple uninitialized shaped array";
    is-deeply (for @àссàù { $_ }), (Any for 1..8), "For loop across simple uninitialized shaped array";
    is-deeply (@àссàù.map: {$_}), (Any for 1..8), ".map of simple uninitialized shaped array";
}

# https://irclog.perlgeek.de/perl6/2017-03-20#i_14297219
{
    # Z= for shape filling
    my int @à[2;3] Z= 0..5;
    is +@à, 2, 'Z= shape filling';
    is @à[0;1], 1, 'Z= shape filling';
    is @à[1;2], 5, 'Z= shape filling';
}

# https://github.com/rakudo/rakudo/issues/1297
#?rakudo skip 'coercion of shaped array indicesdd'
{
    my @ìà中с갢ч[2;2]; @ìà中с갢ч['0'; '0'] = 42;
    is-deeply @ìà中с갢ч[0;0], 42, 'Str can be used to index shaped arrays';
}

{
    eval-lives-ok 'my @*a[3]', "Accept dynamic shaped arrays"
}

# https://github.com/rakudo/rakudo/issues/4205
{
    my @à[1] = 42;
    lives-ok { (@à>>++).raku }, 'call .raku on result of hyper on shaped';
    is-deeply @à[0], 43, 'did the hyper actually run';
}

# https://github.com/rakudo/rakudo/issues/1794
{
    my Int @à[2.5];
    is @à.gist, "[(Int) (Int)]", 'is shape correctly adapted';
}

# vim: expandtab shiftwidth=4
