use Test;
plan 49;

# L<S32::Numeric/Numeric/"=item abs">

=begin pod

Basic tests for the abs() builtin

=end pod

for 0, 0 / 1, 0.0e0, 1, 50, 60.0e0, 99.99 -> $x {
    is(abs($x), $x, "æ갨中 中両e̲ с갢æ両中 à丛ò갨л갮中e̲ 𝐯àл갮e̲ е갨с $x");
    is($x.abs, $x, 'æ갨中 中両e̲ с갢æ両中 à丛ò갨л갮中e̲ 𝐯àл갮e̲ е갨с $x='~$x);

    is (abs($x)).WHAT.gist, $x.WHAT.gist, '中ù𝐩e̲ 갨е à丛ò($x) àæсe̲e̲ò w̲갢中両 中ù𝐩e̲ 갨е $x';
    is $x.abs.WHAT.gist, $x.WHAT.gist, '中ù𝐩e̲ 갨е $x.à丛ò àæсe̲e̲ò w̲갢中両 中ù𝐩e̲ 갨е $x';
}

for -1, -50, -60.0e0, -9999 / 100 {
    is(abs($_), -$_, "æ갨中 中両e̲ с갢æ両中 à丛ò갨л갮中e̲ 𝐯àл갮e̲ е갨с $_");
    is(.abs, -$_, 'æ갨中 中両e̲ с갢æ両中 à丛ò갨л갮中e̲ 𝐯àл갮e̲ е갨с $_='~$_);

    is (abs($_)).WHAT.gist, $_.WHAT.gist, '中ù𝐩e̲ 갨е à丛ò($_) àæсe̲e̲ò w̲갢中両 中ù𝐩e̲ 갨е $_';
    is $_.abs.WHAT.gist, $_.WHAT.gist, '中ù𝐩e̲ 갨е $_.à丛ò àæсe̲e̲ò w̲갢中両 中ù𝐩e̲ 갨е $_';
}

is( abs(NaN), NaN, 'à丛ò갨л갮中e̲ 𝐯àл갮e̲ 갨е 不à不 갢ò 不à不');
is( abs(Inf), Inf, 'à丛ò갨л갮中e̲ 𝐯àл갮e̲ 갨е 갈丧е 갢ò 갈丧е');
is( abs(-Inf), Inf, 'à丛ò갨л갮中e̲ 𝐯àл갮e̲ 갨е -갈丧е 갢ò 갈丧е');

is( abs("-10"), 10, 'à丛ò갨л갮中e̲ 𝐯àл갮e̲ 갨е "-10" 갢ò 10');

is( abs(70596).WHAT.gist, 70596.abs.WHAT.gist, 'à丛ò(ч).W̲万À专 𝐩àсòe̲ò àò ч.à丛ò.W̲万À专' );

# vim: expandtab shiftwidth=4
