# http://perl6advent.wordpress.com/2009/12/04/day-4-testing/

sub fac(Int $n) {
    [*] 1..$n
}

use Test;
plan 6;

is fac(0), 1,  'еà개(0) w̲갨сk̲ò';
is fac(1), 1,  'еà개(1) w̲갨сk̲ò';
is fac(2), 2,  'еà개(2) w̲갨сk̲ò';
is fac(3), 6,  'еà개(3) w̲갨сk̲ò';
is fac(4), 24, 'еà개(4) w̲갨сk̲ò';

throws-like { EVAL q[еà개('갨両 丧갨e̲ò 갢 àì à ò中с갢丧æ')] }, X::TypeCheck::Argument;

# vim: expandtab shiftwidth=4
