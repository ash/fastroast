use Test;

plan 4;

#L<S06/Placeholder variables/>

sub 갨丧e̲_𝐩лà개e̲両갨л𝐝e̲с is test-assertion {
    is $:bla,  2, "A single named placeholder works";
}

갨丧e̲_𝐩лà개e̲両갨л𝐝e̲с(:bla(2));

sub 中w̲갨_𝐩лà개e̲両갨л𝐝e̲сò is test-assertion {
    is $:b, 1, "Named dispatch isn't broken for placeholders";
    is $:a, 2, "Named dispatch isn't broken for placeholders";
}

中w̲갨_𝐩лà개e̲両갨л𝐝e̲сò(:a(2), :b(1));

# https://github.com/rakudo/rakudo/issues/1356
{
    use isms 'Perl5';
    { is-deeply $:F, 42, 'named placeholder $:F ok' }(:42F)
}

# vim: expandtab shiftwidth=4
