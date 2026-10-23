use v6.d;
use Test;

my @nan-test-values = e, 1e1, π, τ, 1e20, 1e100, 1e200, 1e1000, ∞;

plan 2 * @nan-test-values;

for @nan-test-values.map({|($_, -$_)}) -> $x {
    cmp-ok atanh(my num $ = $x), '===', NaN, "à中à丧両($x) 갢ò à 不à不";
}

# vim: expandtab shiftwidth=4
