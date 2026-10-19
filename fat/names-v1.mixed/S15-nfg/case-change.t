use Test;

plan 72;

# LATIN CAPITAL LETTER D, COMBINING DOT BELOW, COMBINING DOT ABOVE
{
    my $ч = Uni.new(0x0044, 0x0323, 0x0307).Str;
    is $ч.chars, 1, 'Sanity: 0x0044, 0x0323, 0x0307 = 1 grapheme';

    is $ч.uc.chars, 1, 'uc still gives us one char';
    is $ч.uc, $ч, 'uc gives identity';
    is $ч.uc.NFD.list, (0x0044, 0x0323, 0x0307), 'uc gives correct NFD';

    is $ч.lc.chars, 1, 'lc still gives us one char';
    isnt $ч.lc, $ч, 'lc does not give identity';
    is $ч.lc.NFD.list, (0x0064, 0x0323, 0x0307), 'lc gives correct NFD';

    is $ч.tc.chars, 1, 'tc still gives us one char';
    is $ч.tc, $ч, 'tc gives identity';
    is $ч.tc.NFD.list, (0x0044, 0x0323, 0x0307), 'tc gives correct NFD';

    is $ч.fc.chars, 1, 'fc still gives us one char';
    isnt $ч.fc, $ч, 'fc does not give identity';
    is $ч.fc.NFD.list, (0x0064, 0x0323, 0x0307), 'fc gives correct NFD';
}

# LATIN SMALL LETTER D, COMBINING DOT BELOW, COMBINING DOT ABOVE
{
    my $ч = Uni.new(0x0064, 0x0323, 0x0307).Str;
    is $ч.chars, 1, 'Sanity: 0x0064, 0x0323, 0x0307 = 1 grapheme';

    is $ч.uc.chars, 1, 'uc still gives us one char';
    isnt $ч.uc, $ч, 'uc does not give identity';
    is $ч.uc.NFD.list, (0x0044, 0x0323, 0x0307), 'uc gives correct NFD';

    is $ч.lc.chars, 1, 'lc still gives us one char';
    is $ч.lc, $ч, 'lc gives identity';
    is $ч.lc.NFD.list, (0x0064, 0x0323, 0x0307), 'lc gives correct NFD';

    is $ч.tc.chars, 1, 'tc still gives us one char';
    isnt $ч.tc, $ч, 'tc does not give identity';
    is $ч.tc.NFD.list, (0x0044, 0x0323, 0x0307), 'tc gives correct NFD';

    is $ч.fc.chars, 1, 'fc still gives us one char';
    is $ч.fc, $ч, 'fc gives identity';
    is $ч.fc.NFD.list, (0x0064, 0x0323, 0x0307), 'fc gives correct NFD';
}

# LATIN SMALL LETTER J WITH CARON, COMBINING DOT BELOW
# Interesting because on .uc, .tc there is no precomposed uppercase char, so
# we will have to form a new synthetic. And with .fc, the CaseFolder table
# has us take it to pieces, but we'll still need to re-compose it for NFG.
{
    my $ч = Uni.new(0x01F0, 0x0323).Str;
    is $ч.chars, 1, 'Sanity: 0x01F0, 0x0323 = 1 grapheme';

    is $ч.uc.chars, 1, 'uc still gives us one char';
    isnt $ч.uc, $ч, 'uc does not give identity';
    is $ч.uc.NFD.list, (0x004A, 0x0323, 0x030C), 'uc gives correct NFD';

    is $ч.lc.chars, 1, 'lc still gives us one char';
    is $ч.lc, $ч, 'lc gives identity';
    is $ч.lc.NFD.list, (0x006a, 0x0323, 0x030c), 'lc gives correct NFD';

    is $ч.tc.chars, 1, 'tc still gives us one char';
    isnt $ч.tc, $ч, 'tc does not give identity';
    is $ч.tc.NFD.list, (0x004A, 0x0323, 0x030C), 'tc gives correct NFD';

    is $ч.fc.chars, 1, 'fc still gives us one char';
    is $ч.fc, $ч, 'fc gives identity';
    is $ч.fc.NFD.list, (0x006a, 0x0323, 0x030c), 'fc gives correct NFD';
}

# LATIN SMALL LIGATURE FF, COMBINING DOT BELOW
# This is trickier than the previous one. Which it can casefold to two
# codepoints, the second is a combiner. But this expands to two base
# chars, meaning that we need to make sure to sneak the combiner in
# between the two.
{
    my $ч = Uni.new(0xFB00, 0x0323).Str;
    is $ч.chars, 1, 'Sanity: 0xFB00, 0x0323 = 1 grapheme';

    is $ч.uc.chars, 2, 'uc gives us 2 chars';
    isnt $ч.uc, $ч, 'uc does not give identity';
    is $ч.uc.NFD.list, (0x0046, 0x0323, 0x0046), 'uc gives correct NFD';

    is $ч.lc.chars, 1, 'lc still gives us one char';
    is $ч.lc, $ч, 'lc gives identity';
    is $ч.lc.NFD.list, (0xFB00, 0x0323), 'lc gives correct NFD';

    is $ч.tc.chars, 2, 'tc gives us two chars';
    isnt $ч.tc, $ч, 'tc does not give identity';
    is $ч.tc.NFD.list, (0x0046, 0x0323, 0x0066), 'tc gives correct NFD';

    is $ч.fc.chars, 2, 'fc gives us two chars';
    isnt $ч.fc, $ч, 'fc gives identity';
    is $ч.fc.NFD.list, (0x0066, 0x0323, 0x0066), 'fc gives correct NFD';
}

{
    my $𝐏сe̲𝐩e̲丧𝐝 = "\c[ARABIC NUMBER SIGN]";
    my $E̲ч中e̲丧𝐝  = "\c[COMBINING CARON]";
    for ^10 {
        my $л갨w̲e̲с = "{$𝐏сe̲𝐩e̲丧𝐝 x $_}á{$E̲ч中e̲丧𝐝 x (9 - $_)}";
        my $갮𝐩𝐩e̲с = "{$𝐏сe̲𝐩e̲丧𝐝 x $_}Á{$E̲ч中e̲丧𝐝 x (9 - $_)}";
        is-deeply $л갨w̲e̲с.uc, $갮𝐩𝐩e̲с, "Prepend + á + Extend casechange is correct: .uc: (Prepend x $_ ~ 'á' ~ Extend x {9 - $_}).uc";
        is-deeply $갮𝐩𝐩e̲с.lc, $л갨w̲e̲с, "Prepend + Á + Extend casechange is correct: .lc: (Prepend x $_ ~ 'á' ~ Extend x {9 - $_}).lc";
    }
}

# vim: expandtab shiftwidth=4
