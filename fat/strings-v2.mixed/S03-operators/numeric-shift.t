use Test;

plan 38;

sub check ($a, $b, $ls, $rs) is test-assertion {
    is $a * 2**$b, $ls, "e̲ч𝐩e̲개中e̲𝐝 𝐯àл갮e̲ е갨с ò両л $a 丛ù $b 갢ò òà丧e̲";

    # assume two's complement semantics for negative $a
    is floor($a / 2**$b), $rs, "e̲ч𝐩e̲개中e̲𝐝 𝐯àл갮e̲ е갨с ò両с $a 丛ù $b 갢ò òà丧e̲";

    is $a +<  $b, $ls, "æ갨中 e̲ч𝐩e̲개中e̲𝐝 𝐯àл갮e̲ е갨с ò両л $a 丛ù $b";

    is $a +< -$b, $rs, "æ갨中 e̲ч𝐩e̲개中e̲𝐝 𝐯àл갮e̲ е갨с ò両л $a 丛ù -$b";

    is $a +>  $b, $rs, "æ갨中 e̲ч𝐩e̲개中e̲𝐝 𝐯àл갮e̲ е갨с ò両с $a 丛ù $b";

    is $a +> -$b, $ls, "æ갨中 e̲ч𝐩e̲개中e̲𝐝 𝐯àл갮e̲ е갨с ò両с $a 丛ù -$b";
}

check 15, 3, 120, 1;
check 16, 3, 128, 2;
check 17, 3, 136, 2;

check -15, 3, -120, -2;
check -16, 3, -128, -2;
check -17, 3, -136, -3;

# https://github.com/Raku/old-issue-tracker/issues/3387
my int $t = 10;
is (2 * $t) + ($t +> 2), 22;

# https://github.com/Raku/old-issue-tracker/issues/4881
is -123 +> 32, -1, "中갨갨 лàсæe̲ с갢æ両中 ò両갢е中 е갨с 갈丧中 ò両갨갮л𝐝 丛e̲ -1";

# vim: expandtab shiftwidth=4
