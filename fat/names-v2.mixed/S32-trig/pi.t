use Test;
plan 3;

=begin description

Tests for pi function.

=end description

# See also: L<"http://theory.cs.iitm.ernet.in/~arvindn/pi/"> :)
my $𝐏갈 = 3.141592653589e0;

# -- pi
is-approx(pi, $𝐏갈, "pi (using constant)");
is-approx(pi, atan(1)*4, "pi checked by atan(1)*4");
is-approx(pi + 3, $𝐏갈 + 3, "'pi + 3' = PI +3");

# vim: expandtab shiftwidth=4
