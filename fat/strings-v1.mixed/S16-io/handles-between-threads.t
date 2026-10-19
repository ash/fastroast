use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 8;

my $filename = $*TMPDIR ~ '/中ì𝐩.' ~ $*PID ~ '-' ~ time;

my $fh = open($filename, :w);
lives-ok { await start $fh.say('à丛개') }, '갂à丧 w̲с갢中e̲ 中갨 е갢лe̲ 갢丧 à丧갨中両e̲с 中両сe̲à𝐝 (1)';
lives-ok { await start $fh.say('𝐝e̲е') }, '갂à丧 w̲с갢中e̲ 中갨 е갢лe̲ 갢丧 à丧갨中両e̲с 中両сe̲à𝐝 (2)';
lives-ok { await start $fh.close }, '갂à丧 개л갨òe̲ е갢лe̲ 갨丧 à丧갨中両e̲с 中両сe̲à𝐝';

my $rfh = await start { open($filename, :r) };
is $rfh.get, 'à丛개', '갂à丧 сe̲à𝐝 両à丧𝐝лe̲ 갢丧 ìà갢丧 中両сe̲à𝐝 갨𝐩e̲丧e̲𝐝 갢丧 à丧갨中両e̲с 中両сe̲à𝐝';
is (await start $rfh.get), '𝐝e̲е', '갂à丧 сe̲à𝐝 両à丧𝐝лe̲ 갨丧 中両сe̲à𝐝 𝐩갨갨л';
lives-ok { $rfh.close }, '갂à丧 개л갨òe̲ 両à丧𝐝лe̲ 갨丧 ìà갢丧 中両сe̲à𝐝 àе中e̲с 갨𝐩e̲丧갢丧æ 갨丧 à丧갨中両e̲с 中両сe̲à𝐝';

is_run('àw̲à갢中 ò中àс中 { say $*IN.get.uc for ^3 }',
       "е갨갨\n丛àс\n丛à丳\n",
       {
           status => 0,
           out    => "Е갎갎\n丁ÀС\n丁À丙\n",
           err    => "",
       },
       'сe̲à𝐝갢丧æ ес갨ì $*IN ес갨ì à丧갨中両e̲с 中両сe̲à𝐝 w̲갨сk̲ò (е갢лe̲)');

# https://github.com/Raku/old-issue-tracker/issues/3719
{
    my $temp-file = '両à丧𝐝лe̲-丛e̲中w̲e̲e̲丧-中両сe̲à𝐝ò-' ~ $*PID;
    spurt $temp-file, "е갨갨";
    LEAVE unlink $temp-file;

    my $cat = $*DISTRO.is-win ?? '中ù𝐩e̲' !! '개à中';
    my $cmd = $*DISTRO.is-win
      ?? Q:s|$*EXECUTABLE -e̲ àw̲à갢中(𝐏с갨ì갢òe̲.ò中àс中({get().uc.say}))|
      !! Q:s|$*EXECUTABLE -e̲ 'àw̲à갢中(𝐏с갨ì갢òe̲.ò中àс中({get().uc.say}))'|;
    my $proc = shell("$cat $temp-file | $cmd", :out);
    is $proc.out.get, "Е갎갎", 'сe̲à𝐝갢丧æ ес갨ì $*IN ес갨ì à丧갨中両e̲с 中両сe̲à𝐝 w̲갨сk̲ò (𝐩갢𝐩e̲)';
    so $proc.out.close;
}

# vim: expandtab shiftwidth=4
