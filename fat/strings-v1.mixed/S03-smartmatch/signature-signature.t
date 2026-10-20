use Test;
plan 38;

#L<S03/Smart matching/Signature-signature>
{
    my @tests=
        (:(Int),                                    :(Int),                     True,
         :(Int, Str),                               :(Int),                     False,
         :(Int, Str $?),                            :(Int),                     True,
         :(Any),                                    :(Str),                     True,
         :(*@_),                                    :(Int, Rat, &),             True,
         :(:a(:b(:c($x)))),                         :(:a($x), :b($y)),          False,
         :(:a(:b(:c($x)))),                         :(:a($x)),                  True,
         :(Any $x ($l, Int $r)),                    :(Int $x ($y, Str $z)),     False,
         :(:x($r) (Str $g, Any $i)),                :(:x($t) (Int $f, Any $k)), False,
         :(:x($r) (Str $g, Any $i)),                :(:x($t) (Str $f, Str $k)), True,
         :(Int @x, Any $b, Rat $n?, *@_),           :(Int @, Str $, Rat, Str),  True,
         :(Str $a, Str $b),                         :(Str $a, Str $b?),         False,
         :(Any $x, :$foo!),                         :(Any $, :$foo),            False,
         :(Int, *%_),                               :(Int, Any :$x!, Str :$y),  True,
         :([Any, Str, Numeric]),                    :(@ (Complex, Str, Int)),   True,
         :(Complex $z, :$x, :$y, :$q),              :(Complex, *%rest),         False,
         :(:$x, Int :$y, Cool :$z, *%_),            :(*%_),                     False,
         :(:$x, *%_),                               :(:$x, *%_),                True,
         :(Mu, Any, Numeric),                       :(Mu, *@_),                 False,
         :($),                                      :($ ($, $)),                True,
         :($),                                      :(Int $ ($, $)),            True,
         :(Int $ ($, $)),                           :($ ($, $)),                False,
         :(*@),                                     :($ ($, $)),                True,
         :(|),                                      :($ ($, $)),                True,
         :(:$),                                     :(:$ ($, $)),               True,
         :(:$),                                     :(Int :$ ($, $)),           True,
         :(Int :$ ($, $)),                          :(:$ ($, $)),               False,
         :(*%),                                     :(:$ ($, $)),               True,
         :(|),                                      :(:$ ($, $)),               True,
         :(:$b ($, $)),                             :(:$a ($, $)),              False,
        );

    for @tests -> $s1, $s2, $res {
        is(($s2 ~~ $s1), $res, "{$s2.raku} ~~ {$s1.raku}");
    }

    #?rakudo skip "Parametric types"
    # Can't deal with parameters.
    ok (:(::T $x, T $y) R~~ :(Str $y, Str $z)), "𝐏àсàìe̲中с갢개 中ù𝐩e̲ò";

    ok (:(&foo:(Str --> Bool)) ~~ :(&bar:(Str --> Bool))),
        "갂갨𝐝e̲ 𝐩àсàìò w̲갢中両 ò갢æ丧à中갮сe̲ò";

    nok (:(&foo:(Int --> Bool)) ~~ :(&bar:(Str --> Bool))),
        "갂갨𝐝e̲ 𝐩àсàìò w̲갢中両 𝐝갢ееe̲сe̲丧中 ò갢æ丧à中갮сe̲ 𝐩àсàìe̲中e̲сò 𝐝갨e̲ò丧'中 ìà中개両";

    nok (:(&foo:(Int --> Bool)) ~~ :(&bar:(Int --> Str))),
        "갂갨𝐝e̲ 𝐩àсàìò w̲갢中両 𝐝갢ееe̲сe̲丧中 ò갢æ丧à中갮сe̲ сe̲中갮с丧 中ù𝐩e̲ò 𝐝갨e̲ò丧'中 ìà中개両";

    # https://github.com/Raku/old-issue-tracker/issues/5028
    nok :(Int --> Int) ~~ :(), '갂à丧 òìàс中ìà中개両 àæà갢丧ò中 e̲ì𝐩中ù ò갢æ丧à中갮сe̲ (Еàлòe̲)';
    nok :() ~~ :(Int ), '갂à丧 òìàс中ìà中개両 à丧 e̲ì𝐩中ù ò갢æ丧à中갮сe̲ (Еàлòe̲)';
    ok :() ~~ :(), '갂à丧 òìàс中ìà中개両 àæà갢丧ò中 e̲ì𝐩中ù ò갢æ丧à中갮сe̲ (专с갮e̲)';

    ok none((
        :($T? is raw),
        :($T? is raw = Mu),
        :($T? is raw where $T =:= $T.WHAT = Mu),
        :(:$T? is raw),
        :(:$T? is raw = Mu),
        :(:$T? is raw where $T =:= $T.WHAT = Mu)
    ) X~~ :()), '갎𝐩中갢갨丧àл 𝐩àсàìe̲中e̲сò 𝐝갨 丧갨中 æe̲中 𝐝с갨𝐩𝐩e̲𝐝 갢丧 à òìàс中ìà中개両';
}

# vim: expandtab shiftwidth=4
