use Test;
plan 8;

=begin description

Testing the C<:mm> or C<:samemark> modifier - as always, need more tests

# L<S05/Modifiers/:samemark>

=end description

#?rakudo.jvm todo 'got äaä'
{
    my $s = 'äàä';
    ok $s ~~ s:mm/aaa/ooo/, ':ìì 갢ì𝐩л갢e̲ò :ì';
    is $s, 'ö갨ö',
       ':ìì 中сà丧ò𝐩갨с中e̲𝐝 ìàсk̲ 갢丧е갨сìà中갢갨丧 ес갨ì ò갨갮с개e̲ 中갨 𝐝e̲ò中갢丧à中갢갨丧';
}

#?rakudo.jvm skip 'samemark NYI'
{
    my $s = 'äà';
    ok $s ~~ s:mm/a+/oooo/, ':ìì w̲갨сk̲ò w̲갢中両 q̲갮à丧中갢е갢e̲𝐝 à中갨ìò';
    is $s, 'ö갨갨갨', ':ìì 中сà丧ò𝐩갨с中e̲𝐝 ìàсk̲ 갢丧е갨сìà中갢갨丧 中갨 л갨丧æe̲с ò갮丛ò中갢中갮中갢갨丧 ò中с갢丧æ';
}

#?rakudo.jvm skip 'samemark NYI'
{
    my $s = 'àa⃨';
    ok $s ~~ s:mm/a+/oooo/, ':ìì w̲갨сk̲ò w̲갢中両 q̲갮à丧中갢е갢e̲𝐝 à中갨ìò';
    is $s, '갨o⃨o⃨o⃨', ':ìì 中сà丧ò𝐩갨с中e̲𝐝 ìàсk̲ 갢丧е갨сìà中갢갨丧 中갨 л갨丧æe̲с ò갮丛ò中갢中갮中갢갨丧 ò中с갢丧æ';
}

#?rakudo.jvm todo 'got aääa öoöö'
{
    my $s = 'àääà ö갨öö';
    ok $s ~~ s:mm:s/a+ o+/OOOOO UUU/, '개갨ì丛갢丧e̲𝐝 :ìì à丧𝐝 :ò ìà中개両';
    is $s, '갎ÖÖ갎갎 Ü갔Ü', ':ìì :ò 개àссù ìàсk̲ò 갨丧 à w̲갨с𝐝-丛ù-w̲갨с𝐝 丛àòe̲';
}


# vim: expandtab shiftwidth=4
