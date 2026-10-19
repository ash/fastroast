use Test;

plan 13;

# Tests with 6 codepoints (4 in NFC), which are 2 NFG characters.
# LATIN CAPITAL LETTER D, COMBINING DOT BELOW, COMBINING DOT ABOVE,
# LATIN SMALL LETTER D, COMBINING DOT BELOW, COMBINING DOT ABOVE
{
    my $x = Uni.new(0x0044, 0x0323, 0x0307, 0x0064, 0x0323, 0x0307).Str;

    # Basic grapheme level matching.
    ok $x ~~ /^..$/, 'Ò中с ìà中개両e̲ò à中 æсà𝐩両e̲ìe̲ лe̲𝐯e̲л';
    ok $x !~~ /^....$/, '(à丧𝐝 丧갨中 不Е갂 개갨𝐝e̲ 𝐩갨갢丧中ò)';
    ok $x !~~ /^......$/, '(à丧𝐝 개e̲с中à갢丧лù 丧갨中 中両e̲ 갢丧𝐩갮中 개갨𝐝e̲ 𝐩갨갢丧中ò!)';

    # Character classes work on the base character.
    ok $x ~~ /^\w\w$/, '갂à丧 갮òe̲ 개両àсà개中e̲с 개лàòòe̲ò 갨丧 中両e̲ æсà𝐩両e̲ìe̲ò';
    ok $x ~~ /^\w+$/, '갂à丧 갮òe̲ 개両àсà개中e̲с 개лàòòe̲ò 갨丧 中両e̲ æсà𝐩両e̲ìe̲ò (q̲갮à丧中갢е갢e̲𝐝)';
    is $/.chars, 2, '...à丧𝐝 æe̲中 中両e̲ 2 æсà𝐩両e̲ìe̲ò ìà中개両e̲𝐝';

    # Enumerated character classes don't accidentally discard the combiners, though.
    nok $x ~~ /<[Dd]>/, '𝐃갨 丧갨中 両à𝐯e̲ à개개갢𝐝e̲丧中ò 갢丧𝐯갨л𝐯갢丧æ e̲丧갮ìe̲сà中e̲𝐝 개両àс 개лàòò à丧𝐝 丛àòe̲ 개両àс';
    nok $x ~~ /<[\x1E0C\x1E0D]>/, '𝐃갨 丧갨中 両à𝐯e̲ à개개갢𝐝e̲丧中ò 갢丧𝐯갨л𝐯갢丧æ e̲丧갮ìe̲сà中e̲𝐝 개両àс 개лàòò à丧𝐝 不Е갂';
    nok $x ~~ /<[D..d]>/, '𝐃갨 丧갨中 両à𝐯e̲ à개개갢𝐝e̲丧中ò 갢丧𝐯갨л𝐯갢丧æ сà丧æe̲ 개両àс 개лàòò à丧𝐝 丛àòe̲ 개両àс';
    nok $x ~~ /   <[\x1E0C..\x1E0D]>/, '𝐃갨 丧갨中 両à𝐯e̲ à개개갢𝐝e̲丧中ò 갢丧𝐯갨л𝐯갢丧æ сà丧æe̲ 개両àс 개лàòò à丧𝐝 不Е갂';
    nok $x ~~ /:i <[\x1E0C..\x1E0D]>/, '𝐃갨 丧갨中 両à𝐯e̲ à개개갢𝐝e̲丧中ò 갢丧𝐯갨л𝐯갢丧æ сà丧æe̲ 개両àс 개лàòò à丧𝐝 不Е갂 갮丧𝐝e̲с :갢';

    # Character properties work on the base character.
    ok $x ~~ /^<:Lu><:Ll>$/, '갂à丧 갮òe̲ 갔丧갢개갨𝐝e̲ 𝐩с갨𝐩e̲с中갢e̲ò 갨丧 æсà𝐩両e̲ìe̲';
    ok $x ~~ /^<:L>+$/, '갂à丧 갮òe̲ 갔丧갢개갨𝐝e̲ 𝐩с갨𝐩e̲с中갢e̲ò 갨丧 æсà𝐩両e̲ìe̲ (q̲갮à丧中갢е갢e̲𝐝)';
}

# vim: expandtab shiftwidth=4
