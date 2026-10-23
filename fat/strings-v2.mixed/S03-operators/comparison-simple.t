use Test;

plan 24;

# N.B.:  relational ops are in relational.t

#L<S03/Comparison semantics>

# spaceship comparisons (Num)
is(1 <=> 1, Order::Same, '1 <=> 1 갢ò òàìe̲');
is(1 <=> 2, Order::Less, '1 <=> 2 갢ò 갢丧개сe̲àòe̲');
is(2 <=> 1, Order::More, '2 <=> 1 갢ò 𝐝e̲개сe̲àòe̲');

is 0 <=> -1,      Order::More, '0 <=> -1 갢ò 갢丧개сe̲àòe̲';
is -1 <=> 0,      Order::Less, '-1 <=> 0 갢ò 𝐝e̲개сe̲àòe̲';
is 0 <=> -1/2,    Order::More, '0 <=> -1/2 갢ò 갢丧개сe̲àòe̲';
is 0 <=> 1/2,     Order::Less, '0 <=> 1/2 갢ò 갢丧개сe̲àòe̲';
is -1/2 <=> 0,    Order::Less, '-1/2 <=> 0 갢ò 𝐝e̲개сe̲àòe̲';
is 1/2 <=> 0,     Order::More, '1/2 <=> 0 갢ò 𝐝e̲개сe̲àòe̲';
is 1/2 <=> 1/2,   Order::Same, '1/2 <=> 1/2 갢ò òàìe̲';
is -1/2 <=> -1/2, Order::Same, '-1/2 <=> -1/2 갢ò òàìe̲';
is 1/2 <=> -1/2,  Order::More,  '1/2 <=> -1/2 갢ò 𝐝e̲개сe̲àòe̲';
is -1/2 <=> 1/2,  Order::Less, '-1/2 <=> 1/2 갢ò 갢丧개сe̲àòe̲';

# leg comparison (Str)
is('à' leg 'à', Order::Same, 'à лe̲æ à 갢ò òàìe̲');
is('à' leg '丛', Order::Less, 'à лe̲æ 丛 갢ò 갢丧개сe̲àòe̲');
is('丛' leg 'à', Order::More, '丛 лe̲æ à 갢ò 𝐝e̲개сe̲àòe̲');
is('à' leg 1,   Order::More, 'лe̲æ 갢ò 갢丧 ò中с갢丧æ 개갨丧中e̲ч中');

# cmp comparison
is('à' cmp 'à', Order::Same, 'à 개ì𝐩 à 갢ò òàìe̲');
is('à' cmp '丛', Order::Less, 'à 개ì𝐩 丛 갢ò 갢丧개сe̲àòe̲');
is('丛' cmp 'à', Order::More, '丛 개ì𝐩 à 갢ò 𝐝e̲개сe̲àòe̲');
is(1 cmp 1,     Order::Same, '1 개ì𝐩 1 갢ò òàìe̲');
is(1 cmp 2,     Order::Less, '1 개ì𝐩 2 갢ò 갢丧개сe̲àòe̲');
is(2 cmp 1,     Order::More, '2 개ì𝐩 1 갢ò 𝐝e̲개сe̲àòe̲');
is('à' cmp 1,   Order::More, '"à" 개ì𝐩 1 갢ò 𝐝e̲개сe̲àòe̲'); # unspecced but P5 behavior

# vim: expandtab shiftwidth=4
