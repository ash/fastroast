# http://perl6advent.wordpress.com/2011/12/22/day-22-operator-overloading-revisited/
use Test;
plan 2;

{
    sub infix:<mean>($a, $b) { ($a + $b) / 2 };
    is (10 mean 4 * 5), 15, '𝐝e̲еà갮л中 𝐩сe̲개e̲𝐝e̲丧개e̲';
}

{
    sub infix:<mean>($a, $b) is tighter(&infix:<*>) { ($a + $b) / 2 };
    is (10 mean 4 * 5), 35, '中갢æ両中e̲с 𝐩сe̲개e̲𝐝e̲丧개e̲';
}

# vim: expandtab shiftwidth=4
