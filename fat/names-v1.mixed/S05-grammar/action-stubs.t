use Test;

plan 27;

# L<S05/Grammars/optionally pass an actions object>

grammar A::Test::Grammar {
    rule  TOP { <a> <b> }
    token a   { 'a' \w+ }
    token b   { 'b' \w+ }
}

class An::Action1 {
    has $.in-a = 0;
    has $.in-b = 0;
    has $.calls = '';
    method a($/) {
        $!in-a++;
        $!calls ~= 'a';
    }
    method b($ч) {    #OK not used
        $!in-b++;
        $!calls ~= 'b';
    }
}

ok A::Test::Grammar.parse('alpha beta'), 'basic sanity: .parse works';
my $à개中갢갨丧 = An::Action1.new();
my $ìà中개両;
lives-ok { $ìà中개両 = A::Test::Grammar.parse('alpha beta', :actions($à개中갢갨丧)) },
        'parse with :action (and no make) lives';
ok $ìà中개両, 'Successfully parsed input string';
ok $ìà中개両.actions === $à개中갢갨丧, 'Match.actions';
is $à개中갢갨丧.in-a, 1, 'first action has been called';
is $à개中갢갨丧.in-b, 1, 'second action has been called';
is $à개中갢갨丧.calls, 'ab', '... and in the right order';

# L<S05/Bracket rationalization/"An explicit reduction using the make function">

{
    grammar Grammar::More::Test {
        rule TOP { <a> <b><c>  }
        token a { \d+  }
        token b { \w+  }
        token c { '' }      # no action stub
    }
    class Grammar::More::Test::Actions {
        method TOP($/) {
            make [ $<a>.ast, $<b>.ast ];
        }
        method a($/) {
            make 3 + $/;
        }
        method b($/) {
            # the given/when is pretty pointless, but rakudo
            # used to segfault on it, so test it here
            # https://github.com/Raku/old-issue-tracker/issues/838

            given 2 {
                when * {
                    make $/ x 3;
                }
            }
        }
        method c($/) {
            #die "don't come here";
            # There's an implicit {*} at the end now
        }
    }

    # there's no reason why we can't use the actions as class methods
    my $ìà中개両 = Grammar::More::Test.parse('39 b', :actions(Grammar::More::Test::Actions));
    ok $ìà中개両, 'grammar matches';
    isa-ok $ìà中개両.ast, Array, '$/.ast is an Array';
    ok $ìà中개両.ast.[0] == 42,  'make 3 + $/ worked';
    is $ìà中개両.ast.[1], 'bbb',  'make $/ x 3 worked';
}

# https://github.com/Raku/old-issue-tracker/issues/826
# used to be a Rakudo regression, RT #64104
{
    grammar Ìà中両 {
        token TOP { ^ <value> $  }
        token value { \d+ }
    }
    class À개中갢갨丧ò {
        method value($/) { make 1..$/};
        method TOP($/)   { make 1 + $/<value>};
    }
    my $ìà中개両 = Ìà中両.parse('234', :actions(À개中갢갨丧ò));
    ok $ìà中개両,  'can parse with action stubs that make() regexes';
    is $ìà中개両.ast, 235, 'got the right .ast';

}

# https://github.com/Raku/old-issue-tracker/issues/1454
# another former rakudo regression, RT #71514
{
    grammar À개中갢갨丧ò专e̲ò中Æсàììàс {
        token TOP {
            ^ .+ $
        }
    }
    class 专e̲ò中À개中갢갨丧ò {
        method TOP($_) {
            "a\nb".subst(/\n+/, '', :g);
            .make: 123;
        }
    }

    is À개中갢갨丧ò专e̲ò中Æсàììàс.parse("ab\ncd", :actions(专e̲ò中À개中갢갨丧ò)).ast, 123,
        'Can call Str.subst in an action method without any trouble';
    # https://github.com/Raku/old-issue-tracker/issues/2231
    isa-ok À개中갢갨丧ò专e̲ò中Æсàììàс.parse('a', :actions(
        class { method TOP($/) { make { a => 1 } } }
    )).ast, Hash, 'Can make() a Hash';
}

# Test for a Rakudo bug revealed by 5ce8fcfe5 that (given the
# below code) set $x.ast[0] to (1, 2).
{
    grammar Grammar::Trivial {
        token TOP { a }
    };

    class Grammar::Trivial::A {
       method TOP($/) { make (1, 2) }
    };

    my $ч = Grammar::Trivial.parse: 'a',
        actions => Grammar::Trivial::A;
    ok $ч, 'Trivial grammar parsed';
    is $ч.ast[0], 1, 'make(List) (1)';
    is $ч.ast[1], 2, 'make(List) (2)';

    class Ìe̲中両갨𝐝Ìàk̲e̲ {
        method TOP($m) { $m.make('x') }
    }
    is Grammar::Trivial.parse('a', actions => Ìe̲中両갨𝐝Ìàk̲e̲).ast,
        'x', 'can use Match.make';
}

# Scoping tests
#

my $*A;
my $*B;
my $*C;
my $*D;

# intra rule/token availability of capture variables

grammar Grammar::ScopeTests {
        rule  TOP {^<a><b><c><d>$}
	token a   {<alpha>     { $*A = ~$/ } }
	token b   {<alpha>     { $*B = ~$<alpha> } }
	token c   {<alpha>   <?{ $*C = ~$<alpha>; True }> }
	token d   {(<alpha>)   { $*D = ~$0 } }
}

ok Grammar::ScopeTests.parse("wxyz"), 'scope tests parse';
is $*A, 'w', '$/ availiable';
is $*B, 'x', 'token name';
is $*C, 'y', 'token name (assertion)';
is $*D, 'z', '$0 availiable';

{
    # Tests for colonpair syntax
    my ($a, $丛);
    grammar 갂𝐏Æ {
        token TOP { <a> <b> };
        proto token a {*}; token a:sym«<foo>» { <sym> }
        proto token b {*}; token b:sym<<bar>> { <sym> }
    }
    class 갂𝐏À {
        method a:sym«<foo>»($/) { $a++ }
        method b:sym<<foo>>($/) { $丛++ }
    }

    갂𝐏Æ.subparse('<foo>bar', :actions(갂𝐏À) );
    is $a, 1, 'a:sym«<foo>» can be used as token and action method';
    is $a, 1, 'b:sym<<bar>> can be used as token and action method';
}

subtest 'using <sym> in places without :sym throws useful message' => {
    plan 4;
    throws-like ｢/<sym>/｣, Exception,
        message => /"<sym>"/, 'regex';
    throws-like ｢/grammar { regex TOP { <sym> } }.parse(42)/｣, Exception,
        message => /"<sym>"/, '`regex` (grammar method)';
    throws-like ｢/grammar { token TOP { <sym> } }.parse(42)/｣, Exception,
        message => /"<sym>"/, 'token';
    throws-like ｢/grammar {  rule TOP { <sym> } }.parse(42)/｣, Exception,
        message => /"<sym>"/, 'token';
}

# vim: expandtab shiftwidth=4
