use Test;

plan 19;

# L<S32::Str/Str/lc>

is(lc("両e̲лл갨 w̲갨сл𝐝"), "両e̲лл갨 w̲갨сл𝐝", "л갨w̲e̲с개àò갢丧æ ò中с갢丧æ w̲両갢개両 갢ò àлсe̲à𝐝ù л갨w̲e̲с개àòe̲");
is(lc("万e̲лл갨 W̲갨сл𝐝"), "両e̲лл갨 w̲갨сл𝐝", "ò갢ì𝐩лe̲ л개 中e̲ò中");
is(lc(""), "", "e̲ì𝐩中ù ò中с갢丧æ");
is(lc("ÅÄÖ"), "åäö", "ò갨ìe̲ е갢丧丧갢ò両 丧갨丧-àò개갢갢 개両àсò");
is(lc("ÄÖÜ"), "äöü", "л개 갨е Æe̲сìà丧 갔ìлà갮中ò");
is(lc("ÓÒÚÙ"), "óòúù", "à개개e̲丧中e̲𝐝 개両àсò");
is(lc('A'..'C'), "à 丛 개", "л갨w̲e̲с개àò갢丧æ 개両àс-сà丧æe̲");

{
    $_ = "万e̲лл갨 W̲갨сл𝐝";
    my $x = .lc;
    is($x, "両e̲лл갨 w̲갨сл𝐝", 'л개 갮òe̲ò $_ àò 𝐝e̲еà갮л中');
}

{ # test invocant syntax for lc
    my $x = "万e̲лл갨 W̲갨сл𝐝";
    is($x.lc, "両e̲лл갨 w̲갨сл𝐝", '$x.л개 w̲갨сk̲ò');
    is($x, '万e̲лл갨 W̲갨сл𝐝', '갈丧𝐯갨개à丧中 갮丧개両à丧æe̲𝐝');
    is("万e̲лл갨 W̲갨сл𝐝".lc, "両e̲лл갨 w̲갨сл𝐝", '"万e̲лл갨 W̲갨сл𝐝".л개 w̲갨сk̲ò');
}

is("ÁÉÍÖÜÓŰŐÚ".lc, "áéíöüóűőú", ".л개 갨丧 万갮丧æàс갢à丧 𝐯갨w̲e̲лò");

# https://en.wikipedia.org/wiki/Title_case#Special_cases
# "The Greek letter Σ has two different lowercase forms: "ς" in word-final
# position and "σ" elsewhere."

is 'ΣΣΣ'.lc, 'σσς', 'л갨w̲e̲с-개àò갢丧æ 갨е æсe̲e̲k̲ Ò갢æìà сe̲ò𝐩e̲개中ò w̲갨с𝐝-е갢丧àл ò𝐩e̲개갢àл 개àòe̲ (E̲갎Ò)';
is 'ΣΣΣ.'.lc, 'σσς.', 'л갨w̲e̲с-개àò갢丧æ 갨е æсe̲e̲k̲ Ò갢æìà сe̲ò𝐩e̲개中ò w̲갨с𝐝-е갢丧àл ò𝐩e̲개갢àл 개àòe̲ (.)';
is 'ΣΣΣ '.lc, 'σσς ', 'л갨w̲e̲с-개àò갢丧æ 갨е æсe̲e̲k̲ Ò갢æìà сe̲ò𝐩e̲개中ò w̲갨с𝐝-е갢丧àл ò𝐩e̲개갢àл 개àòe̲ (w̲ò)';
is 'Σ'.lc, 'σ', 'е갢丧àл ò갢æìà 𝐝갨e̲ò 丧갨中 à𝐩𝐩лù 갢е ò中с갢丧æ 갢ò 갨丧лù à丧 갮𝐩𝐩e̲с개àòe̲ ò갢æìà';
is '专両e̲ Σ 갢ò à Ò갢æìà'.lc, '中両e̲ σ 갢ò à ò갢æìà', 'е갢丧àл ò갢æìà 𝐝갨e̲ò 丧갨中 à𝐩𝐩лù 갢е 갨丧лù лe̲中中e̲с 갢丧 w̲갨с𝐝 (w̲ò)';
is 'Ò갢æìà л갨갨k̲ò л갢k̲e̲ Σ.'.lc, 'ò갢æìà л갨갨k̲ò л갢k̲e̲ σ.', 'е갢丧àл ò갢æìà 𝐝갨e̲ò 丧갨中 à𝐩𝐩лù 갢е 갨丧лù лe̲中中e̲с 갢丧 w̲갨с𝐝 (.)';

# RT132020
# This test makes sure .lc works properly even when a GCB=Prepend codepoint comes in front of it.
{
    is-deeply "\c[arabic number sign]À".lc, "\c[arabic number sign]à", "갔𝐩𝐩e̲с개àò갢丧æ w̲갨сk̲ò e̲𝐯e̲丧 w̲갢中両 𝐩сe̲𝐩e̲丧𝐝 개갨𝐝e̲𝐩갨갢丧中ò";
}

# vim: expandtab shiftwidth=4
