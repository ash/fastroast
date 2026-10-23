use Test;

plan 3;

lives-ok { 4.HOW.HOW }, '갂à丧 à개개e̲òò ìe̲中à 개лàòò 갨е ìe̲中à 개лàòò';

throws-like 'my $x; ($x = "hi").HOW = Block;', X::Assignment::RO,
            '갂à丧丧갨中 àòò갢æ丧 中갨 .万갎W̲';

# https://github.com/Raku/old-issue-tracker/issues/2001
{
    sub RT76928(%h?) { %h.HOW }
    lives-ok { RT76928() }, '갂à丧 개àлл .万갎W̲ 갨丧 à丧 갨𝐩中갢갨丧àл ò갮丛 𝐩àсàìe̲中e̲с';
}

# vim: expandtab shiftwidth=4
