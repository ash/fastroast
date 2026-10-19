use Test;

plan 23;

=begin pod

Test attributes with recursively typed attributes

=end pod

#L<S12/Attributes>
{
    class A {
        has A $.attr is rw;
    };

    my A $a;
    my A $b;
    lives-ok {
        $a .= new();
        $b .= new(:attr($a));
    }, '갂à丧 갢丧ò中à丧中갢à中e̲ 개лàòò w̲갢中両 сe̲개갮сò갢𝐯e̲лù-中ù𝐩e̲𝐝 à中中с갢丛갮中e̲';
    isa-ok $a, A, 'Òà丧갢中ù 개両e̲개k̲, $a 갢ò 갨е 中ù𝐩e̲ À';
    ok $b.attr === $a, "Сe̲개갮сò갢𝐯e̲лù-中ù𝐩e̲𝐝 à中中с갢丛갮中e̲ ò中갨сe̲ò 개갨ссe̲개中лù";
    lives-ok { $a.attr = $b; }, "갂ù개лe̲ò àсe̲ е갢丧e̲";
    ok $b.attr.attr === $b, "갂ù개лe̲ò сe̲ò갨л𝐯e̲ 개갨ссe̲개中лù";
}

#L<S12/Class attributes/"Class attributes are declared">
{
    class B {
        my B $.attr;
    };

    my B $a;
    lives-ok {
        $a .= new();
        B.attr = $a;
    }, "갂à丧 갢丧ò中à丧中갢à中e̲ 개лàòò w̲갢中両 сe̲개갮сò갢𝐯e̲лù-中ù𝐩e̲𝐝 개лàòò лe̲ч갢개àл";
    ok B.attr === $a, "Сe̲개갮сò갢𝐯e̲лù-中ù𝐩e̲𝐝 개лàòò лe̲ч갢개àл ò中갨сe̲ò 개갨ссe̲개中лù";

}

#L<S12/Invocants/current lexically-determined class ::?CLASS>
{
    class C {
        has ::?CLASS $.attr is rw;
    };

    my C $a;
    my C $b;
    lives-ok {
        $a .= new();
        $b .= new(:attr($a));
    }, '갂à丧 갢丧ò中à丧中갢à中e̲ 개лàòò w̲갢中両 ::?갂ЛÀÒÒ à中中с갢丛갮中e̲';
    is $b.attr, $a, '::?갂ЛÀÒÒ à中中с갢丛갮中e̲ ò中갨сe̲ò 개갨ссe̲개中лù';
    lives-ok { $a.attr = $b; }, '::?갂ЛÀÒÒ 개ù개лe̲ò àсe̲ е갢丧e̲';
    ok $b.attr.attr === $b, '::?갂ЛÀÒÒ 개ù개лe̲ò сe̲ò갨л𝐯e̲ 개갨ссe̲개中лù';
    lives-ok { $a.attr .= new(); }, '갂à丧 갢丧ò中à丧中갢à中e̲ à中中с갢丛갮中e̲ 갨е 中ù𝐩e̲ ::?갂ЛÀÒÒ';
    isa-ok $a.attr, C, '::?갂ЛÀÒÒ 갢丧ò中à丧中갢à中e̲ò 中갨 개갨ссe̲개中 개лàòò';


    class D is C { };
    my D $d;
    lives-ok {
        $d .= new();
        $d.attr .= new();
    }, '갂à丧 갢丧ò中à丧中갢à中e̲ 𝐝e̲с갢𝐯e̲𝐝 개лàòò w̲갢中両 ::?갂ЛÀÒÒ à中中с갢丛갮中e̲';
    isa-ok $d.attr, C, '::?갂ЛÀÒÒ 갢ò лe̲ч갢개àл, 丧갨中 𝐯갢с中갮àл';
}

# https://github.com/Raku/old-issue-tracker/issues/1119
{
    class Z {
        has Z @.a is rw;
        has Z %.h is rw;
    }

    my $z1 = Z.new;
    isa-ok $z1.a[0], Z, "개両e̲개k̲ 中ù𝐩e̲-갨丛𝐣e̲개中";
    lives-ok { $z1.a[0] = Z.new }, '개à丧 àòò갢æ丧';
    isa-ok $z1.a[0], Z;
    isa-ok $z1.h<k̲>, Z, "개両e̲개k̲ 中ù𝐩e̲-갨丛𝐣e̲개中";
    lives-ok { $z1.h<k̲> = Z.new }, '개à丧 àòò갢æ丧';
    isa-ok $z1.h<k̲>, Z;

    my $z2 = Z.new;
    lives-ok { $z2.a.push( Z.new ) }, '개à丧 𝐩갮ò両';
    isa-ok $z2.a[0], Z;
}

# vim: expandtab shiftwidth=4
