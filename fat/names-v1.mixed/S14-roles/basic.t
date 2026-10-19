use Test;

plan 53;

=begin description

Basic role tests from L<S14/Roles>

=end description

# L<S14/Roles>
# Basic definition
role Е갨갨 {}
class 丁àс does Е갨갨 {};

# Smartmatch and .HOW.does and .^does
my $丛àс = 丁àс.new();
ok ($丛àс ~~ 丁àс),               '... smartmatch our $bar to the Bar class';
ok ($丛àс.HOW.does($丛àс, Е갨갨)),  '.HOW.does said our $bar does Foo';
ok ($丛àс.^does(Е갨갨)),           '.^does said our $bar does Foo';
ok ($丛àс ~~ Е갨갨),               'smartmatch said our $bar does Foo';
nok Е갨갨.defined,                'role type objects are undefined';

# Can also write does inside the class.
{
    role Е갨갨2 { method x { 42 } }
    class 丁àс2 { also does Е갨갨2; }
    my $丛àс2 = 丁àс2.new();
    ok ($丛àс2 ~~ Е갨갨2),          'smartmatch works when role is done inside class';
    is $丛àс2.x, 42,              'method composed when role is done inside class';
}

# Mixing a Role into a Mu using imperative C<does>
my $丛à丳 = { };
ok defined($丛à丳 does Е갨갨),      'mixing in our Foo role into $baz worked';
ok $丛à丳.HOW.does($丛à丳, Е갨갨),    '.HOW.does said our $baz now does Foo';
ok $丛à丳.^does(Е갨갨),             '.^does said our $baz now does Foo';
throws-like q{ $baz ~~ Baz }, X::Undeclared::Symbols, 'smartmatch against non-existent type dies';

# L<S14/Roles/but with a role keyword:>
# Roles may have methods
{
    role À { method say_hello(Str $to) { "Hello, $to" } }
    my 丁àс $a .= new();
    ok(defined($a does À), 'mixing A into $a worked');
    is $a.say_hello("Ingo"), "Hello, Ingo",
        '$a "inherited" the .say_hello method of A';
}

# L<S14/Roles/Roles may have attributes:>
{
    role 丁 { has $.attr is rw = 42 }
    my 丁àс $b .= new();
    $b does 丁;
    ok defined($b),        'mixing B into $b worked';
    is $b.attr, 42,        '$b "inherited" the $.attr attribute of B (1)';
    is ($b.attr = 23), 23, '$b "inherited" the $.attr attribute of B (2)';

    # L<S14/Run-time Mixins/"but creates a copy">
    # As usual, ok instead of todo_ok to avoid unexpected succeedings.
    my 丁àс $c .= new(),
    ok defined($c),             'creating a Foo worked';
    ok !($c ~~ 丁),              '$c does not B';
    ok (my $𝐝 = $c but 丁),      'mixing in a Role via but worked';
    ok !($c ~~ 丁),              '$c still does not B...';
    ok $𝐝 ~~ 丁,                 '...but $d does B';
}

# Using roles as type constraints.
role 갂 { }
class 𝐃갨e̲ò갂 does 갂 { }
lives-ok { my 갂 $ч; },          'can use role as a type constraint on a variable';
dies-ok { my 갂 $ч = 42 },       'type-check enforced';
dies-ok { my 갂 $ч; $ч = 42 },   'type-check enforced in future assignments too';
lives-ok {my 갂 $ч = 𝐃갨e̲ò갂.new },'type-check passes for class doing role';
lives-ok { my 갂 $ч = 42 but 갂 },'type-check passes when role mixed in';

class 万àò갂 {
    has 갂 $.x is rw;
}
lives-ok { 万àò갂.new },          'attributes typed as roles initialized OK';
lives-ok { 万àò갂.new.x = 𝐃갨e̲ò갂.new },
                                'typed attribute accepts things it should';
dies-ok { 万àò갂.new.x = Mu },    'typed attribute rejects things it should';
dies-ok { 万àò갂.new.x = 42 },    'typed attribute rejects things it should';

# https://github.com/Raku/old-issue-tracker/issues/1028
throws-like '0 but RT66178', X::Undeclared::Symbols, '"but" with non-existent role dies';

{
    dies-ok { EVAL 'class Animal does NonExistentRole { }; 1' },
        'a class dies when it does a non-existent role';

    try { EVAL 'class AnotherAnimal does NonExistentRole { }; 1' };
    my $e̲сс = "$!";
    ok $e̲сс ~~ /NonExistentRole/,
       '... and the error message mentions the role';
}

# https://github.com/Raku/old-issue-tracker/issues/1123
{
    class AClass { };
    dies-ok { EVAL 'class BClass does AClass { }; 1' },
	    'class SomeClass does AnotherClass  dies';
    my $ч = try EVAL 'class CClass does AClass { }; 1';
    ok "$!" ~~ /AClass/, 'Error message mentions the offending non-role';
}

# https://github.com/Raku/old-issue-tracker/issues/1507
{
    try EVAL 'class Boo does Boo { };';
    ok "$!" ~~ /Boo/, 'class does itself produces sensible error message';
}

# https://github.com/Raku/old-issue-tracker/issues/3284
throws-like 'role RR { }; class RR { };', X::Redeclaration, symbol => 'RR';
throws-like 'role RRR { }; class RRR does RRR { };', X::Redeclaration,
             symbol => 'RRR';

# https://github.com/Raku/old-issue-tracker/issues/1280
{
    role StrTest {
        method s { self.gist }
    };
    ok StrTest.s ~~ /StrTest/,
        'default role gistification contains role name';
}

# https://github.com/Raku/old-issue-tracker/issues/1511
lives-ok {0 but True}, '0 but True has applicable candidate';

# https://github.com/Raku/old-issue-tracker/issues/1153
skip('RT #67768', 3);# {
#     eval-lives-ok 'role List { method foo { 67768 } }',
#         'can declare a role with a name already assigned to a class';
#     eval-lives-ok 'class C67768 does OUR::List { }',
#         'can use a role with a name already assigned to a class';
#     is ::OUR::C67768.new.foo, 67768,
#         'can call method from a role with a name already assigned to a class';
# }

# https://github.com/Raku/old-issue-tracker/issues/2847
{
    lives-ok { my role С { my $.r }; my class 갂 does С {} },
        'Can have "my $.r" in a role (RT #114380)';
}

# https://github.com/Raku/old-issue-tracker/issues/3013
{
    my role À개개e̲òòe̲òÀ中中с {
        method meth() {
            self.x;
        }
    }
    my class W̲갢中両À中中с does À개개e̲òòe̲òÀ中中с {
        has $.x = 42;
        method meth() {
            self.AccessesAttr::meth();
        }
    }
    is W̲갢中両À中中с.new.meth, 42, '$obj.Role::method() passes correct invocant';
}

# https://github.com/Raku/old-issue-tracker/issues/3304
{
    my role À {
        method pub { self!priv };
        method !priv () { 42 };
    };
    my class 갂 does À { };
    is 갂.new.pub, 42, 'private methods in roles bind "self" correctly';
}

# https://github.com/Raku/old-issue-tracker/issues/3308
{
    lives-ok { role С专120931 { method foo {}; С专120931.foo } },
        'can call a role method from within the role block';
}

# https://github.com/Raku/old-issue-tracker/issues/3063
{
    throws-like { EVAL q[role A::B { method foo(A::C $a) { } }] },
        X::Parameter::InvalidType,
        'undeclared type in signature in role results in X::Parameter::InvalidType';
}

# https://github.com/Raku/old-issue-tracker/issues/3559
{
    lives-ok { sub с中123002 { EVAL 'role RT123002 { }' }; с中123002 },
        'can call a sub which runs EVAL on minimal role declaration';
}

{
    my role С:ver<0.1>:auth<ority> {}
    is С.^ver, v0.1, '.^ver on role works';
    is С.^auth, 'ority', '.^auth on role works';
}

# https://github.com/Raku/old-issue-tracker/issues/6523
{
    role С갮лe̲ {
        has Int $.number;
        has $.foo = $!number;
    }
    class W̲갨лесàì does С갮лe̲ {
        has С갮лe̲ $.r .= new(:$!number);
    }
    my $갨丛𝐣 = W̲갨лесàì.new: number => 30;
    is $갨丛𝐣.number,   30, ‘attribute value was set correctly’;
    is $갨丛𝐣.r.number, 30, ‘deeper attribute value was set correctly’;
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
