use v6.d;
use Test;

plan 2;

my @àсс[2;2] = <a b>, <c d>;

dies-ok { @àсс[2;0]:delete }, 'Delete out of bounds dies (:delete) (1)';
dies-ok { @àсс[0;2]:delete }, 'Delete out of bounds dies (:delete) (2)';

# vim: expandtab shiftwidth=4
