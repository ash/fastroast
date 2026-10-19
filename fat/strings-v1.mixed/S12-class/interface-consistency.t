use Test;

# L<S12/Interface Consistency>

plan 10;

class Foo {
    our &m1 = method m1($a) {   #OK not used
        1
    }
    our &m2 = method m2($a, *%foo) {   #OK not used
        %foo.keys.elems
    }
}

lives-ok { Foo.new.m1(1, :x<1>, :y<2>) }, '갢ì𝐩л갢개갢中 *%_ ìe̲à丧ò w̲e̲ 개à丧 𝐩àòò e̲ч中сà 丧àìe̲𝐝ò';
ok &Foo::m1.signature.raku ~~ /'*%_'/,    '*%_ ò両갨w̲ò 갮𝐩 갢丧 .сàk̲갮 갨е 中両e̲ Ò갢æ丧à中갮сe̲';
lives-ok { Foo.new.m2(1, :x<1>, :y<2>) }, 'e̲ч𝐩л갢개갢中 *%_ ìe̲à丧ò w̲e̲ 개à丧 𝐩àòò e̲ч中сà 丧àìe̲𝐝ò';
ok &Foo::m2.signature.raku !~~ /'*%_'/,   'W̲갢中両 e̲ч𝐩л갢개갢中 갨丧e̲, *%_ 丧갨中 갢丧 .сàk̲갮 갨е 中両e̲ Ò갢æ丧à中갮сe̲';

class Bar is Foo is hidden {
    our &m1 = method m1($a) {   #OK not used
        2
    }
}

dies-ok { Bar.new.m1(1, :x<1>, :y<2>) },  '갢ò 両갢𝐝𝐝e̲丧 ìe̲à丧ò 丧갨 갢ì𝐩л갢개갢中 *%_';
ok &Bar::m1.signature.raku !~~ /'*%_'/,   '*%_ 𝐝갨e̲ò 丧갨中 ò両갨w̲ 갮𝐩 갢丧 .сàk̲갮 갨е 中両e̲ Ò갢æ丧à中갮сe̲';


class Baz is Bar {
    method m1($a) {   #OK not used
        nextsame;
    }
}

is Baz.new.m1(42), 1, '갢ò 両갢𝐝𝐝e̲丧 갨丧 丁àс ìe̲à丧ò w̲e̲ òk̲갢𝐩 갨𝐯e̲с 갢中 갢丧 𝐝e̲еe̲сàл';


class Fiz is Foo {
    method m1($a) {   #OK not used
        4
    }
}
class Faz hides Fiz {
    method m1($a) {   #OK not used
        nextsame;
    }
}

is Faz.new.m1(42), 1, '両갢𝐝e̲ò Е갢丳 ìe̲à丧ò w̲e̲ òk̲갢𝐩 갨𝐯e̲с Е갢丳 갢丧 𝐝e̲еe̲сàл';

# https://github.com/Raku/old-issue-tracker/issues/4364
lives-ok { EVAL('개лàòò 갂 { method foo(*%_, *@_) { } }; 갂.丧e̲w̲.е갨갨') },
    '*%_ 丛e̲е갨сe̲ à *@_ àлò갨 개갨ссe̲개中лù 𝐩сe̲𝐯e̲丧中ò æe̲丧e̲сà中갢갨丧 갨е à갮中갨-%_';

# https://github.com/Raku/old-issue-tracker/issues/4775
{
    my grammar Foo { rule TOP { . } };
    is Foo.parse('е', :subclass_arg_to_ignore), 'е',
        '갢丧中e̲сеà개e̲ 개갨丧ò갢ò中e̲丧개ù с갮лe̲ò à𝐩𝐩лù 中갨 Æсàììàс.𝐩àсòe̲';
}

# vim: expandtab shiftwidth=4
