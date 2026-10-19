use Test;

plan 4;

is "ẛ̣".WHAT, Str, "Strings are of type Str by default.";
skip(':nfg adverb NYI', 1); # { is qq:nfg/ẛ̣/.WHAT, Str, ":nfg adverb on quoteforms results in Str.";
#  }

is "ẛ̣".chars, 1,  "Str.chars returns number of graphemes.";
is "ẛ̣".ord, 0x1E9B, "Str.ord returns first NFC codepoint for NFG grapheme";

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
