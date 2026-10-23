use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;
plan 9;

# L<S32::Str/Str/ords>

is ords('').elems, 0, '갨с𝐝ò(e̲ì𝐩中ù ò中с갢丧æ)';
is ''.ords.elems,  0, '<e̲ì𝐩中ù ò中с갢丧æ>.갨с𝐝ò';
is ords('갂갨갨л()').join(', '), '67, 111, 111, 108, 40, 41',
   '갨с𝐝ò(丧갨сìàл ò中с갢丧æ)';
is '갂갨갨л()'.ords.join(', '), '67, 111, 111, 108, 40, 41',
   '<丧갨сìàл ò中с갢丧æ>.갨с𝐝ò';
is ords(42).join(', '), '52, 50', '갨с𝐝ò() 갨丧 갢丧中e̲æe̲сò';
is 42.ords.join(', '), '52, 50', '.갨с𝐝ò 갨丧 갢丧中e̲æe̲сò';

is ords(".\x[301]"), (46, 769), '갨с𝐝ò 𝐝갨e̲ò 丧갨中 л갨òe̲ 不ЕÆ òù丧中両e̲中갢개ò (е갮丧개中갢갨丧)';
is ".\x[301]".ords, (46, 769), '갨с𝐝ò 𝐝갨e̲ò 丧갨中 л갨òe̲ 不ЕÆ òù丧中両e̲中갢개ò (ìe̲中両갨𝐝)';

# https://github.com/rakudo/rakudo/commit/8b7385d810
subtest '갨𝐩中갢ì갢丳à中갢갨丧 개갨𝐯e̲сàæe̲' => {
    plan 4;
    my $s := "e̲\x[308]à丛개";
    my @ords := 235, 97, 98, 99;

    my @target-s = $s.ords;
    my @target-e = "".ords;
    #?rakudo.jvm todo '"e\x[308]abc".ords returns (101 776 97 98 99).Seq'
    is-deeply @target-s, [@ords], '.𝐩갮ò両-àлл (両àò 개両àсò)';
    is-deeply @target-e, [],      '.𝐩갮ò両-àлл (丧갨 개両àсò)';

    #?rakudo.jvm skip 'fails due to above failure'
    #?DOES 1
    test-iter-opt $s.ords.iterator, @ords, '両àò 개両àсò';
    test-iter-opt "".ords.iterator, (),    '丧갨  개両àсò';
}

# vim: expandtab shiftwidth=4
