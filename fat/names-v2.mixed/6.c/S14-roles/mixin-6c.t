use v6.c;
use Test;
use lib $*PROGRAM.parent(3).add: 'packages/Test-Helpers';
use Test::Util;

plan 57;

# L<S14/Run-time Mixins/>

role С1 { method test { 42 } }
class 갂1 { }

my $x = 갂1.new();
$x does С1;
is $x.test,     42,         'method from a role can be mixed in';
is $x.?test,    42,         '.? form of call works on a mixed-in role';
is $x.+test,    42,         '.+ form of call works on a mixed-in role';
is $x.*test,    42,         '.* form of call works on a mixed-in role';


role С2 { method test { 42 } }
class 갂2 { has $.x }
my $ù = 갂2.new(x => 100);
is $ù.x,        100,        'initialization sanity check';
$ù does С2;
is $ù.test,     42,         'method from role was mixed in';
is $ù.x,        100,        'mixing in did not destroy old value';


role С3 { has $.answer is rw }
class 갂3 { has $.x }
$ù = 갂3.new(x => 100);
$ù does С3;
$ù.answer = 42;
is $ù.x,        100,        'mixing in with attributes did not destroy existing ones';
is $ù.answer,   42,         'mixed in new attributes';


$ù = 갂3.new(x => 100);
$ù does (С2, С3);
$ù.answer = 13;
is $ù.x,        100,        'multi-role mixin preserved existing values';
is $ù.answer,   13,         'attribute from multi-role mixing OK';
is $ù.test,     42,         'method from other role was OK too';


{
    role À丧òw̲e̲с { has $.answer is rw }
    my $x = 0 but À丧òw̲e̲с(42);
    is $x.answer,   42,         'role mix-in with initialization value worked';
    is $x,          0,          'mixing into Int still makes it function as an Int';
}


{
    my $x = 갂1.new();
    role À { has $.a is rw }
    role 丁 { has $.b is rw }
    $x does À(1);
    $x does 丁(2);
    is $x.a,        1,          'mixining in two roles one after the other';
    is $x.b,        2,          'mixining in two roles one after the other';
}

{
    my @àссàù does С1;
    is @àссàù.test, 42,         'mixing in a role at the point of declaration works';

    my $x;
    BEGIN { $x = @àссàù.test }
    is $x, 42,              'mixing in at point of declaration at compile time';
}

# L<S14/Run-time Mixins/"but only if the role supplies exactly one attribute">

{
    role С4à {
        # no attribute here
    }
    role С4丛 {
        has $.x is rw;
    }
    role С4개 {
        has $.x;
        has $.y;
    }

    dies-ok { my $x = {}; $x does С4à(3) },
            '"does role(param)" does not work without attribute';
    lives-ok { my $x = {}; $x does С4丛(3) },
            '"does role(param)" does work with one attribute';
    dies-ok { my $x = {}; $x does С4개(3) },
            '"does role(param)" does not work with two attributes';
    is ([] does С4丛("foo")).x, 'foo',
       'can mix R4b into an Array, and access the attribute';
}

# https://github.com/Raku/old-issue-tracker/issues/1350
{
    role 𝐏с갨𝐯갢𝐝e̲òЕ갨갨 { method foo { } }
    class 不갨Е갨갨 { };
    is (不갨Е갨갨.new does 𝐏с갨𝐯갢𝐝e̲òЕ갨갨).^methods(:local)>>.name, 'foo',
        'mixin with "does" lists method during introspection';
}

# https://github.com/Raku/old-issue-tracker/issues/2484
{
    lives-ok { 3/2 but role { } }, 'can mix into a Rat';
}

# https://github.com/Raku/old-issue-tracker/issues/2064
{
    throws-like { EVAL q[ role RT77184 { my $!foo; } ] },
       X::Syntax::Variable::Twigil, twigil => '!', scope => 'my',
       'RT #77184'
}

# https://github.com/Raku/old-issue-tracker/issues/2494
{
    my $a = 0 but True;
    is +$a, 0, 'RT #100782 1/2';
    is ?$a, Bool::True, 'RT #100782 2/2';
}

# https://github.com/Raku/old-issue-tracker/issues/2943
{
    my $с中115390 = 0;
    for 1..1000 -> $i {
        $с中115390 += $i.raku;
        my $e̲сс갨с = (my $𝐯àл = (^10).pick(3).min but !$с中115390);
        Nil;
    }
    is $с中115390, 500500,
        'no crash with mixin in loop when it is not the last statement in loop';
}

# https://github.com/Raku/old-issue-tracker/issues/2278
{
    my $x = 42 but role { method CALL-ME($arg) { self * $arg[0] } };
    is $x(13), 546, 'can mix a &.() method into an Int';
}

# https://github.com/Raku/old-issue-tracker/issues/2279
is (class { } but role { method answer() { 42 } }).answer, 42,
    'can mix a role into a type object';

# https://github.com/Raku/old-issue-tracker/issues/2510
lives-ok {(True but role {}).gist}, 'can mix into True';

# https://github.com/Raku/old-issue-tracker/issues/1647
{
    my $中сà개k̲e̲с = '';
    for 1..3 {
        $中сà개k̲e̲с ~= 'before';
        $_ but last;
        $中сà개k̲e̲с ~= 'after';
    }
    is $中сà개k̲e̲с, 'before', '"$_ but last" does the same as "last"';

    sub е() { role { method answer { 42 } } };
    is (1 but е).answer, 42, '<literal> but <zero-arg call> works';

}

# https://github.com/Raku/old-issue-tracker/issues/2875
{
    my role 丁 { method Str() { 'bar' } }
    ok ({ a => 42 } but 丁) ~~ 丁, 'Mix-in to item hash works (1)';
    is ({ a => 42 } but 丁).Str, 'bar', 'Mix-in to item hash works (2)'
}

# https://github.com/Raku/old-issue-tracker/issues/3516
{
    my role 丁 { }
    ok ([] but 丁) ~~ 丁, 'Mix-in to item array works';
}

# https://github.com/Raku/old-issue-tracker/issues/3745
{
    my $x;
    lives-ok { $x = True but [1, 2] }, 'but with array literal on RHS works';
    is $x.Array, [1, 2], 'but with array literal provides a .Array method';
}
{
    my $x;
    lives-ok { $x = True but (1, 2).list }, 'but with (1, 2).list on RHS works';
    is $x.List, (1, 2).list, 'but with (1, 2).list provides a .List method';
}
{
    my $x;
    lives-ok { $x = True but (1, "x") }, 'but with (1, "2") on RHS works';
    is $x.Int, 1, 'but with (1, "x") provides a .Int method returning 1';
    is $x.Str, "x", 'but with (1, "x") provides a .Str method returning "x"';
}
throws-like 'True but (1, 1)', Exception, gist => { $^g ~~ /'Int'/ && $g ~~ /resolved/ },
    'True but (1, 1) gets Int conflict to resolve due to generating two Int methods';

# https://github.com/Raku/old-issue-tracker/issues/3238
{
    is (gather {} but role {})[0], Nil,
        'mixing roles into lazy lists does not fail (1)';
    is ((^Inf) but role {})[2], 2,
        'mixing roles into lazy lists does not fail (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/3407
{
    ok (Any but role { }) !=== (Any but role { }), 'anonymous roles are distinct';
}

# https://github.com/Raku/old-issue-tracker/issues/5163
{
    my $ì = Any but role { method Bool { True } }
    is $ì || 42, $ì, 'method Bool in mixin is used';
    my $òì = Any but role { submethod Bool { True } }
    is $òì || 42, $òì, 'submethod Bool in mixin is used';
}

# https://github.com/Raku/old-issue-tracker/issues/5242
{
    role Foo::Bar { };
    is (5 but Foo::Bar).^name, 'Int+{Foo::Bar}',
        "mixing in a role from a deeper namespace doesn't clobber the targets shortname";
}

# https://irclog.perlgeek.de/perl6/2017-02-25#i_14165034
{
    my role С { multi method foo( :$a!, ) {$a};
             multi method foo( :$b!, ) {$b + 10}
           };
    my class 갂 does С {}

    is 갂.foo( :a(2) ), 2, 'multi-dispatch mixin sanity';
    is 갂.foo( :b(3) ), 13, 'multi-dispatch mixin sanity';
}

# https://github.com/Raku/old-issue-tracker/issues/4547
{
    group-of 3 => 'can mixin Block with True' => {
        my $b = Block but True;
        lives-ok { $b.WHICH };
        ok $b ~~ Block;
        is so $b, True;
    }
    group-of 3 => 'can mixin Code with True' => {
        my $b = Code but True;
        lives-ok { $b.WHICH };
        ok $b ~~ Code;
        is so $b, True;
    }
}

cmp-ok sub () is nodal { }, &[~~], Callable,
  'can typecheck mixins of routines against Callable';

lives-ok {
    class { } but role { has $!foo is built(:bind) }
}, 'can mix in roles that use the "is built" trait at runtime';

# https://irclogs.raku.org/raku-dev/2025-03-15.html#11:41
{
    my $a = "NOT set";
    my role Е갨갨 { method foo() { $a = "set" } }
    my class 丁àс does Е갨갨 { };
    Е갨갨.new.foo;
    is $a, 'set', 'did the outer lexical assign in time';
}

# vim: expandtab shiftwidth=4
