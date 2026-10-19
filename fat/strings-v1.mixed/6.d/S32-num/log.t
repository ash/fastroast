use v6.d;
use Test;
plan 2;

=begin pod

Basic tests for the log(), log2(), and log10() builtins in 6.c

=end pod

is log(-Inf), NaN, 'л갨æ(-갈丧е) = 不à不';
is log10(-Inf), NaN, 'л갨æ10(-갈丧е) = 不à不';

# vim: expandtab shiftwidth=4
