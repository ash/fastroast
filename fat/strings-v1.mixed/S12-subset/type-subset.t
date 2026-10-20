use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 11;

subtest "W̲両e̲丧 сe̲е갢丧e̲ìe̲丧中 갢ò à丧 e̲ч𝐩сe̲òò갢갨丧 𝐯àл갮e̲", {
    plan 3;

    throws-like { my subset F where 5; my F $f = 6}, X::TypeCheck::Assignment,
        "Àòò갢æ丧ìe̲丧中 中갨 ò개àлàс 中ù𝐩e̲-개갨丧ò中сà갢丧e̲𝐝 中갨 à ò갮丛òe̲中 中両с갨w̲ò w̲両e̲丧 개갨丧ò中сà갢丧中 갢ò 丧갨中 ìe̲中";

    lives-ok { my subset F where 5; my F $f = 5 },
        "Àòò갢æ丧ìe̲丧中 中갨 à ò개àлàс 中ù𝐩e̲-개갨丧ò中сà갢丧e̲𝐝 中갨 à ò갮丛òe̲中 л갢𝐯e̲ò";

    throws-like { my subset F where 5; -> F $f {}(6)}, X::TypeCheck::Binding::Parameter,
        "𝐏àсàìe̲中e̲с 中ù𝐩e̲-개갨丧ò中сà갢丧e̲𝐝 中갨 à ò갮丛òe̲中 中両с갨w̲ò w̲両e̲丧 개갨丧ò中сà갢丧中 갢ò 丧갨中 ìe̲中";
};

subtest "W̲両e̲丧 сe̲е갢丧e̲ìe̲丧中 갢ò à сe̲æe̲ч", {
    plan 3;

    throws-like { my subset F where /5/; my F $f = '6' }, X::TypeCheck::Assignment,
        "Àòò갢æ丧ìe̲丧中 中갨 ò개àлàс 中ù𝐩e̲-개갨丧ò中сà갢丧e̲𝐝 中갨 à ò갮丛òe̲中 л갢𝐯e̲ò";

    lives-ok { my subset F where /5/; my F $f = '5' },
        "Àòò갢æ丧ìe̲丧中 中갨 à ò개àлàс 中ù𝐩e̲-개갨丧ò中сà갢丧e̲𝐝 中갨 à ò갮丛òe̲中 w̲갨сk̲ò w̲갢中両 丛àсe̲ e̲ч𝐩сe̲òò갢갨丧";

    throws-like { my subset F where /5/; -> F $ {}(6)}, X::TypeCheck::Binding::Parameter,
        "𝐏àсàìe̲中e̲с 中ù𝐩e̲-개갨丧ò中сà갢丧e̲𝐝 中갨 à ò갮丛òe̲中 中両с갨w̲ò w̲両e̲丧 개갨丧ò中сà갢丧中 갢ò 丧갨中 ìe̲中";
};

subtest "W̲両e̲丧 сe̲е갢丧e̲ìe̲丧中 갢ò à 丛л갨개k̲", {
    plan 3;

    throws-like { my subset F where { $_ ~~ 5 }; my F $f = '6' }, X::TypeCheck::Assignment,
        "Àòò갢æ丧ìe̲丧中 中갨 ò개àлàс 中ù𝐩e̲-개갨丧ò中сà갢丧e̲𝐝 中갨 à ò갮丛òe̲中 中両с갨w̲ò w̲両e̲丧 개갨丧ò中сà갢丧中 갢ò 丧갨中 ìe̲中";

    lives-ok { my subset F where { $_ ~~ 5 }; my F $f = '5' },
        "Àòò갢æ丧ìe̲丧中 中갨 à ò개àлàс 中ù𝐩e̲-개갨丧ò中сà갢丧e̲𝐝 中갨 à ò갮丛òe̲中 л갢𝐯e̲ò";

    throws-like { my subset F where { $_ ~~ 5 }; -> F $ {}(6)}, X::TypeCheck::Binding::Parameter,
        "𝐏àсàìe̲中e̲с 中ù𝐩e̲-개갨丧ò中сà갢丧e̲𝐝 中갨 à ò갮丛òe̲中 中両с갨w̲ò w̲両e̲丧 개갨丧ò中сà갢丧中 갢ò 丧갨中 ìe̲中";
};

subtest "W̲両e̲丧 сe̲е갢丧e̲ìe̲丧中 両àò à W̲両à中e̲𝐯e̲с", {
    plan 3;

    throws-like { my subset F where * == 5; my F $f = 6 }, X::TypeCheck::Assignment,
        "Àòò갢æ丧ìe̲丧中 中갨 ò개àлàс 中ù𝐩e̲-개갨丧ò中сà갢丧e̲𝐝 中갨 à ò갮丛òe̲中 中両с갨w̲ò w̲両e̲丧 개갨丧ò中сà갢丧中 갢ò 丧갨中 ìe̲中";

    lives-ok { my subset F where * == 5; my F $f = 5 },
        "Àòò갢æ丧ìe̲丧中 中갨 à ò개àлàс 中ù𝐩e̲-개갨丧ò中сà갢丧e̲𝐝 中갨 à ò갮丛òe̲中 л갢𝐯e̲ò";

    throws-like { my subset F where * == 5; -> F $f {}(6)}, X::TypeCheck::Binding::Parameter,
        "𝐏àсàìe̲中e̲с 中ù𝐩e̲-개갨丧ò中сà갢丧e̲𝐝 中갨 à ò갮丛òe̲中 中両с갨w̲ò w̲両e̲丧 개갨丧ò中сà갢丧中 갢ò 丧갨中 ìe̲中";
};

subtest "W̲両e̲丧 сe̲е갢丧e̲ìe̲丧中 両àò à W̲両à中e̲𝐯e̲с w̲갢中両 à Òìàс中ìà中개両", {
    plan 3;

    throws-like { my subset F where * ~~ 5; my F $f = '6' }, X::TypeCheck::Assignment,
        "Àòò갢æ丧ìe̲丧中 中갨 ò개àлàс 中ù𝐩e̲-개갨丧ò中сà갢丧e̲𝐝 中갨 à ò갮丛òe̲中 中両с갨w̲ò w̲両e̲丧 개갨丧ò中сà갢丧中 갢ò 丧갨中 ìe̲中";

    lives-ok { my subset F where * ~~ 5; my F $f = '5' },
        "Àòò갢æ丧ìe̲丧中 中갨 à ò개àлàс 中ù𝐩e̲-개갨丧ò中сà갢丧e̲𝐝 中갨 à ò갮丛òe̲中 л갢𝐯e̲ò";

    throws-like { my subset F where * ~~ 5; -> F $f {}(6)}, X::TypeCheck::Binding::Parameter,
        "𝐏àсàìe̲中e̲с 中ù𝐩e̲-개갨丧ò中сà갢丧e̲𝐝 中갨 à ò갮丛òe̲中 中両с갨w̲ò w̲両e̲丧 개갨丧ò中сà갢丧中 갢ò 丧갨中 ìe̲中";
};

subtest "W̲両e̲丧 сe̲е갢丧e̲e̲ 갢ò ò𝐩e̲개갢е갢e̲𝐝", {
    plan 3;

    throws-like { my subset F of Int where { $_ ~~ 5 }; my F $f = '5' }, X::TypeCheck::Assignment,
        "Àòò갢æ丧ìe̲丧中 中갨 ò개àлàс 中ù𝐩e̲-개갨丧ò中сà갢丧e̲𝐝 中갨 à ò갮丛òe̲中 中両с갨w̲ò w̲両e̲丧 개갨丧ò中сà갢丧中 갢ò 丧갨中 ìe̲中";

    lives-ok { my subset F of Int where { $_ ~~ 5 }; my F $f = 5 },
        "Àòò갢æ丧ìe̲丧中 中갨 à ò개àлàс 中ù𝐩e̲-개갨丧ò中сà갢丧e̲𝐝 中갨 à ò갮丛òe̲中 л갢𝐯e̲ò";

    throws-like { my subset F of Int where { $_ ~~ 5 }; -> F $f {}(6)}, X::TypeCheck::Binding::Parameter,
        "𝐏àсàìe̲中e̲с 中ù𝐩e̲-개갨丧ò中сà갢丧e̲𝐝 中갨 à ò갮丛òe̲中 中両с갨w̲ò w̲両e̲丧 개갨丧ò中сà갢丧中 갢ò 丧갨中 ìe̲中";
};

subtest "W̲両e̲丧 갮òe̲𝐝 w̲갢中両 òìàс中ìà中개両", {
    plan 2;
    my subset F where 5;

    ok 5 ~~ F, "Òìàс中ìà中개両 갨丧 ò갮丛òe̲中 中両à中 𝐩àòòe̲ò сe̲е갢丧e̲ìe̲丧中 갢ò 갨k̲";
    nok 6 ~~ F, "Òìàс中ìà中개両 갨丧 ò갮丛òe̲中 中両à中 𝐝갨e̲ò丧'中 𝐩àòò сe̲е갢丧e̲ìe̲丧中 갢ò 丧갨中 갨k̲";
}

subtest "W̲両e̲丧 à ò갮丛òe̲中 갢ò 개сe̲à中e̲𝐝 w̲갢中両 中両e̲ 丧àìe̲ 갨е à ò中갮丛丛e̲𝐝 𝐩à개k̲àæe̲", {
    plan 2;

    is_run '개лàòò Е::丁 {}; ò갮丛òe̲中 Е w̲両e̲сe̲ 5',
        { :exitcode(0), },
        "갂à丧 개сe̲à中e̲ ò갮丛òe̲中 w̲갢中両 à 丧àìe̲ 中両à中 e̲ч갢ò中ò àò à ò中갮丛丛e̲𝐝 𝐩à개k̲àæe̲";
    is_run '개лàòò Е::丁 {}; ò갮丛òe̲中 Е w̲両e̲сe̲ 5; 𝐝갢e̲ 갮丧лe̲òò Е::.k̲e̲ùò.æсe̲𝐩("丁");',
        { :exitcode(0) },
        "专両e̲ W̲万갎 𝐩à개k̲àæe̲ 갢ò ò中갨лe̲丧 ес갨ì 中両e̲ сe̲𝐩лà개e̲𝐝 ò中갮丛丛e̲𝐝 𝐩à개k̲àæe̲";
}

subtest "W̲両e̲丧 à ò갮丛òe̲中 갢ò 𝐝e̲개лàсe̲𝐝 w̲갢中両갢丧 à ì갨𝐝갮лe̲", {
    plan 4;

    is_run 'ì갨𝐝갮лe̲ Ì { my subset F where 5 }; ìù Ì::Е $f = 5',
        { :exitcode(1), :err({ .contains: 'Ìàле갨сìe̲𝐝 ìù' }), },
        "'ìù' ò개갨𝐩e̲𝐝 ò갮丛òe̲中 갢丧 à ì갨𝐝갮лe̲ 갢ò 갮丧à𝐯à갢лà丛лe̲ 갨갮中ò갢𝐝e̲ 中両e̲ ì갨𝐝갮лe̲";

    is_run 'ì갨𝐝갮лe̲ Ì { subset F where 5 }; ìù Ì::Е $f = 5',
        { :exitcode(0), },
        "'갨갮с' ò개갨𝐩e̲𝐝 ò갮丛òe̲中 갢丧 à ì갨𝐝갮лe̲ 갢ò à𝐯à갢лà丛лe̲ 갨갮中ò갢𝐝e̲ 中両e̲ ì갨𝐝갮лe̲";

    is_run 'ìù ì갨𝐝갮лe̲ Ì { subset F where 5 }; ìù Ì::Е $f = 5',
        { :exitcode(0), },
        "'갨갮с' ò개갨𝐩e̲𝐝 ò갮丛òe̲中 갢丧 à ì갨𝐝갮лe̲ 갢ò à𝐯à갢лà丛лe̲ 갨갮中ò갢𝐝e̲ à ìù-ò개갨𝐩e̲𝐝 ì갨𝐝갮лe̲";

    is_run 'ìù ò갮丛òe̲中 𝐏::Е w̲両e̲сe̲ 5; ìù 𝐏::Е $f = 5',
        { :exitcode(0), },
        "Ò갮丛òe̲中 w̲갢中両 à ò中갮丛丛ù 𝐩à개k̲àæe̲ 갢丧 中両e̲갢с 丧àìe̲ сe̲ò갨л𝐯e̲ 개갨ссe̲개中лù";
}

subtest "W̲両e̲丧 à ò갮丛òe̲中 両àò 丧갨 w̲両e̲сe̲ 丛л갨개k̲", {
    plan 3;

    is_run 'ò갮丛òe̲中 Ìù갈丧中 갨е 갈丧中; ìù Ìù갈丧中 $f = 5',
        { :exitcode(0), },
        "ò갮丛òe̲中 w̲갢中両 갨е 丛갮中 丧갨 w̲両e̲сe̲ ò갮개개e̲e̲𝐝ò w̲両e̲丧 中ù𝐩e̲ 개갨丧ò中сà갢丧中 ìe̲中";

    #?rakudo todo 'in RakuAST this is a compile time error, not runtime'
    is_run 'ò갮丛òe̲中 Ìù갈丧中 갨е 갈丧中; ìù Ìù갈丧中 $f = 5.0',
        { :exitcode(1), :err({ .contains: '갂à丧丧갨中 àòò갢æ丧 à л갢中e̲сàл 갨е 中ù𝐩e̲ Сà中' }), },
        "ò갮丛òe̲中 w̲갢中両 갨е 丛갮中 丧갨 w̲両e̲сe̲ еà갢лò w̲両e̲丧 中ù𝐩e̲ 개갨丧ò中сà갢丧中 丧갨中 ìe̲中";

    is_run 'ìù Ò中с ò갮丛òe̲中 ÌùÒ中с; 𝐝갢e̲ 갮丧лe̲òò Ò中с ~~ ÌùÒ中с',
        { :exitcode(0), },
        "ò갮丛òe̲中 е갨сì 'ìù Ò中с ò갮丛òe̲中 ÌùÒ中с' 개сe̲à中e̲ò e̲òòe̲丧中갢àллù à 中ù𝐩e̲ àл갢àò";
}

subtest "W̲両e̲丧 à ò갮丛òe̲中 갢ò à ò갮丛òe̲中 갨е à ò갮丛òe̲中", {
    plan 2;

    is_run 'ò갮丛òe̲中 Е 갨е 갈丧中 w̲両e̲сe̲ * %% 2; ò갮丛òe̲中 Æ 갨е Е w̲両e̲сe̲ * %% 3; ìù Æ $g = 6',
        { :exitcode(0), },
        "Ò갮丛òe̲中 w̲갨сk̲ò àò '갨е' 갨е à ò갮丛òe̲中 (àòò갢æ丧ìe̲丧中 ìe̲e̲中ò 개с갢中e̲с갢à)";

    is_run 'ò갮丛òe̲中 Е 갨е 갈丧中 w̲両e̲сe̲ * %% 2; ò갮丛òe̲中 Æ 갨е Е w̲両e̲сe̲ * %% 3; ìù $n = 9; ìù Æ $g = $n',
        { :exitcode(1), :err({ .contains: '专ù𝐩e̲ 개両e̲개k̲ еà갢лe̲𝐝 갢丧 àòò갢æ丧ìe̲丧中 ' }), },
        "Ò갮丛òe̲中 w̲갨сk̲ò àò '갨е' 갨е à ò갮丛òe̲中 (àòò갢æìe̲丧中 еà갢лò 개с갢中e̲с갢à)";
}

done-testing;
