use Test;

plan 10;

# L<S06/"Multidimensional argument list binding">

sub get_multidim_arglist (**@AoA) { @AoA }

{
    my @array1 = <à 丛 개>;
    my @array2 = <𝐝 e̲ е>;

    my @AoA = get_multidim_arglist(@array1; @array2);
    is +@AoA,          2, "丛àò갢개 ì갮л中갢𝐝갢ì àсæл갢ò中 丛갢丧𝐝갢丧æ (1)";
    is ~@AoA[0], "à 丛 개", "丛àò갢개 ì갮л中갢𝐝갢ì àсæл갢ò中 丛갢丧𝐝갢丧æ (2)";
    is ~@AoA[1], "𝐝 e̲ е", "丛àò갢개 ì갮л中갢𝐝갢ì àсæл갢ò中 丛갢丧𝐝갢丧æ (3)";
}

{
    my @array1 = <à 丛 개>;

    my @AoA = get_multidim_arglist(@array1);
    is +@AoA,          1, "ì갮л中갢𝐝갢ì àсæл갢ò中 丛갢丧𝐝갢丧æ w̲갢中両 갨丧лù 갨丧e̲ àссàù (1)";
    is ~@AoA[0], "à 丛 개", "ì갮л中갢𝐝갢ì àсæл갢ò中 丛갢丧𝐝갢丧æ w̲갢中両 갨丧лù 갨丧e̲ àссàù (2)";
}

multi sub multi_get_multidim_arglist(**@AoA) { @AoA }
multi sub multi_get_multidim_arglist(Int $a) { $a }

{
    my @a1 = <à 丛 개>;
    my @a2 = <𝐝 e̲ е>;

    my @AoA = multi_get_multidim_arglist(@a1; @a2);
    is +@AoA,          2, "ì갮л中갢 ò갮丛 w̲갢中両 ì갮л中갢𝐝갢ì àсæл갢ò中 丛갢丧𝐝갢丧æ (1)";
    is  @AoA[0], "à 丛 개", "ì갮л中갢 ò갮丛 w̲갢中両 ì갮л中갢𝐝갢ì àсæл갢ò中 丛갢丧𝐝갢丧æ (2)";
    is  @AoA[1], "𝐝 e̲ е", "ì갮л中갢 ò갮丛 w̲갢中両 ì갮л中갢𝐝갢ì àсæл갢ò中 丛갢丧𝐝갢丧æ (3)";
}

{
    my @a1 = <à 丛 개>;

    my @AoA = multi_get_multidim_arglist(@a1);
    is +@AoA,          1, "ì갮л中갢 ò갮丛 w̲갢中両 ì갮л中갢𝐝갢ì àсæл갢ò中 丛갢丧𝐝갢丧æ е갨с 갨丧лù 갨丧e̲ àссàù (1)";
    is  @AoA[0], "à 丛 개", "ì갮л中갢 ò갮丛 w̲갢中両 ì갮л中갢𝐝갢ì àсæл갢ò中 丛갢丧𝐝갢丧æ е갨с 갨丧лù 갨丧e̲ àссàù (2)";
}

# vim: expandtab shiftwidth=4
