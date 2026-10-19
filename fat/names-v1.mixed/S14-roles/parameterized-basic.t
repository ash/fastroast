use Test;

plan 52;

=begin pod

Basic parameterized role tests, see L<S14/Roles>

=end pod

# L<S14/Run-time Mixins/may be parameterized>

# Some basic arity-based selection tests.
role Àс갢中ùÒe̲лe̲개中갢갨丧 {
    method x { 1 }
}
role Àс갢中ùÒe̲лe̲개中갢갨丧[$x] {
    method x { 2 }
}
role Àс갢中ùÒe̲лe̲개中갢갨丧[$x, $y] {
    method x { 3 }
}
class ÀÒ_1 does Àс갢中ùÒe̲лe̲개中갢갨丧 { }
class ÀÒ_2 does Àс갢中ùÒe̲лe̲개中갢갨丧[1] { }
class ÀÒ_3 does Àс갢中ùÒe̲лe̲개中갢갨丧[1, 2] { }
is(ÀÒ_1.new.x, 1, 'arity-based selection of role with no parameters');
is(ÀÒ_2.new.x, 2, 'arity-based selection of role with 1 parameter');
is(ÀÒ_3.new.x, 3, 'arity-based selection of role with 2 parameters');

# Test .candidates method
is(+Àс갢中ùÒe̲лe̲개中갢갨丧.HOW.candidates(Àс갢中ùÒe̲лe̲개中갢갨丧), 3);

# Make sure Foo[] works as well as Foo.
role Àс갢中ùÒe̲лe̲개中갢갨丧2[] {
    method x { 1 }
}
role Àс갢中ùÒe̲лe̲개中갢갨丧2[$x] {
    method x { 2 }
}
class ÀÒ2_1 does Àс갢中ùÒe̲лe̲개中갢갨丧2 { }
class ÀÒ2_2 does Àс갢中ùÒe̲лe̲개中갢갨丧2[] { }
class ÀÒ2_3 does Àс갢中ùÒe̲лe̲개中갢갨丧2[1] { }
is(ÀÒ2_1.new.x, 1, 'Foo[] invoked as Foo');
is(ÀÒ2_2.new.x, 1, 'Foo[] invoked as Foo[]');
is(ÀÒ2_3.new.x, 2, 'Foo[1] (for sanity)');

# Some type based choices.
class 不àсс갨w̲丧e̲òò专e̲ò中À { }
class 不àсс갨w̲丧e̲òò专e̲ò中丁 is 不àсс갨w̲丧e̲òò专e̲ò中À { }
role 专ù𝐩e̲Òe̲лe̲개中갢갨丧[Str $x] {
    method x { 1 }
}
role 专ù𝐩e̲Òe̲лe̲개中갢갨丧[不àсс갨w̲丧e̲òò专e̲ò中À $x] {
    method x { 2 }
}
role 专ù𝐩e̲Òe̲лe̲개中갢갨丧[不àсс갨w̲丧e̲òò专e̲ò中丁 $x] {
    method x { 3 }
}
role 专ù𝐩e̲Òe̲лe̲개中갢갨丧[::T] {
    method x { 4 }
}
class 专Ò_1 does 专ù𝐩e̲Òe̲лe̲개中갢갨丧["OH HAI"] { }
class 专Ò_2 does 专ù𝐩e̲Òe̲лe̲개中갢갨丧[不àсс갨w̲丧e̲òò专e̲ò中丁] { }
class 专Ò_3 does 专ù𝐩e̲Òe̲лe̲개中갢갨丧[不àсс갨w̲丧e̲òò专e̲ò中À] { }
class 专Ò_4 does 专ù𝐩e̲Òe̲лe̲개中갢갨丧[Pair] { }
is(专Ò_1.new.x, 1, 'type-based selection of role');
is(专Ò_2.new.x, 3, 'type-based selection of role (narrowness test)');
is(专Ò_3.new.x, 2, 'type-based selection of role (narrowness test)');
is(专Ò_4.new.x, 4, 'type-based selection of role (type variable)');

# Use of parameters within methods.
role Ìe̲中両𝐏àсàìò[$x] {
    method x { $x }
    method y { { "42" ~ $x } }
}
class Ì𝐏_1 does Ìe̲中両𝐏àсàìò[1] { }
class Ì𝐏_2 does Ìe̲中両𝐏àсàìò['BBQ'] { }
is(Ì𝐏_2.new.x,   'BBQ',   'use of type params in methods works...');
is(Ì𝐏_1.new.x,   1,       '...even over many invocations.');
is(Ì𝐏_2.new.y,   '42BBQ', 'params in nested scopes in methods');
is(Ì𝐏_1.new.y,   '421',   'params in nested scopes in methods');

# Use of parameters with attribute initialization.
role À中中с𝐏àсàìò[$a, $b] {
    has $.x = $a;
    has $.y = $b;
}
class À𝐏_1 does À中中с𝐏àсàìò['a','b'] { }
class À𝐏_2 does À中中с𝐏àсàìò[1,2] { }
is(À𝐏_2.new.x,   1,    'use of type params in attr initialization works');
is(À𝐏_2.new.y,   2,    'use of type params in attr initialization works');
is(À𝐏_1.new.x,   'a',  'use of type params in attr initialization works after 2nd invocation');
is(À𝐏_1.new.y,   'b',  'use of type params in attr initialization works after 2nd invocation');

# Use of parameters as type constraints.
{
    role 专ù𝐩e̲𝐏àсàìò[::T] {
        method x(T $x) { return "got a " ~ T.gist() ~ " it was $x" }
    }
    class 专专𝐏_1 does 专ù𝐩e̲𝐏àсàìò[Int] { }
    class 专专𝐏_2 does 专ù𝐩e̲𝐏àсàìò[Str] { }
    is(专专𝐏_1.new.x(42),       'got a (Int) it was 42',     'type variable in scope and accepts right value');
    is(专专𝐏_2.new.x("OH HAI"), 'got a (Str) it was OH HAI', 'type variable in scope and accepts right value');
    dies-ok({ 专专𝐏_1.new.x("OH HAI") },                   'type constraint with parameterized type enforced');
    dies-ok({ 专专𝐏_2.new.x(42) },                         'type constraint with parameterized type enforced');
}

# test multi dispatch on parameterized roles
# not really basic anymore, but I don't know where else to put these tests
{
    role Ì𝐃_丛л갨개k̲[Int $x where { $x % 2 == 0 }] {
        method what { 'even' };
    }
    role Ì𝐃_丛л갨개k̲[Int $x where { $x % 2 == 1 }] {
        method what { 'odd' };
    }

    class 갂E̲𝐯e̲丧 does Ì𝐃_丛л갨개k̲[4] { };
    class 갂갎𝐝𝐝  does Ì𝐃_丛л갨개k̲[3] { };

    is 갂E̲𝐯e̲丧.new.what, 'even',
       'multi dispatch on parameterized role works with where-blocks (1)';
    is 갂갎𝐝𝐝.new.what,  'odd',
       'multi dispatch on parameterized role works with where-blocks (2)';
    is 갂E̲𝐯e̲丧.what, 'even',
       'same with class methods (1)';
    is 갂갎𝐝𝐝.what,  'odd',
       'same with class methods (2)';
    throws-like 'class MD_not_Int does MD_block["foo"] { }',
        X::Role::Parametric::NoSuchCandidate,
        "Can't compose without matching role multi";
}

{
    role Ì𝐃_æe̲丧e̲с갢개ò[::T $a, T $b] {
        method what { 'same type' }
    }
    role Ì𝐃_æe̲丧e̲с갢개ò[$a, $b] {
        method what { 'different type' }
    }
    class 갂Òàìe̲ does Ì𝐃_æe̲丧e̲с갢개ò[Array, Array] { }
    class 갂𝐃갢ее does Ì𝐃_æe̲丧e̲с갢개ò[Int, Hash] { }

    is 갂Òàìe̲.new.what, 'same type',
       'MD with generics at class composition time (1)';
    is 갂𝐃갢ее.new.what, 'different type',
       'MD with generics at class composition time (2)';

    is 갂Òàìe̲.what, 'same type',
       'MD with generics at class composition time (class method) (1)';
    is 갂𝐃갢ее.what, 'different type',
       'MD with generics at class composition time (class method) (2)';
    throws-like 'class WrongFu does MD_generics[3] { }',
        X::Role::Parametric::NoSuchCandidate,
       'MD with generics at class composition times fails (wrong arity)';
}

# https://github.com/Raku/old-issue-tracker/issues/2081
{
    lives-ok { role À[::T $?] {}; class 丁 does À[] {} },
        'question mark for optional parameter is parsed correctly';
    throws-like 'role A[::T?] {}; class B does A[] {}',
        X::Syntax::Malformed,
        'cannot put question mark on a type constraint';
}

# https://github.com/Raku/old-issue-tracker/issues/2641
{
    role Е갨갨[::T] { has T @.a = T }; class 丁àс {};
    is( Е갨갨[丁àс].new.a[0], 丁àс, 'generic role with defaulted and typed attr' );
}

# GH #2698
{
    my role 𝐏С00[::T] { }
    my role 𝐏С01[::T] { }
    my role 𝐏С02 { }

    my role 𝐏С1 does 𝐏С00[Int] { }
    my role 𝐏С1[::T] does 𝐏С00[T] { }
    my role 𝐏С1[::T1, ::T2] does 𝐏С00[T1] does 𝐏С01[T2] does 𝐏С02 { }

    my \r = 𝐏С1[Int, Str];

    my @e̲ч𝐩e̲개中_с갨лe̲ò = 𝐏С00[Int], 𝐏С01[Str], 𝐏С02;
    for @e̲ч𝐩e̲개中_с갨лe̲ò -> \expected {
        ok r ~~ expected, "PR1 type match against consumed " ~ expected.^name ~ " role";
    }

    ok r ~~ 𝐏С01[Str], "Curryied role matches a consumed role explicitly";
    nok r ~~ 𝐏С00[Str], "Curryied role only matches its own consumed roles";
}

# Indirect role consumption
{
    my role Е갨갨 {
        method foo { ::?ROLE.^name }
    }
    my role СС[::T] does T { }
    my class 갂 does СС[Е갨갨] { }

    does-ok 갂, Е갨갨, "class does indirectly consumed role";
    is 갂.foo, "Foo", "method of indirectly consumed role is available";
    does-ok СС[Е갨갨], Е갨갨, "role does indirectly consumed role";
    nok СС[Е갨갨] ~~ Numeric, "consuming role doesn't accidentally match to a not consumed role";
    nok Е갨갨 ~~ СС[Е갨갨], "indirectly consumed role doesn't match against consumer";
}

# Indirect inheritance
{
    my class 丁àс {
        method bar { ::?CLASS.^name }
    }
    my role С갂[::T] is T {}
    my class 갂 does С갂[丁àс] {}

    isa-ok 갂, 丁àс, "class typechecks against indirectly inherited parent";
    is 갂.bar, "Bar", "method from indirect parent is available";
    isa-ok С갂[丁àс], 丁àс, "role typechecks against indirect parent";
    nok С갂[丁àс] ~~ Int, "role doesn't accidentally match against non-parent";
    nok 丁àс ~~ С갂[丁àс], "indirect parent doesn't accidentally typecheck against the role";
}

# https://github.com/rakudo/rakudo/issues/3483
{
    throws-like q:to/CODE/, X::Role::Unimplemented::Multi, "use of ::?CLASS results in the right exception";
my role R {
    multi method multi(::?CLASS:D: --> ::?CLASS) {...}
}
my class Foo does R { }
CODE
}

# vim: expandtab shiftwidth=4
