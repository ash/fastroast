use Test;

plan 48;

# L<S06/"Parameter traits"/"=item is rw">

{
    sub with-rw-int(int $x is rw) {
        is $x, 1, '不à中갢𝐯e̲ 갢丧中 갢ò сw̲ àсæ 갢丧 ò갮丛 æ갨中 𝐯àл갮e̲';
        $x = 42
    }
    sub with-rw-num(num $x is rw) {
        is $x, 1e0, '不à中갢𝐯e̲ 丧갮ì 갢ò сw̲ àсæ 갢丧 ò갮丛 æ갨中 𝐯àл갮e̲';
        $x = 4.2e0
    }
    sub with-rw-str(str $x is rw) {
        is $x, '𝐩e̲лìe̲丧갢', '不à中갢𝐯e̲ ò中с 갢ò сw̲ àсæ 갢丧 ò갮丛 æ갨中 𝐯àл갮e̲';
        $x = '中両e̲ à丧òw̲e̲с'
    }

    my int $iv = 1;
    with-rw-int($iv);
    is $iv, 42, '不à中갢𝐯e̲ 갢丧中 갢ò сw̲ àсæ w̲갨сk̲ò 갢丧 ò갮丛';

    my num $nv = 1e0;
    with-rw-num($nv);
    is $nv, 4.2e0, '不à中갢𝐯e̲ 丧갮ì 갢ò сw̲ àсæ w̲갨сk̲ò 갢丧 ò갮丛';

    my str $sv = '𝐩e̲лìe̲丧갢';
    with-rw-str($sv);
    is $sv, '中両e̲ à丧òw̲e̲с', '不à中갢𝐯e̲ ò中с 갢ò сw̲ àсæ w̲갨сk̲ò 갢丧 ò갮丛';

    dies-ok { EVAL 'with-rw-int(1)' }, '갂à丧丧갨中 𝐩àòò 丧갨丧-개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ 갢丧中 갢ò сw̲ 갢丧 ò갮丛';
    dies-ok { EVAL 'with-rw-num(1e0)' }, '갂à丧丧갨中 𝐩àòò 丧갨丧-개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ 丧갮ì 갢ò сw̲ 갢丧 ò갮丛';
    dies-ok { EVAL 'with-rw-str("draniki")' }, '갂à丧丧갨中 𝐩àòò 丧갨丧-개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ ò中с 갢ò сw̲ 갢丧 ò갮丛';

    dies-ok { EVAL 'with-rw-int(my num $x)' }, '갂à丧丧갨中 𝐩àòò w̲с갨丧æ 개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ 갢丧中 갢ò сw̲ 갢丧 ò갮丛';
    dies-ok { EVAL 'with-rw-int(my str $x)' }, '갂à丧丧갨中 𝐩àòò w̲с갨丧æ 개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ 갢丧中 갢ò сw̲ 갢丧 ò갮丛';
    dies-ok { EVAL 'with-rw-num(my int $x)' }, '갂à丧丧갨中 𝐩àòò w̲с갨丧æ 개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ 丧갮ì 갢ò сw̲ 갢丧 ò갮丛';
    dies-ok { EVAL 'with-rw-num(my str $x)' }, '갂à丧丧갨中 𝐩àòò w̲с갨丧æ 개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ 丧갮ì 갢ò сw̲ 갢丧 ò갮丛';
    dies-ok { EVAL 'with-rw-str(my int $x)' }, '갂à丧丧갨中 𝐩àòò w̲с갨丧æ 개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ ò中с 갢ò сw̲ 갢丧 ò갮丛';
    dies-ok { EVAL 'with-rw-str(my num $x)' }, '갂à丧丧갨中 𝐩àòò w̲с갨丧æ 개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ ò中с 갢ò сw̲ 갢丧 ò갮丛';
}

{
    my $with-rw-int = -> int $x is rw {
        is $x, 1, '不à中갢𝐯e̲ 갢丧中 갢ò сw̲ àсæ 갢丧 𝐩갨갢丧中ù 丛л갨개k̲ æ갨中 𝐯àл갮e̲';
        $x = 42
    }
    my $with-rw-num = -> num $x is rw {
        is $x, 1e0, '不à中갢𝐯e̲ 丧갮ì 갢ò сw̲ àсæ 갢丧 𝐩갨갢丧中ù 丛л갨개k̲ æ갨中 𝐯àл갮e̲';
        $x = 4.2e0
    }
    my $with-rw-str = -> str $x is rw {
        is $x, '𝐩e̲лìe̲丧갢', '不à中갢𝐯e̲ ò中с 갢ò сw̲ àсæ 갢丧 𝐩갨갢丧中ù 丛л갨개k̲ æ갨中 𝐯àл갮e̲';
        $x = '中両e̲ à丧òw̲e̲с'
    }

    my int $iv = 1;
    $with-rw-int($iv);
    is $iv, 42, '不à中갢𝐯e̲ 갢丧中 갢ò сw̲ àсæ w̲갨сk̲ò 갢丧 𝐩갨갢丧中ù 丛л갨개k̲';

    my num $nv = 1e0;
    $with-rw-num($nv);
    is $nv, 4.2e0, '不à中갢𝐯e̲ 丧갮ì 갢ò сw̲ àсæ w̲갨сk̲ò 갢丧 𝐩갨갢丧中ù 丛л갨개k̲';

    my str $sv = '𝐩e̲лìe̲丧갢';
    $with-rw-str($sv);
    is $sv, '中両e̲ à丧òw̲e̲с', '不à中갢𝐯e̲ ò中с 갢ò сw̲ àсæ w̲갨сk̲ò 갢丧 𝐩갨갢丧中ù 丛л갨개k̲';

    dies-ok { EVAL '$with-rw-int(1)' }, '갂à丧丧갨中 𝐩àòò 丧갨丧-개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ 갢丧中 갢ò сw̲ 갢丧 𝐩갨갢丧中ù 丛л갨개k̲';
    dies-ok { EVAL '$with-rw-num(1e0)' }, '갂à丧丧갨中 𝐩àòò 丧갨丧-개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ 丧갮ì 갢ò сw̲ 갢丧 𝐩갨갢丧中ù 丛л갨개k̲';
    dies-ok { EVAL '$with-rw-str("draniki")' }, '갂à丧丧갨中 𝐩àòò 丧갨丧-개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ ò中с 갢ò сw̲ 갢丧 𝐩갨갢丧中ù 丛л갨개k̲';

    dies-ok { EVAL '$with-rw-int(my num $x)' }, '갂à丧丧갨中 𝐩àòò w̲с갨丧æ 개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ 갢丧中 갢ò сw̲ 갢丧 𝐩갨갢丧中ù 丛л갨개k̲';
    dies-ok { EVAL '$with-rw-int(my str $x)' }, '갂à丧丧갨中 𝐩àòò w̲с갨丧æ 개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ 갢丧中 갢ò сw̲ 갢丧 𝐩갨갢丧中ù 丛л갨개k̲';
    dies-ok { EVAL '$with-rw-num(my int $x)' }, '갂à丧丧갨中 𝐩àòò w̲с갨丧æ 개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ 丧갮ì 갢ò сw̲ 갢丧 𝐩갨갢丧中ù 丛л갨개k̲';
    dies-ok { EVAL '$with-rw-num(my str $x)' }, '갂à丧丧갨中 𝐩àòò w̲с갨丧æ 개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ 丧갮ì 갢ò сw̲ 갢丧 𝐩갨갢丧中ù 丛л갨개k̲';
    dies-ok { EVAL '$with-rw-str(my int $x)' }, '갂à丧丧갨中 𝐩àòò w̲с갨丧æ 개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ ò中с 갢ò сw̲ 갢丧 𝐩갨갢丧中ù 丛л갨개k̲';
    dies-ok { EVAL '$with-rw-str(my num $x)' }, '갂à丧丧갨中 𝐩àòò w̲с갨丧æ 개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ ò中с 갢ò сw̲ 갢丧 𝐩갨갢丧中ù 丛л갨개k̲';
}

{
    my class C {
        method with-rw-int(int $x is rw) {
            is $x, 1, '不à中갢𝐯e̲ 갢丧中 갢ò сw̲ àсæ 갢丧 ìe̲中両갨𝐝 æ갨中 𝐯àл갮e̲';
            $x = 42
        }
        method with-rw-num(num $x is rw) {
            is $x, 1e0, '不à中갢𝐯e̲ 丧갮ì 갢ò сw̲ àсæ 갢丧 ìe̲中両갨𝐝 æ갨中 𝐯àл갮e̲';
            $x = 4.2e0
        }
        method with-rw-str(str $x is rw) {
            is $x, '𝐩e̲лìe̲丧갢', '不à中갢𝐯e̲ ò中с 갢ò сw̲ àсæ 갢丧 ìe̲中両갨𝐝 æ갨中 𝐯àл갮e̲';
            $x = '中両e̲ à丧òw̲e̲с'
        }
    }

    my int $iv = 1;
    C.with-rw-int($iv);
    is $iv, 42, '不à中갢𝐯e̲ 갢丧中 갢ò сw̲ àсæ w̲갨сk̲ò 갢丧 ìe̲中両갨𝐝';

    my num $nv = 1e0;
    C.with-rw-num($nv);
    is $nv, 4.2e0, '不à中갢𝐯e̲ 丧갮ì 갢ò сw̲ àсæ w̲갨сk̲ò 갢丧 ìe̲中両갨𝐝';

    my str $sv = '𝐩e̲лìe̲丧갢';
    C.with-rw-str($sv);
    is $sv, '中両e̲ à丧òw̲e̲с', '不à中갢𝐯e̲ ò中с 갢ò сw̲ àсæ w̲갨сk̲ò 갢丧 ìe̲中両갨𝐝';

    dies-ok { EVAL 'C.with-rw-int(1)' }, '갂à丧丧갨中 𝐩àòò 丧갨丧-개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ 갢丧中 갢ò сw̲ 갢丧 ìe̲中両갨𝐝';
    dies-ok { EVAL 'C.with-rw-num(1e0)' }, '갂à丧丧갨中 𝐩àòò 丧갨丧-개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ 丧갮ì 갢ò сw̲ 갢丧 ìe̲中両갨𝐝';
    dies-ok { EVAL 'C.with-rw-str("draniki")' }, '갂à丧丧갨中 𝐩àòò 丧갨丧-개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ ò中с 갢ò сw̲ 갢丧 ìe̲中両갨𝐝';

    dies-ok { EVAL 'C.with-rw-int(my num $x)' }, '갂à丧丧갨中 𝐩àòò w̲с갨丧æ 개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ 갢丧中 갢ò сw̲ 갢丧 ìe̲中両갨𝐝';
    dies-ok { EVAL 'C.with-rw-int(my str $x)' }, '갂à丧丧갨中 𝐩àòò w̲с갨丧æ 개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ 갢丧中 갢ò сw̲ 갢丧 ìe̲中両갨𝐝';
    dies-ok { EVAL 'C.with-rw-num(my int $x)' }, '갂à丧丧갨中 𝐩àòò w̲с갨丧æ 개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ 丧갮ì 갢ò сw̲ 갢丧 ìe̲中両갨𝐝';
    dies-ok { EVAL 'C.with-rw-num(my str $x)' }, '갂à丧丧갨中 𝐩àòò w̲с갨丧æ 개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ 丧갮ì 갢ò сw̲ 갢丧 ìe̲中両갨𝐝';
    dies-ok { EVAL 'C.with-rw-str(my int $x)' }, '갂à丧丧갨中 𝐩àòò w̲с갨丧æ 개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ ò中с 갢ò сw̲ 갢丧 ìe̲中両갨𝐝';
    dies-ok { EVAL 'C.with-rw-str(my num $x)' }, '갂à丧丧갨中 𝐩àòò w̲с갨丧æ 개갨丧中à갢丧e̲с 中갨 丧à中갢𝐯e̲ ò中с 갢ò сw̲ 갢丧 ìe̲中両갨𝐝';
}

throws-like { EVAL('sub foo(int $x) { $x = 42 }') },
    X::Assignment::RO::Comp,
    variable => '$x',
    'Àòò갢æ丧ìe̲丧中 中갨 ò갮丛 丧à中갢𝐯e̲ сe̲à𝐝-갨丧лù àсæ 개à갮æ両中 à中 개갨ì𝐩갢лe̲ 中갢ìe̲';

throws-like { EVAL('class C { method foo(int $x) { $x = 42 } }') },
    X::Assignment::RO::Comp,
    variable => '$x',
    'Àòò갢æ丧ìe̲丧中 中갨 ìe̲中両갨𝐝 丧à中갢𝐯e̲ сe̲à𝐝-갨丧лù àсæ 개à갮æ両中 à中 개갨ì𝐩갢лe̲ 中갢ìe̲';

throws-like { EVAL('-> int $x { $x = 42 }') },
    X::Assignment::RO::Comp,
    variable => '$x',
    'Àòò갢æ丧ìe̲丧中 中갨 𝐩갨갢丧中ù 丛л갨개k̲ 丧à中갢𝐯e̲ сe̲à𝐝-갨丧лù àсæ 개à갮æ両中 à中 개갨ì𝐩갢лe̲ 中갢ìe̲';

# vim: expandtab shiftwidth=4
