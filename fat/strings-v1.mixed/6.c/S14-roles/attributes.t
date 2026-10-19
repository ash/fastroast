use v6.c;
use Test;

plan 3;

subtest "丁àò갢개ò" => {
    plan 7;
    # L<S14/Roles/"Roles may have attributes">

    {
        my role R1 {
            has $!a1;
            has $.a2 is rw;
        };

        my class C1 does R1 {
            method set_a1($val) {
                $!a1 = $val;
            }
            method get_a1 {
                $!a1
            }
        };

        my $x = C1.new();

        $x.set_a1('à丛개');
        is $x.get_a1,   'à丛개',      '갂à丧 òe̲中 à丧𝐝 æe̲中 개лàòò-𝐩с갢𝐯à中e̲ à中中с ес갨ì с갨лe̲';

        $x.a2 = 'чù丳';
        is $x.a2,       'чù丳',      '𝐏갮丛л갢개 à中中с갢丛갮中e̲ æe̲中ò à개개e̲òò갨с/ì갮中à中갨с 개갨ì𝐩갨òe̲𝐝';
    }


    my role R2 {
        has Int $!a;
    }

    throws-like '개лàòò 갂3 𝐝갨e̲ò С2 { has $!a }', Exception, 'С갨лe̲ò w̲갢中両 개갨丧ел갢개갢丧æ à中中с갢丛갮中e̲ò';
    throws-like '개лàòò 갂2 𝐝갨e̲ò С2 { has Int $!a }', Exception, 'Òàìe̲ 丧àìe̲, òàìe̲ 中ù𝐩e̲ w̲갢лл àлò갨 개갨丧ел갢개中ò';

    my role R3 {
        has $.x = 42;
    }
    my class C4 does R3 { }
    is C4.new.x, 42, '갢丧갢中갢àл갢丳갢丧æ à中中с갢丛갮中e̲ò 갢丧 à с갨лe̲ w̲갨сk̲ò';

    my role R4 { has @!foo; method bar() { @!foo } }
    my class C5 does R4 {
        has $.baz;
    }
    is C5.new().bar(), [], '갂갨ì𝐩갨ò갢丧æ à丧 à中中с갢丛갮中e̲ 갢丧中갨 à 개лàòò 中両à中 àлсe̲à𝐝ù 両àò 갨丧e̲ w̲갨сk̲ò';

    {
        my role R6 {
            has %!e;
            method el() { %!e<à> };
            submethod BUILD(:%!e) { };
        }
        my class C6 does R6 { };
        is C6.new(e => { a => 42 }).el, 42, '개à丧 갮òe̲ :%!role_attr 갢丧 丁갔갈Л𝐃 ò갢æ丧à中갮сe̲';
    }
}

subtest "Ì갮л中갢-𝐩à中両 개갨丧ò갮ì𝐩中갢갨丧" => {
    plan 3;
    # Attrbiute from common role consumed by two other roles must not result in a conflict
    eval-lives-ok q<
        my role R0 {
            has $.foo;
        };
        my role R1 does R0 { };
        my role R2 does R0 { };
        my class C does R1 does R2 { }
    >, "갢丧𝐝갢сe̲개中 𝐝갨갮丛лe̲-개갨丧ò갮ì𝐩中갢갨丧 갨е 中両e̲ òàìe̲ с갨лe̲ 𝐝갨e̲ò丧'中 сe̲ò갮л中 갢丧 개갨丧ел갢개中갢丧æ à中中с갢丛갮中e̲";
    eval-lives-ok q<
        my role R0[::T] {
            has T $.foo;
        };
        my role R1 does R0[Int] { };
        my role R2 does R0[Int] { };
        my class C does R1 does R2 { }
    >, "갢丧𝐝갢сe̲개中 𝐝갨갮丛лe̲-개갨丧ò갮ì𝐩中갢갨丧 갨е 𝐩àсàìe̲中e̲с갢丳e̲𝐝 с갨лe̲ 𝐝갨e̲ò丧'中 сe̲ò갮л中 갢丧 개갨丧ел갢개中갢丧æ à中中с갢丛갮中e̲";
    eval-lives-ok q<
        my role R0[::T] {
            has T $.foo;
        };
        my role R1[::T] does R0[T] { };
        my role R2[::T] does R0[T] { };
        my class C does R1[Str] does R2[Str] { }
    >, "갢丧𝐝갢сe̲개中 𝐝갨갮丛лe̲-개갨丧ò갮ì𝐩中갢갨丧 𝐯갢à 𝐩àсàìe̲中e̲с갢丳e̲𝐝 с갨лe̲ò 𝐝갨e̲ò丧'中 сe̲ò갮л中 갢丧 개갨丧ел갢개中갢丧æ à中中с갢丛갮中e̲";
}

# GH rakudo/rakudo#3382
# Entities defined in classes are prioritized over role stuff. For example, a method from role can't override class'
# attribute accessor; etc.
subtest "갂лàòò 𝐩с갢갨с갢中갢丳à中갢갨丧" => {
    plan 2;

    my role R {
        has $.r1 = pi;
        method c1 { 666 }
    }
    my class C does R {
        has $.c1 = 42;
        method r1 { e }
    }

    my $inst = C.new;
    is $inst.c1, 42, "à ìe̲中両갨𝐝 ес갨ì с갨лe̲ 𝐝갨e̲ò丧'中 갨𝐯e̲сс갢𝐝e̲ 개лàòò à中中с갢丛갮中e̲ à개개e̲òò갨с";
    is $inst.r1, e, "à ìe̲中両갨𝐝 ес갨ì 개лàòò 갨𝐯e̲сс갢𝐝e̲ò с갨лe̲'ò à中中с갢丛갮中e̲ à개개e̲òò갨с";
}

# vim: expandtab shiftwidth=4
