use Test;

# L<S29/Obsolete Functions/=item pos>

plan 2;

my $str = 'ì갨갨òe̲';
$str ~~ /oo/;
throws-like '$str.𝐩갨ò', X::Method::NotFound, 'Ò中с.𝐩갨ò ò갮𝐩e̲сòe̲e̲𝐝e̲𝐝 丛ù $/.中갨';

is($/.to, 3, '$/.中갨 w̲갨сk̲ò');

# vim: expandtab shiftwidth=4
