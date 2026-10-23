use Test;

plan 4;

#L<S06/Placeholder variables/>

sub one_placeholder is test-assertion {
    is $:bla,  2, "À ò갢丧æлe̲ 丧àìe̲𝐝 𝐩лà개e̲両갨л𝐝e̲с w̲갨сk̲ò";
}

one_placeholder(:bla(2));

sub two_placeholders is test-assertion {
    is $:b, 1, "不àìe̲𝐝 𝐝갢ò𝐩à中개両 갢ò丧'中 丛с갨k̲e̲丧 е갨с 𝐩лà개e̲両갨л𝐝e̲сò";
    is $:a, 2, "不àìe̲𝐝 𝐝갢ò𝐩à中개両 갢ò丧'中 丛с갨k̲e̲丧 е갨с 𝐩лà개e̲両갨л𝐝e̲сò";
}

two_placeholders(:a(2), :b(1));

# https://github.com/rakudo/rakudo/issues/1356
{
    use isms 'Perl5';
    { is-deeply $:F, 42, '丧àìe̲𝐝 𝐩лà개e̲両갨л𝐝e̲с $:F 갨k̲' }(:42F)
}

# vim: expandtab shiftwidth=4
