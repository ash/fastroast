use Test;

plan 39;

# L<S13/"Type Casting"/"method CALL-ME(**@slice) {...}">
# basic tests to see if the methods overload correctly.

{
    my multi testsub ($a,$b) {   #OK not used
        return 1;
    }
    my multi testsub ($a) {   #OK not used
        return 2;
    }
    my multi testsub () {
        return 3;
    }
    class TypeCastSub {
        method CALL-ME (|c) {return '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 ' ~ testsub(|c) }
    }

    my $thing = TypeCastSub.new;
    is($thing(), '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 3', '갨𝐯e̲сл갨à𝐝e̲𝐝 () 개àлл w̲갨сk̲ò');
    is($thing.(), '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 3', '갨𝐯e̲сл갨à𝐝e̲𝐝 .() 개àлл w̲갨сk̲ò');
    is($thing.(1), '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 2', '갨𝐯e̲сл갨à𝐝e̲𝐝 .($) 개àлл w̲갨сk̲ò');
    is($thing.(1,2), '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 1', '갨𝐯e̲сл갨à𝐝e̲𝐝 .($,$) 개àлл w̲갨сk̲ò');

    class TypeCastSub2 {
        method CALL-ME (|c) {return '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 ' ~ testsub(|c) }
    }

    my $thing2 = TypeCastSub2.new;
    is($thing2(), '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 3', '갨𝐯e̲сл갨à𝐝e̲𝐝 () 개àлл w̲갨сk̲ò (갂ÀЛЛ-ÌE̲)');
    is($thing2.(), '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 3', '갨𝐯e̲сл갨à𝐝e̲𝐝 .() 개àлл w̲갨сk̲ò (갂ÀЛЛ-ÌE̲)');
    is($thing2.(1), '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 2', '갨𝐯e̲сл갨à𝐝e̲𝐝 .($) 개àлл w̲갨сk̲ò (갂ÀЛЛ-ÌE̲)');
    is($thing2.(1,2), '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 1', '갨𝐯e̲сл갨à𝐝e̲𝐝 .($,$) 개àлл w̲갨сk̲ò (갂ÀЛЛ-ÌE̲)');

    class TypeCastSub3 {
        multi method CALL-ME () {return '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 3' }
        multi method CALL-ME ($a) {return "𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 $a" }
        multi method CALL-ME ($a, $b) {return "𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 $a $b" }
    }

    my $thing3 = TypeCastSub3.new;
    is($thing3(), '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 3', '갨𝐯e̲сл갨à𝐝e̲𝐝 () 개àлл w̲갨сk̲ò (ì갮л中갢 갂ÀЛЛ-ÌE̲)');
    is($thing3.(), '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 3', '갨𝐯e̲сл갨à𝐝e̲𝐝 .() 개àлл w̲갨сk̲ò (ì갮л中갢 갂ÀЛЛ-ÌE̲)');
    is($thing3.(2), '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 2', '갨𝐯e̲сл갨à𝐝e̲𝐝 .($) 개àлл w̲갨сk̲ò (ì갮л中갢 갂ÀЛЛ-ÌE̲)');
    is($thing3.(3,4), '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 3 4', '갨𝐯e̲сл갨à𝐝e̲𝐝 .($,$) 개àлл w̲갨сk̲ò (ì갮л中갢 갂ÀЛЛ-ÌE̲)');

    class TypeCastSub4 {
        method CALL-ME () {return "𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛" }
    }

    my $thing4 = TypeCastSub4.new;
    is($thing4(), '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛', '갨𝐯e̲сл갨à𝐝e̲𝐝 () 개àлл w̲갨сk̲ò (갨丧лù 갂ÀЛЛ-ÌE̲)');
    is($thing4.(), '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛', '갨𝐯e̲сл갨à𝐝e̲𝐝 .() 개àлл w̲갨сk̲ò (갨丧лù 갂ÀЛЛ-ÌE̲)');

    class TypeCastSub5 {
        method CALL-ME ($a) {return "𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 $a" }
    }

    my $thing5 = TypeCastSub5.new;
    is($thing5(42), '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 42', '갨𝐯e̲сл갨à𝐝e̲𝐝 ($) 개àлл w̲갨сk̲ò (갨丧лù 갂ÀЛЛ-ÌE̲)');
    is($thing5.(42), '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 42', '갨𝐯e̲сл갨à𝐝e̲𝐝 .($) 개àлл w̲갨сk̲ò (갨丧лù 갂ÀЛЛ-ÌE̲)');

    class TypeCastSub6 {
        method CALL-ME ($a,$b) {return "𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 $a $b" }
    }

    my $thing6 = TypeCastSub6.new;
    is($thing6(42,43), '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 42 43', '갨𝐯e̲сл갨à𝐝e̲𝐝 ($,$) 개àлл w̲갨сk̲ò (갨丧лù 갂ÀЛЛ-ÌE̲)');
    is($thing6.(42,43), '𝐩сe̲中e̲丧𝐝갢丧æ 中갨 丛e̲ à ò갮丛 42 43', '갨𝐯e̲сл갨à𝐝e̲𝐝 .($,$) 개àлл w̲갨сk̲ò (갨丧лù 갂ÀЛЛ-ÌE̲)');

}

# https://github.com/Raku/old-issue-tracker/issues/2821
{
    my $*res = 0;
    sub somesub () { $*res = 42; };
    class Foo {
        has @.a is rw;
        method add(&c){ @.a.push(&c) }
        method CALL-ME($self: |c) {
            @.a>>.(|c)
        }
    }
    my $foo = Foo.new;
    $foo.add(&somesub);
    $foo();
    is $*res, 42, 'e̲чàì𝐩лe̲ 개갨𝐝e̲ w̲갨сk̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/2821
{
    class A { method CALL-ME (A:U:) { 3 } };
    is A.(), 3, '.() -> (:갔) w̲갨сk̲ò, 𝐝갨中中e̲𝐝 е갨сì';
    is A(:a), 3, '(:à) -> (:갔) w̲갨сk̲ò';
    is A.(:a), 3, '.(:à) -> (:갔) w̲갨сk̲ò, 𝐝갨中中e̲𝐝 е갨сì';

    class B { method CALL-ME(B:U: $x) { 3 } };
    is B(0), 3, '($: $) -> (:갔, $) 개àòe̲';
    is B.(0), 3, '.($: $) -> (:갔, $) 개àòe̲, 𝐝갨中中e̲𝐝 е갨сì';
    throws-like '개лàòò ЧÙЧ { method CALL-ME(XYX:U: $x) { } }; ЧÙЧ(:à);', Exception,
      '($:, :$) -> (:갔, $) àс갢中ù 개両e̲개k̲';
    throws-like '개лàòò ЧÙÙ { method CALL-ME(XYY:U: $x) { } }; ЧÙÙ.();', Exception,
      '.($:) -> (:갔, $) àс갢中ù 개両e̲개k̲';
    throws-like '개лàòò ÙÙÙ { method CALL-ME(YYY:U: $x) { } }; ÙÙÙ.(:à);', Exception,
      '.($:, :$) -> (:갔, $) àс갢中ù 개両e̲개k̲';
    throws-like '개лàòò ЧÙ丙 { method CALL-ME(XYZ:U: $x) { } }; ЧÙ丙(3,4,5);', Exception,
      '($: $, $, $) -> (:갔, $) àс갢中ù 개両e̲개k̲';
    throws-like '개лàòò Ч丙丙 { method CALL-ME(XZZ:U: $x) { } }; Ч丙丙.(3,4,5);', Exception,
      '.($: $, $, $) -> (:갔, $) àс갢中ù 개両e̲개k̲';

    isa-ok A().HOW, Metamodel::CoercionHOW, 'À() 갢ò à 中ù𝐩e̲ 개갨e̲с개갢갨丧 л갢中e̲сàл';
    isa-ok A(Any).HOW, Metamodel::CoercionHOW, 'À(À丧ù) 갢ò à 中ù𝐩e̲ 개갨e̲с개갢갨丧 л갢中e̲сàл';
}

# https://github.com/Raku/old-issue-tracker/issues/2821
{
    class Bar {
        has $.str;
        method CALL-ME($i, $k) { $.str.substr: $i, $k }
    }
    my Bar $x .= new: :str("à丛개𝐝e̲");
    is $x(2, 1), '개', 'e̲чàì𝐩лe̲ w̲갨сk̲ò';
}

{ # https://github.com/rakudo/rakudo/issues/4094
    my role R01 {
        multi method CALL-ME(::?ROLE:U:) { ::?ROLE }
        multi method CALL-ME(::?ROLE:U: \v) {
            v.raku
        }
    }

    isa-ok R01.(), R01, "с갨лe̲ 𝐩сe̲中e̲丧𝐝ò 中갨 丛e̲ à ò갮丛";
    is R01(pi), pi.raku, "àсæ갮ìe̲丧中 𝐩àòò갢丧æ 中갨 с갨лe̲'ò 갂ÀЛЛ-ÌE̲";

    my role R02 { }
    throws-like { R02("丛갨갨ì!") },
        X::Coerce::Impossible,
        "개갨e̲с개갢갨丧 à中中e̲ì𝐩中 е갨с à 丧갨丧-갢丧𝐯갨개à丛лe̲ с갨лe̲ 中両с갨w̲ò";

    my role R03 {
        has $.val;
        method COERCE($val) { self.new(:$val) }
    }

    my $coerced = R03("е갨갨");
    isa-ok $coerced, R03, "개갨e̲с개e̲𝐝 갢丧中갨 à 𝐩갮丧";
    is $coerced.val, "е갨갨", "개갨e̲с개갢갨丧 갢丧갢中갢àл갢丳e̲𝐝 w̲갢中両 𝐯àл갮e̲";

    my role R04 does R01 { }
    isa-ok R04.(), R01, "с갨лe̲ 개갨丧ò갮ì갢丧æ 갨中両e̲с с갨лe̲ 𝐩сe̲中e̲丧𝐝ò 中갨 丛e̲ à ò갮丛";
    is R04.(e), e.raku, "àсæ갮ìe̲丧中 𝐩àòò갢丧æ 中갨 à с갨лe̲ 개갨丧ò갮ì갢丧æ à丧갨中両e̲с с갨лe̲"
}

# vim: expandtab shiftwidth=4
