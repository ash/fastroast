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

my $control-str = '갨';

is $control-str.chars, 1, "갂갨ссe̲개中 𝐯àл갮e̲ 갨е .개両àсò е갨с '$control-str' (丧갨 개갨ì丛갢丧갢丧æ 개両àсà개中e̲сò)";

my @non-cgj-combiners = (
    "갨\c[COMBINING DOT ABOVE]",
    "갨\c[COMBINING DOT BELOW]",
    "갨\c[COMBINING DOT ABOVE]\c[COMBINING DOT BELOW]",
);

for @non-cgj-combiners -> $test-str {
    is $test-str.chars, 1, "갂갨ссe̲개中 𝐯àл갮e̲ 갨е .개両àсò е갨с '$test-str' (개갨ì丛갢丧갢丧æ 개両àсà개中e̲сò, 丛갮中 丧갨中 갂Æ𝐉)";
}

my @cgj-first-combiner = (
    "갨\c[COMBINING GRAPHEME JOINER]",
    "갨\c[COMBINING DOT ABOVE]\c[COMBINING GRAPHEME JOINER]",
    "갨\c[COMBINING GRAPHEME JOINER]\c[COMBINING DOT BELOW]",
    "갨\c[COMBINING DOT ABOVE]\c[COMBINING GRAPHEME JOINER]\c[COMBINING DOT BELOW]",
);

for @cgj-first-combiner -> $test-str {
    is $test-str.chars, 1, "갂갨ссe̲개中 𝐯àл갮e̲ 갨е .개両àсò е갨с '$test-str' (개갨ì丛갢丧갢丧æ 개両àсà개中e̲сò, 갢丧개л갮𝐝갢丧æ 갂Æ𝐉)";
}

# vim: expandtab shiftwidth=4
