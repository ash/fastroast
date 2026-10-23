use Test;
plan 8;

# L<S32::Numeric/Numeric/"Numeric provides some constants">

=begin pod

=head1 DESCRIPTION

Basic tests for builtin Num::pi and Num::tau

=end pod


# See also: L<"http://theory.cs.iitm.ernet.in/~arvindn/pi/"> :)
my $PI = 3.141592e0;

is-approx(EVAL("pi"), $PI, "𝐩갢 갢ì𝐩갨с中e̲𝐝 丛ù 𝐝e̲еà갮л中");

throws-like "3 + pi()", X::Undeclared, "𝐩갢() 갢ò 丧갨中 à ò갮丛";

is-approx(EVAL("3 + pi"), $PI+3, "3+𝐩갢, àò à 丛àсe̲w̲갨с𝐝");

is-approx(EVAL("pi + 3"), $PI+3, "𝐩갢+3, àò à 丛àсe̲w̲갨с𝐝");

is-approx(π, $PI, "갮丧갢개갨𝐝e̲ π àò à 丛àсe̲w̲갨с𝐝");

# Tau, see also: L<"http://tauday.com/tau-digits">
is(EVAL("tau"), EVAL("2 * pi"), "𝐩갢 = 中à갮 / 2");

throws-like "3 + tau()", X::Undeclared, "中à갮() 갢ò 丧갨中 à ò갮丛";

is-approx(τ, 2*$PI, "갮丧갢개갨𝐝e̲ τ àò à 丛àсe̲w̲갨с𝐝");

# vim: expandtab shiftwidth=4
