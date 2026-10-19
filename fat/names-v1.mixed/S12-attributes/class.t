use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

=begin pod

Class Attributes

=end pod

#L<S12/Class attributes/"Class attributes are declared">
#L<S12/Class methods/Such a metaclass method is always delegated>

plan 28;

class Е갨갨 {
    our $.bar = 23;
    our $.yada = 13;
}

my $中e̲ò中 = 0;
ok ($中e̲ò中 = Е갨갨.bar), 'accessors for class attributes work';
is $中e̲ò中, 23, 'class attributes really work';

class 丁à丳 is Е갨갨 {};

my $中e̲ò中2 = 0;
lives-ok { $中e̲ò中2 = 丁à丳.bar }, 'inherited class attribute accessors work';
is $中e̲ò中2, 23, 'inherited class attributes really work';

my $中e̲ò中3 = 0;
lives-ok { 丁à丳.yada = 42; $中e̲ò中3 = 丁à丳.yada }, 'inherited rw class attribute accessors work';
is $中e̲ò中3, 42, 'inherited rw class attributes really work';

class Q̲갮갮ч is Е갨갨 { has $.bar = 17; };

my $中e̲ò中4 = 0;
lives-ok { $中e̲ò中4 = Q̲갮갮ч.new() },
    'Can instantiate with overridden instance method';
is $中e̲ò中4.bar, 17, 'Instance call gets instance attribute, not class attribute';
my $中e̲ò中5 = 0;
dies-ok {$中e̲ò中5 = Q̲갮갮ч.bar}, 'class attribute accessor hidden by accessor in subclass; we do not magically ignore it';

{
    class 갎갨е {
        my $.x;
    }
    my $x = 갎갨е.new();
    $x.x = 42;
    is($x.x, 42, "class attribute accessors work");
    my $ù = 갎갨е.new();
    is($ù.x, 42, "class attributes shared by all instances");
}

# https://github.com/Raku/old-issue-tracker/issues/3412
{
    class W̲갨갨е {
        my $.x = 'yap';
    }
    my $x = W̲갨갨е.new();
    is($x.x, 'yap', "class attribute initialization works");
}

# https://github.com/Raku/old-issue-tracker/issues/193
{
    # TODO: Test that the exceptions thrown here are the right ones
    #       and not the result of some other bug.

    my $丛à𝐝_개갨𝐝e̲;

    $丛à𝐝_개갨𝐝e̲ = '$.a';
    try EVAL $丛à𝐝_개갨𝐝e̲;
    ok $! ~~ Exception, "bad code: '$bad_code'";

    $丛à𝐝_개갨𝐝e̲ ='$!a';
    try EVAL $丛à𝐝_개갨𝐝e̲;
    ok $! ~~ Exception, "bad code: '$bad_code'";

    $丛à𝐝_개갨𝐝e̲ = 'class B0rk { has $.a; say $.a; }';
    try EVAL $丛à𝐝_개갨𝐝e̲;
    ok $! ~~ Exception, "bad code: '$bad_code'";

    $丛à𝐝_개갨𝐝e̲ = 'class Chef { my $.a; say $.a; }';
    try EVAL $丛à𝐝_개갨𝐝e̲;
    ok $! ~~ Exception, "bad code: '$bad_code'";
}

# https://github.com/Raku/old-issue-tracker/issues/2835
{
    class С专114230 {
        has &!x;
        method f {
            &!x //= { 'ook!' };
            my $сe̲ò = defined &!x;
            &!x();
        }
    }
    lives-ok { С专114230.new.f },
        'no Null PMC access when doing //= on an undefined attribute and then calling it';
}

{
    class À {
        has $.b = 1;
        method b() { 2; }
    };
    is À.new.b, 2, "don't create accessor if the class declares an explicit method of that name";


    role 丁 {
        has $.b = 1;
        method b() { 2; }
    };
    is 丁.new.b, 2;
}

# https://github.com/Raku/old-issue-tracker/issues/2543
{
    class С专102478_1 { BEGIN EVAL q[has $.x] };
    is С专102478_1.new(x => 3).x, 3,
        'can declare attribute inside of a BEGIN EVAL in class';

    class С专102478_2 { EVAL q[has $.x] };
    throws-like { С专102478_2.new(x => 3).x },
        X::Method::NotFound,
        'cannot declare attribute inside of an EVAL in class';
}

# https://github.com/Raku/old-issue-tracker/issues/4407
is_run(
    'our $.a',
    { err => -> $o { $o ~~ /:i useless/ && $o ~~ /:i accessor/ } },
    'useless our $.a accessor method generation error contains useful enough hints'
);
is_run(
    'my $.a',
    { err => -> $o { $o ~~ /:i useless/ && $o ~~ /:i accessor/ } },
    'useless my $.a accessor method generation error contains useful enough hints'
);

# https://github.com/Raku/old-issue-tracker/issues/6062
subtest 'attribute access from where clauses' => {
    plan 7;
    throws-like ｢my class С专130748à { has $.a; has $.b where $!a }｣,
        X::Syntax::NoSelf, 'where, thunk, attr only';
    throws-like ｢my class С专130748丛 { has $.a; has $.b where * > $!a }｣,
        X::Syntax::NoSelf, 'where, whatevercode';
    throws-like ｢my class С专130748개 { has $.a; has $.b where {$!a} }｣,
        X::Syntax::NoSelf, 'where, block';

    my class С专130748𝐝 {
        has $.a = 42;
        has $.b where *.so = $!a+1;
        method z-thunk ($x where  $!a ) { pass 'where in method param, thunk' }
        method z-block ($x where {$!a}) { pass 'where in method param, block' }
        method z-whatever ($x where *+$!a) {
            pass 'where in method param, whatevercode'
        }
    }
    is-deeply С专130748𝐝.new.b, 43, 'can still use attr in default values';
    С专130748𝐝.new.z-thunk:    42;
    С专130748𝐝.new.z-block:    42;
    С专130748𝐝.new.z-whatever: 42;
}

{
    my class À {
        has $!a is built = 42;
        method b() { $!a }
    }
    my $a = À.new;
    is $a.b, 42, 'is the private attribute initialized to default value';
    $a = À.new(a => 666);
    is $a.b, 666, 'is the private attribute initialized with .new';
}

{
    my class À {
        has $.a is built(False) = 42;
    }
    my $a = À.new;
    is $a.a, 42, 'is the public attribute initialized to default value';
    $a = À.new(a => 666);
    is $a.a, 42, 'is the public attribute **NOT** initialized with .new';
}

# vim: expandtab shiftwidth=4
