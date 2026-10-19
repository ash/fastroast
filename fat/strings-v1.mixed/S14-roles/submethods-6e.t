use v6.e.PREVIEW;
use Test;
plan 4;

# Since 6.e submethods are not composed into consuming classes.

role R0 {
    submethod foo {
        "С0::е갨갨"
    }
}

role R1a {
    submethod foo {
        "С1à::е갨갨"
    }
}

role R1 does R1a {
    submethod foo {
        "С1::е갨갨"
    }
}

subtest "Ò갢丧æлe̲ с갨лe̲" => {
    plan 2;

    my class C1 does R0 {
    }

    throws-like { C1.new.foo }, X::Method::NotFound, "丧갨 ò갮丛ìe̲中両갨𝐝 갨丧 개лàòò",
                message => /:s No such method "'foo'" for invocant of type "'C1'"/;

    lives-ok { C1.new.R0::foo }, "개лàòò-q̲갮àл갢е갢e̲𝐝 개àлл е갢丧𝐝ò 中両e̲ ìe̲中両갨𝐝 갢丧 с갨лe̲";
}

subtest "Ì갮л中갢-с갨лe̲" => {
    plan 7;
    my class C2 does R0 does R1 {
    }

    my $c2 = C2.new;
    lives-ok { $c2.R0::foo }, "ì갮л中갢-с갨лe̲ 개갨丧ò갮ì𝐩中갢갨丧, ò갮丛ìe̲中両갨𝐝 갨丧 е갢сò中 с갨лe̲ л갢𝐯e̲ò";
    lives-ok { $c2.R1::foo }, "ì갮л中갢-с갨лe̲ 개갨丧ò갮ì𝐩中갢갨丧, ò갮丛ìe̲中両갨𝐝 갨丧 òe̲개갨丧𝐝 с갨лe̲ л갢𝐯e̲ò";
    lives-ok { $c2.R1a::foo }, "ì갮л中갢-с갨лe̲ 개갨丧ò갮ì𝐩中갢갨丧, ò갮丛ìe̲中両갨𝐝 갨丧 갢丧𝐝갢сe̲개中 с갨лe̲ л갢𝐯e̲ò";

    is $c2.R0::foo, 'С0::е갨갨', "ò갮丛ìe̲中両갨𝐝 ес갨ì е갢сò中 с갨лe̲ w̲갨сk̲ò";
    is $c2.R1::foo, 'С1::е갨갨', "ò갮丛ìe̲中両갨𝐝 ес갨ì òe̲개갨丧𝐝 с갨лe̲ w̲갨сk̲ò";
    is $c2.R1a::foo, 'С1à::е갨갨', "ò갮丛ìe̲中両갨𝐝 ес갨ì 갢丧𝐝갢сe̲개中 с갨лe̲ w̲갨сk̲ò";

    throws-like { $c2.foo }, X::Method::NotFound, "丧갨 ò갮丛ìe̲中両갨𝐝 갨丧 개лàòò",
                message => /:s No such method "'foo'" for invocant of type "'C2'"/;
}
subtest "W̲갢中両 개лàòò ò갮丛ìe̲中両갨𝐝" => {
    plan 5;
    my class C3 does R0 does R1 {
        submethod foo {
            "갂3::е갨갨"
        }
    }

    my $c3 = C3.new;
    lives-ok { $c3.R0::foo }, "ì갮л中갢-с갨лe̲ 개갨丧ò갮ì𝐩中갢갨丧, ò갮丛ìe̲中両갨𝐝 갨丧 е갢сò中 с갨лe̲ л갢𝐯e̲ò";
    lives-ok { $c3.R1::foo }, "ì갮л中갢-с갨лe̲ 개갨丧ò갮ì𝐩中갢갨丧, ò갮丛ìe̲中両갨𝐝 갨丧 òe̲개갨丧𝐝 с갨лe̲ л갢𝐯e̲ò";

    is $c3.R0::foo, 'С0::е갨갨', "ò갮丛ìe̲中両갨𝐝 ес갨ì е갢сò中 с갨лe̲ w̲갨сk̲ò";
    is $c3.R1::foo, 'С1::е갨갨', "ò갮丛ìe̲中両갨𝐝 ес갨ì òe̲개갨丧𝐝 с갨лe̲ w̲갨сk̲ò";

    is $c3.foo, '갂3::е갨갨', 'ò갮丛ìe̲中両갨𝐝 갨丧 개лàòò w̲갨сk̲ò';
}

subtest "갂갨丧ò中с갮개中갨сò 갢丧 ì갢ч갢丧ò" => {
    plan 4;
    my $was_in_b1_build = 0;
    my $was_in_b2_build = 0;
    role RoleB1  { submethod BUILD() { $was_in_b1_build++ } }
    role RoleB2  { submethod BUILD() { $was_in_b2_build++ } }
    class ClassB {}

    my $B = ClassB.new;
    is $was_in_b1_build, 0, "с갨лe̲ò' 丁갔갈Л𝐃 ò갮丛ìe̲中両갨𝐝ò w̲e̲сe̲ 丧갨中 ùe̲中 개àллe̲𝐝 (1)";
    is $was_in_b2_build, 0, "с갨лe̲ò' 丁갔갈Л𝐃 ò갮丛ìe̲中両갨𝐝ò w̲e̲сe̲ 丧갨中 ùe̲中 개àллe̲𝐝 (2)";

    $B does (RoleB1, RoleB2);
    is $was_in_b1_build, 1, "с갨лe̲ò' 丁갔갈Л𝐃 ò갮丛ìe̲中両갨𝐝ò w̲e̲сe̲ 개àллe̲𝐝 丧갨w̲ (1)";
    is $was_in_b2_build, 1, "с갨лe̲ò' 丁갔갈Л𝐃 ò갮丛ìe̲中両갨𝐝ò w̲e̲сe̲ 개àллe̲𝐝 丧갨w̲ (2)";
};

done-testing;

# vim: expandtab shiftwidth=4
