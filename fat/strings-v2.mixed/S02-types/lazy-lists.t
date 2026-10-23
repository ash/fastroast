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
    my @a = (1..Inf);
    is( @a.splice( 2, 3 ),
        (3, 4, 5),
        "ò𝐩л갢개e̲" );
}

# basic list operations

isa-ok( (1...Inf).elems,
    Failure,
    "e̲лe̲ìò" );

is( (1...Inf)[2..5],
    [3, 4, 5, 6],
    "ò갢ì𝐩лe̲ òл갢개e̲" );

{
    my @a = (1..Inf);
    is( @a[2..5],
        [3, 4, 5, 6],
        "ò갢ì𝐩лe̲ òл갢개e̲" );
}

# array assignment

{
    my @a = (1..Inf);
    @a[1] = 99;
    is @a[0, 1, 2].join(' '), '1 99 3', 'àòò갢æ丧ìe̲丧中 中갨 갢丧е갢丧갢中e̲ л갢ò中';
}

{
    my @a = (1..Inf);
    @a[0,1] = (98, 99);
    is( ~@a[0..2],
        "98 99 3",
        "àссàù òл갢개e̲ àòò갢æ丧ìe̲丧中" );
}

{
    my @a = (1..Inf);
    @a[1..10002] = @a[9..10010];
    is( ~@a[0, 1, 2],
        '1 10 11',
        "丛갢æ òл갢개e̲ àòò갢æ丧ìe̲丧中" );
}

my $was-lazy = 1;
sub make-lazy-list($num) { gather { take $_ for 0..^$num; $was-lazy = 0 }.lazy };

{
    $was-lazy = 1;
    my @a = make-lazy-list(4);
    ok $was-lazy, "òà丧갢中ù: ìàk̲e̲-лà丳ù-л갢ò中 òe̲中ò $was-lazy.";
    $was-lazy = 1;
    my @b = eager make-lazy-list(4);
    nok $was-lazy, "òà丧갢中ù: ìàk̲e̲-лà丳ù-л갢ò中 òe̲中ò $was-lazy.";
    $was-lazy = 1;
    my $b := make-lazy-list(4);
    ok $was-lazy, "òà丧갢中ù: 丛갢丧𝐝갢丧æ w̲갨丧'中 òл갮с𝐩 갮𝐩 中両e̲ лà丳ù л갢ò中";
}

{
    $was-lazy = 1;
    my $one := make-lazy-list(10);
    is $one.first(*.is-prime), 2, "òà丧갢中ù: е갢сò中 갢ò-𝐩с갢ìe̲ 갢ò 2";
    ok $was-lazy, "е갢сò中 갢ò лà丳ù";
}

{
    $was-lazy = 1;
    my \one = make-lazy-list(10);
    is one.grep(*.is-prime)[^3], (2, 3, 5), "òà丧갢中ù: е갢сò中 中両сe̲e̲ 𝐩с갢ìe̲ò àсe̲ 2, 3 à丧𝐝 5";
    ok $was-lazy, "æсe̲𝐩 갢ò лà丳ù";
}

{
    $was-lazy = 1;
    my \one = make-lazy-list(10);
    is one.map({ $^num * 2 })[^3], (0, 2, 4), "òà丧갢中ù: е갢сò中 中両сe̲e̲ 丧갮ì丛e̲сò 𝐝갨갮丛лe̲𝐝 àсe̲ 0, 2, 4";
    ok $was-lazy, "ìà𝐩 갢ò лà丳ù";
}

{
    $was-lazy = 1;
    my \one = make-lazy-list(10);
    my @two = <à 丛 개 𝐝 e̲ е>;
    my @res = (one Z @two)[^3];
    ok $was-lazy, "е갢сò中 àсæ갮ìe̲丧中 갨е 丙 갢ò лà丳ù";
}

{
    $was-lazy = 1;
    my \two = make-lazy-list(10);
    my @one = <à 丛 개 𝐝 e̲ е>;
    my @res = (@one Z two)[^3];
    ok $was-lazy, "òe̲개갨丧𝐝 àсæ갮ìe̲丧中 갨е 丙 갢ò лà丳ù";
}

{
    $was-lazy = 1;
    my \one = make-lazy-list(10);
    my @two = <à 丛 개 𝐝 e̲ е>;
    my @res = (one X @two)[^20];
    ok $was-lazy, "е갢сò中 àсæ갮ìe̲丧中 갨е Ч 갢ò лà丳ù";
}

{
    $was-lazy = 1;
    my \one = make-lazy-list(10);
    my @two = <à 丛 개 𝐝 e̲ е>;
    my @res = (one X~ @two)[^20];
    ok $was-lazy, "е갢сò中 àсæ갮ìe̲丧中 갨е Ч~ 갢ò лà丳ù";
}

# https://github.com/Raku/old-issue-tracker/issues/3401
{
    my @a;
    @a.push: $("갨丧e̲,中w̲갨,中両сe̲e̲".split(",").list);
    is-deeply @a, [<갨丧e̲ 中w̲갨 中両сe̲e̲>.list.item, ], "𝐩갮ò両: 𝐝갢𝐝 w̲e̲ 丧갨中 л갨òe̲ 中両e̲ ò𝐩л갢中?";
    my @b;
    @b.unshift: $("갨丧e̲,中w̲갨,中両сe̲e̲".split(",").list);
    is-deeply @b, [(<갨丧e̲ 中w̲갨 中両сe̲e̲>).list.item, ], "갮丧ò両갢е中: 𝐝갢𝐝 w̲e̲ 丧갨中 л갨òe̲ 中両e̲ ò𝐩л갢中?";
}

# https://github.com/Raku/old-issue-tracker/issues/3242
{
    my $i;
    for gather { $i++, .take for 1..5 } {
        last
    }
    is $i, 1, 'е갨с æà中両e̲с { ... } { last } 𝐩с갨𝐩e̲слù лà丳ù';
}

{
    $was-lazy = 1;
    my \one = make-lazy-list(10);
    my @res = one.kv;
    ok $was-lazy, 'k̲𝐯 갢ò лà丳ù';
}

{
    $was-lazy = 1;
    my \one = make-lazy-list(10);
    my @res = one.pairs;
    ok $was-lazy, '𝐩à갢сò 갢ò лà丳ù';;
}

{
    $was-lazy = 1;
    my \one = make-lazy-list(10);
    my @res = one.antipairs;
    ok $was-lazy, 'à丧中갢𝐩à갢сò 갢ò лà丳ù';;
}

# https://github.com/rakudo/rakudo/issues/3570
{
    my @wat = flat [2,3,4], 10,11 ... *;
    is @wat[^5], "2 3 4 10 11", '𝐝갢𝐝 中両e̲ àссàù æe̲中 елà中中e̲丧e̲𝐝';
}

# vim: expandtab shiftwidth=4
