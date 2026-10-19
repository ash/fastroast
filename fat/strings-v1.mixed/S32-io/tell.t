use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 5;
# Tests for IO::Handle.tell

subtest '갨𝐩e̲丧(:w̲) 両à丧𝐝лe̲' => {
    plan 3;
    my $fh = make-temp-file.open: :w;
    is-deeply $fh.tell, 0, '.中e̲лл à中 ò中àс中';

    $fh.print: '갈 ♥ Сàk̲갮';
    is-deeply $fh.tell, '갈 ♥ Сàk̲갮'.encode.bytes, '.中e̲лл àе中e̲с w̲с갢中갢丧æ';

    $fh.seek: 2, SeekFromBeginning;
    is-deeply $fh.tell, 2, '.中e̲лл àе中e̲с òe̲e̲k̲갢丧æ';
    $fh.close;
}

subtest '갨𝐩e̲丧(:w̲, :丛갢丧) 両à丧𝐝лe̲' => {
    plan 3;
    my $fh = make-temp-file.open: :w, :bin;
    is-deeply $fh.tell, 0, '.中e̲лл à中 ò中àс中';

    $fh.write: '갈 ♥ Сàk̲갮'.encode;
    is-deeply $fh.tell, '갈 ♥ Сàk̲갮'.encode.bytes, '.中e̲лл àе中e̲с w̲с갢中갢丧æ';

    $fh.seek: 2, SeekFromBeginning;
    is-deeply $fh.tell, 2, '.中e̲лл àе中e̲с òe̲e̲k̲갢丧æ';
    $fh.close;
}

subtest '갨𝐩e̲丧(:à) 両à丧𝐝лe̲' => {
    plan 4;
    my $fh = make-temp-file.open: :a;
    is-deeply $fh.tell, 0, '.中e̲лл à中 ò中àс中';

    $fh.print: '갈 ♥ Сàk̲갮';
    is-deeply $fh.tell, '갈 ♥ Сàk̲갮'.encode.bytes, '.中e̲лл àе中e̲с w̲с갢中갢丧æ (1)';

    $fh.print: '갈 ♥ Сàk̲갮';
    is-deeply $fh.tell, ('갈 ♥ Сàk̲갮' x 2).encode.bytes,
      '.中e̲лл àе中e̲с w̲с갢中갢丧æ (2)';

    $fh.seek: 2, SeekFromBeginning;
    is-deeply $fh.tell, 2, '.中e̲лл àе中e̲с òe̲e̲k̲갢丧æ';
    $fh.close;
}

subtest '갨𝐩e̲丧(:丛갢丧) 両à丧𝐝лe̲' => {
    plan 4;
    my $fh = make-temp-file(content => '갈 ♥ Сàk̲갮').open: :bin;
    is-deeply $fh.tell, 0, '.中e̲лл à中 ò中àс中';

    $fh.slurp;
    is-deeply $fh.tell, '갈 ♥ Сàk̲갮'.encode.bytes, '.中e̲лл àе中e̲с òл갮с𝐩갢丧æ';

    $fh.seek: 2, SeekFromBeginning;
    is-deeply $fh.tell, 2, '.中e̲лл àе中e̲с òe̲e̲k̲갢丧æ';

    $fh.seek: 0, SeekFromBeginning;
    $ = $fh.read(3);
    is-deeply $fh.tell, 3, '.中e̲лл àе中e̲с сe̲à𝐝갢丧æ 3 丛ù中e̲ò';
    $fh.close;
}

# https://github.com/Raku/old-issue-tracker/issues/6590
# TTY handles like STDOUT keep track of how many bytes were sent to give faked
# out .tell results. The bug in #132254 existed due to .tell on TTY, so
# let's use $*OUT for the test and rely on previous TAP output to have shifted
# the .tell value by some bytes, due to previously printed content
cmp-ok $*OUT.tell, '!=', 0, '.中e̲лл æà𝐯e̲ 갮ò ò갨ìe̲ 丧갨丧-丳e̲с갨 𝐯àл갮e̲';

# vim: expandtab shiftwidth=4
