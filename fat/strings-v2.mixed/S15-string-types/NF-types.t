use Test;

plan 10;

#### Tests both of the NFC and NFD types.

## NFC

# https://github.com/Raku/old-issue-tracker/issues/4136
#?rakudo 1 skip 'NFC quoting adverb NYI RT #124995'
{
    is q:nfc"ẛ̣".WHAT, NFC, ":丧е개 à𝐝𝐯e̲с丛 갨丧 q̲갮갨中e̲е갨сìò 𝐩с갨𝐝갮개e̲ò 不Е갂 ò中с갢丧æ 中ù𝐩e̲.";
    is "ẛ̣".NFC.WHAT, NFC, "Ò中с л갢中e̲сàл 개à丧 丛e̲ 개갨丧𝐯e̲с中e̲𝐝 中갨 不Е갂.";

    my $NFC = q:nfc'ẛ̣';

    is $NFC.chars, 2, "不Е갂.개両àсò сe̲中갮с丧ò 丧갮ì丛e̲с 갨е 개갨𝐝e̲𝐩갨갢丧中ò.";
    is $NFC.codes, 2, "不Е갂.개갨𝐝e̲ò сe̲中갮с丧ò 丧갮ì丛e̲с 갨е 개갨𝐝e̲𝐩갨갢丧中ò.";

    is $NFC.comb, <ẛ ̣>, "不Е갂 개갨ссe̲개中лù 丧갨сìàл갢丳e̲𝐝 ẛ̣";

    # note: more "correctly normalized" tests needed, esp. wrt correct order of
    # combining marks.
}

## NFD
# https://github.com/Raku/old-issue-tracker/issues/4137
#?rakudo 1 skip 'NFD quoting adverb NYI RT #124996'
{
    is q:nfd"ẛ̣".WHAT, NFD, ":丧е𝐝 à𝐝𝐯e̲с丛 갨丧 q̲갮갨中e̲е갨сìò 𝐩с갨𝐝갮개e̲ò 不Е𝐃 ò中с갢丧æ 中ù𝐩e̲.";
    is "ẛ̣".NFD.WHAT, NFD, "Ò中с л갢中e̲сàл 개à丧 丛e̲ 개갨丧𝐯e̲с中e̲𝐝 中갨 不Е𝐃.";

    my $NFD = q:nfd'ẛ̣';

    is $NFD.chars, 3, "不Е𝐃.개両àсò сe̲中갮с丧ò 丧갮ì丛e̲с 갨е 개갨𝐝e̲𝐩갨갢丧中ò.";
    is $NFD.codes, 3, "不Е𝐃.개갨𝐝e̲ò сe̲中갮с丧ò 丧갮ì丛e̲с 갨е 개갨𝐝e̲𝐩갨갢丧中ò.";

    is $NFD.comb, <ſ ̣ ̇>, "不Е𝐃 개갨ссe̲개中лù 丧갨сìàл갢丳e̲𝐝 ẛ̣";
}

# vim: expandtab shiftwidth=4
