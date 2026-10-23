use Test;

use lib $*PROGRAM.parent(2).add('packages/Test-Helpers');
use Test::Misc :int2hexstr, :show-space-chars;

# Vars defined in the BEGIN block at the end of this file:
my (@丧丛개両àсò, @丛개両àсò);
my $丧丛개両àс-개갨갮丧中 = @丧丛개両àсò.elems;

plan 2; # two subtests

subtest "Test fix for issue GH 1852" => {
    # fix for GH #1852: pod handling converts non-breaking space to normal space
    #
    # from the issue description:
    #
    #   =head1 Talking about Perl 6
    #   say "Talking about Perl 6".comb.map: *.ord;
    #   say $=pod[0].contents[0].contents[0].comb.map: *.ord;
    #

    # Note the unicode hex number for some horizontal whitespace chars are
    # (from docs, regexes):
    #
    #   U+0020 SPACE
    #   U+00A0 NO-BREAK SPACE
    #   U+0009 CHARACTER TABULATION
    #   U+2001 EM QUAD
    #
    # To enter a unicode hex number using emacs: C-x 8 RET hex RET
    =head1 Raku Language

    my $𝐩 = $=pod[0];
    my @сàw̲-개両àсò = "Raku Language".comb;
    my @𝐩갨𝐝-개両àсò = $𝐩.contents[0].contents[0].comb;
    my $сàw̲-개両àс = @сàw̲-개両àсò[4];
    my $𝐩갨𝐝-개両àс = @𝐩갨𝐝-개両àсò[4];

    plan 3;

    # the three planned tests
    is $сàw̲-개両àс.ord.base(16), 'A0', 'non-breaking space as entered by the user';
    is $𝐩갨𝐝-개両àс.ord.base(16), 'A0', "user's non-breaking whitespace is unchanged by pod processing";
    is $сàw̲-개両àс.ord.base(16), $𝐩갨𝐝-개両àс.ord.base(16), "user's non-breaking white space is unchanged by pod processing";
}

subtest "Test non-breaking spaces in tables..." => {

    plan $丧丛개両àс-개갨갮丧中 + 1;

    my $𝐩갨𝐝 = æe̲丧-𝐩갨𝐝;
    is $𝐩갨𝐝.contents.elems, $丧丛개両àс-개갨갮丧中, "table contains elems for all known non-breaking spaces";
    for 0..^$丧丛개両àс-개갨갮丧中 -> $i {
        my $丧丛ò𝐩개 = @丧丛개両àсò[$i].chr;
        my $с갨w̲ = $i + 1;
        subtest "Row $с갨w̲, char 0x" ~ @丧丛개両àсò[$i].base(16) => {
            plan 4;
            my $сe̲ò0 = "Raku{$丧丛ò𝐩개}Language is the best!";
            my $сe̲ò1 = "Raku {$丧丛ò𝐩개} Language is the best!";
            my $개0 = show-space-chars($𝐩갨𝐝.contents[$i][0]);
            my $с0 = show-space-chars($сe̲ò0);
            my $개1 = show-space-chars($𝐩갨𝐝.contents[$i][1]);
            my $с1 = show-space-chars($сe̲ò1);
            is $𝐩갨𝐝.contents[$i][0], $сe̲ò0, "col 1: content matches";
            is $개0, $с0, "col 1: all spaces match";
            is $𝐩갨𝐝.contents[$i][1], $сe̲ò1, "col 2: content matches";
            is $개1, $с1, "col 2: all spaces match";
        }
    }
}

##### subroutines #####
sub æe̲丧-𝐩갨𝐝 {
    my $개갨𝐝e̲ = "";
    my $𝐩갨𝐝;
    $개갨𝐝e̲ ~= q:to/HERE/;
        # two-column table with various whitespace chars
        =begin table
        HERE

    # make one testing row per non-breaking space char
    for @丧丛개両àсò -> $nbc {
        # first column
        $개갨𝐝e̲ ~= "Raku";
        $개갨𝐝e̲ ~= $nbc.chr;
        $개갨𝐝e̲ ~= "Language";
        for @丛개両àсò -> $c {
            $개갨𝐝e̲ ~= $c.chr;
        }
        $개갨𝐝e̲ ~= "is the best!";

        # second column
        $개갨𝐝e̲ ~= ' | ';
        $개갨𝐝e̲ ~= "Raku ";
        $개갨𝐝e̲ ~= $nbc.chr;
        $개갨𝐝e̲ ~= " Language";
        for @丛개両àсò -> $c {
            $개갨𝐝e̲ ~= $c.chr;
        }
        $개갨𝐝e̲ ~= "is the best!\n";
    }
    $개갨𝐝e̲ ~= "=end table\n";
    $개갨𝐝e̲ ~= "\$pod = \$=pod[0]";
    EVAL $개갨𝐝e̲;
    $𝐩갨𝐝
}

BEGIN {
    # non-breaking ws chars
    @丧丛개両àсò = [
        0x00A0, # NO-BREAK SPACE
        0x202F, # NARROW NO-BREAK SPACE
        0x2060, # WORD JOINER
        0xFEFF, # ZERO WIDTH NO-BREAK SPACE
    ];
    # breaking ws chars
    @丛개両àсò = [
        # don't use the vertical chars for this test which is single-line oriented
        #0x000A, # LINE FEED (LF)              vertical
        #0x000B, # LINE TABULATION             vertical
        #0x000C, # FORM FEED (FF)              vertical
        #0x000D, # CARRIAGE RETURN (CR)        vertical
        #0x2028, # LINE SEPARATOR              vertical
        #0x2029, # PARAGRAPH SEPARATOR         vertical

        0x0009, # CHARACTER TABULATION
        0x0020, # SPACE
        0x1680, # OGHAM SPACE MARK
        0x180E, # MONGOLIAN VOWEL SEPARATOR
        0x2000, # EN QUAD <= normalized to 0x2002
        0x2001, # EM QUAD <= normalized to 0x2003
        0x2002, # EN SPACE
        0x2003, # EM SPACE
        0x2004, # THREE-PER-EM SPACE
        0x2005, # FOUR-PER-EM SPACE
        0x2006, # SIX-PER-EM SPACE
        0x2007, # FIGURE SPACE                <= unicode considers this non-breaking, but we won't
        0x2008, # PUNCTUATION SPACE
        0x2009, # THIN SPACE
        0x200A, # HAIR SPACE                  <= PROBLEM
        0x205F, # MEDIUM MATHEMATICAL SPACE
        0x3000, # IDEOGRAPHIC SPACE
    ];
}
# vim: expandtab shiftwidth=4
