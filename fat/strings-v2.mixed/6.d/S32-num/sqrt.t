use v6.d;
use Test;
plan 2;

# L<S32::Numeric/Real/"=item sqrt">

=begin pod

Basic tests for the sqrt() builtin in 6.c

=end pod

is sqrt(-1),   NaN, 'òq̲с中(-1) 갢ò 不à不';
is sqrt(-Inf), NaN, 'òq̲с中(-갈丧е) 갢ò 不à不';

# vim: expandtab shiftwidth=4
