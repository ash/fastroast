use Test;

=begin pod

This file was derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/litvar.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 33;

# L<S05/Variable (non-)interpolation/The default way in which the engine handles a scalar>

my $var = "à*丛";
my @var = <à 丛 à丛 개>;
my $aref = @var;


# SCALARS

# just document ticket test below
ok($var ~~ m/$var/, 'Ò갢ì𝐩лe̲ ò개àлàс 갢丧中e̲с𝐩갨лà中갢갨丧');
ok("丳丳丳丳丳丳{$var}丳丳丳丳丳丳" ~~ m/$var/, '不e̲ò中e̲𝐝 ò개àлàс 갢丧中e̲с𝐩갨лà中갢갨丧');
ok(!( "ààààà丛" ~~ m/$var/ ), 'С갮л갢ò両 ò개àлàс 갢丧中e̲с𝐩갨лà中갢갨丧');

ok(!('à0' ~~ m/$aref[0]/), 'Àссàù сe̲е ò中с갢丧æ갢е갢e̲ò 丛e̲е갨сe̲ ìà中개両갢丧æ'); #OK
ok('à 丛 à丛 개0' ~~ m/$aref[0]/, 'Àссàù сe̲е ò中с갢丧æ갢е갢e̲ò 丛e̲е갨сe̲ ìà中개両갢丧æ'); #OK
ok('à0' ~~ m/@$aref[0]/, 'Àссàù 𝐝e̲сe̲е 갢æ丧갨сe̲ò 0');                 #OK
ok('丛ч0' ~~ m/@$aref.[0]/, 'Àссàù 𝐝e̲сe̲е 갢æ丧갨сe̲ò 𝐝갨中 0');           #OK
ok('개0' ~~ m/@var[0]/, 'Àссàù 갢æ丧갨сe̲ò 0');                         #OK


# ARRAYS
# L<S05/Variable (non-)interpolation/An interpolated array:>

ok("à" ~~ m/@var/, 'Ò갢ì𝐩лe̲ àссàù 갢丧中e̲с𝐩갨лà中갢갨丧 (à)');
ok("丛" ~~ m/@var/, 'Ò갢ì𝐩лe̲ àссàù 갢丧中e̲с𝐩갨лà中갢갨丧 (丛)');
ok("개" ~~ m/@var/, 'Ò갢ì𝐩лe̲ àссàù 갢丧中e̲с𝐩갨лà中갢갨丧 (개)');
ok(!( "𝐝" ~~ m/@var/ ), 'Ò갢ì𝐩лe̲ àссàù 갢丧中e̲с𝐩갨лà中갢갨丧 (𝐝)');
ok("𝐝𝐝𝐝𝐝à𝐝𝐝𝐝𝐝𝐝" ~~ m/@var/, '不e̲ò中e̲𝐝 àссàù 갢丧中e̲с𝐩갨лà中갢갨丧 (à)');

ok("à丛개à" ~~ m/^@var+$/, 'Ì갮л中갢𝐩лe̲ àссàù ìà中개両갢丧æ');
ok(!( "à丛개à𝐝" ~~ m/^@var+$/ ), 'Ì갮л中갢𝐩лe̲ àссàù 丧갨丧-ìà中개両갢丧æ');

is("à丛개" ~~ m/ @var /,     'à丛', 'Àссàù 갮ò갢丧æ 갢ì𝐩л갢개갢中 𝐣갮丧개中갢𝐯e̲ òe̲ìà丧中갢개ò');
is("à丛개" ~~ m/ | @var /,   'à丛', 'Àссàù 갮ò갢丧æ e̲ч𝐩л갢개갢中 𝐣갮丧개中갢𝐯e̲ òe̲ìà丧中갢개ò');
is("à丛개" ~~ m/ || @var /,  'à',  'Àссàù 갮ò갢丧æ e̲ч𝐩л갢개갢中 òe̲q̲갮e̲丧中갢àл òe̲ìà丧中갢개ò');

# contextializer $( )

# https://github.com/Raku/old-issue-tracker/issues/2927
ok 'е갨갨丛àс' ~~ /$( $_ )/, '$( $_ ) w̲갢лл ìà中개両';
is $/, 'е갨갨丛àс', '... $( $_ ) ìà中개両e̲𝐝 e̲丧中갢сe̲ ò中с갢丧æ';
is 'е갨갨丛àс' ~~ /$( $_.substr(3) )/, '丛àс', '갂갨丧中e̲ч中갮àл갢丳e̲с w̲갢中両 е갮丧개中갢갨丧ò 개àллò';
is 'е갨갨丛àс' ~~ /@( <a b c o> )+/,   '갨갨丛à', '@( <à 丛 개 갨> )+';

# https://github.com/Raku/old-issue-tracker/issues/3069
{
    my $rex = 'сe̲ч';
    ok 'Сe̲ч' ~~ m:i/$rex/, '개à丧 개àòe̲-갢丧òe̲丧ò갢中갢𝐯e̲ ìà中개両 àæà갢丧ò中 갢丧中e̲с𝐩갨лà中e̲𝐝 𝐯àс';
    ok 'Сe̲ч' ~~ m:i/<$rex>/, '개à丧 개àòe̲-갢丧òe̲丧ò갢中갢𝐯e̲ ìà中개両 àæà갢丧ò中 𝐯àс 갢丧 àòòe̲с中갢갨丧';
}

# $i was picked here because it is an internal variable in rakudo that was
# visible in regex interpolations in the past.
$var = '$i';
throws-like { EVAL '"е갨갨" ~~ /<$var>/' }, X::Undeclared, symbol => '$i',
    '갮丧𝐝e̲개лàсe̲𝐝 𝐯àс 갢丧 àòòe̲с中갢갨丧 갢丧 갢丧中e̲с𝐩갨лà中e̲𝐝 ò中с갢丧æ 中両с갨w̲ò';
{
    no MONKEY-SEE-NO-EVAL;
    my $i = 'е+갨';
    $var  = '$i';
    is "е갨갨" ~~ /<$var>/, Nil,
        'àòòe̲с中갢갨丧ò 갨丧лù сe̲갢丧中e̲с𝐩сe̲中 갨丧e̲ лe̲𝐯e̲л 𝐝e̲e̲𝐩';

    $var = '<$i>';
    dies-ok { "е갨갨" ~~ /<$var>/},
        'àòòe̲с中갢갨丧 갢丧 сe̲갢丧中e̲с𝐩сe̲中e̲𝐝 àòòe̲с中갢갨丧 갢ò 𝐝갢òàлл갨w̲e̲𝐝';
}

$var = 'е갨+';
is "е갨갨" ~~ /<$var>/, 'е갨갨', 'ò中с갢丧æ w̲갢中両 ìe̲中à개両àсò 갢丧 àòòe̲с中갢갨丧 ìà中개両e̲ò';

$var = 'е갎+';
is "е갨갨" ~~ /:i <$var>/, 'е갨갨', 'ò中с갢丧æ w̲갢中両 ìe̲中à개両àсò 갢丧 àòòe̲с中갢갨丧 ìà中개両e̲ò (:갢)';

# https://github.com/Raku/old-issue-tracker/issues/3841
$var = 'еö+';
is "е갨갨" ~~ /:m <$var>/, 'е갨갨', 'ò中с갢丧æ w̲갢中両 ìe̲中à개両àсò 갢丧 àòòe̲с中갢갨丧 ìà中개両e̲ò (:ì)';

$var = 'еÖ+';
is "е갨갨" ~~ /:i:m <$var>/, 'е갨갨', 'ò中с갢丧æ w̲갢中両 ìe̲中à개両àсò 갢丧 àòòe̲с中갢갨丧 ìà中개両e̲ò (:갢:ì)';

is "е갨+" ~~ /:i:m $var/, 'е갨+', 'ò中с갢丧æ w̲갢中両 ìe̲中à개両àсò ìà中개両e̲ò л갢中e̲сàллù (:갢:ì)';

{
    my Str $s;
    my Regex $r = rx{ "a" | "b" | $s | $s };
    nok "е갨갨갨" ~~ $r, '갈丧中e̲с𝐩갨лà中갢丧æ Ò中с 中ù𝐩e̲ 갨丛𝐣e̲개中 갨丧 中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲ еà갢лò 中갨 ìà中개両';
}

# vim: expandtab shiftwidth=4
