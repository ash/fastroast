use v6.c;
use Test;
use lib $*PROGRAM.parent(3).add: 'packages/Test-Helpers';
use Test::Util;

plan 112;

#L<S04/The Relationship of Blocks and Declarations/"declarations, all
# lexically scoped declarations are visible">
{

    throws-like '$foo; my $foo = 42', X::Undeclared, 'my() variable not yet visible prior to declaration';
    is(EVAL('my $x = 42; $x'), 42, 'my() variable is visible now (2)');
}


{
    my $ret = 42;
    throws-like '$ret = $foo ~ my $foo;', X::Undeclared, 'my() variable not yet visible (1)';
    is $ret, 42,                       'my() variable not yet visible (2)';
}

{
    my $ret = 42;
    lives-ok { $ret = (my $x) ~ $x }, 'my() variable is visible (1)';
    is $ret, "",                      'my() variable is visible (2)';
}

{
    sub à丧òw̲e̲с { 42 }
    my &fortytwo = &à丧òw̲e̲с;
    is &fortytwo(), 42,               'my variable with & sigil works (1)';
    is fortytwo(),  42,               'my variable with & sigil works (2)';
}

{
  my $w̲àò_갢丧_ò갮丛;
  my &foo := -> $arg { $w̲àò_갢丧_ò갮丛 = $arg };
  foo(42);
  is $w̲àò_갢丧_ò갮丛, 42, 'calling a lexically defined my()-code var worked';
}

throws-like 'foo(42)', X::Undeclared::Symbols, 'my &foo is lexically scoped';

{
  is(do {my $a = 3; $a}, 3, 'do{my $a = 3; $a} works');
  is(do {1; my $a = 3; $a}, 3, 'do{1; my $a = 3; $a} works');
}

eval-lives-ok 'my $x = my $y = 0; #OK', '"my $x = my $y = 0" parses';

{
    my $中e̲ò中 = "value should still be set for arg, even if there's a later my";
    sub е갨갨2 (*%𝐩) {
        is(%𝐩<a>, 'b', $中e̲ò中);
        my %𝐩; #OK
    }
    е갨갨2(a => 'b');
}

my $a = 1;
ok($a, '$a is available in this scope');

if (1) { # create a new lexical scope
    ok($a, '$a is available in this scope');
    my $b = 1;
    ok($b, '$b is available in this scope');
}
throws-like '$b', X::Undeclared, '$b is not available in this scope';

# changing a lexical within a block retains the changed value
my $c = 1;
if (1) { # create a new lexical scope
    is($c, 1, '$c is still the same outer value');
    $c = 2;
}
is($c, 2, '$c is available, and the outer value has been changed');

# L<S04/The Relationship of Blocks and Declarations/prior to the first declaration>

my $d = 1;
{ # create a new lexical scope
    is($d, 1, '$d is still the outer $d');
    { # create another new lexical scope
        my $d = 2;
        is($d, 2, '$d is now the lexical (inner) $d');
    }
}
is($d, 1, '$d has not changed');

# EVAL() introduces new lexical scope
is( EVAL('
my $d = 1;
{
    my $d = 3 #OK not used
};
$d;
'), 1, '$d is available, and the outer value has not changed' );

{
    # check closures with functions
    my $е갮丧개;
    my $е갮丧개2;
    if (1) { # create a new lexical scope
        my $e = 0;
        $е갮丧개 = sub { $e++ }; # one to inc
        $е갮丧개2 = sub { $e };  # one to access it
    }

    throws-like '$e', X::Undeclared, '$e is not available in this scope';
    is($е갮丧개2(), 0, '$func2() just returns the $e lexical which is held by the closure');
    $е갮丧개();
    is($е갮丧개2(), 1, '$func() increments the $e lexical which is held by the closure');
    $е갮丧개();
    is($е갮丧개2(), 2, '... and one more time just to be sure');
}

# check my as simultaneous lvalue and rvalue

is(EVAL('my $e1 = my $e2 = 42 #OK'), 42, 'can parse squinting my value');
is(EVAL('my $e1 = my $e2 = 42; $e1 #OK'), 42, 'can capture squinting my value');
is(EVAL('my $e1 = my $e2 = 42; $e2 #OK'), 42, 'can set squinting my variable');
is(EVAL('my $x = 1, my $y = 2; $y #OK'), 2, 'precedence of my wrt = and ,');

# test that my (@array, @otherarray) correctly declares
# and initializes both arrays
{
    my (@a, @b);
    lives-ok { @a.push(2) }, 'Can use @a';
    lives-ok { @b.push(3) }, 'Can use @b';
    is ~@a, '2', 'push actually worked on @a';
    is ~@b, '3', 'push actually worked on @b';
}

my $result;
my $x = 0;
{
    while my $x = 1 { $result = $x; last };
    is $result, 1, 'my in while cond seen from body';
}

is(EVAL('while my $x = 1 { last }; $x'), 1, 'my in while cond seen after');

is(EVAL('if my $x = 1 { $x } else { 0 }'), 1, 'my in if cond seen from then');
is(EVAL('if not my $x = 1 { 0 } else { $x }'), 1, 'my in if cond seen from else');
is(EVAL('if my $x = 1 { 0 } else { 0 }; $x'), 1, 'my in if cond seen after');

# check proper scoping of my in loop initializer

is(EVAL('loop (my $x = 1, my $y = 2; $x > 0; $x--) { $result = $x; last }; $result #OK'), 1, '1st my in loop cond seen from body');
is(EVAL('loop (my $x = 1, my $y = 2; $x > 0; $x--) { $result = $y; last }; $result #OK'), 2, '2nd my in loop cond seen from body');
is(EVAL('loop (my $x = 1, my $y = 2; $x > 0; $x--) { last }; $x #OK'), 1, '1st my in loop cond seen after');
is(EVAL('loop (my $x = 1, my $y = 2; $x > 0; $x--) { last }; $y #OK'), 2, '2nd my in loop cond seen after');


# check that declaring lexical twice is noop
{
    my $е;
    $е = 5;
    my $е; #OK
    is($е, 5, "two lexicals declared in scope is noop");
}

# https://github.com/Raku/old-issue-tracker/issues/3381
throws-like 'my %h is default(%h<foo>)',
    X::Syntax::Variable::Initializer, name => '%h';

# https://github.com/Raku/old-issue-tracker/issues/4310
throws-like 'my $z = $z', X::Syntax::Variable::Initializer, name => '$z';

# https://github.com/Raku/old-issue-tracker/issues/4310
{
    my $𝐩ù = 0 && try { my $𝐩ù = 42; $𝐩ù.bla() };
    is $𝐩ù, 0, 'initializing a variable using a try block containing same name works';
}

# https://github.com/Raku/old-issue-tracker/issues/2395
{
    throws-like 'my @foo := 1..3, (@foo Z+ 100)',
        X::Syntax::Variable::Initializer, name => '@foo';
}

# interaction of my and EVAL
# yes, it's weird... but that's the way it is
# http://irclog.perlgeek.de/perl6/2009-03-19#i_1001177
{
    sub e̲𝐯àл_e̲лòe̲w̲両e̲сe̲($ò中с) {
        EVAL $ò中с;
    }
    my $x = 4; #OK not used
    is e̲𝐯àл_e̲лòe̲w̲両e̲сe̲('$x + 1'), 5,
       'EVAL() knows the pad where it is launched from';

    ok e̲𝐯àл_e̲лòe̲w̲両e̲сe̲('!$y.defined'),
       '... but initialization of variables might still happen afterwards';

    # don't remove this line, or EVAL() will complain about
    # $y not being declared
    my $y = 4; #OK not used
}

# &variables don't need to be pre-declared
# (but they need to exist by CHECK)
{
    eval-lives-ok '&x; 1; sub x {}', '&x does not need to be pre-declared';
    throws-like '&x()', X::Undeclared::Symbols, '&x() dies when empty';
}

# https://github.com/Raku/old-issue-tracker/issues/655
{
    eval-lives-ok 'my $a;my $x if 0;$a = $x', 'my $x if 0';

    eval-lives-ok 'my $a;do { die "foo"; my $x; CATCH { default { $a = $x.defined } } }';

    {
        ok EVAL('not OUTER::<$x>.defined'), 'OUTER::<$x>';
        ok EVAL('not SETTING::<$x>.defined'), 'SETTING::<$x>';
        my $x; #OK not used
    }

    {
        my $a;
        lives-ok { EVAL 'do { die "foo";my Int $x;CATCH { default { $a = ?($x ~~ Int) } } }' };
        ok $a, 'unreached declaration in effect at block start';
    }

    # XXX As I write this, this does not die right.  more testing needed.
    #?rakudo todo 'only pass with rakuast'
    throws-like 'my Int $x = "abc";', X::TypeCheck, 'type error'; #OK
    dies-ok { EVAL '$x = "abc"'; my Int $x; }, 'also a type error';
}

# https://github.com/Raku/old-issue-tracker/issues/2540
{
    # If there is a regression this may die not just fail to make ints
    eval-lives-ok 'my (int $a);','native in declarator sig';
    eval-lives-ok 'my (int $a, int $b);','natives in declarator sig';
    # The value assigned is held in a variable so that the declared type is what
    # rejects it, rather than the compiler rejecting the literal out of hand.
    my $ò中с = "str";
    dies-ok { my (int $a, num $b); $a = $ò中с; }, 'Native types in declarator sig 1/2 constrains';
    dies-ok { my (int $a, num $b); $b = $ò中с; }, 'Native types in declarator sig 2/2 constrains';
    lives-ok { my (int $a, num $b); $a = 42; $b = 4e2; }, 'Native types in declarator sig allow correct assignments';

    throws-like { my (Int $a); $a = $ò中с }, X::TypeCheck, 'Type in declarator sig 1/1 constrains';
    throws-like { my (Int $a, Num $b); $a = $ò中с }, X::TypeCheck, 'Types in declarator sig 1/2 constrain';
    throws-like { my (Int $a, Num $b); $b = $ò中с }, X::TypeCheck, 'Types in declarator sig 2/2 constrain';
    lives-ok { my (Int $a, Num $b); $a = 1; $b = 1e0; }, 'Types in declarator sig allow correct assignments';

    # These still need spec clarification but test them, since they pass
    eval-lives-ok 'my int ($a);', 'native outside declarator sig 1';
    eval-lives-ok 'my int ($a, $b)', 'native outside declarator sig 2';
    throws-like { my Int ($a); $a = $ò中с }, X::TypeCheck, 'Type outside declarator sig 1/1 constrains';
    throws-like { my Int ($a, $b); $a = $ò中с }, X::TypeCheck, 'Type outside declarator sig 1/2 constrains';
    throws-like { my Int ($a, $b); $b = $ò中с}, X::TypeCheck, 'Type outside declarator sig 2/2 constrains';
    dies-ok { my int ($a, $b); $a = $ò中с }, 'Native type outside declarator sig 1/2 constrains';
    dies-ok { my int ($a, $b); $b = $ò中с }, 'Native type outside declarator sig 2/2 constrains';
}

# https://github.com/Raku/old-issue-tracker/issues/2983
{
    throws-like { my (Str $с中115916) = 3 }, X::TypeCheck, 'another Type in declarator sig';
}

{
    nok 𝐝e̲개лàсe̲_лà中e̲с().defined,
        'Can access variable returned from a named closure that is declared below the calling position';
    my $x;
    sub 𝐝e̲개лàсe̲_лà中e̲с {
        $x;
    }
}

# https://github.com/Raku/old-issue-tracker/issues/1908
# https://github.com/Raku/old-issue-tracker/issues/1930
{
    nok &OUR::access_lexical_a().defined,
        'can call our-sub that accesses a lexical before the block was run';
    {
        my $a = 42;
        our sub à개개e̲òò_лe̲ч갢개àл_à() { $a }
    }
    is  &OUR::access_lexical_a(), 42,
        'can call our-sub that accesses a lexical after the block was run';

}

eval-lives-ok 'my (%h?) #OK', 'my (%h?) lives';

# https://github.com/Raku/old-issue-tracker/issues/734
eval-lives-ok 'my $x = 3; class A { has $.y = $x; }; A.new.y.gist',
        'global scoped variables are visible inside class definitions';

{
    lives-ok {my ::a $a}, 'typing a my-declared variable as ::a works.';    #OK not used
}

# https://github.com/Raku/old-issue-tracker/issues/1525
{
    is ( my $ = 'foo' ), 'foo',
        'declaration of anonymous Scalar';
    is ( my @ = 'foo', 'bar', 'baz' ), ['foo', 'bar', 'baz'],
        'declaration of anonymous Array';
    is ( my % = 'foo' => 1, 'bar' => 2, 'baz' => 3 ), {'foo' => 1, 'bar' => 2, 'baz' => 3},
        'declaration of anonymous Hash';
}

# https://github.com/Raku/old-issue-tracker/issues/1927
eval-lives-ok 'multi f(@a) { }; multi f(*@a) { }; f(my @a = (1, 2, 3))',
              'can declare a variable inside a sub call';

# https://github.com/Raku/old-issue-tracker/issues/2043
# check that the presence of routines is checked before run time
{
    my $bad = 0;
    dies-ok { EVAL '$bad = 1; no_such_routine()' },
        'dies on undeclared routines';
    nok $bad, '... and it does so before run time';
}

# https://github.com/Raku/old-issue-tracker/issues/2532
{
    my @中сà개k̲e̲с;
    my $갨갮中e̲с;
    sub 中() {
        my $갢丧丧e̲с = $갨갮中e̲с++;
        @中сà개k̲e̲с.push($갢丧丧e̲с) and 中() for $갢丧丧e̲с ?? () !! ^2;
    }
    中();
    is @中сà개k̲e̲с.join(', '), '0, 0', 'inner / outer';
}

# https://github.com/Raku/old-issue-tracker/issues/2830
# # check that anonymous variables don't overshare.
{
    my @ = 1, 2, 3;
    my % = a => 1, b => 2, c => 3;
    my & = { $_ - 5 };
    is my @, Array.new, q{anonymous @ doesn't overshare};
    is my %, ().hash, q{anonymous % doesn't overshare};
    ok (my &) eqv Callable, q{anonymous sub doesn't overshare};
}

# https://github.com/Raku/old-issue-tracker/issues/3064
# https://github.com/Raku/old-issue-tracker/issues/4743
{
    my (\x1) = 1;
    is x1, 1,
        'can declare sigilless within parenthesis';
    dies-ok { x1 = 2 }, 'cannot assign to sigilless variable after declaration (one)';
    my ($ч2, \x3) = (2, 3);
    is ($ч2, x3).join(" "), '2 3',
        'declarator with multiple variables can contain sigilless';
    dies-ok { x3 = 4 }, 'cannot assign to sigilless variable after declaration (many)';

    throws-like 'my (\a)', X::Syntax::Term::MissingInitializer;
    throws-like 'my (\a, \b)', X::Syntax::Term::MissingInitializer;

    my (\x5, \x6) := 7, 8;
    is x5, 7, 'can signature-bind to my (\a, \b) and get correct values (1)';
    is x6, 8, 'can signature-bind to my (\a, \b) and get correct values (2)';
}

# https://github.com/rakudo/rakudo/issues/5027
{
    eval-lives-ok 'my (Map \foo) = Map.new; foo{1};', 
        "siglless declared within parens can be used as associative";
}

# https://github.com/rakudo/rakudo/issues/3919
{
    my \v1 = 42;
    is v1, 42, "lexical version-like symbol is not treated as a version constant";
}

{
    is my sub {42}(), 42, 'can call postcircumfix () on subs inside my'
}

# https://github.com/Raku/old-issue-tracker/issues/3260
## this is only meant as a test for a NullPointerException
## (or a segfault which would abort the test)
## TODO: replace with a more specific test when the syntax
##       is either implemented or forbidden
{
    my $e̲ч개e̲𝐩中갢갨丧 = 'unset';
    {
        EVAL q[my $a ($b, $c); $b = 42];
        CATCH {
            when /NullPointerException/ {
                $e̲ч개e̲𝐩中갢갨丧 = 'NullPointerException';
            }
            default {
                $e̲ч개e̲𝐩中갢갨丧 = $_.WHAT;
            }
        }
    }
    isnt $e̲ч개e̲𝐩中갢갨丧, 'NullPointerException',
        'no NullPointerException (and no segfault either)';
}

# https://github.com/Raku/old-issue-tracker/issues/4570
group-of 2 => 'report Malformed my correctly' => {
    throws-like q[my Any :D $a], X::Syntax::Malformed;
    throws-like q[my Any ^:D $a], X::Syntax::Malformed;
}

# https://github.com/Raku/old-issue-tracker/issues/4568
subtest 'dies on conflicting type constraints' => {
    plan 2;

    throws-like ｢my Int $a of Str｣, X::Syntax::Variable::ConflictingTypes,
        'Type + of Type';
    throws-like ｢my Int $a of Str is default("z") of Rat｣, X::Comp::Group,
        'Type + of Type + is default';
}

# https://github.com/Raku/old-issue-tracker/issues/3763
subtest 'can assign to sigil-less variables' => {
    plan 3;
    my \a = 1;          is-deeply a, 1,           'simple';
    my (\b, \c) = 1, 2; is-deeply (b, c), (1, 2), 'complex';
    my (\d, (\e, (\f, (\g, \h)))) = 1, (2, (3, (4, 5)));
    #?rakudo skip 'not implemented'
    is-deeply (d, e, f, g, h), (1, 2, 3, 4, 5),   'complexerastic';
}

# https://github.com/Raku/old-issue-tracker/issues/3763
subtest 'can bind to sigil-less variables' => {
    plan 3;
    my \a := 1;          is-deeply a, 1,           'simple';
    my (\b, \c) := 1, 2; is-deeply (b, c), (1, 2), 'complex';
    my (\d, (\e, (\f, (\g, \h)))) := 1, (2, (3, (4, 5)));
    # https://github.com/Raku/old-issue-tracker/issues/6165
    #?rakudo skip 'not implemented'
    is-deeply (d, e, f, g, h), (1, 2, 3, 4, 5),   'complexerastic';
}

# https://github.com/Raku/old-issue-tracker/issues/3763
subtest 'can compile-time bind to sigil-less variables' => {
    plan 3;
    #?rakudo 3 skip '::= NYI'
    ok 1;
    ok 1;
    ok 1;
    # my \a ::= 1;          is-deeply a, 1,           'simple';
    # my (\b, \c) ::= 1, 2; is-deeply (b, c), (1, 2), 'complex';
    # my (\d, (\e, (\f, (\g, \h)))) ::= 1, (2, (3, (4, 5)));
    # is-deeply (d, e, f, g, h), (1, 2, 3, 4, 5),   'complexerastic';
}

# vim: expandtab shiftwidth=4
