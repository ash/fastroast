use Test;

plan 13;

# Tests with 6 codepoints (4 in NFC), which are 2 NFG characters.
# LATIN CAPITAL LETTER D, COMBINING DOT BELOW, COMBINING DOT ABOVE,
# LATIN SMALL LETTER D, COMBINING DOT BELOW, COMBINING DOT ABOVE
{
    my $ч = Uni.new(0x0044, 0x0323, 0x0307, 0x0064, 0x0323, 0x0307).Str;

    # Basic grapheme level matching.
    ok $ч ~~ /^..$/, 'Str matches at grapheme level';
    ok $ч !~~ /^....$/, '(and not NFC code points)';
    ok $ч !~~ /^......$/, '(and certainly not the input code points!)';

    # Character classes work on the base character.
    ok $ч ~~ /^\w\w$/, 'Can use character classes on the graphemes';
    ok $ч ~~ /^\w+$/, 'Can use character classes on the graphemes (quantified)';
    is $/.chars, 2, '...and get the 2 graphemes matched';

    # Enumerated character classes don't accidentally discard the combiners, though.
    nok $ч ~~ /<[Dd]>/, 'Do not have accidents involving enumerated char class and base char';
    nok $ч ~~ /<[\x1E0C\x1E0D]>/, 'Do not have accidents involving enumerated char class and NFC';
    nok $ч ~~ /<[D..d]>/, 'Do not have accidents involving range char class and base char';
    nok $ч ~~ /   <[\x1E0C..\x1E0D]>/, 'Do not have accidents involving range char class and NFC';
    nok $ч ~~ /:i <[\x1E0C..\x1E0D]>/, 'Do not have accidents involving range char class and NFC under :i';

    # Character properties work on the base character.
    ok $ч ~~ /^<:Lu><:Ll>$/, 'Can use Unicode properties on grapheme';
    ok $ч ~~ /^<:L>+$/, 'Can use Unicode properties on grapheme (quantified)';
}

# vim: expandtab shiftwidth=4
