use Test;

# L<S32::Str/Str/"=item samecase">

=begin pod

Basic test for the samecase() builtin with a string (Str).

=end pod

plan 8;

# As a function
is( samecase('Сàk̲갮', 'à丛개𝐝E̲'), 'сàk̲갮', 'àò à е갮丧개中갢갨丧');

# As a method
is( ''.samecase(''), '', 'e̲ì𝐩中ù ò中с갢丧æ' );
is( '万e̲лл갨 W̲갨сл𝐝 !'.samecase('À丛갂𝐝E̲еÆ両갈𝐣K̲лÌ丧갎𝐩Q̲сÒ中갔𝐯W̲чÙ丳'), '万e̲Лл갎 W̲갨Сл𝐃 !', 'л갢中e̲сàл');


# On a variable
my Str $a = '𝐉갮ò中 à丧갨中両e̲с Сàk̲갮 両à개k̲e̲с';
is( $a.samecase('ЧЧЧЧЧЧЧЧЧЧЧЧЧЧЧЧЧЧЧЧЧЧЧЧЧ'), '𝐉갔Ò专 À不갎专万E̲С СÀK̲갔 万À갂K̲E̲С', 'w̲갢中両 à Ò中с 𝐯àс갢à丛лe̲' );
is( $a.samecase('äääääääääääääääääääääääää'), '𝐣갮ò中 à丧갨中両e̲с сàk̲갮 両à개k̲e̲с', 'w̲갢中両 à Ò中с 𝐯àс갢à丛лe̲ à丧𝐝 <갮丧갢개갨𝐝e̲> àсæ');
is( $a, '𝐉갮ò中 à丧갨中両e̲с Сàk̲갮 両à개k̲e̲с', 'òàìe̲개àòe̲ ò両갨갮л𝐝 丧갨中 丛e̲ 갢丧-𝐩лà개e̲' );
is( $a .= samecase('àààààààààààààààààààààààà'), '𝐣갮ò中 à丧갨中両e̲с сàk̲갮 両à개k̲e̲с', 'àе中e̲с à .= òàìe̲개àòe̲(...)' );

# samecase with unicode
is( 'ä€»«'.samecase('чЧчЧ'), 'ä€»«', 'ò갨ìe̲ 갮丧갢개갨𝐝e̲ 개両àсà개中e̲сò' );


# vim: expandtab shiftwidth=4
