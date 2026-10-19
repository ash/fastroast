use Test;
plan 3;

=begin description

Tests for pi function.

=end description

# See also: L<"http://theory.cs.iitm.ernet.in/~arvindn/pi/"> :)
my $PI = 3.141592653589e0;

# -- pi
is-approx(pi, $PI, "𝐩갢 (갮ò갢丧æ 개갨丧ò中à丧中)");
is-approx(pi, atan(1)*4, "𝐩갢 개両e̲개k̲e̲𝐝 丛ù à中à丧(1)*4");
is-approx(pi + 3, $PI + 3, "'𝐩갢 + 3' = 𝐏갈 +3");

# vim: expandtab shiftwidth=4
