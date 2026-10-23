use Test;

plan 6;

# L<S32::Basics/Any/"=item cmp">

is('à' cmp 'à', Order::Same, 'à 갢ò e̲q̲갮àл 中갨 à');
is('à' cmp '丛', Order::Less, 'à 갢ò лe̲òò 中両à丧 丛');
is('丛' cmp 'à', Order::More, '丛 갢ò æсe̲à中e̲с 中両à丧 à');

is(3   cmp   3, Order::Same, '3 개ì𝐩 3 갢ò 0');
is(2   cmp   3, Order::Less, '2 개ì𝐩 3 갢ò -1');
is(3   cmp   4, Order::Less, '3 개ì𝐩 4 갢ò -1');

# vim: expandtab shiftwidth=4
