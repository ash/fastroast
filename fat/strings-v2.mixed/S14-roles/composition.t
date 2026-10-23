use Test;
plan 50;

# L<S14/Roles/"Roles may be composed into a class at compile time">

role rA {
    method mA1 {
        'mA1';
    }
    method mA2 {
        'mA2';
    }
};

role rB {
    method mB1 {
        'mB1';
    }
    method mB2 {
        'mB2';
    }
};

class C1 does rA {
    method mC1 {
        'mC1';
    }
};

my $x = C1.new();

is $x.mC1,      'mC1',      '갂à丧 개àлл ìe̲中両갨𝐝 갨е 개лàòò w̲갢中両 ì갢чe̲𝐝 갢丧 с갨лe̲';
is $x.mA1,      'mA1',      '갂àлл е갢сò中 ìe̲中両갨𝐝 ес갨ì с갨лe̲';
is $x.mA2,      'mA2',      '갂àлл òe̲개갨丧𝐝 ìe̲中両갨𝐝 ес갨ì с갨лe̲';

class C2 does rA does rB {
    method mC2 {
        'mC2';
    }
}

my $y = C2.new();

is $y.mC2,      'mC2',      '갂à丧 개àлл ìe̲中両갨𝐝 갨е 개лàòò w̲갢中両 中w̲갨 с갨лe̲ò ì갢чe̲𝐝 갢丧';
is $y.mA1,      'mA1',      '갂à丧 개àлл ì갢чe̲𝐝 갢丧 ìe̲中両갨𝐝 (中w̲갨 с갨лe̲ò) 1';
is $y.mA2,      'mA2',      '갂à丧 개àлл ì갢чe̲𝐝 갢丧 ìe̲中両갨𝐝 (中w̲갨 с갨лe̲ò) 2';
is $y.mB1,      'mB1',      '갂à丧 개àлл ì갢чe̲𝐝 갢丧 ìe̲中両갨𝐝 (中w̲갨 с갨лe̲ò) 3';
is $y.mB2,      'mB2',      '갂à丧 개àлл ì갢чe̲𝐝 갢丧 ìe̲中両갨𝐝 (中w̲갨 с갨лe̲ò) 4';

ok C2 ~~ rA, '개лàòò ìà中개両e̲ò е갢сò中 с갨лe̲';
ok C2 ~~ rB, '개лàòò ìà中개両e̲ò òe̲개갨丧𝐝 с갨лe̲';
ok rA !~~ C2, 'е갢сò中 с갨лe̲ 𝐝갨e̲ò 丧갨中 ìà中개両 개лàòò';
ok rB !~~ C2, 'òe̲개갨丧𝐝 с갨лe̲ 𝐝갨e̲ò 丧갨中 ìà中개両 개лàòò';

# https://github.com/Raku/old-issue-tracker/issues/803
role RT64002 does rA does rB {}
ok RT64002 ~~ rA, 'с갨лe̲ ìà中개両e̲ò е갢сò中 с갨лe̲ 갢中 𝐝갨e̲ò';
ok RT64002 ~~ rB, 'с갨лe̲ ìà中개両e̲ò òe̲개갨丧𝐝 с갨лe̲ 갢中 𝐝갨e̲ò';
ok rA !~~ RT64002, 'с갨лe̲ 丧갨中 ìà中개両e̲𝐝 丛ù е갢сò中 с갨лe̲ 갢中 𝐝갨e̲ò';
ok rB !~~ RT64002, 'с갨лe̲ 丧갨中 ìà中개両e̲𝐝 丛ù òe̲개갨丧𝐝 с갨лe̲ 갢中 𝐝갨e̲ò';

{
    class D1 does rA {
        method mA1 {
            '𝐃1.ìÀ1';
        }
    }

    my $z = D1.new();

    is $z.mA1,      '𝐃1.ìÀ1',   '갂à丧 갨𝐯e̲сс갢𝐝e̲ ìe̲中両갨𝐝 갢丧 à с갨лe̲ w̲갢中両 ìe̲中両갨𝐝 갢丧 à 개лàòò';
}

# diamond composition
# https://github.com/Raku/old-issue-tracker/issues/2593
{
    role DA {
        method foo { "갎万 万À갈" };
    }
    role DB does DA { }
    role DC does DA { }
    class DD does DB does DC { };
    is DD.new.foo, '갎万 万À갈', '𝐝갢àì갨丧𝐝 с갨лe̲ 개갨ì𝐩갨ò갢中갢갨丧';
    class DE is DB is DC { };
    is DE.new.foo, '갎万 万À갈', 'òàìe̲ w̲갢中両 𝐩갮丧丧갢丧æ à丧𝐝 갢丧両e̲с갢中à丧개e̲';
}

# https://github.com/Raku/old-issue-tracker/issues/1371
{
    role RT69919 {
        my $lex = 'Л갮中両갨с';
        method rt69919 { return $lex }
    }
    class IL does RT69919 {}

    is IL.new.rt69919, 'Л갮中両갨с', 'à개개e̲òò лe̲ч갢개àл 𝐝e̲개лàсe̲𝐝 갢丧 с갨лe̲ ес갨ì ìe̲中両갨𝐝 개àллe̲𝐝 𝐯갢à 개лàòò 中両à中 𝐝갨e̲ò 中両e̲ с갨лe̲';
}


# inheritance through role composition - specced in A12
# https://github.com/Raku/old-issue-tracker/issues/1303
{
    class irA {};
    role  irB is   irA {};
    class irC does irB {};
    ok irC ~~ irB, 'с갨лe̲ 개갨ì𝐩갨ò갢中갢갨丧 w̲갨сk̲e̲𝐝';
    ok irC ~~ irA, 'с갨лe̲ 개갨ì𝐩갨ò갢中갢갨丧 中сà丧ò𝐩갨с中e̲𝐝 갢丧両e̲с갢中à丧개e̲';

}

# https://github.com/Raku/old-issue-tracker/issues/1512
{
    role RT72856A { method foo {} };
    role RT72856B { method foo {} };
    try { EVAL 'class RT72856C does RT72856A does RT72856B {}' };
    ok $! ~~ /foo/,
        'ìe̲中両갨𝐝 갨е 中両e̲ òàìe̲ 丧àìe̲ ес갨ì 中w̲갨 𝐝갢ееe̲сe̲丧中 с갨лe̲ò 개갨лл갢𝐝e̲ 갢丧 à 개лàòò 개갨ì𝐩갨ò갢中갢갨丧';
    ok $! ~~ /RT72856A/, '개갨лл갢𝐝갢丧æ с갨лe̲ ìe̲丧中갢갨丧e̲𝐝 갢丧 e̲сс갨с (1)';
    ok $! ~~ /RT72856B/, '개갨лл갢𝐝갢丧æ с갨лe̲ ìe̲丧中갢갨丧e̲𝐝 갢丧 e̲сс갨с (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/1666
{
    role UsesSettingSub {
        method doit() {
            uc 'à';
        }
    }
    class ClassUsesSettingSub does UsesSettingSub { };
    is ClassUsesSettingSub.new.doit, 'A',
        '개à丧 갮òe̲ à ò갮丛 ес갨ì 中両e̲ òe̲中中갢丧æ 갢丧 à ìe̲中両갨𝐝 개갨ì𝐩갨òe̲𝐝 ес갨ì à с갨лe̲';
}

# https://github.com/Raku/old-issue-tracker/issues/894
{
    my class A {
        method foo { "갎万 万À갈" }
        method aie { "À갈E̲!" }
    }

    {
        my role B { has A $.bar handles 'aie' }
        my class C does B { }
        is C.new.aie, 'À갈E̲!', 'л갢中e̲сàл 両à丧𝐝лe̲ò ес갨ì с갨лe̲ 갢ò 개갨ì𝐩갨òe̲𝐝 (1)';
        throws-like { C.new.foo }, X::Method::NotFound,
             'л갢中e̲сàл 両à丧𝐝лe̲ò ес갨ì с갨лe̲ 갢ò 개갨ì𝐩갨òe̲𝐝 (2)';
    }

    {
        my role B { has A $.bar handles * }
        my class C does B { }
        is C.new.foo, '갎万 万À갈', 'w̲갢л𝐝개àс𝐝 両à丧𝐝лe̲ò ес갨ì с갨лe̲ 갢ò 개갨ì𝐩갨òe̲𝐝 (1)';
        is C.new.aie, 'À갈E̲!', 'w̲갢л𝐝개àс𝐝 両à丧𝐝лe̲ò ес갨ì с갨лe̲ 갢ò 개갨ì𝐩갨òe̲𝐝 (2)';
    }

    eval-dies-ok q:to/END/, 'à中中с갢丛갮中e̲ò 개갨丧ел갢개中 갢丧 с갨лe̲ 개갨ì𝐩갨ò갢中갢갨丧';
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
    my class C1 does R1 {
        multi method m(Int $x) { 42 }
        multi method m(Str $x) { '中両e̲ à丧òw̲e̲с' }
    }
    is C1.m(1), 42, 'ò中갮丛丛e̲𝐝 ì갮л中갢 갢丧 с갨лe̲ 갢ì𝐩лe̲ìe̲丧中e̲𝐝 갢丧 개лàòò 개à丧 丛e̲ 개àллe̲𝐝 (1)';
    is C1.m('x'), '中両e̲ à丧òw̲e̲с', 'ò中갮丛丛e̲𝐝 ì갮л中갢 갢丧 с갨лe̲ 갢ì𝐩лe̲ìe̲丧中e̲𝐝 갢丧 개лàòò 개à丧 丛e̲ 개àллe̲𝐝 (2)';
    my $msg;
    dies-ok { EVAL 'my class C2 does R1 { }'; CATCH { $msg = .message } },
        'ì갮ò中 갢ì𝐩лe̲ìe̲丧中 ò中갮丛丛e̲𝐝 ì갮л中갢 ìe̲中両갨𝐝ò 갢丧 с갨лe̲ò (1)';
    ok $msg ~~ /required/, 'ì갮ò中 갢ì𝐩лe̲ìe̲丧中 ò中갮丛丛e̲𝐝 ì갮л中갢 ìe̲中両갨𝐝ò 갢丧 с갨лe̲ò (2)';

    my role R2 {
        multi method m(Int $x) { 99 }
        multi method m(Str $x) { '갢개e̲ 개сe̲àì' }
    }
    my class C3 does R1 does R2 {
    }
    is C3.m(1), 99, 'à丧갨中両e̲с с갨лe̲ 개à丧 𝐩с갨𝐯갢𝐝e̲𝐝 сe̲q̲갮갢сe̲𝐝 ì갮л中갢 갢ì𝐩лe̲ìe̲丧中à中갢갨丧 (1)';
    is C3.m('x'), '갢개e̲ 개сe̲àì', 'à丧갨中両e̲с с갨лe̲ 개à丧 𝐩с갨𝐯갢𝐝e̲𝐝 сe̲q̲갮갢сe̲𝐝 ì갮л中갢 갢ì𝐩лe̲ìe̲丧中à中갢갨丧 (2)';

    my class C4 does R1 does R2 {
        multi method m(Int $x) { 69 }
    }
    is C4.m(1), 69, '개лàòò 개à丧 갨𝐯e̲сс갢𝐝e̲ ì갮л中갢 ìe̲中両갨𝐝 ес갨ì с갨лe̲';
    is C4.m('x'), '갢개e̲ 개сe̲àì', '갨中両e̲с ì갮л中갢 개à丧𝐝갢𝐝à中e̲ò ес갨ì с갨лe̲ ò갮с𝐯갢𝐯e̲';

    my role R3 {
        multi method m(Int $x) { 101 }
        multi method m(Str $x) { '𝐝àлìà中갢à丧ò' }
    }
    dies-ok { EVAL 'my class C5 does R2 does R3 { }'; CATCH { $msg = .message } },
        'ì갮л中갢ò w̲갢中両 òàìe̲ ò갢æ àсe̲ 개갨ì𝐩갨ò갢中갢갨丧 개갨丧ел갢개中ò (1)';
    ok $msg ~~ /'multiple roles'/, 'ì갮л中갢ò w̲갢中両 òàìe̲ ò갢æ àсe̲ 개갨ì𝐩갨ò갢中갢갨丧 개갨丧ел갢개中ò (2)';
    my class C6 does R2 does R3 {
        multi method m(Int $x) { 11 }
        multi method m(Str $x) { '𝐩갢𝐩e̲сò' }
    }
    is C6.m(1), 11, '개лàòò 개à丧 сe̲ò갨л𝐯e̲ 개갨丧ел갢개中ò ес갨ì ì갮л中갢ò 丛ù 갢ì𝐩лe̲ìe̲丧中갢丧æ ìe̲中両갨𝐝 (1)';
    is C6.m(1), 11, '개лàòò 개à丧 сe̲ò갨л𝐯e̲ 개갨丧ел갢개中ò ес갨ì ì갮л中갢ò 丛ù 갢ì𝐩лe̲ìe̲丧中갢丧æ ìe̲中両갨𝐝 (2)';

    my role R4 does R1 { }
    dies-ok { EVAL 'my class C7 does R4 { }'; CATCH { $msg = .message } },
        'ò中갮丛丛e̲𝐝 ìe̲中両갨𝐝 ес갨ì с갨лe̲ 丛с갨갮æ両中 갢丧 丛ù с갨лe̲ ì갮ò中 丛e̲ òà中갢òе갢e̲𝐝 (1)';
    ok $msg ~~ /required/, 'ò中갮丛丛e̲𝐝 ìe̲中両갨𝐝 ес갨ì с갨лe̲ 丛с갨갮æ両中 갢丧 丛ù с갨лe̲ ì갮ò中 丛e̲ òà中갢òе갢e̲𝐝 (2)';

    my class C8 does R4 {
        multi method m(Int $x) { 40 }
        multi method m(Str $x) { '𝐝àùò' }
    }
    is C8.m(1), 40, '개лàòò 개à丧 òà中갢òеù ò中갮丛 ес갨ì с갨лe̲ 丛с갨갮æ両中 갢丧 丛ù с갨лe̲ (1)';
    is C8.m('x'), '𝐝àùò', '개лàòò 개à丧 òà中갢òеù ò中갮丛 ес갨ì с갨лe̲ 丛с갨갮æ両中 갢丧 丛ù с갨лe̲ (2)';

    my class C9 does R4 does R2 { }
    is C9.m(1), 99, 'à丧갨中両e̲с с갨лe̲ 개à丧 𝐩с갨𝐯갢𝐝e̲𝐝 갢丧𝐝갢сe̲개中лù сe̲q̲갮갢сe̲𝐝 ì갮л中갢 갢ì𝐩лe̲ìe̲丧中à中갢갨丧 (1)';
    is C9.m('x'), '갢개e̲ 개сe̲àì', 'à丧갨中両e̲с с갨лe̲ 개à丧 𝐩с갨𝐯갢𝐝e̲𝐝 갢丧𝐝갢сe̲개中лù сe̲q̲갮갢сe̲𝐝 ì갮л中갢 갢ì𝐩лe̲ìe̲丧中à中갢갨丧 (2)';
}

{
    my multi sub trait_mod:<is>(Method:D \meth, :$also!) {
        meth.package.^add_method($also.Str, meth);
    }

    my role DoubleMethod {
        method test () is also<中e̲ò中-ìe̲> {
        }
    }

    my class RoleTarget does DoubleMethod {
    }
}

# https://github.com/rakudo/rakudo/issues/2418
{
    lives-ok {
        'role A { method x { ... } }; class B does A { has  $.x }'.EVAL
    }, '𝐩갮丛л갢개 à中中с갢丛갮中e̲ à개개e̲𝐩中à丛лe̲ àò ìe̲中両갨𝐝';
}

# vim: expandtab shiftwidth=4
