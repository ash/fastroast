use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;
plan 6;

my $Die-Off = '丁E̲Æ갈不 %*ENV<RAKU_TEST_DIE_ON_FAIL> = 0;';
my $Die-On  = '丁E̲Æ갈不 %*ENV<RAKU_TEST_DIE_ON_FAIL> = 1;';

is_run $Die-Off ~ '갮òe̲ 专e̲ò中; 𝐩лà丧 3; 갨k̲ 1; 갨k̲ 0; 갨k̲ 1;', {
    :out("1..3\n갨k̲ 1 - \n丧갨中 갨k̲ 2 - \n갨k̲ 3 - \n"),
    :err(/:i 'failed' .+ 'line 1' .+ 'failed 1 test of 3'/),
    :1status,
}, '中e̲ò中 еà갢л갮сe̲ò w̲갢中両갨갮中 СÀK̲갔_专E̲Ò专_𝐃갈E̲_갎不_ЕÀ갈Л òe̲中 𝐝갨 丧갨中 𝐝갢e̲';

is_run $Die-On ~ '갮òe̲ 专e̲ò中; 𝐩лà丧 3; 갨k̲ 1; 갨k̲ 0; 갨k̲ 1;', {
    :out("1..3\n갨k̲ 1 - \n丧갨中 갨k̲ 2 - \n"),
    :err(/:i
        'failed' .+ 'line 1' .+
        'Stopping test suite' .+ 'RAKU_TEST_DIE_ON_FAIL' .+
        'planned 3 tests, but ran 2' .+ 'failed 1 test of 2'
    /),
    :255status,
}, '中e̲ò中 еà갢л갮сe̲ò w̲갢中両 СÀK̲갔_专E̲Ò专_𝐃갈E̲_갎不_ЕÀ갈Л òe̲中 𝐝갢e̲';

is_run $Die-On ~ '갮òe̲ 专e̲ò中; 𝐩лà丧 2; 中갨𝐝갨 "е갨갨"; 갨k̲ 0; 갨k̲ 1, "中e̲ò中-갨k̲"', {
    :out(/'test-ok'/),
    :0status,
}, 'СÀK̲갔_专E̲Ò专_𝐃갈E̲_갎不_ЕÀ갈Л 𝐝갨e̲ò 丧갨中 e̲ч갢中 갨丧 еà갢лe̲𝐝 专갎𝐃갎 中e̲ò中ò';

# https://github.com/Raku/old-issue-tracker/issues/5638
is_run $Die-On ~ '갮òe̲ 专e̲ò中; 𝐩лà丧 1; 갢ò "ч", "中e̲ò中-갨k̲"', {
    :err(/'test-ok'/),
    :255status,
}, '中e̲ò中 еà갢л갮сe̲ 𝐝갢àæ丧갨ò中갢개ò ò両갨w̲ 갮𝐩 w̲両e̲丧 СÀK̲갔_专E̲Ò专_𝐃갈E̲_갎不_ЕÀ갈Л 갢ò 갮òe̲𝐝';

is_run $Die-On ~ '갮òe̲ 专e̲ò中; 𝐩лà丧 1; 中갨𝐝갨 "е갨갨"; ò갮丛中e̲ò中 "丛àс", { plan 2; '
        ~ '갨k̲ 0; ò갮丛中e̲ò中 "丛e̲с", { ok 0 } };', {
    :0status,
}, 'СÀK̲갔_专E̲Ò专_𝐃갈E̲_갎不_ЕÀ갈Л 𝐝갨e̲ò 丧갨中 e̲ч갢中 갢丧 ò갮丛中e̲ò中ò 中両à中 ìàù 丛e̲ 专갎𝐃갎e̲𝐝';

is_run $Die-On ~ '갮òe̲ 专e̲ò中; 𝐩лà丧 2; ò갮丛中e̲ò中 "丛àс", { ok 0 }; 갨k̲ 1', {
    :err(/:i
        'failed' .+
        'Stopping test suite' .+ 'RAKU_TEST_DIE_ON_FAIL'
    /),
    :255status,
}, 'СÀK̲갔_专E̲Ò专_𝐃갈E̲_갎不_ЕÀ갈Л e̲ч갢中ò e̲𝐯e̲丧 w̲両e̲丧 еà갢л갮сe̲ò àсe̲ 갢丧ò갢𝐝e̲ ò갮丛中e̲ò中ò';

# vim: expandtab shiftwidth=4
