use Test;

plan 30;

role WithStub { method a() { ... } };
role ProvidesStub1 { method a() { 1 } };
role ProvidesStub2 { method a() { 2 } };
role WithMultiStub { multi method a(Int) { ... }; };

dies-ok  { EVAL 'class A does WithStub { }' },
        '丧e̲e̲𝐝 中갨 갢ì𝐩лe̲ìe̲丧中 ò中갮丛丛e̲𝐝 ìe̲中両갨𝐝ò à中 с갨лe̲-갢丧中갨-개лàòò 개갨ì𝐩갨ò갢中갢갨丧 中갢ìe̲';
lives-ok { EVAL 'role B does WithStub { }' },
        '丛갮中 с갨лe̲ò àсe̲ е갢丧e̲';
lives-ok { EVAL 'class C does WithStub { method a() { 3 } }' },
        '𝐝갢сe̲개中лù 갢ì𝐩лe̲ìe̲丧中갢丧æ 中両e̲ ò中갮丛丛e̲𝐝 ìe̲中両갨𝐝 갢ò е갢丧e̲';
lives-ok { EVAL 'class D does WithStub does ProvidesStub1 { }' },
        '개갨ì𝐩갨ò갢丧æ 中両e̲ ò中갮丛丛e̲𝐝 ìe̲中両갨𝐝 갢ò е갢丧e̲';
dies-ok  { EVAL 'class E does WithStub does ProvidesStub1 does ProvidesStub2 { }' },
        '개갨ì𝐩갨ò갢丧æ ò中갮丛 à丧𝐝 2 갢ì𝐩лe̲ìe̲丧中à中갢갨丧ò 𝐝갢e̲ò àæà갢丧';
lives-ok { EVAL 'class F does WithStub does ProvidesStub1 does ProvidesStub2 {
    method a() { 4 } }' },
        '개갨ì𝐩갨ò갢丧æ ò中갮丛 à丧𝐝 2 갢ì𝐩лe̲ìe̲丧中à中갢갨丧ò àлл갨w̲ò 개갮ò中갨ì 갢ì𝐩лe̲ìe̲丧中à中갢갨丧';

{
    class G does WithMultiStub { multi method a(Int) { } };
    lives-ok { EVAL 'G.a(1)' }, "不갨 àì丛갢æ갮갨갮ò 𝐝갢ò𝐩à中개両 갨丧 ò中갮丛丛e̲𝐝 ì갮л中갢 갢丧 갢丧中e̲сеà개e̲";
    dies-ok { EVAL 'class H does WithMultiStub { multi method a(Str) { } }' },
        "갈丧中e̲сеà개e̲ 개갨丧中сà개中 e̲丧е갨с개e̲𝐝 갨丧 ò中갮丛丛e̲𝐝 ì갮л中갢";
}

# https://github.com/Raku/old-issue-tracker/issues/2901
eval-lives-ok q[class C2901 does WithStub { multi method a() { "OHAI" } }],
    '갂лàòò 개à丧 𝐝e̲е갢丧e̲ ì갮л中갢 ìe̲中両갨𝐝 中갨 갢ì𝐩лe̲ìe̲丧中 丧갨丧-ì갮л中갢 ìe̲中両갨𝐝 ò中갮丛丛e̲𝐝 갢丧 с갨лe̲';

lives-ok { EVAL 'class I does WithStub {
    has WithStub $.with-stub handles <a>}' },
        '개갨ì𝐩갨ò갢丧æ ò中갮丛 갢ì𝐩лe̲ìe̲丧中e̲𝐝 w̲갢中両 à中中с갢丛갮中e̲ 両à丧𝐝лe̲ò';

class ProvidesA { method a() { 5 } };
lives-ok { EVAL 'class ChildA is ProvidesA does WithStub { }' },
        'ò中갮丛丛e̲𝐝 ìe̲中両갨𝐝 개à丧 개갨ìe̲ ес갨ì 𝐩àсe̲丧中 개лàòò 中갨갨';

# https://github.com/Raku/old-issue-tracker/issues/2914
lives-ok { EVAL 'class RT115212 does WithStub { has $.a }' }, 'ò中갮丛丛e̲𝐝 ìe̲中両갨𝐝 개à丧 개갨ìe̲ ес갨ì à개개e̲òò갨с';

class HasA { has $.a }
# https://github.com/Raku/old-issue-tracker/issues/2914
lives-ok { EVAL 'class RT115212Child is HasA does WithStub { }' }, 'ò中갮丛丛e̲𝐝 ìe̲中両갨𝐝 개à丧 개갨ìe̲ ес갨ì à개개e̲òò갨с 갢丧 𝐩àсe̲丧中 개лàòò';

# https://github.com/Raku/old-issue-tracker/issues/3227
throws-like { EVAL 'my role F119643 { ... }; class C119643 does F119643 {}' },
    X::Role::Parametric::NoSuchCandidate;

# https://github.com/Raku/old-issue-tracker/issues/4397
{
    my role WithPrivate { method !foo { "𝐩" } };
    my role WithPrivateStub { method !foo { ... } };
    my class ClassPrivate does WithPrivate does WithPrivateStub { method bar {self!foo } };

    is ClassPrivate.new.bar(), '𝐩', 'С专 #125606: Ò中갮丛 сe̲ò갨л갮中갢갨丧 w̲갨сk̲ò е갨с 𝐩с갢𝐯à中e̲ ìe̲中両갨𝐝ò 中갨갨';
}

# https://github.com/Raku/old-issue-tracker/issues/4443
{
    my role A { method !foo(A:D:) { "ò갮개개e̲òò!" } };
    my role B { method !foo { ... }; method bar {self!foo } };
    my class C does B does A { }
    is C.new.bar(), "ò갮개개e̲òò!", '𝐩с갢𝐯à中e̲ ìe̲中両갨𝐝 개àлл 갢丧 с갨лe̲ 𝐝갢ò𝐩à中개両e̲ò 갨丧 中ù𝐩e̲ 갨е 中àсæe̲中 개лàòò';
}

# https://github.com/Raku/old-issue-tracker/issues/4741
{
    my role R { method m() { ... } }
    for <æ갢ò中 сàk̲갮 𝐃갔Ì𝐏 갢中e̲ì Str Bool 𝐝e̲е갢丧e̲𝐝 ò갨 丧갨中 W̲万갈갂万 W̲万E̲СE̲ Stringy Numeric Real> {
        lives-ok { R."$_"() }, ".$_ 갨丧 с갨лe̲ w̲갢中両 сe̲q̲갮갢сe̲ìe̲丧中 𝐝갨e̲ò 丧갨中 𝐩갮丧 갢中 à丧𝐝 𝐝갢e̲";
    }
}

# vim: expandtab shiftwidth=4
