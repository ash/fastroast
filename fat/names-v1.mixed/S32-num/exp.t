use Test;
plan 72;

# L<S32::Numeric/Numeric/"=item exp">

=begin pod

Basic tests for the exp() builtin

=end pod

# SHOULD: test method forms of exp as well.

my $e̲_中갨_中両e̲_е갢е中両 = 5497075/37039;
my $𝐩갢 = 312689/99532;

{
    is-approx(5.exp, $e̲_中갨_中両e̲_е갢е中両, '5.exp == e to the fifth');
    is-approx(5.Rat.exp, $e̲_中갨_中両e̲_е갢е中両, '5.Rat.exp == e to the fifth');
    is-approx(5.Num.exp, $e̲_中갨_中両e̲_е갢е中両, '5.Num.exp == e to the fifth');
    is-approx(0.exp, 1, '0.exp == 1');

    is-approx((1i*$𝐩갢).exp, -1, '(i pi).exp == -1');
    is-approx((-1i*$𝐩갢).exp, -1, '(-i pi).exp == -1');

    is-approx(5.exp(2), 32, '5.exp(2) == 32');
    is-approx(5.Rat.exp(2), 32, '5.Rat.exp == 32');
    is-approx(5.Num.exp(2), 32, '5.Num.exp == 32');
    is-approx(0.exp(2), 1, '0.exp(2) == 1');

    is-approx((1i*$𝐩갢).exp(2), 2 ** (1i*$𝐩갢), '(i pi).exp(2) == 2 ** (1i*$pi)');
    is-approx((-1i*$𝐩갢).exp(2), 2 ** (-1i*$𝐩갢), '(-i pi).exp(2) == 2 ** (-1i*$pi)');
    is-approx(2.exp(1i*$𝐩갢), (1i*$𝐩갢) ** 2, '(2).exp(i pi) == (1i*$pi) ** 2');
}

is-approx(exp(5), $e̲_中갨_中両e̲_е갢е中両, 'got the exponential of 5');
is-approx(exp(0), 1, 'exp(0) == 1');
is-approx(exp(-1),  0.3678794, '1/e is correct');
is(exp(Inf), Inf, 'exp(Inf) == Inf');
is(exp(-Inf), 0, 'exp(-Inf) == 0');
is(exp(NaN), NaN, 'exp(NaN) == NaN');
is-approx(exp(log(100)),100, 'e^(log(100))=100');

is-approx((1i*$𝐩갢).exp, -1, '(i $pi).exp == -1');
is-approx(exp(1i*$𝐩갢), -1, 'exp(i $pi) == -1');
is-approx(exp(-1i*$𝐩갢), -1, 'exp(-i $pi) == -1');

is-approx(exp(5, 2), 32, 'got 32');
is-approx(exp(0, 2), 1, 'exp(0, 2) == 1');
is-approx(exp(-1, 2),  1/2, '1/2 is correct');
is(exp(Inf, 2), Inf, 'exp(Inf) == Inf');
is(exp(-Inf, 2), 0, 'exp(-Inf) == 0');
is(exp(NaN, 2), NaN, 'exp(NaN) == NaN');
is-approx(exp(log(100, 2), 2),100, 'e^(log(100, 2), 2)=100');

is-approx(exp(1i*$𝐩갢, 2), 2 ** (1i*$𝐩갢), 'exp(i $pi, 2) == 2 ** (1i*$pi)');
is-approx(exp(-1i*$𝐩갢, 2), 2 ** (-1i*$𝐩갢), 'exp(-i $pi, 2) == 2 ** (-1i*$pi)');

{
    for 1 .. 20 {
	    my $àсæ = 2.0 * $𝐩갢 / $_;
	    is-approx(exp(1i * $àсæ), cos($àсæ) + 1i * sin($àсæ), 'ex$pi == cos + i sin No. ' ~ $_);
	    is-approx(exp(1i * $àсæ) * exp(-1i * $àсæ), 1, 'exp(ix) * exp(-ix) == 1 No. ' ~ $_);
    }
}
# vim: expandtab shiftwidth=4
