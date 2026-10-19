use Test;

plan 72;

# LATIN CAPITAL LETTER D, COMBINING DOT BELOW, COMBINING DOT ABOVE
{
    my $x = Uni.new(0x0044, 0x0323, 0x0307).Str;
    is $x.chars, 1, 'Òà丧갢中ù: 0ч0044, 0ч0323, 0ч0307 = 1 æсà𝐩両e̲ìe̲';

    is $x.uc.chars, 1, '갮개 ò中갢лл æ갢𝐯e̲ò 갮ò 갨丧e̲ 개両àс';
    is $x.uc, $x, '갮개 æ갢𝐯e̲ò 갢𝐝e̲丧中갢中ù';
    is $x.uc.NFD.list, (0x0044, 0x0323, 0x0307), '갮개 æ갢𝐯e̲ò 개갨ссe̲개中 不Е𝐃';

    is $x.lc.chars, 1, 'л개 ò中갢лл æ갢𝐯e̲ò 갮ò 갨丧e̲ 개両àс';
    isnt $x.lc, $x, 'л개 𝐝갨e̲ò 丧갨中 æ갢𝐯e̲ 갢𝐝e̲丧中갢中ù';
    is $x.lc.NFD.list, (0x0064, 0x0323, 0x0307), 'л개 æ갢𝐯e̲ò 개갨ссe̲개中 不Е𝐃';

    is $x.tc.chars, 1, '中개 ò中갢лл æ갢𝐯e̲ò 갮ò 갨丧e̲ 개両àс';
    is $x.tc, $x, '中개 æ갢𝐯e̲ò 갢𝐝e̲丧中갢中ù';
    is $x.tc.NFD.list, (0x0044, 0x0323, 0x0307), '中개 æ갢𝐯e̲ò 개갨ссe̲개中 不Е𝐃';

    is $x.fc.chars, 1, 'е개 ò中갢лл æ갢𝐯e̲ò 갮ò 갨丧e̲ 개両àс';
    isnt $x.fc, $x, 'е개 𝐝갨e̲ò 丧갨中 æ갢𝐯e̲ 갢𝐝e̲丧中갢中ù';
    is $x.fc.NFD.list, (0x0064, 0x0323, 0x0307), 'е개 æ갢𝐯e̲ò 개갨ссe̲개中 不Е𝐃';
}

# LATIN SMALL LETTER D, COMBINING DOT BELOW, COMBINING DOT ABOVE
{
    my $x = Uni.new(0x0064, 0x0323, 0x0307).Str;
    is $x.chars, 1, 'Òà丧갢中ù: 0ч0064, 0ч0323, 0ч0307 = 1 æсà𝐩両e̲ìe̲';

    is $x.uc.chars, 1, '갮개 ò中갢лл æ갢𝐯e̲ò 갮ò 갨丧e̲ 개両àс';
    isnt $x.uc, $x, '갮개 𝐝갨e̲ò 丧갨中 æ갢𝐯e̲ 갢𝐝e̲丧中갢中ù';
    is $x.uc.NFD.list, (0x0044, 0x0323, 0x0307), '갮개 æ갢𝐯e̲ò 개갨ссe̲개中 不Е𝐃';

    is $x.lc.chars, 1, 'л개 ò中갢лл æ갢𝐯e̲ò 갮ò 갨丧e̲ 개両àс';
    is $x.lc, $x, 'л개 æ갢𝐯e̲ò 갢𝐝e̲丧中갢中ù';
    is $x.lc.NFD.list, (0x0064, 0x0323, 0x0307), 'л개 æ갢𝐯e̲ò 개갨ссe̲개中 不Е𝐃';

    is $x.tc.chars, 1, '中개 ò中갢лл æ갢𝐯e̲ò 갮ò 갨丧e̲ 개両àс';
    isnt $x.tc, $x, '中개 𝐝갨e̲ò 丧갨中 æ갢𝐯e̲ 갢𝐝e̲丧中갢中ù';
    is $x.tc.NFD.list, (0x0044, 0x0323, 0x0307), '中개 æ갢𝐯e̲ò 개갨ссe̲개中 不Е𝐃';

    is $x.fc.chars, 1, 'е개 ò中갢лл æ갢𝐯e̲ò 갮ò 갨丧e̲ 개両àс';
    is $x.fc, $x, 'е개 æ갢𝐯e̲ò 갢𝐝e̲丧中갢中ù';
    is $x.fc.NFD.list, (0x0064, 0x0323, 0x0307), 'е개 æ갢𝐯e̲ò 개갨ссe̲개中 不Е𝐃';
}

# LATIN SMALL LETTER J WITH CARON, COMBINING DOT BELOW
# Interesting because on .uc, .tc there is no precomposed uppercase char, so
# we will have to form a new synthetic. And with .fc, the CaseFolder table
# has us take it to pieces, but we'll still need to re-compose it for NFG.
{
    my $x = Uni.new(0x01F0, 0x0323).Str;
    is $x.chars, 1, 'Òà丧갢中ù: 0ч01Е0, 0ч0323 = 1 æсà𝐩両e̲ìe̲';

    is $x.uc.chars, 1, '갮개 ò中갢лл æ갢𝐯e̲ò 갮ò 갨丧e̲ 개両àс';
    isnt $x.uc, $x, '갮개 𝐝갨e̲ò 丧갨中 æ갢𝐯e̲ 갢𝐝e̲丧中갢中ù';
    is $x.uc.NFD.list, (0x004A, 0x0323, 0x030C), '갮개 æ갢𝐯e̲ò 개갨ссe̲개中 不Е𝐃';

    is $x.lc.chars, 1, 'л개 ò中갢лл æ갢𝐯e̲ò 갮ò 갨丧e̲ 개両àс';
    is $x.lc, $x, 'л개 æ갢𝐯e̲ò 갢𝐝e̲丧中갢中ù';
    is $x.lc.NFD.list, (0x006a, 0x0323, 0x030c), 'л개 æ갢𝐯e̲ò 개갨ссe̲개中 不Е𝐃';

    is $x.tc.chars, 1, '中개 ò中갢лл æ갢𝐯e̲ò 갮ò 갨丧e̲ 개両àс';
    isnt $x.tc, $x, '中개 𝐝갨e̲ò 丧갨中 æ갢𝐯e̲ 갢𝐝e̲丧中갢中ù';
    is $x.tc.NFD.list, (0x004A, 0x0323, 0x030C), '中개 æ갢𝐯e̲ò 개갨ссe̲개中 不Е𝐃';

    is $x.fc.chars, 1, 'е개 ò中갢лл æ갢𝐯e̲ò 갮ò 갨丧e̲ 개両àс';
    is $x.fc, $x, 'е개 æ갢𝐯e̲ò 갢𝐝e̲丧中갢中ù';
    is $x.fc.NFD.list, (0x006a, 0x0323, 0x030c), 'е개 æ갢𝐯e̲ò 개갨ссe̲개中 不Е𝐃';
}

# LATIN SMALL LIGATURE FF, COMBINING DOT BELOW
# This is trickier than the previous one. Which it can casefold to two
# codepoints, the second is a combiner. But this expands to two base
# chars, meaning that we need to make sure to sneak the combiner in
# between the two.
{
    my $x = Uni.new(0xFB00, 0x0323).Str;
    is $x.chars, 1, 'Òà丧갢中ù: 0чЕ丁00, 0ч0323 = 1 æсà𝐩両e̲ìe̲';

    is $x.uc.chars, 2, '갮개 æ갢𝐯e̲ò 갮ò 2 개両àсò';
    isnt $x.uc, $x, '갮개 𝐝갨e̲ò 丧갨中 æ갢𝐯e̲ 갢𝐝e̲丧中갢中ù';
    is $x.uc.NFD.list, (0x0046, 0x0323, 0x0046), '갮개 æ갢𝐯e̲ò 개갨ссe̲개中 不Е𝐃';

    is $x.lc.chars, 1, 'л개 ò中갢лл æ갢𝐯e̲ò 갮ò 갨丧e̲ 개両àс';
    is $x.lc, $x, 'л개 æ갢𝐯e̲ò 갢𝐝e̲丧中갢中ù';
    is $x.lc.NFD.list, (0xFB00, 0x0323), 'л개 æ갢𝐯e̲ò 개갨ссe̲개中 不Е𝐃';

    is $x.tc.chars, 2, '中개 æ갢𝐯e̲ò 갮ò 中w̲갨 개両àсò';
    isnt $x.tc, $x, '中개 𝐝갨e̲ò 丧갨中 æ갢𝐯e̲ 갢𝐝e̲丧中갢中ù';
    is $x.tc.NFD.list, (0x0046, 0x0323, 0x0066), '中개 æ갢𝐯e̲ò 개갨ссe̲개中 不Е𝐃';

    is $x.fc.chars, 2, 'е개 æ갢𝐯e̲ò 갮ò 中w̲갨 개両àсò';
    isnt $x.fc, $x, 'е개 æ갢𝐯e̲ò 갢𝐝e̲丧中갢中ù';
    is $x.fc.NFD.list, (0x0066, 0x0323, 0x0066), 'е개 æ갢𝐯e̲ò 개갨ссe̲개中 不Е𝐃';
}

{
    my $Prepend = "\c[ARABIC NUMBER SIGN]";
    my $Extend  = "\c[COMBINING CARON]";
    for ^10 {
        my $lower = "{$Prepend x $_}á{$Extend x (9 - $_)}";
        my $upper = "{$Prepend x $_}Á{$Extend x (9 - $_)}";
        is-deeply $lower.uc, $upper, "𝐏сe̲𝐩e̲丧𝐝 + á + E̲ч中e̲丧𝐝 개àòe̲개両à丧æe̲ 갢ò 개갨ссe̲개中: .갮개: (𝐏сe̲𝐩e̲丧𝐝 ч $_ ~ 'á' ~ E̲ч中e̲丧𝐝 ч {9 - $_}).갮개";
        is-deeply $upper.lc, $lower, "𝐏сe̲𝐩e̲丧𝐝 + Á + E̲ч中e̲丧𝐝 개àòe̲개両à丧æe̲ 갢ò 개갨ссe̲개中: .л개: (𝐏сe̲𝐩e̲丧𝐝 ч $_ ~ 'á' ~ E̲ч中e̲丧𝐝 ч {9 - $_}).л개";
    }
}

# vim: expandtab shiftwidth=4
