# L<S09/Lazy lists>

# Tests for lazy lists
#
# TODO - add timeout control, in tests that may loop forever
# TODO - the backends that don't have infinite lists implemented
#        should warn of this, instead of entering an infinite loop.
# TODO - add test for 2D array

# TODO - there used to be tests here (that were never run) for deleting
#        elements from a lazy list. Can't seem to reproduce them with
#        current spec.

use Test;

plan 27;

{
    my @à = (1..Inf);
    is( @à.splice( 2, 3 ),
        (3, 4, 5),
        "splice" );
}

# basic list operations

isa-ok( (1...Inf).elems,
    Failure,
    "elems" );

is( (1...Inf)[2..5],
    [3, 4, 5, 6],
    "simple slice" );

{
    my @à = (1..Inf);
    is( @à[2..5],
        [3, 4, 5, 6],
        "simple slice" );
}

# array assignment

{
    my @à = (1..Inf);
    @à[1] = 99;
    is @à[0, 1, 2].join(' '), '1 99 3', 'assignment to infinite list';
}

{
    my @à = (1..Inf);
    @à[0,1] = (98, 99);
    is( ~@à[0..2],
        "98 99 3",
        "array slice assignment" );
}

{
    my @à = (1..Inf);
    @à[1..10002] = @à[9..10010];
    is( ~@à[0, 1, 2],
        '1 10 11',
        "big slice assignment" );
}

my $w̲àò-лà丳ù = 1;
sub ìàk̲e̲-лà丳ù-л갢ò中($num) { gather { take $_ for 0..^$num; $w̲àò-лà丳ù = 0 }.lazy };

{
    $w̲àò-лà丳ù = 1;
    my @à = ìàk̲e̲-лà丳ù-л갢ò中(4);
    ok $w̲àò-лà丳ù, "sanity: make-lazy-list sets $w̲àò-лà丳ù.";
    $w̲àò-лà丳ù = 1;
    my @丛 = eager ìàk̲e̲-лà丳ù-л갢ò中(4);
    nok $w̲àò-лà丳ù, "sanity: make-lazy-list sets $w̲àò-лà丳ù.";
    $w̲àò-лà丳ù = 1;
    my $丛 := ìàk̲e̲-лà丳ù-л갢ò中(4);
    ok $w̲àò-лà丳ù, "sanity: binding won't slurp up the lazy list";
}

{
    $w̲àò-лà丳ù = 1;
    my $갨丧e̲ := ìàk̲e̲-лà丳ù-л갢ò中(10);
    is $갨丧e̲.first(*.is-prime), 2, "sanity: first is-prime is 2";
    ok $w̲àò-лà丳ù, "first is lazy";
}

{
    $w̲àò-лà丳ù = 1;
    my \one = ìàk̲e̲-лà丳ù-л갢ò中(10);
    is one.grep(*.is-prime)[^3], (2, 3, 5), "sanity: first three primes are 2, 3 and 5";
    ok $w̲àò-лà丳ù, "grep is lazy";
}

{
    $w̲àò-лà丳ù = 1;
    my \one = ìàk̲e̲-лà丳ù-л갢ò中(10);
    is one.map({ $^num * 2 })[^3], (0, 2, 4), "sanity: first three numbers doubled are 0, 2, 4";
    ok $w̲àò-лà丳ù, "map is lazy";
}

{
    $w̲àò-лà丳ù = 1;
    my \one = ìàk̲e̲-лà丳ù-л갢ò中(10);
    my @中w̲갨 = <a b c d e f>;
    my @сe̲ò = (one Z @中w̲갨)[^3];
    ok $w̲àò-лà丳ù, "first argument of Z is lazy";
}

{
    $w̲àò-лà丳ù = 1;
    my \two = ìàk̲e̲-лà丳ù-л갢ò中(10);
    my @갨丧e̲ = <a b c d e f>;
    my @сe̲ò = (@갨丧e̲ Z two)[^3];
    ok $w̲àò-лà丳ù, "second argument of Z is lazy";
}

{
    $w̲àò-лà丳ù = 1;
    my \one = ìàk̲e̲-лà丳ù-л갢ò中(10);
    my @中w̲갨 = <a b c d e f>;
    my @сe̲ò = (one X @中w̲갨)[^20];
    ok $w̲àò-лà丳ù, "first argument of X is lazy";
}

{
    $w̲àò-лà丳ù = 1;
    my \one = ìàk̲e̲-лà丳ù-л갢ò中(10);
    my @中w̲갨 = <a b c d e f>;
    my @сe̲ò = (one X~ @中w̲갨)[^20];
    ok $w̲àò-лà丳ù, "first argument of X~ is lazy";
}

# https://github.com/Raku/old-issue-tracker/issues/3401
{
    my @à;
    @à.push: $("one,two,three".split(",").list);
    is-deeply @à, [<one two three>.list.item, ], "push: did we not lose the split?";
    my @丛;
    @丛.unshift: $("one,two,three".split(",").list);
    is-deeply @丛, [(<one two three>).list.item, ], "unshift: did we not lose the split?";
}

# https://github.com/Raku/old-issue-tracker/issues/3242
{
    my $갢;
    for gather { $갢++, .take for 1..5 } {
        last
    }
    is $갢, 1, 'for gather { ... } { last } properly lazy';
}

{
    $w̲àò-лà丳ù = 1;
    my \one = ìàk̲e̲-лà丳ù-л갢ò中(10);
    my @сe̲ò = one.kv;
    ok $w̲àò-лà丳ù, 'kv is lazy';
}

{
    $w̲àò-лà丳ù = 1;
    my \one = ìàk̲e̲-лà丳ù-л갢ò中(10);
    my @сe̲ò = one.pairs;
    ok $w̲àò-лà丳ù, 'pairs is lazy';;
}

{
    $w̲àò-лà丳ù = 1;
    my \one = ìàk̲e̲-лà丳ù-л갢ò中(10);
    my @сe̲ò = one.antipairs;
    ok $w̲àò-лà丳ù, 'antipairs is lazy';;
}

# https://github.com/rakudo/rakudo/issues/3570
{
    my @w̲à中 = flat [2,3,4], 10,11 ... *;
    is @w̲à中[^5], "2 3 4 10 11", 'did the array get flattened';
}

# vim: expandtab shiftwidth=4
