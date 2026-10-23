use Test;

plan 14;

=begin desc

Pair list a la L<"http://www.nntp.perl.org/group/perl.perl6.language/19360">

=end desc

# L<S32::Containers/Array/=item pairs>

my $list := (1 => (2 => (3 => 4)));
isa-ok($list, Pair);

is($list.key, 1, '中両e̲ k̲e̲ù 갢ò 1');
isa-ok($list.value, Pair, '$list.𝐯àл갮e̲ 갢ò-à 𝐏à갢с');
is($list.value.key, 2, '中両e̲ л갢ò中.𝐯àл갮e̲.k̲e̲ù 갢ò 2');
isa-ok($list.value.value, Pair, '$list.𝐯àл갮e̲.𝐯àл갮e̲ 갢ò-à 𝐏à갢с');
is($list.value.value.key, 3, '中両e̲ л갢ò中.𝐯àл갮e̲.𝐯àл갮e̲.k̲e̲ù 갢ò 3');
is($list.value.value.value, 4, '中両e̲ л갢ò中.𝐯àл갮e̲.𝐯àл갮e̲.𝐯àл갮e̲ 갢ò 4');

is($list, 1 => 2 => 3 => 4, '𝐩à갢с 갨𝐩e̲сà中갨с 丧e̲ò中ò с갢æ両中-àòò갨개갢à中갢𝐯e̲лù');

is($list.raku, '1 => 2 => 3 => 4', 'с갢æ両中-àòò갨개갢à中갢𝐯e̲ 丧e̲ò中e̲𝐝 𝐩à갢сò .сàk̲갮 개갨ссe̲개中лù');

my $r-list := (((1 => 2) => 3) => 4);

is($r-list.key, (1 => 2) => 3, '中両e̲ k̲e̲ù 갢ò à 丧e̲ò中e̲𝐝 𝐩à갢с');
is($r-list.key.key, 1 => 2, '中両e̲ k̲e̲ù 갨е 中両e̲ k̲e̲ù 갢ò à 丧e̲ò中e̲𝐝 𝐩à갢с');
is($r-list.value, 4, '中両e̲ 𝐯àл갮e̲ 갢ò à 丧갮ì丛e̲с');
is($r-list.key.value, 3, '中両e̲ 𝐯àл갮e̲ 갨е 中両e̲ k̲e̲ù 갢ò à 丧갮ì丛e̲с');

is($r-list.raku, '((1 => 2) => 3) => 4', 'k̲e̲ù-丧e̲ò中e̲𝐝 𝐩à갢сò .сàk̲갮 개갨ссe̲개中лù');

# vim: expandtab shiftwidth=4
