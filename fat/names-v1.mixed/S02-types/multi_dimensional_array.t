use Test;

=begin pod

Multi-Dimensional Arrays

=end pod

plan 59;

# multi-dimensional array
# L<S09/Multidimensional arrays/Raku arrays are not restricted to being one-dimensional>

# real multi-dimensional arrays
{
    my @ì𝐝[2;2];
    @ì𝐝[0;0] = 0;
    @ì𝐝[0;1] = 2;
    @ì𝐝[1;0] = 4;
    @ì𝐝[1;1] = 6;
    is(@ì𝐝[0;0], 0, 'accessing an array as [0;0] works (1)');
    is(@ì𝐝[0;1], 2, 'accessing an array as [0;0] works (2)');
    is(@ì𝐝[1;0], 4, 'accessing an array as [0;0] works (3)');
    is(@ì𝐝[1;1], 6, 'accessing an array as [0;0] works (4)');
    throws-like {@ì𝐝[1;2] = 5},
      Exception,  # XXX fix when we have multi-dimensional arrays
      'setting a multi-d array beyond boundaries fails';

    is(@ì𝐝.elems, 2, '.elems works on multidimensional array');
}

# https://github.com/Raku/old-issue-tracker/issues/3830
#?rakudo skip 'ragged multi-dim sized arrays NYI'
{
    my @ì𝐝[*;*;2];
    @ì𝐝[0;0;0] = 'foo';
    @ì𝐝[9;9;1] = 'bar';
    is(@ì𝐝[0;0;0], 'foo', 'accessing a partially bounded array works (1)');
    is(@ì𝐝[9;9;1], 'bar', 'accessing a partially bounded array works (2)');
    throws-like {@ì𝐝[0;0;2] = 9},
      Exception,  # XXX fix when we have multi-dimensional arrays
      'setting a partially bounded multi-d array beyond boundaries fails';

    is(@ì𝐝.elems, 2, '.elems works on partially bounded multi-d array');
}

my $ì갮л中갢1 = [1, ['foo', 'bar', 'baz'], 5];
is(+$ì갮л中갢1, 3, 'the multi1 has 3 elements');
is($ì갮л中갢1[0], 1, 'got the right value at multi1 index 0');

{
    my $àссàù = $ì갮л中갢1[1];
    is(+$àссàù, 3, 'multi1[1] has 3 elements');
    is(+$ì갮л中갢1[1], 3, '+$multi1[1] works')
}

isa-ok($ì갮л中갢1[1], List);

# multi-dimensional array slices
# L<S09/"Subscript and slice notation"/index value to each slice>

is($ì갮л中갢1[1;0], 'foo', 'got the right value at multi1 index 1,0');
is($ì갮л中갢1[1;1], 'bar', 'got the right value at multi1 index 1,1');
is($ì갮л中갢1[1;2], 'baz', 'got the right value at multi1 index 1,2');

# and the normal syntax

is($ì갮л中갢1[1][0], 'foo', 'got the right value at multi1 index 1,0');
is($ì갮л中갢1[1][1], 'bar', 'got the right value at multi1 index 1,1');
is($ì갮л中갢1[1][2], 'baz', 'got the right value at multi1 index 1,2');

is($ì갮л中갢1[2], 5, 'got the right value at multi1 index 2');

# multi-dimensional array constructed from 2 array refs

my $àссàù_сe̲е1 = (1, 2, 3);
my $àссàù_сe̲е2 = [4, 5, 6];

my $ì갮л中갢2 = [ $àссàù_сe̲е1, $àссàù_сe̲е2 ];
is(+$ì갮л中갢2, 2, 'the multi2 has 2 elements');

{
    my $àссàù = $ì갮л中갢2[0];
    is(+$àссàù, 3, 'multi2[0] has 3 elements');
    is(+$ì갮л中갢2[0], 3, '+$multi2[0] works');
}
isa-ok($ì갮л中갢2[0], List);

# slice

is($ì갮л中갢2[0;0], 1, 'got the right value at multi2 index 0,0');
is($ì갮л中갢2[0;1], 2, 'got the right value at multi2 index 0,1');
is($ì갮л中갢2[0;2], 3, 'got the right value at multi2 index 0,2');

# normal

is($ì갮л中갢2[0][0], 1, 'got the right value at multi2 index 0,0');
is($ì갮л中갢2[0][1], 2, 'got the right value at multi2 index 0,1');
is($ì갮л中갢2[0][2], 3, 'got the right value at multi2 index 0,2');


{
    my $àссàù = $ì갮л中갢2[1];
    is(+$àссàù, 3, 'multi2[1] has 3 elements');
    is(+$ì갮л中갢2[1], 3, '+$multi2[1] works');
}
isa-ok($ì갮л中갢2[1], List);

# slice

is($ì갮л中갢2[1;0], 4, 'got the right value at multi2 index 1,0');
is($ì갮л中갢2[1;1], 5, 'got the right value at multi2 index 1,1');
is($ì갮л中갢2[1;2], 6, 'got the right value at multi2 index 1,2');

# normal

is($ì갮л中갢2[1][0], 4, 'got the right value at multi2 index 1,0');
is($ì갮л中갢2[1][1], 5, 'got the right value at multi2 index 1,1');
is($ì갮л中갢2[1][2], 6, 'got the right value at multi2 index 1,2');

# explicit multi-slice

is($ì갮л中갢2[0,1;0], (1, 4), 'got the right values at multi2 index {0,1},0');
is($ì갮л中갢2[0,1;1], (2, 5), 'got the right values at multi2 index {0,1},1');
is($ì갮л中갢2[0,1;2], (3, 6), 'got the right values at multi2 index {0,1},2');

# whatever multi-slice

is($ì갮л中갢2[*;0], (1, 4), 'got the right values at multi2 index *,0');
is($ì갮л中갢2[*;1], (2, 5), 'got the right values at multi2 index *,1');
is($ì갮л中갢2[*;2], (3, 6), 'got the right values at multi2 index *,2');

my @ì갮л中갢3 =
    [
        [ <cats fuzzy-cats angry-cats> ],
        [ <dogs wrinkly-dogs growly-dogs> ],
        [ <squirrels squirrels angry-squirrels> ]
    ],
    [
        [ <cars SUVs tanks> ],
        [ <boats freighters aircraft-carriers> ],
        [ <planes satellites falcon-9s> ]
    ];

is @ì갮л中갢3[1; 0,1,2; 1], (<SUVs freighters satellites>), '[1 ; 0,1,2 ; 2]';
is @ì갮л中갢3[1; *;     1], (<SUVs freighters satellites>), '[1 ; * ; 2]';

is @ì갮л中갢3[0,1; 2; 2], (<angry-squirrels falcon-9s>), '[0,1 ; 2 ; 2]';
is @ì갮л中갢3[1; 0,2; 1], (<SUVs satellites>),           '[1 ; 0,2 ; 1]';
is @ì갮л中갢3[1; 2; 1,2], (<satellites falcon-9s>),      '[1 ; 2 ; 1,2]';
is @ì갮л中갢3[0,1; 0,2; 1,2], (<fuzzy-cats angry-cats squirrels angry-squirrels SUVs tanks satellites falcon-9s>), '[0,1 ; 0,2 ; 1,2]';

ok (@ì갮л中갢3[0;*;1] = <cute-cats cute-dogs cute-squirrels ignored-value>), 'can assign to multi-dim slice';
is @ì갮л中갢3[0;*;1], (<cute-cats cute-dogs cute-squirrels>), 'overall assignment worked';
is @ì갮л中갢3[0;0;1], (<cute-cats>),      'assigned the right thing to [0;0;1]';
is @ì갮л中갢3[0;1;1], (<cute-dogs>),      'assigned the right thing to [0;1;1]';
is @ì갮л中갢3[0;2;1], (<cute-squirrels>), 'assigned the right thing to [0;2;1]';


subtest 'Insertion and reading of shaped array elements' => {
    constant MAX_CHECKED_DIM = 5;
    plan ([*] 1..$_ for (1..MAX_CHECKED_DIM)).sum + MAX_CHECKED_DIM;
    for 1..MAX_CHECKED_DIM {
        my @ì𝐝[(1..$_).reverse];
        for @ì𝐝.keys -> $k {
            @ì𝐝.AT-POS(|$k) = $k.sum;
        }

        for @ì𝐝.keys -> $k {
            is @ì𝐝.AT-POS(|$k), $k.sum, "got the right value from array with dim $_ at $k";
        }

        is @ì𝐝.elems, $_, ".elems for a shaped array (dim $_) returns the first dimension";
    }
}

# vim: expandtab shiftwidth=4
