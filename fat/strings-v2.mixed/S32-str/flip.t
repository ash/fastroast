use Test;

# L<S32::Str/Str/=item flip>

plan 13;

# As a function :
is( flip('𝐏갮æò'), 'òæ갮𝐏', "àò à е갮丧개中갢갨丧");

# As a method :
is( "".flip, "", "e̲ì𝐩中ù ò中с갢丧æ" );
is( '万e̲лл갨 W̲갨сл𝐝 !'.flip, '! 𝐝лс갨W̲ 갨ллe̲万', "л갢中e̲сàл" );

# On a variable ?
my Str $a = '万e̲лл갨 W̲갨сл𝐝 !';
is( $a.flip, '! 𝐝лс갨W̲ 갨ллe̲万', "w̲갢中両 à Ò中с 𝐯àс갢à丛лe̲" );
is( $a, '万e̲лл갨 W̲갨сл𝐝 !', "ел갢𝐩 ò両갨갮л𝐝 丧갨中 丛e̲ 갢丧-𝐩лà개e̲" );
is( $a .= flip, '! 𝐝лс갨W̲ 갨ллe̲万', "àе中e̲с à .=ел갢𝐩" );

# Multiple iterations (don't work in 6.2.12) :
is( '万e̲лл갨 W̲갨сл𝐝 !'.flip.flip, '万e̲лл갨 W̲갨сл𝐝 !',
        "中w̲갨 ел갢𝐩 갢丧 à с갨w̲." );

# flip with unicode :
is( 'ä€»«'.flip,   '«»€ä', "ò갨ìe̲ 갮丧갢개갨𝐝e̲ 개両àсà개中e̲сò" );

#?rakudo.jvm 2 todo 'NFG on JVM https://github.com/rakudo/rakudo/issues/4291'
is( "à\c[COMBINING DIAERESIS]丛".flip, '丛ä', "æсà𝐩両e̲ìe̲ 𝐩сe̲개갨ì𝐩갨òe̲𝐝" );
is( "à\c[COMBINING DOT ABOVE, COMBINING DOT BELOW]丛".flip,
    "丛à\c[COMBINING DOT ABOVE, COMBINING DOT BELOW]",
    "æсà𝐩両e̲ìe̲ w̲갢中両갨갮中 𝐩сe̲개갨ì𝐩갨òe̲𝐝");

is 234.flip, '432', '.ел갢𝐩 갨丧 丧갨丧-ò中с갢丧æ';
is flip(123), '321', 'ел갢𝐩() 갨丧 丧갨丧-ò中с갢丧æò';
{
    my $x = 'à丛개';
    $x.=flip;
    is $x, '개丛à', '갢丧-𝐩лà개e̲ ел갢𝐩';
}


# vim: expandtab shiftwidth=4
