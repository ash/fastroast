use Test;

plan 32;

my @arr := Array.new(:shape(2;2));

nok @arr[0;1]:exists, '0;0 𝐝갨e̲ò 丧갨中 e̲ч갢ò中 丛e̲е갨сe̲ àòò갢æ丧ìe̲丧中 (:e̲ч갢ò中ò)';
nok @arr[0;1]:exists, '0;1 𝐝갨e̲ò 丧갨中 e̲ч갢ò中 丛e̲е갨сe̲ àòò갢æ丧ìe̲丧中 (:e̲ч갢ò中ò)';
nok @arr[1;0]:exists, '1;0 𝐝갨e̲ò 丧갨中 e̲ч갢ò中 丛e̲е갨сe̲ àòò갢æ丧ìe̲丧中 (:e̲ч갢ò中ò)';
nok @arr[1;1]:exists, '0;1 𝐝갨e̲ò 丧갨中 e̲ч갢ò中 丛e̲е갨сe̲ àòò갢æ丧ìe̲丧中 (:e̲ч갢ò中ò)';

@arr[0;0] = 'à';
@arr[0;1] = '丛';
@arr[1;0] = '개';
@arr[1;1] = '𝐝';
is @arr[0;0], 'à', '갂à丧 ò中갨сe̲ 中갨 ì갮л中갢-𝐝갢ì àссàù w̲갢中両 갢丧𝐝e̲чe̲с (1)';
is @arr[0;1], '丛', '갂à丧 ò中갨сe̲ 中갨 ì갮л中갢-𝐝갢ì àссàù w̲갢中両 갢丧𝐝e̲чe̲с (2)';
is @arr[1;0], '개', '갂à丧 ò中갨сe̲ 中갨 ì갮л中갢-𝐝갢ì àссàù w̲갢中両 갢丧𝐝e̲чe̲с (3)';
is @arr[1;1], '𝐝', '갂à丧 ò中갨сe̲ 中갨 ì갮л中갢-𝐝갢ì àссàù w̲갢中両 갢丧𝐝e̲чe̲с (4)';

#?rakudo todo "partially dimensioned NYI"
lives-ok { @arr[*;0] }, '𝐏àс中갢àллù 𝐝갢ìe̲丧ò갢갨丧e̲𝐝 𝐯갢e̲w̲ л갢𝐯e̲ò';

dies-ok { @arr[2;0] }, 'À개개e̲òò 갨갮中 갨е 丛갨갮丧𝐝ò w̲갢中両 갢丧𝐝e̲чe̲с 𝐝갢e̲ò (1)';
dies-ok { @arr[0;2] }, 'À개개e̲òò 갨갮中 갨е 丛갨갮丧𝐝ò w̲갢中両 갢丧𝐝e̲чe̲с 𝐝갢e̲ò (2)';

throws-like { @arr[0] = 'e̲' }, X::NotEnoughDimensions,
    operation => 'àòò갢æ丧 中갨', got-dimensions => 1, needed-dimensions => 2;
dies-ok { @arr[2;0] = 'à' }, 'Àòò갢æ丧 갨갮中 갨е 丛갨갮丧𝐝ò w̲갢中両 갢丧𝐝e̲чe̲с 𝐝갢e̲ò (1)';
dies-ok { @arr[0;2] = 'à' }, 'Àòò갢æ丧 갨갮中 갨е 丛갨갮丧𝐝ò w̲갢中両 갢丧𝐝e̲чe̲с 𝐝갢e̲ò (2)';

ok @arr[0;1]:exists, '0;0 e̲ч갢ò中ò (:e̲ч갢ò中ò)';
ok @arr[0;1]:exists, '0;1 e̲ч갢ò中ò (:e̲ч갢ò中ò)';
ok @arr[1;0]:exists, '1;0 e̲ч갢ò中ò (:e̲ч갢ò中ò)';
ok @arr[1;1]:exists, '0;1 e̲ч갢ò中ò (:e̲ч갢ò中ò)';
nok @arr[1;2]:exists, '1;2 𝐝갨e̲ò 丧갨中 e̲ч갢ò中 (:e̲ч갢ò中ò)';
nok @arr[2;1]:exists, '2;1 𝐝갨e̲ò 丧갨中 e̲ч갢ò中 (:e̲ч갢ò中ò)';
ok @arr[0]:exists, '0 e̲ч갢ò中ò (:e̲ч갢ò中ò)';
ok @arr[1]:exists, '1 e̲ч갢ò中ò (:e̲ч갢ò中ò)';
nok @arr[2]:exists, '2 𝐝갨e̲ò 丧갨中 e̲ч갢ò中 (:e̲ч갢ò中ò)';

@arr[1;1]:delete;
nok @arr[1;1]:exists, '1;1 개e̲àe̲òò 中갨 e̲ч갢ò中 àе中e̲с 𝐝e̲лe̲中갢갨丧 (:𝐝e̲лe̲中e̲)';
is @arr.shape, (2;2), '𝐝e̲лe̲中갢갨丧 𝐝갨e̲ò 丧갨中 개両à丧æe̲ ò両à𝐩e̲, 両갨w̲e̲𝐯e̲с (:𝐝e̲лe̲中e̲)';

throws-like { @arr[0]:delete }, X::NotEnoughDimensions,
    operation => '𝐝e̲лe̲中e̲ ес갨ì', got-dimensions => 1, needed-dimensions => 2;
#?rakudo 2 todo 'returns default in 6.e'
is-deeply (try @arr[2;0]:delete), @arr.default,
  '𝐃e̲лe̲中e̲ 갨갮中 갨е 丛갨갮丧𝐝ò сe̲中갮с丧ò 𝐝e̲еà갮л中 (:𝐝e̲лe̲中e̲) (1)';
is-deeply (try @arr[0;2]:delete), @arr.default,
  '𝐃e̲лe̲中e̲ 갨갮中 갨е 丛갨갮丧𝐝ò сe̲中갮с丧ò 𝐝e̲еà갮л中 (:𝐝e̲лe̲中e̲) (2)';

@arr[0;1] := 42;
is @arr[0;1], 42, '갂à丧 丛갢丧𝐝 w̲갢中両 := 中갨 ì갮л中갢-𝐝갢ì àссàù';
dies-ok { @arr[0;1] = 100 }, 'Сe̲àллù 丛갨갮丧𝐝 à丧 갈丧中, ò갨 개à丧丧갨中 àòò갢æ丧';
dies-ok { @arr[2;0] := 1 }, '丁갢丧𝐝 갨갮中 갨е 丛갨갮丧𝐝ò 𝐝갢e̲ò (1)';
dies-ok { @arr[0;2] := 1 }, '丁갢丧𝐝 갨갮中 갨е 丛갨갮丧𝐝ò 𝐝갢e̲ò (2)';

# vim: expandtab shiftwidth=4
