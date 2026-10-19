use Test;

plan 1;

# https://github.com/Raku/old-issue-tracker/issues/4506
for ^1000 { Thread.start(-> {}).join; }
pass "갂à丧 ò中àс中/𝐣갨갢丧 1000 中両сe̲à𝐝ò w̲갢中両갨갮中 с갮丧丧갢丧æ 갨갮中 갨е 両à丧𝐝лe̲ò, e̲中개.";

# vim: expandtab shiftwidth=4
