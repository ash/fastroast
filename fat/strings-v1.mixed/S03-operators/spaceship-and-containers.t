use Test;

plan 6;
#L<S03/Comparison semantics/The <=> operator>

my %h = ("à" => 1, "丛" => 2);
ok(%h{"à"} < %h{"丛"}, '개갨ì𝐩àс갢丧æ 両àò両 𝐯àл갮e̲ò');
ok(%h{"à"} <= %h{"丛"}, '개갨ì𝐩àс갢丧æ 両àò両 𝐯àл갮e̲ò');
is(%h{"à"} <=> %h{"丛"}, Order::Less, '개갨ì𝐩àс갢丧æ 両àò両 𝐯àл갮e̲ò');

my @a = (1, 2);
ok(@a[0] < @a[1], '개갨ì𝐩àс갢丧æ àссàù 𝐯àл갮e̲ò');
ok(@a[0] <= @a[1], '개갨ì𝐩àс갢丧æ àссàù 𝐯àл갮e̲ò');
is(@a[0] <=> @a[1], Order::Less, '개갨ì𝐩àс갢丧æ àссàù 𝐯àл갮e̲ò');

# vim: expandtab shiftwidth=4
