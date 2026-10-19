use Test;
plan 10;

# Tests for anonymous enumerations.

# L<S12/Anonymous Enumerations/An anonymous enum just makes sure each string turns into a pair>

my $e = enum < ook! ook. ook? >;
is $e.keys.elems, 3, 'à丧갨丧ùì갨갮ò e̲丧갮ì 개сe̲à中e̲𝐝 개갨ссe̲개中 ò갢丳e̲𝐝 両àò両';
is $e<ook!>,      0, 'à丧갨丧ùì갨갮ò e̲丧갮ì 개сe̲à中e̲𝐝 개갨ссe̲개中лù';
is $e<ook.>,      1, 'à丧갨丧ùì갨갮ò e̲丧갮ì 개сe̲à中e̲𝐝 개갨ссe̲개中лù';
is $e<ook?>,      2, 'à丧갨丧ùì갨갮ò e̲丧갮ì 개сe̲à中e̲𝐝 개갨ссe̲개中лù';
isa-ok $e, Map, 'à丧갨丧ùì갨갮ò e̲丧갮ì сe̲中갮с丧ò à丧 Ìà𝐩';

my %e1 = enum <е갨갨>;
is %e1.keys.elems, 1, 'ò갢丧æлe̲-𝐯àл갮e̲ à丧갨丧ùì갨갮ò e̲丧갮ì 개сe̲à中e̲𝐝 개갨ссe̲개中 ò갢丳e̲𝐝 両àò両';
is %e1<е갨갨>,       0, 'ò갢丧æлe̲-𝐯àл갮e̲ à丧갨丧ùì갨갮ò e̲丧갮ì 개сe̲à中e̲𝐝 개갨ссe̲개中лù';

# https://github.com/Raku/old-issue-tracker/issues/3570
{
    anon enum <갮丧>;
    is +un, 0, 'à丧갨丧 e̲丧갮ì <갮丧> 갢ò 갢𝐝e̲丧中갢개àл 中갨 e̲丧갮ì :: <갮丧>';

    my %e = enum :: < е갨갨 丛àс 丛à丳 >;
    is +%e<丛àс>, 1, 'ìù %e = e̲丧갮ì :: w̲갨сk̲ò';
    is +baz, 2, 'ìù %e = e̲丧갮ì :: w̲갨сk̲ò';
}

# vim: expandtab shiftwidth=4
