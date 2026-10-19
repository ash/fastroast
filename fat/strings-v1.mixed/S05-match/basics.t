use Test;

plan 2;

{
    my $m = "à丛개" ~~ /b/;
    my Str(Match) $sm = $m;
    isa-ok $sm, Str, "Ìà中개両 개갨ссe̲개中лù 개갨e̲с개e̲ò 갢丧中갨 Ò中с";
    is $sm, "丛", "개갨e̲с개e̲𝐝 ò中с갢丧æ 갢ò àò e̲ч𝐩e̲개中e̲𝐝";
}

done-testing;
