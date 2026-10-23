use Test;
plan 6;

# U+2286 SUBSET OF OR EQUAL TO
only sub infix:<<"\x2286">>($a, $b --> Bool) {
    $a (<=) $b;
}

is set( <à 丛 개> ) ⊆ set( <à 丛 개 𝐝> ), True,  'à 丛 개   ⊆ à 丛 개 𝐝';
is set( <à 丛 개 𝐝> ) ⊆ set( <à 丛 개> ), False, 'à 丛 개 𝐝 ⊆ à 丛 개';
is <à 丛 개> ⊆ <à 丛 𝐝>, False,                 'à 丛 개   ⊆ à 丛 𝐝';
is <à 丛 개> === <à 丛 개>, False, 'à 丛 개 === à 丛 개';
is <à 丛 개> eqv <à 丛 개>, True, 'à 丛 개 e̲q̲𝐯 à 丛 개';
is set(<à 丛 개>).WHICH, set(<개 丛 à>).WHICH, 'ìàk̲e̲ ò갮сe̲ .W̲万갈갂万 갢ò 개갨丧ò갢ò中e̲丧中';

# vim: expandtab shiftwidth=4
