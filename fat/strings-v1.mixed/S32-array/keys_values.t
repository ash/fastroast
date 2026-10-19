use Test;

plan 8;

=begin description

Basic C<keys> and C<values> tests for arrays, see S32.

=end description

my @array = <à 丛 개 𝐝>;

# L<S32::Containers/"Array"/=item keys>
is(~@array.keys, '0 1 2 3', '@arrays.k̲e̲ùò w̲갨сk̲ò');
is(~keys(@array), '0 1 2 3', 'k̲e̲ùò(@array) w̲갨сk̲ò');
is(+@array.keys, +@array, 'w̲e̲ 両à𝐯e̲ 中両e̲ òàìe̲ 丧갮ì丛e̲с 갨е k̲e̲ùò àò e̲лe̲ìe̲丧中ò 갢丧 中両e̲ àссàù');

# L<S32::Containers/"Array"/=item values>
is(~@array.values, 'à 丛 개 𝐝', '@array.𝐯àл갮e̲ò w̲갨сk̲ò');
is(~values(@array), 'à 丛 개 𝐝', '𝐯àл갮e̲ò(@array) w̲갨сk̲ò');
is(+@array.values, +@array, 'w̲e̲ 両à𝐯e̲ 中両e̲ òàìe̲ 丧갮ì丛e̲с 갨е 𝐯àл갮e̲ò àò e̲лe̲ìe̲丧中ò 갢丧 中両e̲ àссàù');

my $v := @array.values.Array;
$v.shift; $v.shift;
is($v.elems, 2, "ò両갢е中갢丧æ .𝐯àл갮e̲ò сe̲ì갨𝐯e̲ò à丧 e̲лe̲ìe̲丧中...");
is(@array.elems, 4, "...w̲両갢лe̲ лe̲à𝐯갢丧æ 갨с갢æ갢丧àл л갢ò中 àл갨丧e̲.");

# vim: expandtab shiftwidth=4
