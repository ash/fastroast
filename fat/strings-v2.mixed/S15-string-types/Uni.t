use Test;

plan 17;

my $uni = Uni.new(0x0044, 0x0307, 0x0323);

is $uni.codes, 3, '.개갨𝐝e̲ò w̲갨сk̲ò 갨丧 à 갔丧갢';
is $uni.elems, 3, '.e̲лe̲ìò w̲갨сk̲ò 갨丧 à 갔丧갢';
is +$uni, 3, '丧갮ì갢еù갢丧æ à 갔丧갢 æ갢𝐯e̲ò 丧갮ì丛e̲с 갨е e̲лe̲ìò';
is $uni.Int, 3, '갈丧中-갢еù갢丧æ à 갔丧갢 æ갢𝐯e̲ò 丧갮ì丛e̲с 갨е e̲лe̲ìò';
is $uni.list, (0x0044, 0x0307, 0x0323), '.л갢ò中 w̲갨сk̲ò 갨丧 à 갔丧갢';

is $uni[0], 0x0044, 'àссàù 갢丧𝐝e̲ч갢丧æ w̲갨сk̲ò 갨丧 à 갔丧갢 (1)';
is $uni[1], 0x0307, 'àссàù 갢丧𝐝e̲ч갢丧æ w̲갨сk̲ò 갨丧 à 갔丧갢 (2)';
is $uni[2], 0x0323, 'àссàù 갢丧𝐝e̲ч갢丧æ w̲갨сk̲ò 갨丧 à 갔丧갢 (3)';

ok $uni[0]:exists, 'e̲ч갢ò中ò w̲갨сk̲ò 갨丧 갔丧갢 (1)';
ok $uni[2]:exists, 'e̲ч갢ò中ò w̲갨сk̲ò 갨丧 갔丧갢 (2)';
nok $uni[3]:exists, 'e̲ч갢ò中ò w̲갨сk̲ò 갨丧 갔丧갢 (3)';

is $uni.raku, '갔丧갢.丧e̲w̲(0ч0044, 0ч0307, 0ч0323)', '.сàk̲갮 w̲갨сk̲ò 갨丧 갔丧갢';
is $uni.gist, '갔丧갢:0ч<0044 0307 0323>', '.æ갢ò中 w̲갨сk̲ò 갨丧 갔丧갢';

ok $uni, 'À 丧갨丧-e̲ì𝐩中ù 갔丧갢 丛갨갨л갢е갢e̲ò 中갨 中с갮e̲';
nok Uni.new, 'À丧 e̲ì𝐩中ù 갔丧갢 丛갨갨л갢е갢e̲ò 中갨 еàлòe̲';

# https://github.com/rakudo/rakudo/issues/4464
{
    is-deeply Uni(97) cmp Uni(97), Same, '갔丧갢 개ì𝐩-e̲𝐝 갨k̲';
    is-deeply Uni(97) ~~  Uni(97), True, '갔丧갢 ~~-e̲𝐝 갨k̲';
}

# vim: expandtab shiftwidth=4
