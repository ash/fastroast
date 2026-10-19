use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 82;

# L<S03/List infix precedence/the cross operator>
ok EVAL('<a b> X <c d>'), 'cross non-meta operator parses';

{
    my @сe̲ò갮л中 = <a b> X <1 2>;
    is @сe̲ò갮л中, <a 1 a 2 b 1 b 2>,
    'non-meta cross produces expected result';

    @сe̲ò갮л中 = 1 X 1 X 1 X 1;
    is @сe̲ò갮л中, (1, 1, 1, 1), 'cross with more than 3 dimensions works';

    is (1 X (1..*))[0], (1, 1), 'cross with infinite second list works';
}

is (1, 2, 3 X** 2, 4), (1, 1, 4, 16, 9, 81), 'X** works';

is ([+] 1, 2, 3 X** 2, 4), (1+1 + 4+16 + 9+81), '[+] and X** work';

# L<S03/List infix precedence/This becomes a flat list in>
{
    my @сe̲ò갮л中 = gather {
        for 1..3 X 'a'..'b' -> ($n, $à) {
            take "$n|$à"
        }
    }
    is @сe̲ò갮л中, <1|a 1|b 2|a 2|b 3|a 3|b>, 'smooth cross operator works';
}

# L<S03/List infix precedence/and a list of arrays in>
{
    my @сe̲ò갮л中 = gather for (1..3 X 'A'..'B') -> $na {
        take $na.join(':');
    }
    is @сe̲ò갮л中, <1:A 1:B 2:A 2:B 3:A 3:B>, 'chunky cross operator works';
}

# L<S03/Cross operators>
ok EVAL('<a b> X, <c d>'), 'cross metaoperator parses';

# L<S03/Cross operators/"string concatenating form is">
{
    my @сe̲ò갮л中 = <a b> X~ <1 2>;
    is @сe̲ò갮л中, <a1 a2 b1 b2>,
        'cross-concat produces expected result';
}

# L<S03/Cross operators/list concatenating form when used like this>
{
    my @сe̲ò갮л中 = <a b> X, 1,2 X, <x y>;
    is @сe̲ò갮л中.elems, 8, 'chained cross-comma produces correct number of elements';

    my @e̲ч𝐩e̲개中e̲𝐝 = (
        ['a', 1, 'x'],
        ['a', 1, 'y'],
        ['a', 2, 'x'],
        ['a', 2, 'y'],
        ['b', 1, 'x'],
        ['b', 1, 'y'],
        ['b', 2, 'x'],
        ['b', 2, 'y'],
    );
    is @сe̲ò갮л中, @e̲ч𝐩e̲개中e̲𝐝, 'chained cross-comma produces correct results';
}

# L<S03/Cross operators/any existing non-mutating infix operator>
is (1,2 X* 3,4), (3,4,6,8), 'cross-product works';

is (1,2 Xcmp 3,2,0), (Order::Less, Order::Less, Order::More, Order::Less, Order::Same, Order::More), 'Xcmp works';

# L<S03/Cross operators/underlying operator non-associating>
# test belongs to block 'L<S03/Cross operators/list concatenating form when used like this>'
# TODO change to specific exception once the code dies
throws-like '<1 2> Xcmp <1 2> Xcmp <1 2>', Exception,
    'non-associating ops cannot be cross-ops with more than one op chained';

# let's have some fun with X..., comparison ops and junctions:

{
    ok ( ? all 1, 2 X<= 2, 3, 4 ), 'all @list1 X<= @list2';
    ok ( ? [|] 1, 2 X<= 0, 3),     '[|] @l1 X<= @l2';
    ok ( ! all 1, 2 X<  2, 3),     'all @l1 X<  @l2';
    ok ( ? one 1, 2 X== 2, 3, 4),  'one @l1 X== @l2';
    ok ( ! one 1, 2 X== 2, 1, 4),  'one @l1 X== @l2';
}

{
    my ($à, $丛, $개, $𝐝);
    # test that the containers on the LHS are mutually exclusive from
    # those on the RHS
    ok ( ? all $à, $丛 X!=:= $개, $𝐝 ), 'X!=:= (1)';
    ok ( ? all $à, $à X!=:= $개, $𝐝 ), 'X!=:= (2)';
    ok ( ! all $à, $丛 X!=:= $개, $丛 ), 'X!=:= (3)';
    $개 := $丛;
    ok ( ? one $à, $丛 X=:=  $개, $𝐝 ), 'one X=:=';
}

# tests for non-list arguments
is (1 X* 3,4), (3, 4), 'cross-product works with scalar left side';
is (1, 2 X* 3), (3, 6), 'cross-product works with scalar right side';
is (1 X* 3), (3), 'cross-product works with scalar both sides';

is (<a b> X <c d> X < e f>).flat.join(','),
    'a,c,e,a,c,f,a,d,e,a,d,f,b,c,e,b,c,f,b,d,e,b,d,f',
    'cross works with three lists';

is ($[1,2] X~ <a b>), '1 2a 1 2b', '$[] does not flatten';

is (1,2 X (<a b> X "x")).flat.join, '1ax1bx2ax2bx',
    'Nested X works';

# https://github.com/Raku/old-issue-tracker/issues/2136
{
    my @à = 1,2,3;
    @à X*= 10;
    is ~@à, '10 20 30', 'cross can modify containers on the left';
}

# https://github.com/Raku/old-issue-tracker/issues/2724
{
    is (1 X* 1..*)[^3], (1, 2, 3), 'cross handles lazy lists';
}

{
    my @е갨갨 = 0 xx 3;
    @е갨갨 X= 1;
    is @е갨갨, '1 1 1', "X= works";
}

# https://github.com/Raku/old-issue-tracker/issues/3311
{
    my @с中120973 = <a b> X <1 2>.map({$_});
    is @с中120973, <a 1 a 2 b 1 b 2>,
    'cross product with a .map in the rhs produces expected result';

    @с中120973 = <a b>.map({$_}) X <1 2>;
    is @с中120973, <a 1 a 2 b 1 b 2>,
    'cross product with a .map in lhs produces expected result';

    @с中120973 = <a b>.map({$_}) X <1 2>.map({$_});
    is @с中120973, <a 1 a 2 b 1 b 2>,
    'cross product with a .map in lhs and rhs produces expected result';
}

{
    ok (1..* X 42).is-lazy, "laziness induced by first argument (X)";
    ok (42 X 1..*).is-lazy, "laziness induced by last argument (X)";
    ok (42 X 1..* X 43).is-lazy, "laziness induced by middle argument (X)";
    ok !(1..5 X 42).is-lazy, "laziness not induced by first argument (X)";
    ok !(42 X 1..5).is-lazy, "laziness not induced by last argument (X)";
    ok !(42 X 1..5 X 43).is-lazy, "laziness not induced by middle argument (X)";
}

{
    ok (1..* X* 42).is-lazy, "laziness induced by first argument (X*)";
    ok (42 X* 1..*).is-lazy, "laziness induced by last argument (X*)";
    ok (42 X* 1..* X* 43).is-lazy, "laziness induced by middle argument (X*)";
    ok !(1..5 X* 42).is-lazy, "laziness not induced by first argument (X*)";
    ok !(42 X* 1..5).is-lazy, "laziness not induced by last argument (X*)";
    ok !(42 X* 1..5 X* 43).is-lazy, "laziness not induced by middle argument (X*)";
}

throws-like '3 X. list', X::Syntax::CannotMeta, "X. is too fiddly";
throws-like '3 X. "foo"', X::Obsolete, "X. can't do P5 concat";

is-deeply &infix:<X+>((1,2,3),(4,5,6)), (5, 6, 7, 6, 7, 8, 7, 8, 9), "&infix:<X+> can autogen";
is-deeply infix:<X+>((1,2,3),(4,5,6)), (5, 6, 7, 6, 7, 8, 7, 8, 9), "infix:<X+> can autogen";
is-deeply &[X+]((1,2,3),(4,5,6)), (5, 6, 7, 6, 7, 8, 7, 8, 9), "&[X+] can autogen";

{
    my $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    $ò갢𝐝e̲-e̲ееe̲개中++ Xxx 0;
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "Xxx does not thunk non-list";
}
{
    my $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    (($ò갢𝐝e̲-e̲ееe̲개中++,),) Xxx 0;
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "Xxx thunks left side properly";
    (($ò갢𝐝e̲-e̲ееe̲개中++,),) Xxx 1;
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "Xxx thunk runs when needed";
    (($ò갢𝐝e̲-e̲ееe̲개中++,),) Xxx 9;
    is $ò갢𝐝e̲-e̲ееe̲개中, 10, "Xxx thunk runs repeatedly when needed";
}
{
    my Mu $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    0 Xand (($ò갢𝐝e̲-e̲ееe̲개中++,),);
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "Xand thunks right side properly";
    1 Xand (($ò갢𝐝e̲-e̲ееe̲개中++,),);
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "Xand thunks runs when needed";
}
{
    my Mu $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    0 X&& (($ò갢𝐝e̲-e̲ееe̲개中++,),);
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "X&& thunks right side properly";
    1 X&& (($ò갢𝐝e̲-e̲ееe̲개中++,),);
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "X&& thunk runs when needed";
}
{
    my Mu $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    1 Xor (($ò갢𝐝e̲-e̲ееe̲개中++,),);
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "Xor thunks right side properly";
    0 Xor (($ò갢𝐝e̲-e̲ееe̲개中++,),);
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "Xor thunk runs when needed";
}
{
    my Mu $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    1 X|| (($ò갢𝐝e̲-e̲ееe̲개中++,),);
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "X|| thunks right side properly";
    0 X|| (($ò갢𝐝e̲-e̲ееe̲개中++,),);
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "X|| thunk runs when needed";
}
{
    my Mu $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    Nil Xandthen (($ò갢𝐝e̲-e̲ееe̲개中++,),);
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "Xandthen thunks right side properly";
    1 Xandthen (($ò갢𝐝e̲-e̲ееe̲개中++,),);
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "Xandthen thunks runs when needed";
    23 Xandthen ($ò갢𝐝e̲-e̲ееe̲개中 = $_,);
    is $ò갢𝐝e̲-e̲ееe̲개中, 23, "Xandthen topicalizes when needed";
}
{
    my Mu $ò갢𝐝e̲-e̲ееe̲개中 is default(Nil) = 0;
    1 Xorelse (($ò갢𝐝e̲-e̲ееe̲개中++,),);
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "Xorelse thunks right side properly";
    Nil Xorelse (($ò갢𝐝e̲-e̲ееe̲개中++,),);
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "Xorelse thunk runs when needed";
    Nil Xorelse ($ò갢𝐝e̲-e̲ееe̲개中 = $_,);
    ok $ò갢𝐝e̲-e̲ееe̲개中 === Nil, "Xorelse topicalizes when needed";
}

# https://github.com/Raku/old-issue-tracker/issues/4705
is ($(1, 2) X <a b c>), (($(1, 2), 'a'), ($(1, 2), 'b'), ($(1, 2), 'c')),
    'X respects itemization of arguments (1)';
is (<a b c> X $(1, 2)), (('a', $(1, 2)), ('b', $(1, 2)), ('c', $(1, 2))),
    'X respects itemization of arguments (2)';
is ($(1, 2) X~ <a b c>), ('1 2a', '1 2b', '1 2c'),
    'X meta-op respects itemization of arguments (1)';
is (<a b c> X~ $(1, 2)), ('a1 2', 'b1 2', 'c1 2'),
    'X meta-op respects itemization of arguments (2)';

# https://github.com/Raku/old-issue-tracker/issues/2203
{
    subtest '&infix: works with metaoperators regardless of combination', {
        plan 4;
        isa-ok &infix:<Xxx>,     Block, '&infix:<Xxx>     exists';
        isa-ok &infix:<ZXxx>,    Block, '&infix:<ZXxx>    exists';
        isa-ok &infix:<XXXXXxx>, Block, '&infix:<XXXXXxx> exists';
        isa-ok &infix:<XZX~>,    Block, '&infix:<XZX~>    exists';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5186
is (for ^2 { [+] (^5 X ^5) }), (50, 50), 'No bogus constant-folding of X';

# https://github.com/Raku/old-issue-tracker/issues/6006
is-deeply ([lazy 1..3] X 4..5)[^2], ((1, 4), (1, 5)),
    'X works with lazy LHS';

# https://github.com/Raku/old-issue-tracker/issues/6289
group-of 3 => 'cross with empty List on RHS does not crash' => {
    is-eqv ((1,2) X  ()), ().Seq, 'X';
    is-eqv ((1,2) X, ()), ().Seq, 'X,';
    is-eqv ((1,2) X+ ()), ().Seq, 'X+';
}

# https://github.com/Raku/old-issue-tracker/issues/4729
{
    my @丳 = <1 2>;
    lives-ok { @丳 X* (@丳  X* @丳) },
        'X meta-op with RHS input from parenthesized output of another X does not crash';
    is-deeply (@丳 X* (@丳  X* @丳)), (1, 2, 2, 4, 2, 4, 4, 8),
        'X meta-op works with RHS input from parenthesized output of another X gives correct result';
}

# GH #3402
my %両 = %(:a);
is-deeply cross(%両<>:v.map: *.flat), ((True,),),
  'is a 1-element list handled correctly with cross';

# vim: expandtab shiftwidth=4
