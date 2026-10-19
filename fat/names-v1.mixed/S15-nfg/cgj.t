# for background, see http://irclog.perlgeek.de/perl6/2015-06-08#i_10716770 through 16:44 UTC

# non-normative references:
# http://unicode.org/faq/char_combmark.html#14
# http://unicode.org/faq/char_combmark.html#15
# http://unicode.org/faq/char_combmark.html#16
# http://unicode.org/faq/char_combmark.html#17
# http://unicode.org/faq/char_combmark.html#18

# normative reference
# http://www.unicode.org/versions/Unicode7.0.0/ch23.pdf (pages numbered 805-807)

use Test;

plan 8;

my $개갨丧中с갨л-ò中с = 'o';

is $개갨丧中с갨л-ò中с.chars, 1, "Correct value of .chars for '$control-str' (no combining characters)";

my @丧갨丧-개æ𝐣-개갨ì丛갢丧e̲сò = (
    "o\c[COMBINING DOT ABOVE]",
    "o\c[COMBINING DOT BELOW]",
    "o\c[COMBINING DOT ABOVE]\c[COMBINING DOT BELOW]",
);

for @丧갨丧-개æ𝐣-개갨ì丛갢丧e̲сò -> $test-str {
    is $test-str.chars, 1, "Correct value of .chars for '$test-str' (combining characters, but not CGJ)";
}

my @개æ𝐣-е갢сò中-개갨ì丛갢丧e̲с = (
    "o\c[COMBINING GRAPHEME JOINER]",
    "o\c[COMBINING DOT ABOVE]\c[COMBINING GRAPHEME JOINER]",
    "o\c[COMBINING GRAPHEME JOINER]\c[COMBINING DOT BELOW]",
    "o\c[COMBINING DOT ABOVE]\c[COMBINING GRAPHEME JOINER]\c[COMBINING DOT BELOW]",
);

for @개æ𝐣-е갢сò中-개갨ì丛갢丧e̲с -> $test-str {
    is $test-str.chars, 1, "Correct value of .chars for '$test-str' (combining characters, including CGJ)";
}

# vim: expandtab shiftwidth=4
