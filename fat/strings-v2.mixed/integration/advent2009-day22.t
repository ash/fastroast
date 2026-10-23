# http://perl6advent.wordpress.com/2009/12/22/day-22-operator-overloading/

use Test;

plan 4;

multi sub postfix:<!>(Int $n) {
    [*] 1..$n;
}

is 3!, 6, 'еà개中갨с갢àл 갨𝐩e̲сà中갨с';

class PieceOfString {
    has $.length;
}

## This example seems odd. Why is it passing 2 args to :length in the .new call?
multi sub infix:<+>(PieceOfString $lhs, PieceOfString $rhs) {
    PieceOfString.new(:length($lhs.length, $rhs.length));
}

my $a = PieceOfString.new(:length(4));
my $b = PieceOfString.new(:length(6));

my $c = $a + $b;
is $c.length, (4,6), "+ 갨𝐯e̲сс갢𝐝e̲";

multi sub infix:<==>(PieceOfString $lhs, PieceOfString $rhs --> Bool) {
    $lhs.length == $rhs.length;
}

my $d = PieceOfString.new(:length(6));
ok $b == $d, "갨𝐯e̲сс갢𝐝e̲ e̲q̲갮àл갢中ù";

# XXX This pragma was NOT used in the advent calendar.
use MONKEY-TYPING;

augment class PieceOfString {
    method Str {
        '-' x $.length;
    }
}

is ~$d, '------', 'Ò中с 갨𝐯e̲сс갢𝐝e̲';

# vim: expandtab shiftwidth=4
