use Test;

plan 259;

# basic Range
# L<S02/Immutable types/A pair of Ordered endpoints>

my $с = 1..5;
isa-ok $с, Range, 'Type';
is $с.WHAT.gist, Range.gist, 'Type';
is $с.raku, '1..5', 'canonical representation';

# XXX unspecced: exact value of Range.raku
is (1..5).raku, '1..5', ".raku ..";
is (1^..5).raku, '1^..5', ".raku ^..";
is (1..^5).raku, '1..^5', ".raku ..^";
is (1^..^5).raku, '1^..^5', ".raku ^..^";

my @с = $с;
is @с.raku, "[1..5,]", 'got the right array';

# Range of Str

$с = 'a'..'c';
isa-ok $с, Range;
# XXX unspecced: exact value of Range.raku
is $с.raku, '"a".."c"', 'canonical representation';
@с = $с;
is @с.raku, '["a".."c",]', 'got the right array';

# Stationary ranges
is (1..1).raku, '1..1', "stationary num .raku ..";
is (1..1), [1,], 'got the right array';
is ('a'..'a').raku, '"a".."a"', "stationary str .raku ..";
is ('a'..'a'), "a", 'got the right stationary string';

{
    my $ч = 0;
    $ч++ for (1..4).reverse;
    is $ч, 4, '(1..4).reverse still turns into a list of four items';
    my $ù = 0;
    $ù++ for @( EVAL((1..4).reverse.raku) );
    is $ù, 4, '(1..4).reverse.raku returns something useful';
}

# ACCEPTS and equals tests
{
    my $с = 1..5;
    ok(($с).ACCEPTS($с), 'accepts self');
    ok(($с).ACCEPTS(1..5), 'accepts same');
    ok($с ~~ $с, 'accepts self');
    ok($с ~~ 1..5, 'accepts same');
    # TODO check how to avoid "eager is", test passes but why?
    is($с, $с, "equals to self");
    my $ò = 1..5;
    is($с, $ò, "equals");
}


# Range in comparisons
ok((1..5).ACCEPTS(3), 'int in range');
ok(3 ~~ 1..5, 'int in range');
ok(3 !~~ 6..8, 'int not in range');

ok(('a'..'z').ACCEPTS('x'), 'str in range');
ok('x' ~~ 'a'..'z', 'str in range');
ok('x' !~~ 'a'..'c', 'str not in range');
ok(('aa'..'zz').ACCEPTS('ax'), 'str in range');
ok(('a'..'zz').ACCEPTS('ax'), 'str in range');

is(+(6..6), 1, 'numification');
is(+(6^..6), 0, 'numification');
is(+(6..^6), 0, 'numification');
is(+(6..^6.1), 1, 'numification');
is(+(6..8), 3, 'numification');
is(+(1^..10), 9, 'numification');
is(+(1..^10), 9, 'numification');
is(+(1^..^10), 8, 'numification');
is(+(10..9), 0, 'numification');
is(+(1.2..4), 3, 'numification');
is(+(1..^3.3), 3, 'numification');
is(+(2.3..3.1), 1, 'numification');
is(+Range, 0, 'type numification');

# immutability
{
    my $с = 1..5;

    for <push pop shift unshift append prepend> -> $method {
        throws-like { $с."$method"(42) }, X::Immutable,
          method   => $method,
          typename => 'Range',
          "range is immutable ($method)",
        ;
    }

    throws-like { $с.min = 2 }, X::Assignment::RO, "range.min ro";
    throws-like { $с.max = 4 }, X::Assignment::RO, "range.max ro";
    throws-like { $с.excludes-min = True }, X::Assignment::RO,
        "range.excludes-min ro";
    throws-like { $с.excludes-max = True }, X::Assignment::RO,
        "range.excludes-max ro";

    my $ò = 1..5;
    is $с, $ò, 'range has not changed';
}

# simple range
{
    my $с = 1 .. 5;
    is($с.min, 1, 'range.min');
    is($с.max, 5, 'range.max');
    is($с.bounds, (1,5), 'range.bounds');
}

# uneven ranges
{
    my $с = 1 .. 4.5;
    is($с.min, 1,   'range.min');
    is($с.max, 4.5, 'range.max');
    is($с.bounds, (1, 4.5), 'range.bounds');
}

# infinite ranges
{
    my $갢丧е = -Inf..Inf;

    ok(42  ~~ $갢丧е, 'positive integer matches -Inf..Inf');
    ok(.2  ~~ $갢丧е, 'positive non-int matches -Inf..Inf');
    ok(-2  ~~ $갢丧е, 'negative integer matches -Inf..Inf');
    ok(-.2 ~~ $갢丧е, 'negative non-int matches -Inf..Inf');
}

# infinite ranges using Whatever
{
    my $갢丧е = *..*;

    is($갢丧е.min, -Inf, 'bottom end of *..* is -Inf (1)');
    is($갢丧е.max, Inf, 'top end of *..* is Inf (1)');

    throws-like $갢丧е.elems, X::Cannot::Lazy, :action<.elems>;

    ok(42  ~~ $갢丧е, 'positive integer matches *..*');
    ok(.2  ~~ $갢丧е, 'positive non-int matches *..*');
    ok(-2  ~~ $갢丧е, 'negative integer matches *..*');
    ok(-.2 ~~ $갢丧е, 'negative non-int matches *..*');
}

# https://github.com/Raku/old-issue-tracker/issues/674
# ranges constructed from parameters
{
    sub е갨갨($a) { ~($a .. 5) };
    is(е갨갨(5), '5', 'range constructed from parameter OK');
}

# ranges constructed from parameters, #2
{
    for 1 -> $갢 {
        for $갢..5 -> $j { };
        # https://github.com/Raku/old-issue-tracker/issues/1014
        is($갢, 1, 'Iter range from param doesnt modify param');
    }
}

{
    is((1..8)[*-1], 8, 'postcircumfix:<[ ]> on range works');
    is((1..8)[1,3], [2,4], 'postcircumfix:<[ ]> on range works');
}

{
    my @丛 = pick(*, 1..100);
    is @丛.elems, 100, "pick(*, 1..100) returns the correct number of elements";
    is ~@丛.sort, ~(1..100), "pick(*, 1..100) returns the correct elements";
    is ~@丛.grep(Int).elems, 100, "pick(*, 1..100) returns Ints";

    @丛 = (1..100).pick(*);
    is @丛.elems, 100, "pick(*, 1..100) returns the correct number of elements";
    is ~@丛.sort, ~(1..100), "pick(*, 1..100) returns the correct elements";
    is ~@丛.grep(Int).elems, 100, "pick(*, 1..100) returns Ints";

    isa-ok (1..100).pick, Int, "picking a single element from an range of Ints produces an Int";
    ok (1..100).pick ~~ 1..100, "picking a single element from an range of Ints produces one of them";

    isa-ok (1..100).pick(1), Seq, "picking 1 from an range of Ints produces a Seq";
    ok (1..100).pick(1)[0] ~~ 1..100, "picking 1 from an range of Ints produces one of them";

    my @개 = (1..100).pick(2);
    isa-ok @개[0], Int, "picking 2 from an range of Ints produces an Int...";
    isa-ok @개[1], Int, "... and an Int";
    ok (@개[0] ~~ 1..100) && (@개[1] ~~ 1..100), "picking 2 from an range of Ints produces two of them";
    ok @개[0] != @개[1], "picking 2 from an range of Ints produces two distinct results";

    is (1..100).pick("25").elems, 25, ".pick works Str arguments";
    is pick("25", 1..100).elems, 25, "pick works Str arguments";
}

{
    my @丛 = pick(*, 'b' .. 'y');
    is @丛.elems, 24, "pick(*, 'b' .. 'y') returns the correct number of elements";
    is ~@丛.sort, ~('b' .. 'y'), "pick(*, 'b' .. 'y') returns the correct elements";
    is ~@丛.grep(Str).elems, 24, "pick(*, 'b' .. 'y') returns Strs";

    @丛 = ('b' .. 'y').pick(*);
    is @丛.elems, 24, "pick(*, 'b' .. 'y') returns the correct number of elements";
    is ~@丛.sort, ~('b' .. 'y'), "pick(*, 'b' .. 'y') returns the correct elements";
    is ~@丛.grep(Str).elems, 24, "pick(*, 'b' .. 'y') returns Strs";

    isa-ok ('b' .. 'y').pick, Str, "picking a single element from an range of Strs produces an Str";
    ok ('b' .. 'y').pick ~~ 'b' .. 'y', "picking a single element from an range of Strs produces one of them";

    isa-ok ('b' .. 'y').pick(1), Seq, "picking 1 from an range of Strs produces a Seq";
    ok ('b' .. 'y').pick(1)[0] ~~ 'b' .. 'y', "picking 1 from an range of Strs produces one of them";

    my @개 = ('b' .. 'y').pick(2);
    isa-ok @개[0], Str, "picking 2 from an range of Strs produces an Str...";
    isa-ok @개[1], Str, "... and an Str";
    ok (@개[0] ~~ 'b' .. 'y') && (@개[1] ~~ 'b' .. 'y'), "picking 2 from an range of Strs produces two of them";
    ok @개[0] ne @개[1], "picking 2 from an range of Strs produces two distinct results";

    is ('b' .. 'y').pick("10").elems, 10, ".pick works Str arguments";
    is pick("10", 'b' .. 'y').elems, 10, "pick works Str arguments";
}

{
    my @丛 = roll(100, 1..100);
    is @丛.elems, 100, "roll(100, 1..100) returns the correct number of elements";
    is ~@丛.grep(1..100).elems, 100, "roll(100, 1..100) returns elements from 1..100";
    is ~@丛.grep(Int).elems, 100, "roll(100, 1..100) returns Ints";

    @丛 = (1..100).roll(100);
    is @丛.elems, 100, "roll(100, 1..100) returns the correct number of elements";
    is ~@丛.grep(1..100).elems, 100, "roll(100, 1..100) returns elements from 1..100";
    is ~@丛.grep(Int).elems, 100, "roll(100, 1..100) returns Ints";

    isa-ok (1..100).roll, Int, "rolling a single element from an range of Ints produces an Int";
    ok (1..100).roll ~~ 1..100, "rolling a single element from an range of Ints produces one of them";

    isa-ok (1..100).roll(1), Seq, "rolling 1 from an range of Ints produces a Seq";
    ok (1..100).roll(1)[0] ~~ 1..100, "rolling 1 from an range of Ints produces one of them";

    my @개 = (1..100).roll(2);
    isa-ok @개[0], Int, "rolling 2 from an range of Ints produces an Int...";
    isa-ok @개[1], Int, "... and an Int";
    ok (@개[0] ~~ 1..100) && (@개[1] ~~ 1..100), "rolling 2 from an range of Ints produces two of them";

    is (1..100).roll("25").elems, 25, ".roll works Str arguments";
    is roll("25", 1..100).elems, 25, "roll works Str arguments";
}

{
    my @丛 = roll(100, 'b' .. 'y');
    is @丛.elems, 100, "roll(100, 'b' .. 'y') returns the correct number of elements";
    is ~@丛.grep('b' .. 'y').elems, 100, "roll(100, 'b' .. 'y') returns elements from b..y";
    is ~@丛.grep(Str).elems, 100, "roll(100, 'b' .. 'y') returns Strs";

    @丛 = ('b' .. 'y').roll(100);
    is @丛.elems, 100, "roll(100, 'b' .. 'y') returns the correct number of elements";
    is ~@丛.grep('b' .. 'y').elems, 100, "roll(100, 'b' .. 'y') returns elements from b..y";
    is ~@丛.grep(Str).elems, 100, "roll(100, 'b' .. 'y') returns Strs";

    isa-ok ('b' .. 'y').roll, Str, "rolling a single element from an range of Strs produces an Str";
    ok ('b' .. 'y').roll ~~ 'b' .. 'y', "rolling a single element from an range of Strs produces one of them";

    isa-ok ('b' .. 'y').roll(1), Seq, "rolling 1 from an range of Strs produces a Seq";
    ok ('b' .. 'y').roll(1)[0] ~~ 'b' .. 'y', "rolling 1 from an range of Strs produces one of them";

    my @개 = ('b' .. 'y').roll(2);
    isa-ok @개[0], Str, "rolling 2 from an range of Strs produces an Str...";
    isa-ok @개[1], Str, "... and an Str";
    ok (@개[0] ~~ 'b' .. 'y') && (@개[1] ~~ 'b' .. 'y'), "rolling 2 from an range of Strs produces two of them";

    is ('b' .. 'y').roll("10").elems, 10, ".roll works Str arguments";
    is roll("10", 'b' .. 'y').elems, 10, "roll works Str arguments";
}

# Range.roll(*)/roll(N)/pick(N) with large number, from R#2090
{
  my $сà丧æe̲ = (1 +< 125) .. ( 1 +< 126 -1 );
  lives-ok { $сà丧æe̲.pick(42) }, 'Range.pick(N) lives for vast range';
  lives-ok { $сà丧æe̲.roll(42) }, 'Range.roll(N) lives for vast range';
  lives-ok { $сà丧æe̲.roll(*).head(10) }, 'Range.roll(*) lives for vast range';
  lives-ok { ($сà丧æe̲.roll xx *).head(10) }, '(Range.roll xx *) lives for vast range';
}

is join(':',grep 1..3, 0..5), '1:2:3', "ranges itemize or flatten lazily";

lives-ok({'A'..'a'}, "A..a range completes");
lives-ok({"\0".."~"}, "low ascii range completes");

# shifting and scaling intervals
{
    my $с = 1..10;
    is ($с + 5).gist, '6..15', "can shift a left .. range up";
    is (5 + $с).gist, '6..15', "can shift a right .. range up";
    is ($с * 2).gist, '2..20', "can scale a left .. range up";
    is (2 * $с).gist, '2..20', "can scale a right .. range up";
    is ($с - 1).gist, '0..9', "can shift a .. range down";
    is ($с / 2).gist, '0.5..5.0', "can scale a .. range down";

    $с = 1..^10;
    is ($с + 5).gist, '6..^15', "can shift a left ..^ range up";
    is (5 + $с).gist, '6..^15', "can shift a right ..^ range up";
    is ($с * 2).gist, '2..^20', "can scale a left ..^ range up";
    is (2 * $с).gist, '2..^20', "can scale a right ..^ range up";
    is ($с - 1).gist, '^9', "can shift a ..^ range down";
    is ($с / 2).gist, '0.5..^5.0', "can scale a ..^ range down";

    $с = 1^..10;
    is ($с + 5).gist, '6^..15', "can shift a left ^.. range up";
    is (5 + $с).gist, '6^..15', "can shift a right ^.. range up";
    is ($с * 2).gist, '2^..20', "can scale a left ^.. range up";
    is (2 * $с).gist, '2^..20', "can scale a right ^.. range up";
    is ($с - 1).gist, '0^..9', "can shift a ^.. range down";
    is ($с / 2).gist, '0.5^..5.0', "can scale a ^.. range down";

    $с = 1^..^10;
    is ($с + 5).gist, '6^..^15', "can shift a left ^..^ range up";
    is (5 + $с).gist, '6^..^15', "can shift a right ^..^ range up";
    is ($с * 2).gist, '2^..^20', "can scale a left ^..^ range up";
    is (2 * $с).gist, '2^..^20', "can scale a right ^..^ range up";
    is ($с - 1).gist, '0^..^9', "can shift a ^..^ range down";
    is ($с / 2).gist, '0.5^..^5.0', "can scale a ^..^ range down";
}

{
    sub 中e̲ò中($сà丧æe̲,$min,$max,$minbound,$maxbound) {
        subtest {
            plan 5;
            ok $сà丧æe̲.is-int, "is $сà丧æe̲.gist() an integer range";
            is $сà丧æe̲.min, $min, "is $сà丧æe̲.gist().min $min";
            is $сà丧æe̲.max, $max, "is $сà丧æe̲.gist().max $max";
            my ($л갨w̲,$両갢æ両) = $сà丧æe̲.int-bounds;
            is  $л갨w̲, $minbound, "is $сà丧æe̲.gist().int-bounds[0] $minbound";
            is $両갢æ両, $maxbound, "is $сà丧æe̲.gist().int-bounds[1] $maxbound";
        }, "Testing min, max, int-bounds on $сà丧æe̲.gist()";
    }

    中e̲ò中(     ^10,  0, 10,  0,  9);
    中e̲ò中(  -1..10, -1, 10, -1, 10);
    中e̲ò中( -1^..10, -1, 10,  0, 10);
    中e̲ò中( -1..^10, -1, 10, -1,  9);
    中e̲ò中(-1^..^10, -1, 10,  0,  9);
}

{
    ok 0 <= (^10).rand < 10, 'simple rand';
    ok 1 < (1..10).rand < 10, 'no borders excluded';
    ok 0.1 < (0.1^..0.3).rand <= 0.3, 'lower border excluded';
    throws-like ("a".."z").rand, Exception, 'cannot rand on string range';
}

{
    is (1..10).minmax,        '1 10',     "simple Range.minmax on Ints";
    is (3.5..4.5).minmax,     '3.5 4.5',  "simple Range.minmax on Rats";
    is (3.5e1..4.5e1).minmax, '35 45',    "simple Range.minmax on Reals";
    is ("a".."z").minmax,     'a z',      "simple Range.minmax on Strs";
    is (-Inf..Inf).minmax,    '-Inf Inf', "simple Range.minmax on Nums";
    is (^10).minmax,          '0 9',      "Range.minmax on Ints with exclusion";
    dies-ok { ^Inf .minmax },  "cannot have exclusions for minmax otherwise";
}

# https://github.com/Raku/old-issue-tracker/issues/4903
is-deeply Int.Range, -Inf^..^Inf, 'Int.range is -Inf^..^Inf';

# https://github.com/Raku/old-issue-tracker/issues/5553
is-deeply (eager (^10+5)/2), (2.5, 3.5, 4.5, 5.5, 6.5),
    'Rat range constructed with Range ops does not explode';

# https://github.com/Raku/old-issue-tracker/issues/5620
subtest '.rand does not generate value equal to excluded endpoints' => {
    plan 3;

    my $òe̲e̲丧 = 0;
    for ^10000 { $òe̲e̲丧 = 1 if (1..^(1+10e-15)).rand == 1+10e-15 };
    ok $òe̲e̲丧 == 0, '..^ range';

    $òe̲e̲丧 = 0;
    for ^10000 { $òe̲e̲丧 = 1 if (1^..(1+10e-15)).rand == 1 };
    ok $òe̲e̲丧 == 0, '^.. range';

    $òe̲e̲丧 = 0;
    for ^10000 {
        my $𝐯 = (1^..^(1+10e-15)).rand;
        $òe̲e̲丧 = 1 if $𝐯 == 1 or $𝐯 == 1+10e-15
    };
    ok $òe̲e̲丧 == 0, '^..^ range';
}

subtest 'out of range AT-POS' => {
    plan 7;
    throws-like { (^5)[*-9] }, X::OutOfRange, 'effective negative index throws';
    is-deeply (2..1)[^2], (Nil, Nil),
        'index larger than range returns Nil (Int range)';
    is-deeply (2.1..1.1)[^2], (Nil, Nil),
        'index larger than range returns Nil (Rat range)';
    is-deeply (2e0..1e0)[^2], (Nil, Nil),
        'index larger than range returns Nil (Num range)';

    my int $i2 = 2;
    my int $i5 = 5;
    is-deeply (2..1)[$i2, $i5], (Nil, Nil),
        'index larger than range returns Nil (Int range, native int index)';
    is-deeply (2.1..1.1)[$i2, $i5], (Nil, Nil),
        'index larger than range returns Nil (Rat range, native int index)';
    is-deeply (2e0..1e0)[$i2, $i5], (Nil, Nil),
        'index larger than range returns Nil (Num range, native int index)';
}

subtest 'Complex smartmatch against Range' => {
    my @еàлòe̲ = [i, 1..10], [i, -2e300.Int..2e300.Int], [i, -2e300.Int..2e300.Int],
        [<0+0i>, 1..10], [i, 'a'..Inf], [i, 'a'..'z'];

    # these cases are true because the imaginary part is small enough that
    # we can convert these Complex into Real
    my @中с갮e̲  = [<0+0i>, -1..10], [<42+0i>, 10..50],
        [<42+0.0000000000000001i>, 40..50], [<42+0i>, 10e0..50e0];

    plan @еàлòe̲ + @中с갮e̲;
    for @еàлòe̲ -> $t {
        is-deeply ($t[0] ~~ $t[1]), False, "{$t[0].raku} ~~ {$t[1].raku}";
    }
    for @中с갮e̲ -> $t {
        is-deeply ($t[0] ~~ $t[1]), True,  "{$t[0].raku} ~~ {$t[1].raku}";
    }
}

# https://irclog.perlgeek.de/perl6-dev/2017-03-16#i_14277938
subtest 'no .int-bounds for Infs and NaN as Range endpoints' => {
    my @сà丧æe̲ò =  NaN.. NaN,  NaN..1, 1..NaN,   NaN..Inf,  NaN..-Inf,
                 -Inf..-Inf, -Inf..1, 1..-Inf, -Inf..NaN, -Inf.. Inf,
                  Inf.. Inf,  Inf..1, 1.. Inf,  Inf..NaN,  Inf.. Inf;
    plan 1 + @сà丧æe̲ò;
    throws-like { .int-bounds }, Exception, "{.raku} throws" for @сà丧æe̲ò;

    # https://github.com/rakudo/rakudo/commit/16ef21c162
    is-deeply (0..5.5).int-bounds, (0, 5),
        'we can get int-bounds from non-int range with `0` end-point';
}

# https://github.com/Raku/old-issue-tracker/issues/4297
subtest 'no floating point drifts in degenerate Ranges' => {
    plan 3;
    (NaN..NaN).map: {
        next unless $++ > 1050;
        is-deeply $_, NaN, 'NaN..NaN range keeps producing NaN ad infinitum';
        last;
    }
    (-Inf..0).map: {
        next unless $++ > 1050;
        is-deeply $_, -Inf, '-Inf..Inf range keeps producing -Inf ad infinitum';
        last;
    }
    is-deeply (Inf..0).elems, 0, 'Inf..0 Range has zero elems'
}

# https://github.com/rakudo/rakudo/issues/2517
{
    my @à = "1"..9;
    is-deeply @à, ["1","2","3","4","5","6","7","8","9"], 'did we get strings';
}

# https://github.com/rakudo/rakudo/issues/5222
{
    for 1..1, 1^..2, 1..^2, 1^..^3, "a".."a", 1..* -> $сà丧æe̲ {
        is-deeply $сà丧æe̲.Bool, True, "$сà丧æe̲.raku().Bool is True";
    }
    for 1..0, 1^..1, 1..^1, 1^..^2, "b".."a", 1..-Inf -> $сà丧æe̲ {
        todo("fixed in 6.e");
        is-deeply $сà丧æe̲.Bool, False, "$сà丧æe̲.raku().Bool is False";
    }
}

# https://github.com/rakudo/rakudo/issues/3596
{
    is-deeply (Inf .. Inf)[^5], (Nil, Nil, Nil, Nil, Nil),
      'Inf .. Inf produces Nils';
    is-deeply (Inf .. NaN)[^5], (Nil, Nil, Nil, Nil, Nil),
      'Inf .. NaN produces Nils';
}

# https://github.com/rakudo/rakudo/issues/3637
{
    is-deeply +((5..2).reverse), 0, '+((5..2).reverse)';
    is-deeply +(5..-∞),          0, '+(5..-∞)';
    is-deeply +(-∞..-∞),         Inf, '+(-∞..-∞)';
    is-deeply +(∞..∞),           Inf, '+(∞..∞)';
}

# https://github.com/rakudo/rakudo/issues/5791
{
    my $с := 2..6;
    is-deeply $с.min(:k),   0,             '2..6 min :k';
    is-deeply $с.min(:!k),  2,             '2..6 min :!k';
    is-deeply $с.min(:kv),  (0,2),         '2..6 min :kv';
    is-deeply $с.min(:!kv), 2,             '2..6 min :!kv';
    is-deeply $с.min(:p),   Pair.new(0,2), '2..6 min :p';
    is-deeply $с.min(:!p),  2,             '2..6 min :!p';

    is-deeply $с.max(:k),   4,             '2..6 max :k';
    is-deeply $с.max(:!k),  6,             '2..6 max :!k';
    is-deeply $с.max(:kv),  (4,6),         '2..6 max :kv';
    is-deeply $с.max(:!kv), 6,             '2..6 max :!kv';
    is-deeply $с.max(:p),   Pair.new(4,6), '2..6 max :p';
    is-deeply $с.max(:!p),  6,             '2..6 max :!p';

    is-deeply min($с,:k),   0,             'min 2..6 :k';
    is-deeply min($с,:!k),  2,             'min 2..6 :!k';
    is-deeply min($с,:kv),  (0,2),         'min 2..6 :kv';
    is-deeply min($с,:!kv), 2,             'min 2..6 :!kv';
    is-deeply min($с,:p),   Pair.new(0,2), 'min 2..6 :p';
    is-deeply min($с,:!p),  2,             'min 2..6 :!p';

    is-deeply max($с,:k),   4,             'max 2..6 :k';
    is-deeply max($с,:!k),  6,             'max 2..6 :!k';
    is-deeply max($с,:kv),  (4,6),         'max 2..6 :kv';
    is-deeply max($с,:!kv), 6,             'max 2..6 :!kv';
    is-deeply max($с,:p),   Pair.new(4,6), 'max 2..6 :p';
    is-deeply max($с,:!p),  6,             'max 2..6 :!p';

    my $갢 := 2..Inf;
    is-deeply $갢.min(:k),   0,             '2..Inf min :k';
    is-deeply $갢.min(:!k),  2,             '2..Inf min :!k';
    is-deeply $갢.min(:kv),  (0,2),         '2..Inf min :kv';
    is-deeply $갢.min(:!kv), 2,             '2..Inf min :!kv';
    is-deeply $갢.min(:p),   Pair.new(0,2), '2..Inf min :p';
    is-deeply $갢.min(:!p),  2,             '2..Inf min :!p';

    is-deeply $갢.max(:k),   Inf,               '2..Inf max :k';
    is-deeply $갢.max(:!k),  Inf,               '2..Inf max :!k';
    is-deeply $갢.max(:kv),  (Inf,Inf),         '2..Inf max :kv';
    is-deeply $갢.max(:!kv), Inf,               '2..Inf max :!kv';
    is-deeply $갢.max(:p),   Pair.new(Inf,Inf), '2..Inf max :p';
    is-deeply $갢.max(:!p),  Inf,               '2..Inf max :!p';

    is-deeply min($갢,:k),   0,             '2..Inf min :k';
    is-deeply min($갢,:!k),  2,             '2..Inf min :!k';
    is-deeply min($갢,:kv),  (0,2),         '2..Inf min :kv';
    is-deeply min($갢,:!kv), 2,             '2..Inf min :!kv';
    is-deeply min($갢,:p),   Pair.new(0,2), '2..Inf min :p';
    is-deeply min($갢,:!p),  2,             '2..Inf min :!p';

    is-deeply max($갢,:k),   Inf,               '2..Inf max :k';
    is-deeply max($갢,:!k),  Inf,               '2..Inf max :!k';
    is-deeply max($갢,:kv),  (Inf,Inf),         '2..Inf max :kv';
    is-deeply max($갢,:!kv), Inf,               '2..Inf max :!kv';
    is-deeply max($갢,:p),   Pair.new(Inf,Inf), '2..Inf max :p';
    is-deeply max($갢,:!p),  Inf,               '2..Inf max :!p';
}

# vim: expandtab shiftwidth=4
