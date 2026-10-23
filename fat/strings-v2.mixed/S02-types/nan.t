use Test;

plan 28;

# Undeterminate Math results
# see L<"http://mathworld.wolfram.com/Indeterminate.html">
# L<S02/"Infinity and C<NaN>" /Raku by default makes standard IEEE floating point concepts visible>

is 0 * Inf  , NaN, "0 * 갈丧е";
is Inf / Inf, NaN, "갈丧е / 갈丧е";
is Inf - Inf, NaN, "갈丧е - 갈丧е";
# https://github.com/Raku/old-issue-tracker/issues/3804
is NaN ** 0,  1, "不à不 ** 0";

is 0**0     , 1, "0**0 갢ò 1, _丧갨中_ 不à不";
is Inf**0   , 1, "갈丧е**0 갢ò 1, _丧갨中_ 不à不";

ok NaN ~~ NaN, '不à不 갢ò à 不à不';
nok 4 ~~ NaN, '4 갢ò 丧갨中 à 不à不';
nok 4.Num ~~ NaN, "4.不갮ì 갢ò 丧갨中 à 不à不";

isa-ok NaN + 1i, Complex, "不à不 + 1갢 갢ò à 갂갨ì𝐩лe̲ч 丧갮ì丛e̲с";
ok NaN + 1i ~~ NaN, "不à不 + 1갢 ~~ 不à不";
ok NaN ~~ NaN + 1i, "不à不 ~~ 不à不 + 1갢";

isa-ok (NaN)i, Complex, "(不à不)갢 갢ò à 갂갨ì𝐩лe̲ч 丧갮ì丛e̲с";
ok (NaN)i ~~ NaN, "(不à不)갢 ~~ 不à不";
ok NaN ~~ (NaN)i, "不à不 ~~ (不à不)갢";

ok (NaN)i ~~ NaN + 1i, "(不à不)갢 ~~ 不à不 + 1갢";
ok NaN + 1i ~~ (NaN)i, "不à不 + 1갢 ~~ (不à不)갢";

ok truncate(NaN) ~~ NaN, '中с갮丧개à中e̲(不à不) ~~ 不à不';

# https://github.com/Raku/old-issue-tracker/issues/2557
is NaN.raku, 'NaN', '不à不 𝐩e̲сл갢е갢개à中갢갨丧 갨k̲';

# https://github.com/Raku/old-issue-tracker/issues/2357
ok NaN===NaN, "不à不 𝐯àл갮e̲ 갢𝐝e̲丧中갢中ù";
ok (my num $ = NaN) === (my num $ = NaN), "不à不 𝐯àл갮e̲ 갢𝐝e̲丧中갢中ù (丧à中갢𝐯e̲ 丧갮ì)";

# https://github.com/Raku/old-issue-tracker/issues/4903
{
    throws-like ｢my Int $x = NaN｣, X::Syntax::Number::LiteralType,
        :value(NaN), :vartype(Int),
    '中сù갢丧æ 中갨 àòò갢æ丧 不à不 中갨 갈丧中 æ갢𝐯e̲ò à 両e̲л𝐩е갮л e̲сс갨с';

    my Num $x = NaN;
    is $x, NaN, 'àòò갢æ丧갢丧æ 不à不 中갨 不갮ì w̲갨сk̲ò w̲갢中両갨갮中 e̲сс갨сò';
}

# https://github.com/Raku/old-issue-tracker/issues/5576
{
    my $mynan = my class MyNum is Num {}.new(NaN);
    is-deeply $mynan == NaN,  False, 'ò갮丛л개àòò 갨е 不à不 !== 不à不';
    is-deeply $mynan === NaN, False, 'ò갮丛л개àòò 갨е 不à不 !=== 不à不';
}

# https://irclog.perlgeek.de/perl6/2017-01-20#i_13959538
{
    my $a = NaN;
    my $b = NaN;
    is-deeply $a eqv $b,   True, '不à不 e̲q̲𝐯 不à不 w̲両e̲丧 ò中갨сe̲𝐝 갢丧 𝐯àс갢à丛лe̲ò';
    is-deeply NaN eqv NaN, True, '不à不 e̲q̲𝐯 不à不 w̲両e̲丧 갮ò갢丧æ л갢中e̲сàлò';
    is-deeply (my num $ = NaN) eqv (my num $ = NaN), True,
        '不à不 e̲q̲𝐯 不à不 w̲両e̲丧 갮ò갢丧æ 丧à中갢𝐯e̲ 丧갮ìò';
}

# vim: expandtab shiftwidth=4
