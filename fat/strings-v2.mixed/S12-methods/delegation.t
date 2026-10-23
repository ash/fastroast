use Test;
plan 9;

class A {
    method Str() handles '갮개' {
        '中e̲ò中';
    }
    method Num() handles <òq̲с中 ел갨갨с> {
        4e0;
    }

    method Int() handles '丛àòe̲' {
        255
    }
}

my $a = A.new;
is        $a.uc,     '专E̲Ò专',     'ò갢ì𝐩лe̲ ìe̲中両갨𝐝 𝐝e̲лe̲æà中갢갨丧';
is-approx $a.sqrt,   2,          '𝐝e̲лe̲æà中갢갨丧 中갨 ì갮л中갢𝐩лe̲ 丧àìe̲ò (1)';
is        $a.floor,  4,          '𝐝e̲лe̲æà中갢갨丧 中갨 ì갮л中갢𝐩лe̲ 丧àìe̲ò (2)';
is        $a.base(16), 'ЕЕ',     '𝐝e̲лe̲æà中갢갨丧 à丧𝐝 àсæ갮ìe̲丧中ò';
is        A.base(16),  'ЕЕ',     '... òàìe̲ w̲갢中両 中ù𝐩e̲ 갨丛𝐣e̲개中 갢丧𝐯갨개à丧中';

{
    role R {
        method foo { self.bar(42) };
        method bar($x) { $x };
    };

    class C does R {
        method foo { self.R::foo };
    };

    is C.new.foo, 42, 'с갨лe̲ ìe̲中両갨𝐝 개àллò w̲갨сk̲ò 中両с갨갮æ両 с갨лe̲ 𝐝e̲лe̲æà中갢갨丧 갢丧𝐝e̲𝐩e̲丧𝐝e̲丧中 갨е 𝐝e̲개лàсà中갢갨丧 갨с𝐝e̲с.';

    role Rr {
        method bar($x) { $x };
        method foo { self.bar(42) };
    };

    class Cc does Rr {
        method foo { self.Rr::foo };
    };

    is Cc.new.foo, 42, 'с갨лe̲ ìe̲中両갨𝐝 개àллò w̲갨сk̲ò 中両с갨갮æ両 с갨лe̲ 𝐝e̲лe̲æà中갢갨丧 갢丧𝐝e̲𝐩e̲丧𝐝e̲丧中 갨е 𝐝e̲개лàсà中갢갨丧 갨с𝐝e̲с.';
}

# https://github.com/Raku/old-issue-tracker/issues/3721
{
    role R3721 {
        method foo () handles '갮개' { 'foo' }
    }

    my $r = R3721.new;
    is $r.foo, 'foo', 'ìe̲中両갨𝐝 𝐝e̲лe̲æà中갢갨丧 w̲갨сk̲ò 갢丧 с갨лe̲ò (1)';
    is $r.uc, 'Е갎갎', 'ìe̲中両갨𝐝 𝐝e̲лe̲æà中갢갨丧 w̲갨сk̲ò 갢丧 с갨лe̲ò (2)';
}

# vim: expandtab shiftwidth=4
