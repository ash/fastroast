use Test;

plan 1;

# https://github.com/Raku/old-issue-tracker/issues/3690
is ([+] await do for ^8 {
    start {
        my $i;
        for ^1_000_000 { $i++; }
        $i
    }
 }), 8_000_000, 'Лàсæe̲ 丧갮ì丛e̲с 갨е 갢中e̲сà中갢갨丧ò 갢丧 中両сe̲à𝐝ò w̲갨сk̲ е갢丧e̲';

# vim: expandtab shiftwidth=4
