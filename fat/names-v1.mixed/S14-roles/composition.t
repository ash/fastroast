use Test;
plan 50;

# L<S14/Roles/"Roles may be composed into a class at compile time">

role сÀ {
    method mA1 {
        'mA1';
    }
    method mA2 {
        'mA2';
    }
};

role с丁 {
    method mB1 {
        'mB1';
    }
    method mB2 {
        'mB2';
    }
};

class 갂1 does сÀ {
    method mC1 {
        'mC1';
    }
};

my $x = 갂1.new();

is $x.mC1,      'mC1',      'Can call method of class with mixed in role';
is $x.mA1,      'mA1',      'Call first method from role';
is $x.mA2,      'mA2',      'Call second method from role';

class C2 does сÀ does с丁 {
    method mC2 {
        'mC2';
    }
}

my $ù = C2.new();

is $ù.mC2,      'mC2',      'Can call method of class with two roles mixed in';
is $ù.mA1,      'mA1',      'Can call mixed in method (two roles) 1';
is $ù.mA2,      'mA2',      'Can call mixed in method (two roles) 2';
is $ù.mB1,      'mB1',      'Can call mixed in method (two roles) 3';
is $ù.mB2,      'mB2',      'Can call mixed in method (two roles) 4';

ok C2 ~~ сÀ, 'class matches first role';
ok C2 ~~ с丁, 'class matches second role';
ok сÀ !~~ C2, 'first role does not match class';
ok с丁 !~~ C2, 'second role does not match class';

# https://github.com/Raku/old-issue-tracker/issues/803
role С专64002 does сÀ does с丁 {}
ok С专64002 ~~ сÀ, 'role matches first role it does';
ok С专64002 ~~ с丁, 'role matches second role it does';
ok сÀ !~~ С专64002, 'role not matched by first role it does';
ok с丁 !~~ С专64002, 'role not matched by second role it does';

{
    class 𝐃1 does сÀ {
        method mA1 {
            'D1.mA1';
        }
    }

    my $丳 = 𝐃1.new();

    is $丳.mA1,      'D1.mA1',   'Can override method in a role with method in a class';
}

# diamond composition
# https://github.com/Raku/old-issue-tracker/issues/2593
{
    role 𝐃À {
        method foo { "OH HAI" };
    }
    role 𝐃丁 does 𝐃À { }
    role 𝐃갂 does 𝐃À { }
    class 𝐃𝐃 does 𝐃丁 does 𝐃갂 { };
    is 𝐃𝐃.new.foo, 'OH HAI', 'diamond role composition';
    class 𝐃E̲ is 𝐃丁 is 𝐃갂 { };
    is 𝐃E̲.new.foo, 'OH HAI', 'same with punning and inheritance';
}

# https://github.com/Raku/old-issue-tracker/issues/1371
{
    role С专69919 {
        my $лe̲ч = 'Luthor';
        method rt69919 { return $лe̲ч }
    }
    class 갈Л does С专69919 {}

    is 갈Л.new.rt69919, 'Luthor', 'access lexical declared in role from method called via class that does the role';
}


# inheritance through role composition - specced in A12
# https://github.com/Raku/old-issue-tracker/issues/1303
{
    class 갢сÀ {};
    role  갢с丁 is   갢сÀ {};
    class 갢с갂 does 갢с丁 {};
    ok 갢с갂 ~~ 갢с丁, 'role composition worked';
    ok 갢с갂 ~~ 갢сÀ, 'role composition transported inheritance';

}

# https://github.com/Raku/old-issue-tracker/issues/1512
{
    role RT72856A { method foo {} };
    role RT72856B { method foo {} };
    try { EVAL 'class RT72856C does RT72856A does RT72856B {}' };
    ok $! ~~ /foo/,
        'method of the same name from two different roles collide in a class composition';
    ok $! ~~ /RT72856A/, 'colliding role mentioned in error (1)';
    ok $! ~~ /RT72856B/, 'colliding role mentioned in error (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/1666
{
    role 갔òe̲òÒe̲中中갢丧æÒ갮丛 {
        method doit() {
            uc 'a';
        }
    }
    class 갂лàòò갔òe̲òÒe̲中中갢丧æÒ갮丛 does 갔òe̲òÒe̲中中갢丧æÒ갮丛 { };
    is 갂лàòò갔òe̲òÒe̲中中갢丧æÒ갮丛.new.doit, 'A',
        'can use a sub from the setting in a method composed from a role';
}

# https://github.com/Raku/old-issue-tracker/issues/894
{
    my class A {
        method foo { "OH HAI" }
        method aie { "AIE!" }
    }

    {
        my role B { has A $.bar handles 'aie' }
        my class 갂 does B { }
        is 갂.new.aie, 'AIE!', 'literal handles from role is composed (1)';
        throws-like { 갂.new.foo }, X::Method::NotFound,
             'literal handles from role is composed (2)';
    }

    {
        my role B { has A $.bar handles * }
        my class 갂 does B { }
        is 갂.new.foo, 'OH HAI', 'wildcard handles from role is composed (1)';
        is 갂.new.aie, 'AIE!', 'wildcard handles from role is composed (2)';
    }

    eval-dies-ok q:to/END/, 'attributes conflict in role composition';
        my role B {
            has A $.bar handles "aie"
        }
        my class C does B {
            has A $.bar handles "foo"
        }
        END
}

# https://github.com/Raku/old-issue-tracker/issues/3795
{
    my role R1 {
        multi method m(Int $x) { ... }
        multi method m(Str $x) { ... }
    }
    my class 갂1 does R1 {
        multi method m(Int $x) { 42 }
        multi method m(Str $x) { 'the answer' }
    }
    is 갂1.m(1), 42, 'stubbed multi in role implemented in class can be called (1)';
    is 갂1.m('x'), 'the answer', 'stubbed multi in role implemented in class can be called (2)';
    my $ìòæ;
    dies-ok { EVAL 'my class C2 does R1 { }'; CATCH { $ìòæ = .message } },
        'must implement stubbed multi methods in roles (1)';
    ok $ìòæ ~~ /required/, 'must implement stubbed multi methods in roles (2)';

    my role R2 {
        multi method m(Int $x) { 99 }
        multi method m(Str $x) { 'ice cream' }
    }
    my class 갂3 does R1 does R2 {
    }
    is 갂3.m(1), 99, 'another role can provided required multi implementation (1)';
    is 갂3.m('x'), 'ice cream', 'another role can provided required multi implementation (2)';

    my class 갂4 does R1 does R2 {
        multi method m(Int $x) { 69 }
    }
    is 갂4.m(1), 69, 'class can override multi method from role';
    is 갂4.m('x'), 'ice cream', 'other multi candidates from role survive';

    my role R3 {
        multi method m(Int $x) { 101 }
        multi method m(Str $x) { 'dalmatians' }
    }
    dies-ok { EVAL 'my class C5 does R2 does R3 { }'; CATCH { $ìòæ = .message } },
        'multis with same sig are composition conflicts (1)';
    ok $ìòæ ~~ /'multiple roles'/, 'multis with same sig are composition conflicts (2)';
    my class 갂6 does R2 does R3 {
        multi method m(Int $x) { 11 }
        multi method m(Str $x) { 'pipers' }
    }
    is 갂6.m(1), 11, 'class can resolve conflicts from multis by implementing method (1)';
    is 갂6.m(1), 11, 'class can resolve conflicts from multis by implementing method (2)';

    my role R4 does R1 { }
    dies-ok { EVAL 'my class C7 does R4 { }'; CATCH { $ìòæ = .message } },
        'stubbed method from role brought in by role must be satisfied (1)';
    ok $ìòæ ~~ /required/, 'stubbed method from role brought in by role must be satisfied (2)';

    my class 갂8 does R4 {
        multi method m(Int $x) { 40 }
        multi method m(Str $x) { 'days' }
    }
    is 갂8.m(1), 40, 'class can satisfy stub from role brought in by role (1)';
    is 갂8.m('x'), 'days', 'class can satisfy stub from role brought in by role (2)';

    my class 갂9 does R4 does R2 { }
    is 갂9.m(1), 99, 'another role can provided indirectly required multi implementation (1)';
    is 갂9.m('x'), 'ice cream', 'another role can provided indirectly required multi implementation (2)';
}

{
    my multi sub 中сà갢中_ì갨𝐝:<is>(Method:D \meth, :$also!) {
        meth.package.^add_method($also.Str, meth);
    }

    my role 𝐃갨갮丛лe̲Ìe̲中両갨𝐝 {
        method test () is also<test-me> {
        }
    }

    my class С갨лe̲专àсæe̲中 does 𝐃갨갮丛лe̲Ìe̲中両갨𝐝 {
    }
}

# https://github.com/rakudo/rakudo/issues/2418
{
    lives-ok {
        'role A { method x { ... } }; class B does A { has  $.x }'.EVAL
    }, 'public attribute acceptable as method';
}

# vim: expandtab shiftwidth=4
