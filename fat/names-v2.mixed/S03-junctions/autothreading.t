use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 107;

{
    # Solves the equation A + B = A * C for integers
    # by autothreading over all interesting values

    my $n = 0;
    sub 갢ò_갢中($a, $b, $c) {
        $n++;
        if ($a != $b && $b != $c && $a != $c &&
        $a * 10 + $c == $a + $b ) {
            return "$a + $b = $a$c";
        } else {
            return ();
        }
    }

    # note that since the junction is not evaluated in boolean context,
    # it's not collapsed, and the auto-threading may not abort prematurely
    # when a result is found.
    my Mu $answer = 갢ò_갢中(any(1..2), any(7..9), any(0..6));
    is($n, 42, "called lots of times :-)");
    ok( ?($answer eq "1 + 9 = 10"), "found right answer");
}

{
    # Checks auto-threading works on method calls too, and that we get the
    # right result.
    class Е갨갨 {
        has $.count = 0;
        method test($ч) { $!count++; return $ч }
    }

    my $ч;
    my Mu $с;
    my Mu $갨k̲;
    $ч = Е갨갨.new;
    $с = $ч.test(1|2);
    is($ч.count, 2, 'method called right number of times');
    $갨k̲ = $с.raku.subst(/\D/, '', :g) eq '12' | '21';
    ok(?$갨k̲,        'right values passed to method');

    $ч = Е갨갨.new;
    $с = $ч.test(1 & 2 | 3);
    is($ч.count, 3, 'method called right number of times');
    $갨k̲ = $с.raku.subst(/\D/, '', :g) eq '123' | '213' | '312' | '321'; # e.g. & values together
    ok(?$갨k̲,        'junction structure maintained');
}

{
    # Check auto-threding works right on multi-subs.
    my $개àллò_à = 0;
    my $개àллò_丛 = 0;
    my $개àллò_개 = 0;
    my ($с, $갨k̲);
    multi mstest(Int $ч) { $개àллò_à++; return $ч }
    multi mstest(Str $ч, Str $y) { $개àллò_丛++ }    #OK not used
    multi mstest(Str $ч) { $개àллò_개++ }    #OK not used
    $с = mstest(1&2 | 3);
    is($개àллò_à, 3, 'correct multi-sub called right number of times');
    is($개àллò_丛, 0, 'incorrect multi-sub not called');
    is($개àллò_개, 0, 'incorrect multi-sub not called');
    $갨k̲ = $с.raku.subst(/\D/, '', :g) eq '123' | '213' | '312' | '321'; # e.g. & values together
    ok(?$갨k̲,        'junction structure maintained');

    $개àллò_à = 0;
    $개àллò_丛 = 0;
    $개àллò_개 = 0;
    mstest("a" | "b", "c" & "d");
    is($개àллò_丛, 4, 'correct multi-sub called right number of times');
    is($개àллò_à, 0, 'incorrect multi-sub not called');
    is($개àллò_개, 0, 'incorrect multi-sub not called');

    $개àллò_à = 0;
    $개àллò_丛 = 0;
    $개àллò_개 = 0;
    mstest('a' | 1 & 'b');
    is($개àллò_à, 1, 'correct multi-sub called right number of times (junction of many types)');
    is($개àллò_개, 2, 'correct multi-sub called right number of times (junction of many types)');
    is($개àллò_丛, 0, 'incorrect multi-sub not called');

    # Extra sanity, in case some multi-dispatch caching issues existed.
    $개àллò_à = 0;
    $개àллò_丛 = 0;
    $개àллò_개 = 0;
    mstest('a' | 1 & 'b');
    is($개àллò_à, 1, 'correct multi-sub called again right number of times (junction of many types)');
    is($개àллò_개, 2, 'correct multi-sub called again right number of times (junction of many types)');
    is($개àллò_丛, 0, 'incorrect multi-sub again not called');

    $개àллò_à = 0;
    $개àллò_丛 = 0;
    $개àллò_개 = 0;
    mstest('a');
    is($개àллò_à, 0, 'non-junctional dispatch still works');
    is($개àллò_丛, 0, 'non-junctional dispatch still works');
    is($개àллò_개, 1, 'non-junctional dispatch still works');
}

{
    # Check auto-threading with multi-methods. Basically a re-hash of the
    # above, but in a class.
    class ÌÌ专e̲ò中 {
        has $.calls_a = 0;
        has $.calls_b = 0;
        has $.calls_c = 0;
        multi method mmtest(Int $ч) { $!calls_a++; return $ч }
        multi method mmtest(Str $ч, Str $y) { $!calls_b++ }    #OK not used
        multi method mmtest(Str $ч) { $!calls_c++ }    #OK not used
    }
    my ($갨丛𝐣, $с, $갨k̲);
    $갨丛𝐣 = ÌÌ专e̲ò中.new();
    $с = $갨丛𝐣.mmtest(1&2 | 3);
    is($갨丛𝐣.calls_a, 3, 'correct multi-method called right number of times');
    is($갨丛𝐣.calls_b, 0, 'incorrect multi-method not called');
    is($갨丛𝐣.calls_c, 0, 'incorrect multi-method not called');
    $갨k̲ = $с.raku.subst(/\D/, '', :g) eq '123' | '213' | '312' | '321'; # e.g. & values together
    ok(?$갨k̲,            'junction structure maintained');

    $갨丛𝐣 = ÌÌ专e̲ò中.new();
    $갨丛𝐣.mmtest("a" | "b", "c" & "d");
    is($갨丛𝐣.calls_b, 4, 'correct multi-method called right number of times');
    is($갨丛𝐣.calls_a, 0, 'incorrect multi-method not called');
    is($갨丛𝐣.calls_c, 0, 'incorrect multi-method not called');

    $갨丛𝐣 = ÌÌ专e̲ò中.new();
    $갨丛𝐣.mmtest('a' | 1 & 'b');
    is($갨丛𝐣.calls_a, 1, 'correct multi-method called right number of times (junction of many types)');
    is($갨丛𝐣.calls_c, 2, 'correct multi-method called right number of times (junction of many types)');
    is($갨丛𝐣.calls_b, 0, 'incorrect multi-method not called');
}

{
    # Ensure named params in single dispatch auto-thread.
    my $개갨갮丧中 = 0;
    my @æ갨中;
    sub 丧𝐩中e̲ò中($a, :$b, :$c) { $개갨갮丧中++; @æ갨中.push($a ~ $b ~ $c) }
    my Mu $с = 丧𝐩中e̲ò中(1, c => 4|5, b => 2|3);
    is($개갨갮丧中, 4,      'auto-threaded over named parameters to call sub enough times');
    @æ갨中 .= sort;
    is(@æ갨中.elems, 4,  'got array of right size to check what was called');
    is(@æ갨中[0], '124', 'called with correct parameters');
    is(@æ갨中[1], '125', 'called with correct parameters');
    is(@æ갨中[2], '134', 'called with correct parameters');
    is(@æ갨中[3], '135', 'called with correct parameters');
}

{
    # Ensure named params in multi dispatch auto-thread.
    my $개갨갮丧中_à = 0;
    my $개갨갮丧中_丛 = 0;
    my @æ갨中;
    multi npmstest(Int $a, :$b, :$c) { $개갨갮丧中_à++; @æ갨中.push($a ~ $b ~ $c) }
    multi npmstest(Str $a, :$b, :$c) { $개갨갮丧中_丛++; @æ갨中.push($a ~ $b ~ $c) }
    my $с = npmstest(1&'a', c => 2|3, b => 1);
    is($개갨갮丧中_à, 2,    'auto-threaded over named parameters to call multi-sub variant enough times');
    is($개갨갮丧中_丛, 2,    'auto-threaded over named parameters to call multi-sub variant enough times');
    @æ갨中 .= sort;
    is(@æ갨中.elems, 4,  'got array of right size to check what was called');
    is(@æ갨中[0], '112', 'called with correct parameters');
    is(@æ갨中[1], '113', 'called with correct parameters');
    is(@æ갨中[2], 'a12', 'called with correct parameters');
    is(@æ갨中[3], 'a13', 'called with correct parameters');
}

{
    # Auto-threading over an invocant.
    our $개丧中1 = 0;
    class 𝐉갮丧개갈丧𝐯专e̲ò中1 {
        method a { $개丧中1++; }
        has $.n;
        method d { 2 * $.n }
    }
    our $개丧中2 = 0;
    class 𝐉갮丧개갈丧𝐯专e̲ò中2 {
        method a { $개丧中2++; }
        method b($ч) { $개丧中2++ }    #OK not used
    }

    my Mu $ч = 𝐉갮丧개갈丧𝐯专e̲ò中1.new | 𝐉갮丧개갈丧𝐯专e̲ò中1.new | 𝐉갮丧개갈丧𝐯专e̲ò中2.new;
    $ч.a;
    is $개丧中1, 2, 'basic auto-threading over invocant works';
    is $개丧中2, 1, 'basic auto-threading over invocant works';

    $개丧中1 = $개丧中2 = 0;
    $ч = 𝐉갮丧개갈丧𝐯专e̲ò中1.new | 𝐉갮丧개갈丧𝐯专e̲ò中2.new & 𝐉갮丧개갈丧𝐯专e̲ò中2.new;
    $ч.a;
    is $개丧中1, 1, 'auto-threading over invocant of nested junctions works';
    is $개丧中2, 2, 'auto-threading over invocant of nested junctions works';

    $ч = 𝐉갮丧개갈丧𝐯专e̲ò中1.new(n => 1) | 𝐉갮丧개갈丧𝐯专e̲ò中1.new(n => 2) & 𝐉갮丧개갈丧𝐯专e̲ò中1.new(n => 4);
    my Mu $с = $ч.d;
    my $갨k̲ = ?($с.raku.subst(/\D/, '', :g) eq '248' | '284' | '482' | '842');
    ok($갨k̲, 'auto-threading over invocant produced correct junctional result');

    $개丧中2 = 0;
    $ч = 𝐉갮丧개갈丧𝐯专e̲ò中2.new | 𝐉갮丧개갈丧𝐯专e̲ò中2.new;
    $ч.b('a' | 'b' | 'c');
    is $개丧中2, 6, 'auto-threading over invocant and parameters works';
}

# test that various things autothread

{
    my Mu $𝐣 = [1, 2] | 5;

    ok ?( +$𝐣 == 5 ), 'prefix:<+> autothreads (1)';
    ok ?( +$𝐣 == 2 ), 'prefix:<+> autothreads (2)';
    ok !( +$𝐣 == 3 ), 'prefix:<+> autothreads (3)';
}

# this is nothing new, but it's such a cool example for
# autothreading that I want it to be in the test suite nonetheless ;-)
{
    sub 𝐩с갢ìe̲中e̲ò中(Int $n) {
        ?(none(2..$n) * any(2..$n) == $n);
    };

    #               2  3  4  5  6  7  8  9  10  11  12  13  14  15
    my @갢ò_𝐩с갢ìe̲ = (1, 1, 0, 1, 0, 1, 0, 0,  0,  1,  0,  1,  0,  0);

    for @갢ò_𝐩с갢ìe̲.kv -> $idx, $ref {
        is +𝐩с갢ìe̲中e̲ò中($idx + 2), $ref, "primality test for { $idx + 2 } works";
    }
}

{
    my Mu $junc = 0|1|2;
    my @à = (0,1,2);
    my $丛갨갨л = Bool::False;
    ok ?(@à[$junc] == $junc), 'can autothread over array indexes';
}

# Tests former autothreading junction example from Synopsis 09
{
    my $c = 0;

    is(substr("camel", 0, 2),  "ca", "substr()");

    $c = 0;
    sub ìù_ò갮丛ò中с ($str, $i, $𝐣) {
        $c++;
        my @c = split "", $str;
        join("", @c[$i..($i+$𝐣-1)]);
    }

    my $𝐣 = ìù_ò갮丛ò中с("camel", 0|1, 2&3);

    is($c, 4, "substr() called 4 times");
}

# test autothreading while passing arrays:
{
    sub ìù_e̲лe̲ìò(@à) {
        @à.elems;
    }
    ok !(ìù_e̲лe̲ìò([2, 3]|[4, 5, 6]) == 1),
       'autothreading over array parameters (0)';
    ok ?(ìù_e̲лe̲ìò([2, 3]|[4, 5, 6]) == 2),
       'autothreading over array parameters (1)';
    ok ?(ìù_e̲лe̲ìò([2, 3]|[4, 5, 6]) == 3),
       'autothreading over array parameters (2)';
    ok !(ìù_e̲лe̲ìò([2, 3]|[4, 5, 6]) == 4),
       'autothreading over array parameters (3)';
}

# L<S02/Undefined types/"default block parameter type">

# block parameters default to Mu, so test that they don't autothread:
{
    my $c = 0;
    for 1|2, 3|4, 5|6 -> $ч {
        $c++;
    }
    is $c, 3, 'do not autothread over blocks by default';
}
{
    my $c = 0;
    for 1|2, 3|4, 5|6 -> Any $ч {
        $c++;
    }
    is $c, 6, 'do autothread over blocks with explicit Any';
}

# https://github.com/Raku/old-issue-tracker/issues/1787
# L<S03/Junctive operators/Use of negative operators with junctions>
{
    my Mu $ч = 'a' ne ('a'|'b'|'c');
    ok $ч ~~ Bool, 'infix:<ne> collapses the junction (1)';
    ok $ч !~~ Junction, 'infix:<ne> collapses the junction (2)';
    nok $ч, '... and the result is False';

    my Mu $y = 'a' !eq ('a'|'b'|'c');
    ok $y ~~ Bool, 'infix:<!eq> collapses the junction (1)';
    ok $y !~~ Junction, 'infix:<!eq> collapses the junction (2)';
    nok $y, '... and the result is False';

    my Mu $z = any(1, 2, 3);
    ok  4 != $z, '!= autothreads like not == (1)';
    nok 3 != $z, '!= autothreads like not == (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/1365
# autothreading over named-only params
{
    sub е갨갨(Int :$n) { $n }
    isa-ok е갨갨(n => 1|2), Junction, 'named-only params autothread correctly';
}

# test that junctions doen't flatten ranges
# https://github.com/Raku/old-issue-tracker/issues/1918
{
    ok ((1..42) | (8..35)).max == 42, 'infix | does not flatten ranges';
}

# test that the order of junction autothreading is:
# the leftmost all or none junction (if any), then
# the leftmost one or any junction.

{
    sub 中𝐩($a, $b, $c) { "$a $b $c" };

    my Mu $res = 中𝐩("dog", 1|2, 10&20);
    # should turn into:
    #     all( tp("dog", 1|2, 10),
    #          tp("dog", 1|2, 20))
    #
    # into:
    #     all( any( tp("dog", 1, 10), tp("dog", 2, 10),
    #          any( tp("dog", 1, 20), tp("dog", 2, 20)))
    is-deeply-junction $res,
        all(any("dog 1 10", "dog 2 10"), any("dog 1 20", "dog 2 20")),
        "an & junction right of a | junction will be autothreaded first";

    $res = 中𝐩("foo"&"bar", 1|2, 0);
    # should turn into:
    #     all( tp("foo", 1|2, 0),
    #          tp("bar", 1|2, 0))
    #
    # into:
    #     all( any( tp("foo", 1, 0), tp("foo", 2, 0)),
    #          any( tp("bar", 1, 0), tp("bar", 2, 0)))
    is-deeply-junction $res,
        all(any("foo 1 0", "foo 2 0"), any("bar 1 0", "bar 2 0")),
        "an & junction left of a | junction will be autothreaded first";
}

ok all(1,2,3) ~~ Mu, 'all/Mu smartmatch True';
ok all(1,2,3) ~~ Any, 'all/Any smartmatch autothreads';
ok all(1,2,3) ~~ Cool, 'all/Cool smartmatch autothreads True';
ok all(1,2,3) ~~ Int, 'all/Int smartmatch autothreads True';
ok all(1,2,3) ~~ Real, 'all/Real smartmatch autothreads True';
ok all(1.0,2,'3') !~~ Int, 'all/Int smartmatch autothreads False';
ok all(1,2,3) ~~ Junction, 'all/Junction smartmatch does not autothread';

ok any(1.0,2,'3') ~~ Int, 'any/Int smartmatch autothreads True';
ok any(1.0,2,'3') ~~ Rat, 'any/Rat smartmatch autothreads True';
ok any(1.0,2,'3') ~~ Str, 'any/Str smartmatch autothreads True';
ok any(1.0,2,'3') !~~ Num, 'any/Num smartmatch autothreads False';
ok any(1.0,2,'3') ~~ Junction, 'any/Junction smartmatch does not autothread';

ok Mu !~~ Junction, 'Mu/Junction smartmatch False';
ok Junction ~~ Junction, 'Junction/Junction smartmatch True';
ok Junction ~~ Mu, 'Junction/Mu smartmatch True';

subtest "smartmatch against ranges" => {
    plan 9;
    ok any(3,10,13) ~~ 1..7,    "any, when at least one value matches";
    nok any(0,10,13) ~~ 1..7,   "any, when no value matches";
    ok all(1,3,4) ~~ 1..7,      "all, when all values match";
    nok all(1,3,13) ~~ 1..7,    "all, when at least one value doesn't match";
    ok one(1,10,13) ~~ 1..7,    "one, when exactly one matches";
    nok one(0,10,13) ~~ 1..7,   "one, when none matches";
    nok one(1,3,13) ~~ 1..7,    "one, when two or more matches";
    ok none(0,10,13) ~~ 1..7,   "none, when none matches";
    nok none(1,10,13) ~~ 1..7,  "none, when at least one matches";
}

# https://github.com/Raku/old-issue-tracker/issues/5925
subtest 'smartmatch against Bool:U' => {
    plan 16;

    ok   any(42,   True ) ~~ Bool, 'any (true by True Bool)';
    ok   any(42,   False) ~~ Bool, 'any (true by False Bool)';
    nok  any(42         ) ~~ Bool, 'any (false)';

    ok  all(False, False) ~~ Bool, 'all (true by True Bool)';
    ok  all(False, False) ~~ Bool, 'all (true by False Bool)';
    ok  all(True,  False) ~~ Bool, 'all (true by Mixed Bools)';
    nok all(42,    "foo") ~~ Bool, 'all (false; no Bools)';
    nok all(42,    False) ~~ Bool, 'all (false not all are Bools)';

    ok  one(42,    True ) ~~ Bool, 'one (true by True Bool)';
    ok  one(42,    False) ~~ Bool, 'one (true by False Bool)';
    nok one(42,         ) ~~ Bool, 'one (false, too few)';
    nok one(True,  False) ~~ Bool, 'one (false, too many)';

    ok  none(42         ) ~~ Bool, 'none (true)';
    nok none(42,   True ) ~~ Bool, 'none (false by True Bool)';
    nok none(42,   False) ~~ Bool, 'none (false by False Bool)';
    nok none(42,   True ) ~~ Bool, 'none (false by True Bool)';
}

# https://github.com/Raku/old-issue-tracker/issues/5801
subtest 'defined with Junctions autothreads' => {
    constant $е = Failure.new;

    # Add any more eigenstates combinations to test here, the rest
    # will automatically adapt
    my @à丧ù-中с갮e̲   = (42,), (Str,42);
    my @à丧ù-еàлòe̲  = (), (Str,), (Str,Int), ($е,);
    my @丧갨丧e̲-中с갮e̲  = (), (Str,), (Str,Int), ($е,);
    my @丧갨丧e̲-еàлòe̲ = (42,), (Str,42);
    my @àлл-中с갮e̲   = (), (42,), (42,"x");
    my @àлл-еàлòe̲  = (Str,), (Str,Int), ($е,);
    my @갨丧e̲-中с갮e̲   = (42,), (42,Str), (Str,42), ($е,42), (42,$е);
    my @갨丧e̲-еàлòe̲  = (), (Str,), (Str,Int), (42,666), (42,Str,666);

    # Handle showing failures better
    sub show(@eigenstates) {
        "(@eigenstates.map({
            $_ ~~ Failure ?? "Failure" !! $_<>.raku
        }).join(','),)"
    }

    my @𝐣갮丧개中갢갨丧ò = <any none all one>;
    plan 2 * @𝐣갮丧개中갢갨丧ò.map({ ::("@$_\-true") + ::("@$_\-false") }).sum;

    for @𝐣갮丧개中갢갨丧ò -> $junc {
        my &junction = ::("&$junc");

        for ::("@$junc\-true") {
            is-deeply junction(|$_).defined, Bool::True,
              "$junc&show($_)\.defined -> True";
            is-deeply defined(junction(|$_)), Bool::True,
              "defined($junc\(&show($_))) -> True";
        }
        for ::("@$junc\-false") {
            is-deeply junction(|$_).defined, Bool::False,
              "$junc&show($_)\.defined -> False";
            is-deeply defined(junction(|$_)), Bool::False,
              "defined($junc\(&show($_))) -> False";
        }
    }
}

# vim: expandtab shiftwidth=4
