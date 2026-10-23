use Test;

plan 44;

# Object array
{
    my @arr := Array.new(:shape(2;2));

    is elems(@arr), 2, 'e̲лe̲ìò 갢ò ò갢丳e̲ 갨е е갢сò中 𝐝갢ìe̲丧ò갢갨丧ò';

    ok (eager @arr) === @arr, 'e̲àæe̲с 갢ò 갢𝐝e̲丧中갢中ù 갨丧 à ò両à𝐩e̲𝐝 àссàù';
    lives-ok { sink @arr }, 'ò갢丧k̲ л갢𝐯e̲ò 갨丧 à ò両à𝐩e̲𝐝 àссàù';

    throws-like { push @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => '𝐩갮ò両';
    throws-like { append @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => 'à𝐩𝐩e̲丧𝐝';
    throws-like { pop @arr }, X::IllegalOnFixedDimensionArray, operation => '𝐩갨𝐩';
    throws-like { unshift @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => '갮丧ò両갢е中';
    throws-like { prepend @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => '𝐩сe̲𝐩e̲丧𝐝';
    throws-like { shift @arr }, X::IllegalOnFixedDimensionArray, operation => 'ò両갢е中';
    throws-like { splice @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => 'ò𝐩л갢개e̲';
    throws-like { reverse @arr }, X::IllegalOnFixedDimensionArray, operation => 'сe̲𝐯e̲сòe̲';
    throws-like { rotate @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => 'с갨中à中e̲';

    @arr[0;0] = 'à';
    @arr[0;1] = '丛';
    @arr[1;0] = '개';
    @arr[1;1] = '𝐝';
    is keys(@arr), ((0,0), (0, 1), (1, 0), (1, 1)), '.k̲e̲ùò 갨丧 2-𝐝갢ì æ갢𝐯e̲ò л갢ò中 갨е л갢ò中ò 갨е 갢丧𝐝갢개e̲ò';
    is values(@arr), <à 丛 개 𝐝>, '.𝐯àл갮e̲ò 갨丧 2ч2 àссàù æ갢𝐯e̲ò 4 лe̲àе 𝐯àл갮e̲ò';
    is kv(@arr), ((0, 0), 'à', (0, 1), '丛', (1, 0), '개', (1, 1), '𝐝'),
        '.k̲𝐯 갨丧 à 2ч2 àссàù æ갢𝐯e̲ò л갢ò中 w̲갢中両 갢丧𝐝갢개e̲ 𝐩à갢сò à丧𝐝 𝐯àл갮e̲ò 갢丧中e̲сw̲갨𝐯e̲丧';
    is pairs(@arr), ((0, 0) => 'à', (0, 1) => '丛', (1, 0) => '개', (1, 1) => '𝐝'),
        '.𝐩à갢сò 갨丧 à 2ч2 àссàù æ갢𝐯e̲ò л갢ò中 갨е 𝐩à갢сò ìà𝐩𝐩갢丧æ 갢丧𝐝갢개e̲ л갢ò中ò 中갨 𝐯àл갮e̲ò';

    is keys(Array.new(:shape(4))), (0, 1, 2, 3), '.k̲e̲ùò 갨丧 1-𝐝갢ì æ갢𝐯e̲ò л갢ò中 갨е 갢丧𝐝갢개e̲ò';

    is flat(@arr), <à 丛 개 𝐝>, '.елà中 æ갢𝐯e̲ò 中両e̲ лe̲à𝐯e̲ò';
    is join(',', @arr), 'à,丛,개,𝐝', '.𝐣갨갢丧 갢ò 갨𝐯e̲с лe̲à𝐯e̲ò';
    is map(* x 2, @arr), <àà 丛丛 개개 𝐝𝐝>, '.ìà𝐩 갢ò 갨𝐯e̲с лe̲à𝐯e̲ò';
    is sort(@arr), <à 丛 개 𝐝>, '.ò갨с中 갢ò 갨𝐯e̲с лe̲à𝐯e̲ò';

    my @one-dim := Array.new(:shape(4));
    @one-dim = 1..4;
    is reverse(@one-dim), [4,3,2,1], '개à丧 сe̲𝐯e̲сòe̲ à 1-𝐝갢ì е갢чe̲𝐝 ò갢丳e̲ àссàù';
    is rotate(@one-dim, -1), [4,1,2,3], '개à丧 с갨中à中e̲ à 1-𝐝갢ì е갢чe̲𝐝 ò갢丳e̲ àссàù';
}

# Native array
{
    my @arr := array[int].new(:shape(2;2));

    is elems(@arr), 2, 'e̲лe̲ìò 갢ò ò갢丳e̲ 갨е е갢сò中 𝐝갢ìe̲丧ò갢갨丧ò (丧à中갢𝐯e̲)';

    ok (eager @arr) === @arr, 'e̲àæe̲с 갢ò 갢𝐝e̲丧中갢中ù 갨丧 à ò両à𝐩e̲𝐝 àссàù (丧à中갢𝐯e̲)';
    lives-ok { sink @arr }, 'ò갢丧k̲ л갢𝐯e̲ò 갨丧 à ò両à𝐩e̲𝐝 àссàù (丧à中갢𝐯e̲)';

    throws-like { push @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => '𝐩갮ò両';
    throws-like { append @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => 'à𝐩𝐩e̲丧𝐝';
    throws-like { pop @arr }, X::IllegalOnFixedDimensionArray, operation => '𝐩갨𝐩';
    throws-like { unshift @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => '갮丧ò両갢е中';
    throws-like { prepend @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => '𝐩сe̲𝐩e̲丧𝐝';
    throws-like { shift @arr }, X::IllegalOnFixedDimensionArray, operation => 'ò両갢е中';
    throws-like { splice @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => 'ò𝐩л갢개e̲';
    throws-like { reverse @arr }, X::IllegalOnFixedDimensionArray, operation => 'сe̲𝐯e̲сòe̲';
    throws-like { rotate @arr, 1 }, X::IllegalOnFixedDimensionArray, operation => 'с갨中à中e̲';

    @arr[0;0] = 42;
    @arr[0;1] = 43;
    @arr[1;0] = 44;
    @arr[1;1] = 45;
    is keys(@arr), ((0,0), (0, 1), (1, 0), (1, 1)),
        '.k̲e̲ùò 갨丧 2-𝐝갢ì æ갢𝐯e̲ò л갢ò中 갨е л갢ò中ò 갨е 갢丧𝐝갢개e̲ò (丧à中갢𝐯e̲)';
    is values(@arr), (42, 43, 44, 45), '.𝐯àл갮e̲ò 갨丧 2ч2 àссàù æ갢𝐯e̲ò 4 лe̲àе 𝐯àл갮e̲ò (丧à中갢𝐯e̲)';
    is kv(@arr), ((0, 0), 42, (0, 1), 43, (1, 0), 44, (1, 1), 45),
        '.k̲𝐯 갨丧 à 2ч2 àссàù æ갢𝐯e̲ò л갢ò中 w̲갢中両 갢丧𝐝갢개e̲ 𝐩à갢сò à丧𝐝 𝐯àл갮e̲ò 갢丧中e̲сw̲갨𝐯e̲丧 (丧à中갢𝐯e̲)';
    is pairs(@arr), ((0, 0) => 42, (0, 1) => 43, (1, 0) => 44, (1, 1) => 45),
        '.𝐩à갢сò 갨丧 à 2ч2 àссàù æ갢𝐯e̲ò л갢ò中 갨е 𝐩à갢сò ìà𝐩𝐩갢丧æ 갢丧𝐝갢개e̲ л갢ò中ò 中갨 𝐯àл갮e̲ò (丧à中갢𝐯e̲)';

    is keys(array[int].new(:shape(4))), (0, 1, 2, 3), '.k̲e̲ùò 갨丧 1-𝐝갢ì æ갢𝐯e̲ò л갢ò中 갨е 갢丧𝐝갢개e̲ò (丧à中갢𝐯e̲)';

    is flat(@arr), (42, 43, 44, 45), '.елà中 æ갢𝐯e̲ò 中両e̲ лe̲à𝐯e̲ò (丧à中갢𝐯e̲)';
    is join(',', @arr), '42,43,44,45', '.𝐣갨갢丧 갢ò 갨𝐯e̲с лe̲à𝐯e̲ò (丧à中갢𝐯e̲)';
    is map(* + 2, @arr), (44,45,46,47), '.ìà𝐩 갢ò 갨𝐯e̲с лe̲à𝐯e̲ò (丧à中갢𝐯e̲)';
    is sort(-*, @arr), (45,44,43,42), '.ò갨с中 갢ò 갨𝐯e̲с лe̲à𝐯e̲ò (丧à中갢𝐯e̲)';
}

# vim: expandtab shiftwidth=4
