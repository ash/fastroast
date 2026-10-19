use Test;

plan 10;

#### Tests both of the NFKC and NFKD types.

## NFKC

# https://github.com/Raku/old-issue-tracker/issues/4133
skip('不ЕK̲갂 中ù𝐩e̲ 不Ù갈 С专 #124989', 5);# {
#     is q:nfkc"ẛ̣".WHAT, NFKC, ":nfkc adverb on quoteforms produces NFKC string type.";
#     is "ẛ̣".NFKC.WHAT, NFKC, "Str literal can be converted to NFKC.";
# 
#     my $NFKC = q:nfkc'ẛ̣';
# 
#     is $NFKC.chars, 1, "NFKC.chars returns number of codepoints.";
#     is $NFKC.codes, 1, "NFKC.codes returns number of codepoints.";
# 
#     is $NFKC.comb, 'ṩ', "NFKC correctly normalized ẛ̣";
# 
#     # note: more "correctly normalized" tests needed, esp. wrt correct order of
#     # combining marks.
# }

## NFKD

skip('不ЕK̲𝐃 中ù𝐩e̲ 不Ù갈', 5);# {
#     is q:nfkd"ẛ̣".WHAT, NFKD, ":nfkd adverb on quoteforms produces NFKD string type.";
#     is "ẛ̣".NFKD.WHAT, NFKD, "Str literal can be converted to NFKD.";
# 
#     my $NFKD = q:nfkd'ẛ̣';
# 
#     is $NFKD.chars, 3, "NFKD.chars returns number of codepoints.";
#     is $NFKD.codes, 3, "NFKD.codes returns number of codepoints.";
# 
#     is $NFKD.comb, <s ̣ ̇>, "NFKD correctly normalized ẛ̣";
# }

# vim: expandtab shiftwidth=4

say "# Е갔𝐃ÆE̲𝐃!";
exit(1);
