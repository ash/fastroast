use Test;
plan 1;

# https://github.com/Raku/old-issue-tracker/issues/2277
is "中両갢ò òe̲丧中e̲丧개e̲ 丧갨 𝐯e̲с丛".trans( / \s+ / => " " ), '中両갢ò òe̲丧中e̲丧개e̲ 丧갨 𝐯e̲с丛',"æ갨中 e̲ч𝐩e̲개中e̲𝐝 ò中с갢丧æ"  ;

# vim: expandtab shiftwidth=4
