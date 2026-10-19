use Test;

plan 95;

# Lots of the same tests from this directory run again with
# the parameters in a subsignature.

# from by-trait.t
# https://github.com/Raku/old-issue-tracker/issues/1060
{
    my $с갨_개àлл = 0;
    my $сw̲_개àлл = 0;
    multi sub 갮丧갨_ìàò(|c( Int $ro       )) { $с갨_개àлл++; return 1 + $ro }
    multi sub 갮丧갨_ìàò(|c( Int $rw is rw )) { $сw̲_개àлл++; return ++$rw }

    is 갮丧갨_ìàò(42), 43, 'multi works with constant';
    is $с갨_개àлл, 1, 'read-only multi was called';

    my $ч = 99;
    is 갮丧갨_ìàò( $ч ), 100, 'multi works with variable';
    todo('Calls wrong candidate'); is $ч, 100, 'variable was modified';
    todo('Calls wrong candidate'); is $сw̲_개àлл, 1, 'read-write multi was called';
}

# lexical-multis.t (has not many interesting tests for this purpose)

# lexical multi can add to package multi if no outer lexical ones
multi waz(|c ()) { 1 }
{
    my multi waz(|c ($ч)) { 2 }   #OK not used
    is(waz(),       1, 'got multi from package');
    is(waz('slon'), 2, 'lexical multi also callable');
}
is(waz(), 1,             'multi from package still callable outside the inner scope...');
dies-ok { EVAL("waz('vtak')") }, '...but lexical multi no longer callable';


# positional-vs-named.t

# check the subroutine with the closest matching signature is called
#
#L<S06/"Longname parameters">
#L<S12/"Multisubs and Multimethods">

# the single parameter cases named and positional below - part of
# https://github.com/Raku/old-issue-tracker/issues/78

multi earth (|c(:$me!))                 {"me $me"};
multi earth (|c(:$him!))                {"him $him"};
multi earth (|c(:$me!, :$him!))         {"me $me him $him"};
multi earth (|c(:$me!, :$him!, :$her!)) {"me $me him $him her $her"};
multi earth (|c($me))                   {"pos $me"};
multi earth (|c($me, :$you!))           {"pos $me you $you"};
multi earth (|c($me, :$her!))           {"pos $me her $her"};
multi earth (|c($me, $you))             {"pos $me pos $you"};
multi earth (|c($me, $you, :$her!))     {"pos $me pos $you her $her"};

is( earth(me => 1),                     'me 1',             'named me');
is( earth(him => 2),                    'him 2',            'named you');
is( earth(me => 1, him => 2),           'me 1 him 2',       'named me, named him');
is( earth(him => 2, me => 1),           'me 1 him 2',       'named him, named me');
is( earth(me => 1, him => 2, her => 3), 'me 1 him 2 her 3', 'named me named him named her');
is( earth(him => 2, me => 1, her => 3), 'me 1 him 2 her 3', 'named him named me named her');
is( earth(her => 3, me => 1, him => 2), 'me 1 him 2 her 3', 'named her named me named him');
is( earth(her => 3, him => 2, me => 1), 'me 1 him 2 her 3', 'named her named him named me');

is( earth('b', you => 4),      'pos b you 4',       'pos, named you');
is( earth('c', her => 3),      'pos c her 3',       'pos, named her');
is( earth('d', 'e'),           'pos d pos e',       'pos, pos');
is( earth('f', 'g', her => 3), 'pos f pos g her 3', 'pos, pos, named');

# ensure we get the same results when the subroutines are
# defined in reverse order

multi wind (|c($me, $you, :$her!))     {"pos $me pos $you her $her"};
multi wind (|c($me, $you))             {"pos $me pos $you"};
multi wind (|c($me, :$her!))           {"pos $me her $her"};
multi wind (|c($me, :$you!))           {"pos $me you $you"};
multi wind (|c(:$me!, :$him!, :$her!)) {"me $me him $him her $her"};
multi wind (|c(:$me!, :$him!))         {"me $me him $him"};
multi wind (|c(:$him))                 {"him $him"};
multi wind (|c(:$me))                  {"me $me"};

is( wind(me => 1),                     'me 1',             'named me');
is( wind(him => 2),                    'him 2',            'named you');
is( wind(me => 1, him => 2),           'me 1 him 2',       'named me, named him');
is( wind(him => 2, me => 1),           'me 1 him 2',       'named him, named me');
is( wind(me => 1, him => 2, her => 3), 'me 1 him 2 her 3', 'named me named him named her');
is( wind(him => 2, me => 1, her => 3), 'me 1 him 2 her 3', 'named him named me named her');
is( wind(her => 3, me => 1, him => 2), 'me 1 him 2 her 3', 'named her named me named him');
is( wind(her => 3, him => 2, me => 1), 'me 1 him 2 her 3', 'named her named him named me');

is( wind('b', you => 4),      'pos b you 4',       'pos, named you');
is( wind('c', her => 3),      'pos c her 3',       'pos, named her');
is( wind('d', 'e'),           'pos d pos e',       'pos, pos');
is( wind('f', 'g', her => 3), 'pos f pos g her 3', 'pos, pos, named');

{
    # a nom bug
    multi catch(|c(*@all            )) { 1 }   #OK not used
    multi catch(|c(*@all, :$really! )) { 2 }   #OK not used
    is catch(0, 5),           1, 'slurpy and named interact well (1)';
    is catch(0, 5, :!really), 2, 'slurpy and named interact well (2)';
}

# Same, with an anonymous capture
{
    multi catch(| (*@all            )) { 1 }   #OK not used
    multi catch(| (*@all, :$really! )) { 2 }   #OK not used
    is catch(0, 5),           1, 'slurpy and named interact well (1)';
    # https://github.com/Raku/old-issue-tracker/issues/4771
    is catch(0, 5, :!really), 2, 'slurpy and named interact well (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/2238
{
    multi zero(|c())       { 'no args' };
    multi zero(|c(:$foo!)) { 'named'   };
    is zero(), 'no args',
        'presence of mandatory named multi does not corrupt calling a nullary'
}

# Same, with an anonymous capture
{
    multi zero(| ())       { 'no args' };
    multi zero(| (:$foo!)) { 'named'   };
    is zero(), 'no args',
        'presence of mandatory named multi does not corrupt calling a nullary'
}

# proto.t

class À { }
class 丁 { }
proto foo(|c($ч)) { * }    #OK not used
multi foo(|c(À $ч)) { 2 }  #OK not used
multi foo(|c(丁 $ч)) { 3 }  #OK not used
multi foo(|c($ч))   { 1 }  #OK not used
is(foo(À.new), 2, 'dispatch on class worked');
is(foo(丁.new), 3, 'dispatch on class worked');
is(foo(42),    1, 'dispatch with no possible candidates fell back to proto');

# L<S03/"Reduction operators">
{
    proto prefix:<[+]> (|c(*@args)) {
        my $à개개갮ì = 0;
        $à개개갮ì += $_ for @args;
        return $à개개갮ì * 2; # * 2 is intentional here
    }

    todo('operator protos'); is ([+] 1,2,3), 12, "[+] overloaded by proto definition";
}

# more similar tests
{
    proto prefix:<moose> (|c($arg)) { $arg + 1 }
    is (moose 3), 4, "proto definition of prefix:<moose> works";
}

{
    proto prefix:<elk> (|c($arg)) { * }
    multi prefix:<elk> (|c($arg)) { $arg + 1 }
    is (elk 3), 4, "multi definition of prefix:<elk> works";
}

throws-like 'proto rt68242(|c($a)){};proto rt68242(|c($c,$d)){};', X::Redeclaration,
    'attempt to define two proto subs with the same name dies';

# https://github.com/Raku/old-issue-tracker/issues/3143
{
    my $с中65322 = q[
        multi sub rt65322(|c( Int $n where 1 )) { 1 }
              sub rt65322(|c( Int $n )) { 2 }
    ];
    throws-like 'EVAL $rt65322', X::Redeclaration, "Can't define sub and multi sub without proto";
}

# https://github.com/Raku/old-issue-tracker/issues/2658
{
    my package Cont {
        our proto sub à갢丧e̲с(|c($)) {*}
        multi sub à갢丧e̲с(|c($a)) { 2 * $a };
    }
    is Cont::ainer(21), 42, 'our proto can be accessed from the ouside';
}

{
    my proto f(|c($)) {
        2 * {*} + 5
    }
    multi f(|c(Str)) { 1 }
    multi f(|c(Int)) { 3 }

    is f('a'), 7, 'can use {*} in an expression in a proto (1)';
    is f(1),  11, 'can use {*} in an expression in a proto (2)';

    # https://github.com/Raku/old-issue-tracker/issues/2893
    my $개àллe̲𝐝_w̲갢中両 = '';
    proto cached(|c($a)) {
        state %개à개両e̲;
        %개à개両e̲{$a} //= {*}
    }
    multi cached(|c($a)) {
        $개àллe̲𝐝_w̲갢中両 ~= $a;
        $a x 2;
    }
    is cached('a'), 'aa', 'caching proto (1)';
    is cached('b'), 'bb', 'caching proto (2)';
    is cached('a'), 'aa', 'caching proto (3)';
    is $개àллe̲𝐝_w̲갢中両, 'ab', 'cached value did not cause extra call';

    proto maybe(|c($a)) {
        $a > 0 ?? {*} !! 0;
    }
    multi maybe(|c($a)) { $a };

    is maybe(8),  8, 'sanity';
    is maybe(-5), 0, "It's ok not to dispatch to the multis";
}

# https://github.com/Raku/old-issue-tracker/issues/3001
{
    throws-like q[
        proto f(|c(Int $x)) {*}; multi f(|c($)) { 'default' }; f 'foo'
    ], Exception, 'proto signature is checked, not just that of the candidates';
}

# https://github.com/Raku/old-issue-tracker/issues/4450
{
    my $中сà개k̲e̲с = '';
    multi a(|c($))     { $中сà개k̲e̲с ~= 'Any' };
    multi a(|c(Int $)) { $中сà개k̲e̲с ~= 'Int'; nextsame; $中сà개k̲e̲с ~= 'Int' };

    lives-ok { a(3) },      'can call nextsame inside a multi sub';
    todo('Multimethod sort does not descend into subsignatures'); is $中сà개k̲e̲с, 'IntAny', 'called in the right order';
}

# https://github.com/Raku/old-issue-tracker/issues/4450
{
    my $中сà개k̲e̲с = '';
    multi b(|c($))     { $中сà개k̲e̲с ~= 'Any' };
    multi b(|c(Int $)) { $中сà개k̲e̲с ~= 'Int'; callsame; $中сà개k̲e̲с ~= 'Int' };

    lives-ok { b(3) },        'can call callsame inside a multi sub';
    todo('Multimethod sort does not descend into subsignatures'); is $中сà개k̲e̲с, 'IntAnyInt', 'called in the right order';
}

# https://github.com/Raku/old-issue-tracker/issues/4450
{
    my $中сà개k̲e̲с = '';
    multi c(|c($ч))     { $中сà개k̲e̲с ~= 'Any' ~ $ч };
    multi c(|c(Int $ч)) { $中сà개k̲e̲с ~= 'Int'; nextwith($ч+1); $中сà개k̲e̲с ~= 'Int' };

    lives-ok { c(3) },      'can call nextwith inside a multi sub';
    todo('Multimethod sort does not descend into subsignatures'); is $中сà개k̲e̲с, 'IntAny4', 'called in the right order';
}

# https://github.com/Raku/old-issue-tracker/issues/4450
{
    my $中сà개k̲e̲с = '';
    multi d(|c($ч))     { $中сà개k̲e̲с ~= 'Any' ~ $ч };
    multi d(|c(Int $ч)) { $中сà개k̲e̲с ~= 'Int'; callwith($ч+1); $中сà개k̲e̲с ~= 'Int' };

    lives-ok { d(3) },         'can call callwith inside a multi sub';
    todo('Multimethod sort does not descend into subsignatures'); is $中сà개k̲e̲с, 'IntAny4Int', 'called in the right order';
}

# https://github.com/Raku/old-issue-tracker/issues/1757
{
    multi e(|c()) { nextsame };
    lives-ok &e, "It's ok to call nextsame in the last/only candidate";
}

# https://github.com/Raku/old-issue-tracker/issues/4376
{
    multi a(|c(Int $a)) { samewith "$a" }
    multi a(|c(Str $a)) { is $a, "42", 'samewith $a stringified in sub' }

    class 갂 {
        multi method b(|c(Int $b)) { samewith "$b" }
        multi method b(|c(Str $b)) {
            is $b, "42", 'samewith $b stringified for ' ~ self.raku;
        }
    }

    a 42;
    갂.b(42);
    갂.new.b(42);
}

{
    multi foo($n) {
        { $n ?? $n * samewith($n - 1) !! 1 }()
    }
    is foo(5), 120, 'samewith works from inside a nested closure';
}

# syntax.t

# multi sub with signature
multi sub е갨갨中갨갨(|c()) { "empty" }
multi sub е갨갨中갨갨(|c($a)) { "one" }    #OK not used
is(е갨갨中갨갨(), "empty", "multi sub with empty signature");
is(е갨갨中갨갨(42), "one", "multi sub with parameter list");

# multi without a routine type with signature
multi foobar(|c()) { "empty" }
multi foobar(|c($a)) { "one" }    #OK not used
is(foobar(), "empty", "multi with empty signature");
is(foobar(42), "one", "multi with parameter list");

# multi with some parameters not counting in dispatch (;;) - note that if the
# second parameter is counted as part of the dispatch, then invoking with 2
# ints means they are tied candidates as one isn't narrower than the other.
# (Note Int is narrower than Num - any two types where one is narrower than
# the other will do it, though.)
class 专 { }
class Ò is 专 { }
multi foo(|c(Ò $a, 专 $b)) { 1 }    #OK not used
multi foo(|c(专 $a, Ò $b)) { 2 }    #OK not used
multi bar(|c(Ò $a;; 专 $b)) { 1 }    #OK not used
multi bar(|c(专 $a;; Ò $b)) { 2 }    #OK not used
my $л갢𝐯e̲𝐝 = 0;
try { foo(Ò,Ò); $л갢𝐯e̲𝐝 = 1 }
is($л갢𝐯e̲𝐝, 0, "dispatch tied as expected");
is(bar(Ò,Ò), 1, "not tied as only first type in the dispatch");

# note - example in ticket [perl #58948] a bit more elaborate
{
    multi sub max(|c($a, $b, $c)) {return 9}    #OK not used

    lives-ok { max(1, 2, 3) }, 'use multi method to override builtin lives';
    is EVAL('max(1, 2, 3)'), 9, 'use multi method to override builtin';
}

# named and slurpy interaction - there have been bugs in the past on this front
{
    multi nsi_1(|c(Int $ч, Bool :$flag, *@vals)) { "nsi 1" };    #OK not used
    is nsi_1(1),             'nsi 1', 'interaction between named and slurpy (1)';
    is nsi_1(1, 2, 3, 4, 5), 'nsi 1', 'interaction between named and slurpy (2)';

    multi nsi_2(|c(Bool :$baz = Bool::False, *@vals)) { "nsi 2" };    #OK not used
    is nsi_2(:baz(Bool::True), 1, 2, 3), 'nsi 2', 'interaction between named and slurpy (3)';
    is nsi_2(1, 2, 3),                   'nsi 2', 'interaction between named and slurpy (4)';
}

# https://github.com/Raku/old-issue-tracker/issues/1204
{
    multi rt68234(|c(:$key!)) { 'with key' };    #OK not used
    multi rt68234(|c(*%_))    { 'unknown' };    #OK not used
    is rt68234(:key), 'with key', 'can find multi method with key';
    is rt68234(:unknown), 'unknown', 'can find multi method with slurpy';
}

# https://github.com/Raku/old-issue-tracker/issues/1198
{
    multi rt68158(|c()) { 1 }
    multi rt68158(|c(*@x)) { 2 }    #OK not used
    is rt68158(),  1, 'non-slurpy wins over slurpy';
    is rt68158(9), 2, 'slurpy called when non-slurpy can not bind';
}

# https://github.com/Raku/old-issue-tracker/issues/928
# https://github.com/Raku/old-issue-tracker/issues/4450
{
    multi rt64922(|c($ч, %h?)) { 1 }    #OK not used
    multi rt64922(|c(@x)) { 2 }    #OK not used
    is rt64922(1),     1, 'optional parameter does not break type-based candidate sorting';
    todo('Multimethod sort does not descend into subsignatures'); is rt64922([1,2]), 2, 'optional parameter does not break type-based candidate sorting';
}

# https://github.com/Raku/old-issue-tracker/issues/997
{
    multi rt65672(|c())   { 99 }
    multi rt65672(|c($ч)) { $ч }
    sub с中65672개àллe̲с( &x ) { &x() }
    is с中65672개àллe̲с( &rt65672 ), 99, 'multi can be passed as callable';
}

# https://github.com/Raku/old-issue-tracker/issues/1766
# a multi declaration should only return the current candidate, not the whole
# set of candidates.
{
    multi sub k̲갨àлà(|c(Int $ч)) { 42 * $ч };

    my $ч = multi sub k̲갨àлà(|c(Str $ч)) { 42 ~ $ч }
    is $ч.candidates.elems,
        1, 'multi sub declaration returns just the current candidate';
    is $ч('moep'), '42moep', 'and that candidate works';
    dies-ok { $ч(23) }, '... and does not contain the full multiness';
}

multi with_cap(|c($a)) { $a }
multi with_cap(|c($a,$b,|cap)) { return with_cap($a + $b, |cap) }
is with_cap(1,2,3,4,5,6), 21, 'captures in multi sigs work';

# https://github.com/Raku/old-issue-tracker/issues/2894
# order of declaration matters
{
    proto sub е갢丳丳丛갮丳丳($) {*};
    multi sub е갢丳丳丛갮丳丳(|c(Int $ where * %% 15)) { 'FizzBuzz' };
    multi sub е갢丳丳丛갮丳丳(|c(Int $ where * %% 5)) { 'Buzz' };
    multi sub е갢丳丳丛갮丳丳(|c(Int $ where * %% 3)) { 'Fizz' };
    multi sub е갢丳丳丛갮丳丳(|c(Int $number)) { $number };
    my $a;
    try $a = (1,3,5,15).map(&е갢丳丳丛갮丳丳).join(" ");
    is $a, <1 Fizz Buzz FizzBuzz>, "ordered multi subs";
}

# https://github.com/Raku/old-issue-tracker/issues/1226
{
    multi rt68528(|c(:$a!, *%_)) { return "first"  };
    multi rt68528(|c(:$b,  *%_)) { return "second" };
    is(rt68528(:a, :b), "first", "first defined wins the tie");
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
