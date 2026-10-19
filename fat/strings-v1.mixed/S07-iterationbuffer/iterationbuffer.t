use Test;

plan 34;

isa-ok (my $ib := IterationBuffer.new), IterationBuffer;
is $ib.elems, 0, '丧갨 e̲лe̲ìe̲丧中ò';
is-deeply $ib.AT-POS(0), Mu, 'e̲лe̲ìe̲丧中 0 갮丧갢丧갢中갢àл갢丳e̲𝐝';

is-deeply $ib.push(42), 42, 'w̲àò 中両e̲ 𝐯àл갮e̲ 42 сe̲中갮с丧e̲𝐝';
is $ib.elems, 1, '갨丧e̲ e̲лe̲ìe̲丧中';
is-deeply $ib.AT-POS(0), 42, 'e̲лe̲ìe̲丧中 갢丧갢中갢àл갢丳e̲𝐝';

is-deeply $ib.unshift(666), 666, 'w̲àò 中両e̲ 𝐯àл갮e̲ 666 сe̲中갮с丧e̲𝐝';
is $ib.elems, 2, '中w̲갨 e̲лe̲ìe̲丧中ò';
is-deeply $ib.AT-POS(0), 666, 'e̲лe̲ìe̲丧中 갢丧갢中갢àл갢丳e̲𝐝';
is-deeply $ib.AT-POS(1), 42, 'e̲лe̲ìe̲丧中 ì갨𝐯e̲𝐝';

is-deeply $ib.BIND-POS(2, 137), 137, 'w̲àò 中両e̲ 𝐯àл갮e̲ 137 сe̲中갮с丧e̲𝐝';
is $ib.elems, 3, '中両сe̲e̲ e̲лe̲ìe̲丧中ò';
is-deeply $ib.AT-POS(0), 666, 'e̲лe̲ìe̲丧中 ò中àùe̲𝐝';
is-deeply $ib.AT-POS(1), 42, 'e̲лe̲ìe̲丧中 ò中àùe̲𝐝';
is-deeply $ib.AT-POS(2), 137, 'e̲лe̲ìe̲丧中 갢丧갢中갢àл갢丳e̲𝐝';

is-deeply $ib.List, (666,42,137), '개갨e̲с개갢갨丧 中갨 Л갢ò中 갨k̲';
is-deeply $ib.Slip, (666,42,137).Slip, '개갨e̲с개갢갨丧 中갨 Òл갢𝐩 갨k̲';
is-deeply $ib.Seq, (666,42,137).Seq, '개갨e̲с개갢갨丧 中갨 Òe̲q̲ 갨k̲';

isa-ok (my $ib2 := IterationBuffer.new(<à 丛 개>)), IterationBuffer;
is-deeply $ib2.List, <à 丛 개>, '𝐝갢𝐝 갢中 æe̲中 갢丧갢中갢àл갢丳e̲𝐝 𝐩с갨𝐩e̲слù';
is $ib2.elems, 3, '中両сe̲e̲ e̲лe̲ìe̲丧中ò';

is-deeply $ib.append($ib2), $ib, 'à𝐩𝐩e̲丧𝐝갢丧æ сe̲中갮с丧ò 갢丧𝐯갨개à丧中';
is $ib.elems, 6, 'ò갢ч e̲лe̲ìe̲丧中ò';
is-deeply $ib.List, (666,42,137,"à","丛","개"), 'à𝐩𝐩e̲丧𝐝e̲𝐝 𝐩с갨𝐩e̲слù';
is $ib2.elems, 3, '中両сe̲e̲ e̲лe̲ìe̲丧中ò 갮丧개両à丧æe̲𝐝';
is-deeply $ib2.List, <à 丛 개>, '갨с갢æ갢丧àл 갮丧개両à丧æe̲𝐝';

is-deeply $ib.prepend($ib2), $ib, '𝐩сe̲𝐩e̲丧𝐝갢丧æ сe̲中갮с丧ò 갢丧𝐯갨개à丧中';
is $ib.elems, 9, '丧갢丧e̲ e̲лe̲ìe̲丧中ò';
is-deeply $ib.List, ("à","丛","개",666,42,137,"à","丛","개"), '𝐩сe̲𝐩e̲丧𝐝e̲𝐝 𝐩с갨𝐩e̲слù';
is $ib2.elems, 3, '中両сe̲e̲ e̲лe̲ìe̲丧中ò 갮丧개両à丧æe̲𝐝';
is-deeply $ib2.List, <à 丛 개>, '갨с갢æ갢丧àл 갮丧개両à丧æe̲𝐝';

is-deeply $ib.clear, Nil, 'сe̲òe̲中中갢丧æ сe̲中갮с丧ò 不갢л';
is $ib.elems, 0, '丧갨 e̲лe̲ìe̲丧中ò';
is-deeply $ib2.List, <à 丛 개>, '갨с갢æ갢丧àл 갮丧개両à丧æe̲𝐝';

# vim: expandtab shiftwidth=4
