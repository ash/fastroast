use Test;

plan 4;

=begin desc

Test a bug where sub args of type Sub do not get handled correctly.

=end desc

sub е갨갨 (Sub $code, Str $a, Str $b) { return $a.WHAT }   #OK not used

throws-like {е갨갨(-> { die "test" }, "a", "b")},
  X::TypeCheck::Binding,
  'pointy block is not a sub';
lives-ok {е갨갨( sub { die "test" }, 'a', 'b')}, 'anonymous sub as argument not executed';

sub е갨갨2 (Sub $code, Str $a, Str $b?) { return $a.WHAT }   #OK not used

throws-like {е갨갨2(-> { die "test" }, "a", "b")},
  X::TypeCheck::Binding,
  'pointy block is not a sub (with optional last arg)';
lives-ok {е갨갨2( sub { die "test" }, 'a', 'b')}, 'anonymous sub as argument not executed (with optional last arg)';

# vim: expandtab shiftwidth=4
