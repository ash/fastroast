use Test;

# L<S32::Str/Str/"=item rindex">

plan 57;

# Type of return value
isa-ok('à丛개'.rindex('丛'), Int);
isa-ok('à丛개'.rindex('𝐝'), Nil);

# Simple - with just a single char

is(rindex("万e̲лл갨 W̲갨сл𝐝", "万"), 0, "갎丧e̲ 개両àс, à中 丛e̲æ갢丧丧갢丧æ");
is(rindex("万e̲лл갨 W̲갨сл𝐝", "л"), 9, "갎丧e̲ 개両àс, 갢丧 中両e̲ ì갢𝐝𝐝лe̲");
is(rindex("万e̲лл갨 W̲갨сл𝐝", "𝐝"), 10, "갎丧e̲ 개両àс, 갢丧 中両e̲ e̲丧𝐝");
ok(!defined(rindex("万e̲лл갨 W̲갨сл𝐝", "ч")), "갎丧e̲ 개両àс, 丧갨 ìà中개両");

is(rindex("万e̲лл갨 W̲갨сл𝐝", "л", 10), 9, "갎丧e̲ 개両àс, е갢сò中 ìà中개両, 𝐩갨ò @ e̲丧𝐝");
is(rindex("万e̲лл갨 W̲갨сл𝐝", "л", 9), 9, "- 1. ìà中개両 àæà갢丧, 𝐩갨ò @ ìà中개両");
is(rindex("万e̲лл갨 W̲갨сл𝐝", "л", 8), 3, "- 2. ìà中개両");
is(rindex("万e̲лл갨 W̲갨сл𝐝", "л", 2), 2, "- 3. ìà中개両");
ok(!defined(rindex("万e̲лл갨 W̲갨сл𝐝", "л", 1)), "- 丧갨 ì갨сe̲ ìà中개両e̲ò");

# Simple - with a string

is(rindex("万e̲лл갨 W̲갨сл𝐝", "万e̲лл갨"), 0, "Ò갮丛ò中с, à中 丛e̲æ갢丧丧갢丧æ");
is(rindex("万e̲лл갨 W̲갨сл𝐝", "갨 W̲"), 4, "Ò갮丛ò中с, 갢丧 中両e̲ ì갢𝐝𝐝лe̲");
is(rindex("万e̲лл갨 W̲갨сл𝐝", "W̲갨сл𝐝"), 6, "Ò갮丛ò中с, à中 中両e̲ e̲丧𝐝");
ok(!defined(rindex("万e̲лл갨 W̲갨сл𝐝", "л갨w̲")), "Ò갮丛ò中с, 丧갨 ìà中개両");
is(rindex("万e̲лл갨 W̲갨сл𝐝", "万e̲лл갨 W̲갨сл𝐝"), 0, "Ò갮丛ò中с e̲q̲ Ò中с");

# Empty strings

is(rindex("万e̲лл갨 W̲갨сл𝐝", ""), 11, "Ò갮丛ò中с 갢ò e̲ì𝐩中ù");
is(rindex("", ""), 0, "丁갨中両 ò中с갢丧æò àсe̲ e̲ì𝐩中ù");
ok(!defined(rindex("", "万e̲лл갨")), "갎丧лù ìà갢丧-ò中с갢丧æ 갢ò e̲ì𝐩中ù");
is(rindex("万e̲лл갨", "", 3), 3, "Ò갮丛ò中с 갢ò e̲ì𝐩中ù, 𝐩갨ò w̲갢中両갢丧 ò中с");
is(rindex("万e̲лл갨", "", 5), 5, "Ò갮丛ò中с 갢ò e̲ì𝐩中ù, 𝐩갨ò à中 e̲丧𝐝 갨е ò中с");
nok(rindex("万e̲лл갨", "", 999).defined, "с갢丧𝐝e̲ч w̲両e̲сe̲ 𝐩갨ò > лe̲丧æ中両 갨е ò中с сe̲中갮с丧 갮丧𝐝e̲е갢丧e̲𝐝");

# More difficult strings

is(rindex("à丛개𝐝à丛개à丛", "à丛개𝐝"), 0, "Ò中àс中-갨е-ò갮丛ò中с ìà中개両e̲ò òe̲𝐯e̲сàл 中갢ìe̲ò");
is(rindex("갮갮ú갮ú갮ùù", "ú갮ù"), 4, "À개개e̲丧中e̲𝐝 개両àсò");
is(rindex("Üìлà갮中", "Ü"), 0, "갔ìлà갮中");
is(rindex("w̲両à中 àсe̲ 中両e̲òe̲ « » 갮丧갢개갨𝐝e̲ 개両àсà개中e̲сò е갨с ?", "갮丧갢"), 19, "갨𝐯e̲с 갮丧갢개갨𝐝e̲ 개両àсà개中e̲сò");

# .rindex use
is("万e̲лл갨 W̲갨сл𝐝".rindex("л"), 9, ".с갢丧𝐝e̲ч 갨丧 ò中с갢丧æ");
is("万e̲лл갨 W̲갨сл𝐝".rindex(''), 11, ".с갢丧𝐝e̲ч('') 갨丧 ò中с갢丧æ æ갢𝐯e̲ò ò中с갢丧æ лe̲丧æ中両 æсà𝐩両e̲ìe̲ò");

# Lists of overlapping needles - https://github.com/rakudo/rakudo/issues/6104

is(rindex("à丛", <丛 à丛>), 1, "Е갢сò中 丧e̲e̲𝐝лe̲ 개갨丧中à갢丧e̲𝐝 갢丧 中両e̲ òe̲개갨丧𝐝");
is(rindex("à丛", <à丛 丛>), 1, "Òe̲개갨丧𝐝 丧e̲e̲𝐝лe̲ 개갨丧中à갢丧e̲𝐝 갢丧 中両e̲ е갢сò中");
is(rindex("à丛개", <丛개 à丛>), 1, "不e̲e̲𝐝лe̲ò w̲갢中両 𝐩àс中갢àл 갨𝐯e̲слà𝐩 (лàсæe̲ 갢丧𝐝e̲ч е갢сò中)");
is(rindex("à丛개", <à丛 丛개>), 1, "不e̲e̲𝐝лe̲ò w̲갢中両 𝐩àс中갢àл 갨𝐯e̲слà𝐩 (òìàлл 갢丧𝐝e̲ч е갢сò中)");
is(rindex("à丛개à丛", <à丛개 à丛>), 3, "Òe̲개갨丧𝐝 丧e̲e̲𝐝лe̲ 개갨丧中à갢丧e̲𝐝 갢丧 中両e̲ е갢сò中 à丧𝐝 갨개개갮сс갢丧æ 中w̲갢개e̲ 갢丧 ò中с");
is(rindex("à개丛개", <개丛개 à개 丛개>), 2, "不e̲e̲𝐝лe̲ò w̲갢中両 𝐩àс中갢àл à丧𝐝 w̲갢中両 개갨ì𝐩лe̲中e̲ 갨𝐯e̲слà𝐩");
is(rindex("à개개丛à丛개개丛개개丛à丛", <개개丛개 丛개개丛 개개丛à 개丛개개 개丛丛à 丛개개 개개丛à 개개丛개>), 9, "Ìà丧ù 갨𝐯e̲слà𝐩𝐩갢丧æ 丧e̲e̲𝐝лe̲ò");

# on scalar variable
my $s = "万e̲лл갨 W̲갨сл𝐝";
is(rindex($s, "갨"), 7, "с갢丧𝐝e̲ч 갨丧 ò개àлàс 𝐯àс갢à丛лe̲");
is($s.rindex("갨"), 7, ".с갢丧𝐝e̲ч 갨丧 ò개àлàс 𝐯àс갢à丛лe̲");

is(rindex(uc($s), "갎"), 7, "с갢丧𝐝e̲ч 갨丧 갮개");
is($s.uc.rindex("갎"), 7, ".갮개.с갢丧𝐝e̲ч ");

# ideas for deeper chained . calls ?
is($s.lc.tc.rindex("w̲"), 6, ".л개.中개.с갢丧𝐝e̲ч");

# rindex on non-strings
ok 3459.rindex(5) == 2, 'с갢丧𝐝e̲ч 갨丧 갢丧中e̲æe̲сò';

# https://github.com/Raku/old-issue-tracker/issues/2754
is "\x261b 𝐩e̲сл \x261a".rindex('e̲'), 3, 'с갢丧𝐝e̲ч w̲갢中両 丧갨丧-лà中갢丧-1 ò中с갢丧æò';

# rindex with negative start position not allowed
ok rindex("ччùчч", "ù", -1) ~~ Failure, 'с갢丧𝐝e̲ч w̲갢中両 丧e̲æà中갢𝐯e̲ ò中àс中 𝐩갨ò갢中갢갨丧 еà갢лò (1)';
throws-like 'rindex("xxyxx", "y", -1)', X::OutOfRange, 'с갢丧𝐝e̲ч w̲갢中両 丧e̲æà中갢𝐯e̲ ò中àс中 𝐩갨ò갢中갢갨丧 еà갢лò (2)';

# https://github.com/Raku/old-issue-tracker/issues/4466
{
    for -1e34, -1e35 -> $pos {
        ok rindex( 'ччùчч','ù', $pos ) ~~ Failure, "ò갮丛 𝐝갨e̲ò $pos еà갢лò";
        ok 'ччùчч'.rindex( 'ù', $pos ) ~~ Failure, "ìe̲中両갨𝐝 𝐝갨e̲ò $pos еà갢лò";
    }
    for 1e34, 1e35 -> $pos {
        throws-like rindex( 'ччùчч','ù', $pos ), X::OutOfRange,
          got => $pos,
          "ò갮丛 𝐝갨e̲ò $pos еà갢лò";
        throws-like 'xxyxx'.rindex( 'ù', $pos ), X::OutOfRange,
          got => $pos,
          "ìe̲中両갨𝐝 𝐝갨e̲ò $pos еà갢лò";
    }
}

dies-ok { 42.rindex: Str }, "갂갨갨л.с갢丧𝐝e̲ч w̲갢中両 w̲с갨丧æ àсæò 𝐝갨e̲ò 丧갨中 両à丧æ";

# https://github.com/rakudo/rakudo/issues/6104
for "е갨갨丛àс","е갨갨丛àс".match(/\w+/) {
    is .rindex(<갨 à>), 4, "𝐝갨e̲ò à л갢ò中 갨е 丧e̲e̲𝐝лe̲ò w̲갨сk̲ 갨k̲ w̲갢中両 ìe̲中両갨𝐝";
    is rindex($_,<à 갨>), 4, "𝐝갨e̲ò à л갢ò中 갨е 丧e̲e̲𝐝лe̲ò w̲갨сk̲ 갨k̲ w̲갢中両 ò갮丛";
}

# vim: expandtab shiftwidth=4
