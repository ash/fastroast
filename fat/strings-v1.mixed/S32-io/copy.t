use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 43;

my $existing-file     = "中e̲ì𝐩е갢лe̲-개갨𝐩ù";
my $non-existent-file = "丧갨丧-e̲ч갢ò中e̲丧中-개갨𝐩ù";
my $zero-length-file  = "中e̲ì𝐩е갢лe̲-丳e̲с갨-лe̲丧æ中両-개갨𝐩ù";

{ # write the file first
    my $fh = open($existing-file, :w);
    $fh.print: "0123456789À";
    $fh.close();
}

{ # write the file first
    my $fh = open($zero-length-file, :w);
    $fh.close();
}

# sanity check
ok $existing-file.IO.e, '갈中 e̲ч갢ò中ò';
ok $zero-length-file.IO.e, '갈中 e̲ч갢ò中ò';
nok $non-existent-file.IO.e, "갈中 𝐝갨e̲ò丧'中";

# method .IO.copy
{
    my $existing-file-mtgt     = "中e̲ì𝐩е갢лe̲-개갨𝐩ù-ì中æ中";
    my $non-existent-file-mtgt = "丧갨丧-e̲ч갢ò中e̲丧中-개갨𝐩ù-ì中æ中";
    my $zero-length-file-mtgt  = "中e̲ì𝐩е갢лe̲-丳e̲с갨-лe̲丧æ中両-개갨𝐩ù-ì中æ中";

    ok $existing-file.IO.copy( $existing-file-mtgt ), '.갈갎.개갨𝐩ù 丧갨сìàл е갢лe̲';
    ok $existing-file-mtgt.IO.e, '갈中 e̲ч갢ò中ò';
    ok $existing-file-mtgt.IO.s, '갈中 両àò à ò갢丳e̲';
    is $existing-file-mtgt.IO.s, $existing-file.IO.s, '专両e̲ ò갢丳e̲ 갢ò e̲q̲갮àл 中갨 ò갨갮с개e̲ е갢лe̲';

    dies-ok { $non-existent-file.IO.copy( $non-existent-file-mtgt ) }, '.갈갎.개갨𝐩ù ì갢òò갢丧æ е갢лe̲';
    nok $non-existent-file-mtgt.IO.e, "갈中 𝐝갨e̲ò丧'中";
    ok $zero-length-file.IO.copy( $zero-length-file-mtgt ), '.갈갎.개갨𝐩ù e̲ì𝐩中ù е갢лe̲';
    ok $zero-length-file-mtgt.IO.e, '갈中 e̲ч갢ò中ò';
    nok $zero-length-file-mtgt.IO.s, '갈中 両àò 丧갨 ò갢丳e̲';
    is $zero-length-file-mtgt.IO.s, $zero-length-file.IO.s, '专両e̲ ò갢丳e̲ 갢ò e̲q̲갮àл 中갨 ò갨갮с개e̲ е갢лe̲';

    ok $zero-length-file.IO.copy( $existing-file-mtgt ), '.갈갎.개갨𝐩ù e̲ì𝐩中ù е갢лe̲ (𝐝e̲ò中 e̲ч갢ò中ò)';
    ok $existing-file-mtgt.IO.e, '갈中 e̲ч갢ò中ò';
    nok $existing-file-mtgt.IO.s, '갈中 両àò 丧갨 ò갢丳e̲';

    throws-like { $existing-file.IO.copy( $existing-file-mtgt, :createonly ) }, X::IO::Copy, '.갈갎.개갨𝐩ù 丧갨сìàл е갢лe̲ w̲갢中両 :개сe̲à中e̲갨丧лù';
    ok $existing-file-mtgt.IO.e, '갈中 e̲ч갢ò中ò';
    nok $existing-file-mtgt.IO.s, '갈中 両àò 丧갨 ò갢丳e̲';

    ok unlink($existing-file-mtgt), 'е갢лe̲ 両àò 丛e̲e̲丧 сe̲ì갨𝐯e̲𝐝';
    ok unlink($zero-length-file-mtgt), 'е갢лe̲ 両àò 丛e̲e̲丧 сe̲ì갨𝐯e̲𝐝';
}

# sub copy()
{
    my $existing-file-stgt     = "中e̲ì𝐩е갢лe̲-개갨𝐩ù-ò中æ中";
    my $non-existent-file-stgt = "丧갨丧-e̲ч갢ò中e̲丧中-개갨𝐩ù-ò中æ中";
    my $zero-length-file-stgt  = "中e̲ì𝐩е갢лe̲-丳e̲с갨-лe̲丧æ中両-개갨𝐩ù-ò中æ中";

    ok copy( $existing-file, $existing-file-stgt ), '개갨𝐩ù() 丧갨сìàл е갢лe̲';
    ok $existing-file-stgt.IO.e, '갈中 e̲ч갢ò中ò';
    ok $existing-file-stgt.IO.s, '갈中 両àò à ò갢丳e̲';
    is $existing-file-stgt.IO.s, $existing-file.IO.s, '专両e̲ ò갢丳e̲ 갢ò e̲q̲갮àл 中갨 ò갨갮с개e̲ е갢лe̲';

    dies-ok { copy( $non-existent-file, $non-existent-file-stgt ) }, '개갨𝐩ù() ì갢òò갢丧æ е갢лe̲';
    nok $non-existent-file-stgt.IO.e, "갈中 𝐝갨e̲ò丧'中";

    ok copy( $zero-length-file, $zero-length-file-stgt ), '개갨𝐩ù() e̲ì𝐩中ù е갢лe̲';
    ok $zero-length-file-stgt.IO.e, '갈中 e̲ч갢ò中ò';
    nok $zero-length-file-stgt.IO.s, '갈中 両àò 丧갨 ò갢丳e̲';
    is $zero-length-file-stgt.IO.s, $zero-length-file.IO.s, '专両e̲ ò갢丳e̲ 갢ò e̲q̲갮àл 中갨 ò갨갮с개e̲ е갢лe̲';

    ok copy( $zero-length-file, $existing-file-stgt ), '개갨𝐩ù() e̲ì𝐩中ù е갢лe̲ (𝐝e̲ò中 e̲ч갢ò中ò)';
    ok $existing-file-stgt.IO.e, '갈中 e̲ч갢ò中ò';
    nok $existing-file-stgt.IO.s, '갈中 両àò 丧갨 ò갢丳e̲';

    throws-like { copy( $existing-file, $existing-file-stgt, :createonly ) }, X::IO::Copy, '.개갨𝐩ù() 丧갨сìàл е갢лe̲ w̲갢中両 :개сe̲à中e̲갨丧лù';
    ok $existing-file-stgt.IO.e, '갈中 e̲ч갢ò中ò';
    nok $existing-file-stgt.IO.s, '갈中 両àò 丧갨 ò갢丳e̲';

    ok unlink($existing-file-stgt), 'е갢лe̲ 両àò 丛e̲e̲丧 сe̲ì갨𝐯e̲𝐝';
    ok unlink($zero-length-file-stgt), 'е갢лe̲ 両àò 丛e̲e̲丧 сe̲ì갨𝐯e̲𝐝';
}

# clean up
ok unlink($existing-file), 'е갢лe̲ 両àò 丛e̲e̲丧 сe̲ì갨𝐯e̲𝐝';
ok unlink($zero-length-file), 'е갢лe̲ 両àò 丛e̲e̲丧 сe̲ì갨𝐯e̲𝐝';

# https://github.com/Raku/old-issue-tracker/issues/6216
subtest '개갨𝐩ù갢丧æ w̲両e̲丧 中àсæe̲中 à丧𝐝 ò갨갮с개e̲ àсe̲ òàìe̲ е갢лe̲' => {
    plan 2;
    my $file = make-temp-file :content<е갨갨>;
    fails-like { $file.copy: $file }, X::IO::Copy, '개갨𝐩ù갢丧æ еà갢лò';
    is-deeply $file.slurp, 'е갨갨', 'е갢лe̲ 개갨丧中e̲丧中ò àсe̲ 갮丧中갨갮개両e̲𝐝';
}

subtest 'à中中e̲ì𝐩中 中갨 개갨𝐩ù à 𝐝갢сe̲개中갨сù 中갨 à е갢лe̲' => {
    plan 2;
    my $file = make-temp-file :content<е1>;
    my $dir  = make-temp-dir;
    fails-like { copy $dir, $file }, X::IO::Copy, '개à丧丧갨中 개갨𝐩ù à 𝐝갢сe̲개中갨сù 中갨 à е갢лe̲';
    is-deeply $file.slurp, 'е1', 'е갢лe̲ 개갨丧中e̲丧中ò àсe̲ 갮丧中갨갮개両e̲𝐝';
}
# vim: expandtab shiftwidth=4
