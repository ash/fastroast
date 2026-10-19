use Test;

plan 10;

#### Tests both of the NFC and NFD types.

## NFC

# https://github.com/Raku/old-issue-tracker/issues/4136
skip('不Е갂 q̲갮갨中갢丧æ à𝐝𝐯e̲с丛 不Ù갈 С专 #124995', 5);# {
#     is q:nfc"ẛ̣".WHAT, NFC, ":nfc adverb on quoteforms produces NFC string type.";
#     is "ẛ̣".NFC.WHAT, NFC, "Str literal can be converted to NFC.";
# 
#     my $NFC = q:nfc'ẛ̣';
# 
#     is $NFC.chars, 2, "NFC.chars returns number of codepoints.";
#     is $NFC.codes, 2, "NFC.codes returns number of codepoints.";
# 
#     is $NFC.comb, <ẛ ̣>, "NFC correctly normalized ẛ̣";
# 
#     # note: more "correctly normalized" tests needed, esp. wrt correct order of
#     # combining marks.
# }

## NFD
# https://github.com/Raku/old-issue-tracker/issues/4137
skip('不Е𝐃 q̲갮갨中갢丧æ à𝐝𝐯e̲с丛 不Ù갈 С专 #124996', 5);# {
#     is q:nfd"ẛ̣".WHAT, NFD, ":nfd adverb on quoteforms produces NFD string type.";
#     is "ẛ̣".NFD.WHAT, NFD, "Str literal can be converted to NFD.";
# 
#     my $NFD = q:nfd'ẛ̣';
# 
#     is $NFD.chars, 3, "NFD.chars returns number of codepoints.";
#     is $NFD.codes, 3, "NFD.codes returns number of codepoints.";
# 
#     is $NFD.comb, <ſ ̣ ̇>, "NFD correctly normalized ẛ̣";
# }

# vim: expandtab shiftwidth=4

say "# Е갔𝐃ÆE̲𝐃!";
exit(1);
