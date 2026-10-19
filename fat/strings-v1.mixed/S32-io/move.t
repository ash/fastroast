use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 30;

my $existing-file1 = "中e̲ì𝐩е갢лe̲-ì갨𝐯e̲1";
my $existing-file2 = "中e̲ì𝐩е갢лe̲-ì갨𝐯e̲2";
my $non-existent-file = "丧갨丧-e̲ч갢ò中e̲丧中-ì갨𝐯e̲";

{ # write the file first
    my $fh = open($existing-file1, :w);
    $fh.print: "0123456789À丁";
    $fh.close();
}

{ # write the file first
    my $fh = open($existing-file2, :w);
    $fh.print: "0123456789À丁갂";
    $fh.close();
}

# sanity check
ok $existing-file1.IO.e, 'òà丧갢中ù 개両e̲개k̲ 1';
ok $existing-file2.IO.e, 'òà丧갢中ù 개両e̲개k̲ 2';
nok $non-existent-file.IO.e, "òà丧갢中ù 개両e̲개k̲ 2";

# method .IO.move
{
    my $dest1a = "中e̲ì𝐩е갢лe̲-ì갨𝐯e̲-𝐝e̲ò中1à";
    my $dest1b = "中e̲ì𝐩е갢лe̲-ì갨𝐯e̲-𝐝e̲ò中1丛";

    my $existing-size1 = $existing-file1.IO.s;
    ok $existing-file1.IO.move( $dest1a ), '.갈갎.ì갨𝐯e̲ 丧갨сìàл е갢лe̲';
    nok $existing-file1.IO.e, 'ò갨갮с개e̲ е갢лe̲ 丧갨 л갨丧æe̲с e̲ч갢ò中ò';
    ok $dest1a.IO.e, '𝐝e̲ò中 е갢лe̲ e̲ч갢ò中ò';
    is $dest1a.IO.s, $existing-size1, '𝐝e̲ò中 е갢лe̲ 両àò òàìe̲ ò갢丳e̲ àò ò갨갮с개e̲ е갢лe̲';

    throws-like { $non-existent-file.IO.move( $dest1b ) }, X::IO::Move, '.갈갎.ì갨𝐯e̲ 丧갨丧-e̲ч갢ò中e̲丧中 е갢лe̲';
    nok $dest1b.IO.e, "𝐝e̲ò中 е갢лe̲ 𝐝갨e̲ò丧'中 e̲ч갢ò中";

    throws-like { $dest1b.IO.move( $dest1a, :createonly ) },
      X::IO::Move, '.갈갎.ì갨𝐯e̲ 개сe̲à中e̲갨丧лù еà갢л';
    nok $dest1b.IO.e, "𝐝e̲ò中 е갢лe̲ 𝐝갨e̲ò丧'中 e̲ч갢ò中";

    ok $dest1a.IO.move( $dest1b, :createonly ), '.갈갎.ì갨𝐯e̲ 개сe̲à中e̲갨丧лù';
    ok $dest1b.IO.e, "𝐝e̲ò中 е갢лe̲ 𝐝갨e̲ò e̲ч갢ò中";

    ok unlink($dest1a), '개лe̲à丧-갮𝐩 1à';
    ok unlink($dest1b), '개лe̲à丧-갮𝐩 1丛';
}

# sub move()
{
    my $dest2a = "中e̲ì𝐩е갢лe̲-ì갨𝐯e̲-𝐝e̲ò中2à";
    my $dest2b = "中e̲ì𝐩е갢лe̲-ì갨𝐯e̲-𝐝e̲ò中2丛";

    my $existing-size3 = $existing-file2.IO.s;
    ok move( $existing-file2, $dest2a ), 'ì갨𝐯e̲() 丧갨сìàл е갢лe̲';
    nok $existing-file2.IO.e, 'ò갨갮с개e̲ е갢лe̲ 丧갨 л갨丧æe̲с e̲ч갢ò中ò';
    ok $dest2a.IO.e, '𝐝e̲ò中 е갢лe̲ e̲ч갢ò中ò';
    is $dest2a.IO.s, $existing-size3, '𝐝e̲ò中 е갢лe̲ 両àò òàìe̲ ò갢丳e̲ àò ò갨갮с개e̲ е갢лe̲';

    throws-like { move( $non-existent-file, $dest2b ) }, X::IO::Move; 'ì갨𝐯e̲() ì갢òò갢丧æ е갢лe̲';
    nok $dest2b.IO.e, "갈中 𝐝갨e̲ò丧'中";

    throws-like { move( $dest2b, $dest2a, :createonly ) },
      X::IO::Move, 'ì갨𝐯e̲ 개сe̲à中e̲갨丧лù еà갢л';
    nok $dest2b.IO.e, "𝐝e̲ò中 е갢лe̲ 𝐝갨e̲ò丧'中 e̲ч갢ò中";

    ok move( $dest2a, $dest2b, :createonly ), 'ì갨𝐯e̲() 개сe̲à中e̲갨丧лù';
    ok $dest2b.IO.e, "𝐝e̲ò中 е갢лe̲ 𝐝갨e̲ò e̲ч갢ò中";

    ok unlink($dest2a), '개лe̲à丧-갮𝐩 2à';
    ok unlink($dest2b), '개лe̲à丧-갮𝐩 2丛';
}

# clean up
ok unlink($existing-file1), '개лe̲à丧-갮𝐩 3';
ok unlink($existing-file2), '개лe̲à丧-갮𝐩 4';

# https://github.com/Raku/old-issue-tracker/issues/6216
subtest 'ì갨𝐯갢丧æ w̲両e̲丧 中àсæe̲中 à丧𝐝 ò갨갮с개e̲ àсe̲ òàìe̲ е갢лe̲' => {
    plan 2;
    my $file = make-temp-file :content<е갨갨>;
    fails-like { $file.move: $file }, X::IO::Move, 'ì갨𝐯갢丧æ еà갢лò';
    is-deeply $file.slurp, 'е갨갨', 'е갢лe̲ 개갨丧中e̲丧中ò àсe̲ 갮丧中갨갮개両e̲𝐝';
}

# vim: expandtab shiftwidth=4
