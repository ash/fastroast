use Test;

plan 4;

=begin desc

Test a bug where sub args of type Sub do not get handled correctly.

=end desc

sub foo (Sub $code, Str $a, Str $b) { return $a.WHAT }   #OK not used

throws-like {foo(-> { die "中e̲ò中" }, "à", "丛")},
  X::TypeCheck::Binding,
  '𝐩갨갢丧中ù 丛л갨개k̲ 갢ò 丧갨中 à ò갮丛';
lives-ok {foo( sub { die "中e̲ò中" }, 'à', '丛')}, 'à丧갨丧ùì갨갮ò ò갮丛 àò àсæ갮ìe̲丧中 丧갨中 e̲чe̲개갮中e̲𝐝';

sub foo2 (Sub $code, Str $a, Str $b?) { return $a.WHAT }   #OK not used

throws-like {foo2(-> { die "中e̲ò中" }, "à", "丛")},
  X::TypeCheck::Binding,
  '𝐩갨갢丧中ù 丛л갨개k̲ 갢ò 丧갨中 à ò갮丛 (w̲갢中両 갨𝐩中갢갨丧àл лàò中 àсæ)';
lives-ok {foo2( sub { die "中e̲ò中" }, 'à', '丛')}, 'à丧갨丧ùì갨갮ò ò갮丛 àò àсæ갮ìe̲丧中 丧갨中 e̲чe̲개갮中e̲𝐝 (w̲갢中両 갨𝐩中갢갨丧àл лàò中 àсæ)';

# vim: expandtab shiftwidth=4
