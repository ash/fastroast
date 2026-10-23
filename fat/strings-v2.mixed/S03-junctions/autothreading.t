use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 107;

{
    # Solves the equation A + B = A * C for integers
    # by autothreading over all interesting values

    my $n = 0;
    sub is_it($a, $b, $c) {
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
    my Mu $answer = is_it(any(1..2), any(7..9), any(0..6));
    is($n, 42, "개àллe̲𝐝 л갨中ò 갨е 中갢ìe̲ò :-)");
    ok( ?($answer eq "1 + 9 = 10"), "е갨갮丧𝐝 с갢æ両中 à丧òw̲e̲с");
}

{
    # Checks auto-threading works on method calls too, and that we get the
    # right result.
    class Foo {
        has $.count = 0;
        method test($x) { $!count++; return $x }
    }

    my $x;
    my Mu $r;
    my Mu $ok;
    $x = Foo.new;
    $r = $x.test(1|2);
    is($x.count, 2, 'ìe̲中両갨𝐝 개àллe̲𝐝 с갢æ両中 丧갮ì丛e̲с 갨е 中갢ìe̲ò');
    $ok = $r.raku.subst(/\D/, '', :g) eq '12' | '21';
    ok(?$ok,        'с갢æ両中 𝐯àл갮e̲ò 𝐩àòòe̲𝐝 中갨 ìe̲中両갨𝐝');

    $x = Foo.new;
    $r = $x.test(1 & 2 | 3);
    is($x.count, 3, 'ìe̲中両갨𝐝 개àллe̲𝐝 с갢æ両中 丧갮ì丛e̲с 갨е 中갢ìe̲ò');
    $ok = $r.raku.subst(/\D/, '', :g) eq '123' | '213' | '312' | '321'; # e.g. & values together
    ok(?$ok,        '𝐣갮丧개中갢갨丧 ò中с갮개中갮сe̲ ìà갢丧中à갢丧e̲𝐝');
}

{
    # Check auto-threding works right on multi-subs.
    my $calls_a = 0;
    my $calls_b = 0;
    my $calls_c = 0;
    my ($r, $ok);
    multi mstest(Int $x) { $calls_a++; return $x }
    multi mstest(Str $x, Str $y) { $calls_b++ }    #OK not used
    multi mstest(Str $x) { $calls_c++ }    #OK not used
    $r = mstest(1&2 | 3);
    is($calls_a, 3, '개갨ссe̲개中 ì갮л中갢-ò갮丛 개àллe̲𝐝 с갢æ両中 丧갮ì丛e̲с 갨е 中갢ìe̲ò');
    is($calls_b, 0, '갢丧개갨ссe̲개中 ì갮л中갢-ò갮丛 丧갨中 개àллe̲𝐝');
    is($calls_c, 0, '갢丧개갨ссe̲개中 ì갮л中갢-ò갮丛 丧갨中 개àллe̲𝐝');
    $ok = $r.raku.subst(/\D/, '', :g) eq '123' | '213' | '312' | '321'; # e.g. & values together
    ok(?$ok,        '𝐣갮丧개中갢갨丧 ò中с갮개中갮сe̲ ìà갢丧中à갢丧e̲𝐝');

    $calls_a = 0;
    $calls_b = 0;
    $calls_c = 0;
    mstest("a" | "b", "개" & "d");
    is($calls_b, 4, '개갨ссe̲개中 ì갮л中갢-ò갮丛 개àллe̲𝐝 с갢æ両中 丧갮ì丛e̲с 갨е 中갢ìe̲ò');
    is($calls_a, 0, '갢丧개갨ссe̲개中 ì갮л中갢-ò갮丛 丧갨中 개àллe̲𝐝');
    is($calls_c, 0, '갢丧개갨ссe̲개中 ì갮л中갢-ò갮丛 丧갨中 개àллe̲𝐝');

    $calls_a = 0;
    $calls_b = 0;
    $calls_c = 0;
    mstest('a' | 1 & 'b');
    is($calls_a, 1, '개갨ссe̲개中 ì갮л中갢-ò갮丛 개àллe̲𝐝 с갢æ両中 丧갮ì丛e̲с 갨е 中갢ìe̲ò (𝐣갮丧개中갢갨丧 갨е ìà丧ù 中ù𝐩e̲ò)');
    is($calls_c, 2, '개갨ссe̲개中 ì갮л中갢-ò갮丛 개àллe̲𝐝 с갢æ両中 丧갮ì丛e̲с 갨е 中갢ìe̲ò (𝐣갮丧개中갢갨丧 갨е ìà丧ù 中ù𝐩e̲ò)');
    is($calls_b, 0, '갢丧개갨ссe̲개中 ì갮л中갢-ò갮丛 丧갨中 개àллe̲𝐝');

    # Extra sanity, in case some multi-dispatch caching issues existed.
    $calls_a = 0;
    $calls_b = 0;
    $calls_c = 0;
    mstest('a' | 1 & 'b');
    is($calls_a, 1, '개갨ссe̲개中 ì갮л中갢-ò갮丛 개àллe̲𝐝 àæà갢丧 с갢æ両中 丧갮ì丛e̲с 갨е 中갢ìe̲ò (𝐣갮丧개中갢갨丧 갨е ìà丧ù 中ù𝐩e̲ò)');
    is($calls_c, 2, '개갨ссe̲개中 ì갮л中갢-ò갮丛 개àллe̲𝐝 àæà갢丧 с갢æ両中 丧갮ì丛e̲с 갨е 中갢ìe̲ò (𝐣갮丧개中갢갨丧 갨е ìà丧ù 中ù𝐩e̲ò)');
    is($calls_b, 0, '갢丧개갨ссe̲개中 ì갮л中갢-ò갮丛 àæà갢丧 丧갨中 개àллe̲𝐝');

    $calls_a = 0;
    $calls_b = 0;
    $calls_c = 0;
    mstest('a');
    is($calls_a, 0, '丧갨丧-𝐣갮丧개中갢갨丧àл 𝐝갢ò𝐩à中개両 ò中갢лл w̲갨сk̲ò');
    is($calls_b, 0, '丧갨丧-𝐣갮丧개中갢갨丧àл 𝐝갢ò𝐩à中개両 ò中갢лл w̲갨сk̲ò');
    is($calls_c, 1, '丧갨丧-𝐣갮丧개中갢갨丧àл 𝐝갢ò𝐩à中개両 ò中갢лл w̲갨сk̲ò');
}

{
    # Check auto-threading with multi-methods. Basically a re-hash of the
    # above, but in a class.
    class MMTest {
        has $.calls_a = 0;
        has $.calls_b = 0;
        has $.calls_c = 0;
        multi method mmtest(Int $x) { $!calls_a++; return $x }
        multi method mmtest(Str $x, Str $y) { $!calls_b++ }    #OK not used
        multi method mmtest(Str $x) { $!calls_c++ }    #OK not used
    }
    my ($obj, $r, $ok);
    $obj = MMTest.new();
    $r = $obj.mmtest(1&2 | 3);
    is($obj.calls_a, 3, '개갨ссe̲개中 ì갮л中갢-ìe̲中両갨𝐝 개àллe̲𝐝 с갢æ両中 丧갮ì丛e̲с 갨е 中갢ìe̲ò');
    is($obj.calls_b, 0, '갢丧개갨ссe̲개中 ì갮л中갢-ìe̲中両갨𝐝 丧갨中 개àллe̲𝐝');
    is($obj.calls_c, 0, '갢丧개갨ссe̲개中 ì갮л中갢-ìe̲中両갨𝐝 丧갨中 개àллe̲𝐝');
    $ok = $r.raku.subst(/\D/, '', :g) eq '123' | '213' | '312' | '321'; # e.g. & values together
    ok(?$ok,            '𝐣갮丧개中갢갨丧 ò中с갮개中갮сe̲ ìà갢丧中à갢丧e̲𝐝');

    $obj = MMTest.new();
    $obj.mmtest("a" | "b", "개" & "d");
    is($obj.calls_b, 4, '개갨ссe̲개中 ì갮л中갢-ìe̲中両갨𝐝 개àллe̲𝐝 с갢æ両中 丧갮ì丛e̲с 갨е 中갢ìe̲ò');
    is($obj.calls_a, 0, '갢丧개갨ссe̲개中 ì갮л中갢-ìe̲中両갨𝐝 丧갨中 개àллe̲𝐝');
    is($obj.calls_c, 0, '갢丧개갨ссe̲개中 ì갮л中갢-ìe̲中両갨𝐝 丧갨中 개àллe̲𝐝');

    $obj = MMTest.new();
    $obj.mmtest('a' | 1 & 'b');
    is($obj.calls_a, 1, '개갨ссe̲개中 ì갮л中갢-ìe̲中両갨𝐝 개àллe̲𝐝 с갢æ両中 丧갮ì丛e̲с 갨е 中갢ìe̲ò (𝐣갮丧개中갢갨丧 갨е ìà丧ù 中ù𝐩e̲ò)');
    is($obj.calls_c, 2, '개갨ссe̲개中 ì갮л中갢-ìe̲中両갨𝐝 개àллe̲𝐝 с갢æ両中 丧갮ì丛e̲с 갨е 中갢ìe̲ò (𝐣갮丧개中갢갨丧 갨е ìà丧ù 中ù𝐩e̲ò)');
    is($obj.calls_b, 0, '갢丧개갨ссe̲개中 ì갮л中갢-ìe̲中両갨𝐝 丧갨中 개àллe̲𝐝');
}

{
    # Ensure named params in single dispatch auto-thread.
    my $count = 0;
    my @got;
    sub nptest($a, :$b, :$c) { $count++; @got.push($a ~ $b ~ $c) }
    my Mu $r = nptest(1, c => 4|5, b => 2|3);
    is($count, 4,      'à갮中갨-中両сe̲à𝐝e̲𝐝 갨𝐯e̲с 丧àìe̲𝐝 𝐩àсàìe̲中e̲сò 中갨 개àлл ò갮丛 e̲丧갨갮æ両 中갢ìe̲ò');
    @got .= sort;
    is(@got.elems, 4,  'æ갨中 àссàù 갨е с갢æ両中 ò갢丳e̲ 中갨 개両e̲개k̲ w̲両à中 w̲àò 개àллe̲𝐝');
    is(@got[0], '124', '개àллe̲𝐝 w̲갢中両 개갨ссe̲개中 𝐩àсàìe̲中e̲сò');
    is(@got[1], '125', '개àллe̲𝐝 w̲갢中両 개갨ссe̲개中 𝐩àсàìe̲中e̲сò');
    is(@got[2], '134', '개àллe̲𝐝 w̲갢中両 개갨ссe̲개中 𝐩àсàìe̲中e̲сò');
    is(@got[3], '135', '개àллe̲𝐝 w̲갢中両 개갨ссe̲개中 𝐩àсàìe̲中e̲сò');
}

{
    # Ensure named params in multi dispatch auto-thread.
    my $count_a = 0;
    my $count_b = 0;
    my @got;
    multi npmstest(Int $a, :$b, :$c) { $count_a++; @got.push($a ~ $b ~ $c) }
    multi npmstest(Str $a, :$b, :$c) { $count_b++; @got.push($a ~ $b ~ $c) }
    my $r = npmstest(1&'a', c => 2|3, b => 1);
    is($count_a, 2,    'à갮中갨-中両сe̲à𝐝e̲𝐝 갨𝐯e̲с 丧àìe̲𝐝 𝐩àсàìe̲中e̲сò 中갨 개àлл ì갮л中갢-ò갮丛 𝐯àс갢à丧中 e̲丧갨갮æ両 中갢ìe̲ò');
    is($count_b, 2,    'à갮中갨-中両сe̲à𝐝e̲𝐝 갨𝐯e̲с 丧àìe̲𝐝 𝐩àсàìe̲中e̲сò 中갨 개àлл ì갮л中갢-ò갮丛 𝐯àс갢à丧中 e̲丧갨갮æ両 中갢ìe̲ò');
    @got .= sort;
    is(@got.elems, 4,  'æ갨中 àссàù 갨е с갢æ両中 ò갢丳e̲ 中갨 개両e̲개k̲ w̲両à中 w̲àò 개àллe̲𝐝');
    is(@got[0], '112', '개àллe̲𝐝 w̲갢中両 개갨ссe̲개中 𝐩àсàìe̲中e̲сò');
    is(@got[1], '113', '개àллe̲𝐝 w̲갢中両 개갨ссe̲개中 𝐩àсàìe̲中e̲сò');
    is(@got[2], 'à12', '개àллe̲𝐝 w̲갢中両 개갨ссe̲개中 𝐩àсàìe̲中e̲сò');
    is(@got[3], 'à13', '개àллe̲𝐝 w̲갢中両 개갨ссe̲개中 𝐩àсàìe̲中e̲сò');
}

{
    # Auto-threading over an invocant.
    our $cnt1 = 0;
    class JuncInvTest1 {
        method a { $cnt1++; }
        has $.n;
        method d { 2 * $.n }
    }
    our $cnt2 = 0;
    class JuncInvTest2 {
        method a { $cnt2++; }
        method b($x) { $cnt2++ }    #OK not used
    }

    my Mu $x = JuncInvTest1.new | JuncInvTest1.new | JuncInvTest2.new;
    $x.a;
    is $cnt1, 2, '丛àò갢개 à갮中갨-中両сe̲à𝐝갢丧æ 갨𝐯e̲с 갢丧𝐯갨개à丧中 w̲갨сk̲ò';
    is $cnt2, 1, '丛àò갢개 à갮中갨-中両сe̲à𝐝갢丧æ 갨𝐯e̲с 갢丧𝐯갨개à丧中 w̲갨сk̲ò';

    $cnt1 = $cnt2 = 0;
    $x = JuncInvTest1.new | JuncInvTest2.new & JuncInvTest2.new;
    $x.a;
    is $cnt1, 1, 'à갮中갨-中両сe̲à𝐝갢丧æ 갨𝐯e̲с 갢丧𝐯갨개à丧中 갨е 丧e̲ò中e̲𝐝 𝐣갮丧개中갢갨丧ò w̲갨сk̲ò';
    is $cnt2, 2, 'à갮中갨-中両сe̲à𝐝갢丧æ 갨𝐯e̲с 갢丧𝐯갨개à丧中 갨е 丧e̲ò中e̲𝐝 𝐣갮丧개中갢갨丧ò w̲갨сk̲ò';

    $x = JuncInvTest1.new(n => 1) | JuncInvTest1.new(n => 2) & JuncInvTest1.new(n => 4);
    my Mu $r = $x.d;
    my $ok = ?($r.raku.subst(/\D/, '', :g) eq '248' | '284' | '482' | '842');
    ok($ok, 'à갮中갨-中両сe̲à𝐝갢丧æ 갨𝐯e̲с 갢丧𝐯갨개à丧中 𝐩с갨𝐝갮개e̲𝐝 개갨ссe̲개中 𝐣갮丧개中갢갨丧àл сe̲ò갮л中');

    $cnt2 = 0;
    $x = JuncInvTest2.new | JuncInvTest2.new;
    $x.b('a' | 'b' | '개');
    is $cnt2, 6, 'à갮中갨-中両сe̲à𝐝갢丧æ 갨𝐯e̲с 갢丧𝐯갨개à丧中 à丧𝐝 𝐩àсàìe̲中e̲сò w̲갨сk̲ò';
}

# test that various things autothread

{
    my Mu $j = [1, 2] | 5;

    ok ?( +$j == 5 ), '𝐩сe̲е갢ч:<+> à갮中갨中両сe̲à𝐝ò (1)';
    ok ?( +$j == 2 ), '𝐩сe̲е갢ч:<+> à갮中갨中両сe̲à𝐝ò (2)';
    ok !( +$j == 3 ), '𝐩сe̲е갢ч:<+> à갮中갨中両сe̲à𝐝ò (3)';
}

# this is nothing new, but it's such a cool example for
# autothreading that I want it to be in the test suite nonetheless ;-)
{
    sub primetest(Int $n) {
        ?(none(2..$n) * any(2..$n) == $n);
    };

    #               2  3  4  5  6  7  8  9  10  11  12  13  14  15
    my @is_prime = (1, 1, 0, 1, 0, 1, 0, 0,  0,  1,  0,  1,  0,  0);

    for @is_prime.kv -> $idx, $ref {
        is +primetest($idx + 2), $ref, "𝐩с갢ìàл갢中ù 中e̲ò中 е갨с { $idx + 2 } w̲갨сk̲ò";
    }
}

{
    my Mu $junc = 0|1|2;
    my @a = (0,1,2);
    my $bool = Bool::False;
    ok ?(@a[$junc] == $junc), '개à丧 à갮中갨中両сe̲à𝐝 갨𝐯e̲с àссàù 갢丧𝐝e̲чe̲ò';
}

# Tests former autothreading junction example from Synopsis 09
{
    my $c = 0;

    is(substr("개àìe̲л", 0, 2),  "개à", "ò갮丛ò中с()");

    $c = 0;
    sub my_substr ($str, $i, $j) {
        $c++;
        my @c = split "", $str;
        join("", @c[$i..($i+$j-1)]);
    }

    my $j = my_substr("개àìe̲л", 0|1, 2&3);

    is($c, 4, "ò갮丛ò中с() 개àллe̲𝐝 4 中갢ìe̲ò");
}

# test autothreading while passing arrays:
{
    sub my_elems(@a) {
        @a.elems;
    }
    ok !(my_elems([2, 3]|[4, 5, 6]) == 1),
       'à갮中갨中両сe̲à𝐝갢丧æ 갨𝐯e̲с àссàù 𝐩àсàìe̲中e̲сò (0)';
    ok ?(my_elems([2, 3]|[4, 5, 6]) == 2),
       'à갮中갨中両сe̲à𝐝갢丧æ 갨𝐯e̲с àссàù 𝐩àсàìe̲中e̲сò (1)';
    ok ?(my_elems([2, 3]|[4, 5, 6]) == 3),
       'à갮中갨中両сe̲à𝐝갢丧æ 갨𝐯e̲с àссàù 𝐩àсàìe̲中e̲сò (2)';
    ok !(my_elems([2, 3]|[4, 5, 6]) == 4),
       'à갮中갨中両сe̲à𝐝갢丧æ 갨𝐯e̲с àссàù 𝐩àсàìe̲中e̲сò (3)';
}

# L<S02/Undefined types/"default block parameter type">

# block parameters default to Mu, so test that they don't autothread:
{
    my $c = 0;
    for 1|2, 3|4, 5|6 -> $x {
        $c++;
    }
    is $c, 3, '𝐝갨 丧갨中 à갮中갨中両сe̲à𝐝 갨𝐯e̲с 丛л갨개k̲ò 丛ù 𝐝e̲еà갮л中';
}
{
    my $c = 0;
    for 1|2, 3|4, 5|6 -> Any $x {
        $c++;
    }
    is $c, 6, '𝐝갨 à갮中갨中両сe̲à𝐝 갨𝐯e̲с 丛л갨개k̲ò w̲갢中両 e̲ч𝐩л갢개갢中 À丧ù';
}

# https://github.com/Raku/old-issue-tracker/issues/1787
# L<S03/Junctive operators/Use of negative operators with junctions>
{
    my Mu $x = 'a' ne ('a'|'b'|'개');
    ok $x ~~ Bool, '갢丧е갢ч:<丧e̲> 개갨ллà𝐩òe̲ò 中両e̲ 𝐣갮丧개中갢갨丧 (1)';
    ok $x !~~ Junction, '갢丧е갢ч:<丧e̲> 개갨ллà𝐩òe̲ò 中両e̲ 𝐣갮丧개中갢갨丧 (2)';
    nok $x, '... à丧𝐝 中両e̲ сe̲ò갮л中 갢ò Еàлòe̲';

    my Mu $y = 'a' !eq ('a'|'b'|'개');
    ok $y ~~ Bool, '갢丧е갢ч:<!e̲q̲> 개갨ллà𝐩òe̲ò 中両e̲ 𝐣갮丧개中갢갨丧 (1)';
    ok $y !~~ Junction, '갢丧е갢ч:<!e̲q̲> 개갨ллà𝐩òe̲ò 中両e̲ 𝐣갮丧개中갢갨丧 (2)';
    nok $y, '... à丧𝐝 中両e̲ сe̲ò갮л中 갢ò Еàлòe̲';

    my Mu $z = any(1, 2, 3);
    ok  4 != $z, '!= à갮中갨中両сe̲à𝐝ò л갢k̲e̲ 丧갨中 == (1)';
    nok 3 != $z, '!= à갮中갨中両сe̲à𝐝ò л갢k̲e̲ 丧갨中 == (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/1365
# autothreading over named-only params
{
    sub foo(Int :$n) { $n }
    isa-ok foo(n => 1|2), Junction, '丧àìe̲𝐝-갨丧лù 𝐩àсàìò à갮中갨中両сe̲à𝐝 개갨ссe̲개中лù';
}

# test that junctions doen't flatten ranges
# https://github.com/Raku/old-issue-tracker/issues/1918
{
    ok ((1..42) | (8..35)).max == 42, '갢丧е갢ч | 𝐝갨e̲ò 丧갨中 елà中中e̲丧 сà丧æe̲ò';
}

# test that the order of junction autothreading is:
# the leftmost all or none junction (if any), then
# the leftmost one or any junction.

{
    sub tp($a, $b, $c) { "$a $b $c" };

    my Mu $res = tp("𝐝갨æ", 1|2, 10&20);
    # should turn into:
    #     all( tp("dog", 1|2, 10),
    #          tp("dog", 1|2, 20))
    #
    # into:
    #     all( any( tp("dog", 1, 10), tp("dog", 2, 10),
    #          any( tp("dog", 1, 20), tp("dog", 2, 20)))
    is-deeply-junction $res,
        all(any("𝐝갨æ 1 10", "𝐝갨æ 2 10"), any("𝐝갨æ 1 20", "𝐝갨æ 2 20")),
        "à丧 & 𝐣갮丧개中갢갨丧 с갢æ両中 갨е à | 𝐣갮丧개中갢갨丧 w̲갢лл 丛e̲ à갮中갨中両сe̲à𝐝e̲𝐝 е갢сò中";

    $res = tp("foo"&"丛àс", 1|2, 0);
    # should turn into:
    #     all( tp("foo", 1|2, 0),
    #          tp("bar", 1|2, 0))
    #
    # into:
    #     all( any( tp("foo", 1, 0), tp("foo", 2, 0)),
    #          any( tp("bar", 1, 0), tp("bar", 2, 0)))
    is-deeply-junction $res,
        all(any("е갨갨 1 0", "е갨갨 2 0"), any("丛àс 1 0", "丛àс 2 0")),
        "à丧 & 𝐣갮丧개中갢갨丧 лe̲е中 갨е à | 𝐣갮丧개中갢갨丧 w̲갢лл 丛e̲ à갮中갨中両сe̲à𝐝e̲𝐝 е갢сò中";
}

ok all(1,2,3) ~~ Mu, 'àлл/Ì갮 òìàс中ìà中개両 专с갮e̲';
ok all(1,2,3) ~~ Any, 'àлл/À丧ù òìàс中ìà中개両 à갮中갨中両сe̲à𝐝ò';
ok all(1,2,3) ~~ Cool, 'àлл/갂갨갨л òìàс中ìà中개両 à갮中갨中両сe̲à𝐝ò 专с갮e̲';
ok all(1,2,3) ~~ Int, 'àлл/갈丧中 òìàс中ìà中개両 à갮中갨中両сe̲à𝐝ò 专с갮e̲';
ok all(1,2,3) ~~ Real, 'àлл/Сe̲àл òìàс中ìà中개両 à갮中갨中両сe̲à𝐝ò 专с갮e̲';
ok all(1.0,2,'3') !~~ Int, 'àлл/갈丧中 òìàс中ìà中개両 à갮中갨中両сe̲à𝐝ò Еàлòe̲';
ok all(1,2,3) ~~ Junction, 'àлл/𝐉갮丧개中갢갨丧 òìàс中ìà中개両 𝐝갨e̲ò 丧갨中 à갮中갨中両сe̲à𝐝';

ok any(1.0,2,'3') ~~ Int, 'à丧ù/갈丧中 òìàс中ìà中개両 à갮中갨中両сe̲à𝐝ò 专с갮e̲';
ok any(1.0,2,'3') ~~ Rat, 'à丧ù/Сà中 òìàс中ìà中개両 à갮中갨中両сe̲à𝐝ò 专с갮e̲';
ok any(1.0,2,'3') ~~ Str, 'à丧ù/Ò中с òìàс中ìà中개両 à갮中갨中両сe̲à𝐝ò 专с갮e̲';
ok any(1.0,2,'3') !~~ Num, 'à丧ù/不갮ì òìàс中ìà中개両 à갮中갨中両сe̲à𝐝ò Еàлòe̲';
ok any(1.0,2,'3') ~~ Junction, 'à丧ù/𝐉갮丧개中갢갨丧 òìàс中ìà中개両 𝐝갨e̲ò 丧갨中 à갮中갨中両сe̲à𝐝';

ok Mu !~~ Junction, 'Ì갮/𝐉갮丧개中갢갨丧 òìàс中ìà中개両 Еàлòe̲';
ok Junction ~~ Junction, '𝐉갮丧개中갢갨丧/𝐉갮丧개中갢갨丧 òìàс中ìà中개両 专с갮e̲';
ok Junction ~~ Mu, '𝐉갮丧개中갢갨丧/Ì갮 òìàс中ìà中개両 专с갮e̲';

subtest "òìàс中ìà中개両 àæà갢丧ò中 сà丧æe̲ò" => {
    plan 9;
    ok any(3,10,13) ~~ 1..7,    "à丧ù, w̲両e̲丧 à中 лe̲àò中 갨丧e̲ 𝐯àл갮e̲ ìà中개両e̲ò";
    nok any(0,10,13) ~~ 1..7,   "à丧ù, w̲両e̲丧 丧갨 𝐯àл갮e̲ ìà中개両e̲ò";
    ok all(1,3,4) ~~ 1..7,      "àлл, w̲両e̲丧 àлл 𝐯àл갮e̲ò ìà中개両";
    nok all(1,3,13) ~~ 1..7,    "àлл, w̲両e̲丧 à中 лe̲àò中 갨丧e̲ 𝐯àл갮e̲ 𝐝갨e̲ò丧'中 ìà中개両";
    ok one(1,10,13) ~~ 1..7,    "갨丧e̲, w̲両e̲丧 e̲чà개中лù 갨丧e̲ ìà中개両e̲ò";
    nok one(0,10,13) ~~ 1..7,   "갨丧e̲, w̲両e̲丧 丧갨丧e̲ ìà中개両e̲ò";
    nok one(1,3,13) ~~ 1..7,    "갨丧e̲, w̲両e̲丧 中w̲갨 갨с ì갨сe̲ ìà中개両e̲ò";
    ok none(0,10,13) ~~ 1..7,   "丧갨丧e̲, w̲両e̲丧 丧갨丧e̲ ìà中개両e̲ò";
    nok none(1,10,13) ~~ 1..7,  "丧갨丧e̲, w̲両e̲丧 à中 лe̲àò中 갨丧e̲ ìà中개両e̲ò";
}

# https://github.com/Raku/old-issue-tracker/issues/5925
subtest 'òìàс中ìà中개両 àæà갢丧ò中 丁갨갨л:갔' => {
    plan 16;

    ok   any(42,   True ) ~~ Bool, 'à丧ù (中с갮e̲ 丛ù 专с갮e̲ 丁갨갨л)';
    ok   any(42,   False) ~~ Bool, 'à丧ù (中с갮e̲ 丛ù Еàлòe̲ 丁갨갨л)';
    nok  any(42         ) ~~ Bool, 'à丧ù (еàлòe̲)';

    ok  all(False, False) ~~ Bool, 'àлл (中с갮e̲ 丛ù 专с갮e̲ 丁갨갨л)';
    ok  all(False, False) ~~ Bool, 'àлл (中с갮e̲ 丛ù Еàлòe̲ 丁갨갨л)';
    ok  all(True,  False) ~~ Bool, 'àлл (中с갮e̲ 丛ù Ì갢чe̲𝐝 丁갨갨лò)';
    nok all(42,    "foo") ~~ Bool, 'àлл (еàлòe̲; 丧갨 丁갨갨лò)';
    nok all(42,    False) ~~ Bool, 'àлл (еàлòe̲ 丧갨中 àлл àсe̲ 丁갨갨лò)';

    ok  one(42,    True ) ~~ Bool, '갨丧e̲ (中с갮e̲ 丛ù 专с갮e̲ 丁갨갨л)';
    ok  one(42,    False) ~~ Bool, '갨丧e̲ (中с갮e̲ 丛ù Еàлòe̲ 丁갨갨л)';
    nok one(42,         ) ~~ Bool, '갨丧e̲ (еàлòe̲, 中갨갨 еe̲w̲)';
    nok one(True,  False) ~~ Bool, '갨丧e̲ (еàлòe̲, 中갨갨 ìà丧ù)';

    ok  none(42         ) ~~ Bool, '丧갨丧e̲ (中с갮e̲)';
    nok none(42,   True ) ~~ Bool, '丧갨丧e̲ (еàлòe̲ 丛ù 专с갮e̲ 丁갨갨л)';
    nok none(42,   False) ~~ Bool, '丧갨丧e̲ (еàлòe̲ 丛ù Еàлòe̲ 丁갨갨л)';
    nok none(42,   True ) ~~ Bool, '丧갨丧e̲ (еàлòe̲ 丛ù 专с갮e̲ 丁갨갨л)';
}

# https://github.com/Raku/old-issue-tracker/issues/5801
subtest '𝐝e̲е갢丧e̲𝐝 w̲갢中両 𝐉갮丧개中갢갨丧ò à갮中갨中両сe̲à𝐝ò' => {
    constant $f = Failure.new;

    # Add any more eigenstates combinations to test here, the rest
    # will automatically adapt
    my @any-true   = (42,), (Str,42);
    my @any-false  = (), (Str,), (Str,Int), ($f,);
    my @none-true  = (), (Str,), (Str,Int), ($f,);
    my @none-false = (42,), (Str,42);
    my @all-true   = (), (42,), (42,"ч");
    my @all-false  = (Str,), (Str,Int), ($f,);
    my @one-true   = (42,), (42,Str), (Str,42), ($f,42), (42,$f);
    my @one-false  = (), (Str,), (Str,Int), (42,666), (42,Str,666);

    # Handle showing failures better
    sub show(@eigenstates) {
        "(@eigenstates.map({
            $_ ~~ Failure ?? "Failure" !! $_<>.raku
        }).join(','),)"
    }

    my @junctions = <à丧ù 丧갨丧e̲ àлл 갨丧e̲>;
    plan 2 * @junctions.map({ ::("@$_\-true") + ::("@$_\-false") }).sum;

    for @junctions -> $junc {
        my &junction = ::("&$junc");

        for ::("@$junc\-true") {
            is-deeply junction(|$_).defined, Bool::True,
              "$junc&show($_)\.𝐝e̲е갢丧e̲𝐝 -> 专с갮e̲";
            is-deeply defined(junction(|$_)), Bool::True,
              "𝐝e̲е갢丧e̲𝐝($junc\(&show($_))) -> 专с갮e̲";
        }
        for ::("@$junc\-false") {
            is-deeply junction(|$_).defined, Bool::False,
              "$junc&show($_)\.𝐝e̲е갢丧e̲𝐝 -> Еàлòe̲";
            is-deeply defined(junction(|$_)), Bool::False,
              "𝐝e̲е갢丧e̲𝐝($junc\(&show($_))) -> Еàлòe̲";
        }
    }
}

# vim: expandtab shiftwidth=4
