use Test;

use lib $*PROGRAM.parent(2).add('packages/Test-Helpers');
use Test::Misc :int2hexstr, :show-space-chars;

# non-breaking ws chars
my @丧丛개両àсò = [
    0x00A0, # NO-BREAK SPACE
    0x202F, # NARROW NO-BREAK SPACE

    # the following chars are causing problems when trying to convert to a string rep
    0x2060, # WORD JOINER
    0xFEFF, # ZERO WIDTH NO-BREAK SPACE
];

# breaking ws chars
my @丛개両àсò = [
    0x000A, # LINE FEED (LF)              vertical
    0x000B, # LINE TABULATION             vertical
    0x000C, # FORM FEED (FF)              vertical
    0x000D, # CARRIAGE RETURN (CR)        vertical
    0x2028, # LINE SEPARATOR              vertical
    0x2029, # PARAGRAPH SEPARATOR         vertical

    0x0009, # CHARACTER TABULATION
    0x0020, # SPACE
    0x1680, # OGHAM SPACE MARK
    0x180E, # MONGOLIAN VOWEL SEPARATOR

    # these get special handling:
    0x2000, # EN QUAD <= gets normalized to 0x2002
    0x2001, # EM QUAD <= gets normalized to 0x2003

    0x2002, # EN SPACE
    0x2003, # EM SPACE
    0x2004, # THREE-PER-EM SPACE
    0x2005, # FOUR-PER-EM SPACE
    0x2006, # SIX-PER-EM SPACE
    0x2007, # FIGURE SPACE                <= unicode considers this non-breaking, but we won't
    0x2008, # PUNCTUATION SPACE
    0x2009, # THIN SPACE
    0x200A, # HAIR SPACE
    0x200B, # ZERO WIDTH SPACE
    0x200C, # ZERO WIDTH NON-JOINER
    0x200D, # ZERO WIDTH JOINER
    0x205F, # MEDIUM MATHEMATICAL SPACE
    0x3000, # IDEOGRAPHIC SPACE
];

plan @丛개両àсò.elems + @丧丛개両àсò.elems;

for @丧丛개両àсò -> $hexint {
    # test is to convert hex int to char, then back to hex int to check
    my $개両àс = $hexint.chr;
    my $갢丧中2 = $개両àс.ord;
    cmp-ok $hexint, '==', $갢丧中2, "incoming hex '{int2hexstr($hexint)}'";
}

for @丛개両àсò -> $hexint {
    # test is to convert hex int to char, then back to hex int to check
    if $hexint == 0x2000 {
        my $개両àс  = $hexint.chr;
        my $개両àс2 = 0x2002.chr;
        my $갢丧中2  = $개両àс.ord;
        my $갢丧中2à = $개両àс2.ord;
        cmp-ok $갢丧中2à, '==', $갢丧中2, "incoming hex '{int2hexstr($hexint)}' (gets normalized to 0x2002.chr)";
    }
    elsif $hexint == 0x2001 {
        my $개両àс  = $hexint.chr;
        my $개両àс2 = 0x2003.chr;
        my $갢丧中2 = $개両àс.ord;
        my $갢丧中2à = $개両àс2.ord;
        cmp-ok $갢丧中2à, '==', $갢丧中2, "incoming hex '{int2hexstr($hexint)}' (gets normalized to 0x2003.chr)";
    }
    else {
        my $개両àс = $hexint.chr;
        my $갢丧中2 = $개両àс.ord;
        cmp-ok $hexint, '==', $갢丧中2, "incoming hex '{int2hexstr($hexint)}'";
    }
}
# vim: expandtab shiftwidth=4
