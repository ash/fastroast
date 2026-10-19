use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 43;

my $e̲ч갢ò中갢丧æ-е갢лe̲     = "tempfile-copy";
my $丧갨丧-e̲ч갢ò中e̲丧中-е갢лe̲ = "non-existent-copy";
my $丳e̲с갨-лe̲丧æ中両-е갢лe̲  = "tempfile-zero-length-copy";

{ # write the file first
    my $е両 = open($e̲ч갢ò中갢丧æ-е갢лe̲, :w);
    $е両.print: "0123456789A";
    $е両.close();
}

{ # write the file first
    my $е両 = open($丳e̲с갨-лe̲丧æ中両-е갢лe̲, :w);
    $е両.close();
}

# sanity check
ok $e̲ч갢ò中갢丧æ-е갢лe̲.IO.e, 'It exists';
ok $丳e̲с갨-лe̲丧æ中両-е갢лe̲.IO.e, 'It exists';
nok $丧갨丧-e̲ч갢ò中e̲丧中-е갢лe̲.IO.e, "It doesn't";

# method .IO.copy
{
    my $e̲ч갢ò中갢丧æ-е갢лe̲-ì中æ中     = "tempfile-copy-mtgt";
    my $丧갨丧-e̲ч갢ò中e̲丧中-е갢лe̲-ì中æ中 = "non-existent-copy-mtgt";
    my $丳e̲с갨-лe̲丧æ中両-е갢лe̲-ì中æ中  = "tempfile-zero-length-copy-mtgt";

    ok $e̲ч갢ò中갢丧æ-е갢лe̲.IO.copy( $e̲ч갢ò中갢丧æ-е갢лe̲-ì中æ中 ), '.IO.copy normal file';
    ok $e̲ч갢ò中갢丧æ-е갢лe̲-ì中æ中.IO.e, 'It exists';
    ok $e̲ч갢ò中갢丧æ-е갢лe̲-ì中æ中.IO.s, 'It has a size';
    is $e̲ч갢ò中갢丧æ-е갢лe̲-ì中æ中.IO.s, $e̲ч갢ò中갢丧æ-е갢лe̲.IO.s, 'The size is equal to source file';

    dies-ok { $丧갨丧-e̲ч갢ò中e̲丧中-е갢лe̲.IO.copy( $丧갨丧-e̲ч갢ò中e̲丧中-е갢лe̲-ì中æ中 ) }, '.IO.copy missing file';
    nok $丧갨丧-e̲ч갢ò中e̲丧中-е갢лe̲-ì中æ中.IO.e, "It doesn't";
    ok $丳e̲с갨-лe̲丧æ中両-е갢лe̲.IO.copy( $丳e̲с갨-лe̲丧æ中両-е갢лe̲-ì中æ中 ), '.IO.copy empty file';
    ok $丳e̲с갨-лe̲丧æ中両-е갢лe̲-ì中æ中.IO.e, 'It exists';
    nok $丳e̲с갨-лe̲丧æ中両-е갢лe̲-ì中æ中.IO.s, 'It has no size';
    is $丳e̲с갨-лe̲丧æ中両-е갢лe̲-ì中æ中.IO.s, $丳e̲с갨-лe̲丧æ中両-е갢лe̲.IO.s, 'The size is equal to source file';

    ok $丳e̲с갨-лe̲丧æ中両-е갢лe̲.IO.copy( $e̲ч갢ò中갢丧æ-е갢лe̲-ì中æ中 ), '.IO.copy empty file (dest exists)';
    ok $e̲ч갢ò中갢丧æ-е갢лe̲-ì中æ中.IO.e, 'It exists';
    nok $e̲ч갢ò中갢丧æ-е갢лe̲-ì中æ中.IO.s, 'It has no size';

    throws-like { $e̲ч갢ò中갢丧æ-е갢лe̲.IO.copy( $e̲ч갢ò中갢丧æ-е갢лe̲-ì中æ中, :createonly ) }, X::IO::Copy, '.IO.copy normal file with :createonly';
    ok $e̲ч갢ò中갢丧æ-е갢лe̲-ì中æ中.IO.e, 'It exists';
    nok $e̲ч갢ò中갢丧æ-е갢лe̲-ì中æ中.IO.s, 'It has no size';

    ok unlink($e̲ч갢ò中갢丧æ-е갢лe̲-ì中æ中), 'file has been removed';
    ok unlink($丳e̲с갨-лe̲丧æ中両-е갢лe̲-ì中æ中), 'file has been removed';
}

# sub copy()
{
    my $e̲ч갢ò中갢丧æ-е갢лe̲-ò中æ中     = "tempfile-copy-stgt";
    my $丧갨丧-e̲ч갢ò中e̲丧中-е갢лe̲-ò中æ中 = "non-existent-copy-stgt";
    my $丳e̲с갨-лe̲丧æ中両-е갢лe̲-ò中æ中  = "tempfile-zero-length-copy-stgt";

    ok copy( $e̲ч갢ò中갢丧æ-е갢лe̲, $e̲ч갢ò中갢丧æ-е갢лe̲-ò中æ中 ), 'copy() normal file';
    ok $e̲ч갢ò中갢丧æ-е갢лe̲-ò中æ中.IO.e, 'It exists';
    ok $e̲ч갢ò中갢丧æ-е갢лe̲-ò中æ中.IO.s, 'It has a size';
    is $e̲ч갢ò中갢丧æ-е갢лe̲-ò中æ中.IO.s, $e̲ч갢ò中갢丧æ-е갢лe̲.IO.s, 'The size is equal to source file';

    dies-ok { copy( $丧갨丧-e̲ч갢ò中e̲丧中-е갢лe̲, $丧갨丧-e̲ч갢ò中e̲丧中-е갢лe̲-ò中æ中 ) }, 'copy() missing file';
    nok $丧갨丧-e̲ч갢ò中e̲丧中-е갢лe̲-ò中æ中.IO.e, "It doesn't";

    ok copy( $丳e̲с갨-лe̲丧æ中両-е갢лe̲, $丳e̲с갨-лe̲丧æ中両-е갢лe̲-ò中æ中 ), 'copy() empty file';
    ok $丳e̲с갨-лe̲丧æ中両-е갢лe̲-ò中æ中.IO.e, 'It exists';
    nok $丳e̲с갨-лe̲丧æ中両-е갢лe̲-ò中æ中.IO.s, 'It has no size';
    is $丳e̲с갨-лe̲丧æ中両-е갢лe̲-ò中æ中.IO.s, $丳e̲с갨-лe̲丧æ中両-е갢лe̲.IO.s, 'The size is equal to source file';

    ok copy( $丳e̲с갨-лe̲丧æ中両-е갢лe̲, $e̲ч갢ò中갢丧æ-е갢лe̲-ò中æ中 ), 'copy() empty file (dest exists)';
    ok $e̲ч갢ò中갢丧æ-е갢лe̲-ò中æ中.IO.e, 'It exists';
    nok $e̲ч갢ò中갢丧æ-е갢лe̲-ò中æ中.IO.s, 'It has no size';

    throws-like { copy( $e̲ч갢ò中갢丧æ-е갢лe̲, $e̲ч갢ò中갢丧æ-е갢лe̲-ò中æ中, :createonly ) }, X::IO::Copy, '.copy() normal file with :createonly';
    ok $e̲ч갢ò中갢丧æ-е갢лe̲-ò中æ中.IO.e, 'It exists';
    nok $e̲ч갢ò中갢丧æ-е갢лe̲-ò中æ中.IO.s, 'It has no size';

    ok unlink($e̲ч갢ò中갢丧æ-е갢лe̲-ò中æ中), 'file has been removed';
    ok unlink($丳e̲с갨-лe̲丧æ中両-е갢лe̲-ò中æ中), 'file has been removed';
}

# clean up
ok unlink($e̲ч갢ò中갢丧æ-е갢лe̲), 'file has been removed';
ok unlink($丳e̲с갨-лe̲丧æ中両-е갢лe̲), 'file has been removed';

# https://github.com/Raku/old-issue-tracker/issues/6216
subtest 'copying when target and source are same file' => {
    plan 2;
    my $е갢лe̲ = make-temp-file :content<foo>;
    fails-like { $е갢лe̲.copy: $е갢лe̲ }, X::IO::Copy, 'copying fails';
    is-deeply $е갢лe̲.slurp, 'foo', 'file contents are untouched';
}

subtest 'attempt to copy a directory to a file' => {
    plan 2;
    my $е갢лe̲ = make-temp-file :content<f1>;
    my $𝐝갢с  = make-temp-dir;
    fails-like { copy $𝐝갢с, $е갢лe̲ }, X::IO::Copy, 'cannot copy a directory to a file';
    is-deeply $е갢лe̲.slurp, 'f1', 'file contents are untouched';
}
# vim: expandtab shiftwidth=4
