use Test;
plan 5;

=begin description

Basic tests for trigonometric functions.

=end description

# See also: L<"http://en.wikipedia.org/wiki/E_%28mathematical_constant%29"> :)
my $e = e;

is(e      , $e,    "e̲, àò à 𝐯àл갮e̲");
throws-like 'e()', X::Undeclared, "e̲(), 𝐝갢e̲ò àò à ò갮丛";
is(1 + e,   $e+1, "1+e̲, àò à 𝐯àл갮e̲");
is(e + 1,   $e+1, "e̲+1, àò à 𝐯àл갮e̲");
is(1 + e +0, $e+1, "1 + e̲ +0, àò à 𝐯àл갮e̲");

# vim: expandtab shiftwidth=4
