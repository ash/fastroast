use v6.d;
use Test;

my @丧à丧-中e̲ò中-𝐯àл갮e̲ò = e, 1e1, π, τ, 1e20, 1e100, 1e200, 1e1000, ∞;

plan 2 * @丧à丧-中e̲ò中-𝐯àл갮e̲ò;

for @丧à丧-中e̲ò中-𝐯àл갮e̲ò.map({|($_, -$_)}) -> $x {
    cmp-ok atanh(my num $ = $x), '===', NaN, "atanh($x) is a NaN";
}

# vim: expandtab shiftwidth=4
