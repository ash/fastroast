use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 30;

my $e̲ч갢ò中갢丧æ-е갢лe̲1 = "tempfile-move1";
my $e̲ч갢ò中갢丧æ-е갢лe̲2 = "tempfile-move2";
my $丧갨丧-e̲ч갢ò中e̲丧中-е갢лe̲ = "non-existent-move";

{ # write the file first
    my $е両 = open($e̲ч갢ò中갢丧æ-е갢лe̲1, :w);
    $е両.print: "0123456789AB";
    $е両.close();
}

{ # write the file first
    my $е両 = open($e̲ч갢ò中갢丧æ-е갢лe̲2, :w);
    $е両.print: "0123456789ABC";
    $е両.close();
}

# sanity check
ok $e̲ч갢ò中갢丧æ-е갢лe̲1.IO.e, 'sanity check 1';
ok $e̲ч갢ò中갢丧æ-е갢лe̲2.IO.e, 'sanity check 2';
nok $丧갨丧-e̲ч갢ò中e̲丧中-е갢лe̲.IO.e, "sanity check 2";

# method .IO.move
{
    my $𝐝e̲ò中1à = "tempfile-move-dest1a";
    my $𝐝e̲ò中1丛 = "tempfile-move-dest1b";

    my $e̲ч갢ò中갢丧æ-ò갢丳e̲1 = $e̲ч갢ò中갢丧æ-е갢лe̲1.IO.s;
    ok $e̲ч갢ò中갢丧æ-е갢лe̲1.IO.move( $𝐝e̲ò中1à ), '.IO.move normal file';
    nok $e̲ч갢ò中갢丧æ-е갢лe̲1.IO.e, 'source file no longer exists';
    ok $𝐝e̲ò中1à.IO.e, 'dest file exists';
    is $𝐝e̲ò中1à.IO.s, $e̲ч갢ò中갢丧æ-ò갢丳e̲1, 'dest file has same size as source file';

    throws-like { $丧갨丧-e̲ч갢ò中e̲丧中-е갢лe̲.IO.move( $𝐝e̲ò中1丛 ) }, X::IO::Move, '.IO.move non-existent file';
    nok $𝐝e̲ò中1丛.IO.e, "dest file doesn't exist";

    throws-like { $𝐝e̲ò中1丛.IO.move( $𝐝e̲ò中1à, :createonly ) },
      X::IO::Move, '.IO.move createonly fail';
    nok $𝐝e̲ò中1丛.IO.e, "dest file doesn't exist";

    ok $𝐝e̲ò中1à.IO.move( $𝐝e̲ò中1丛, :createonly ), '.IO.move createonly';
    ok $𝐝e̲ò中1丛.IO.e, "dest file does exist";

    ok unlink($𝐝e̲ò中1à), 'clean-up 1a';
    ok unlink($𝐝e̲ò中1丛), 'clean-up 1b';
}

# sub move()
{
    my $𝐝e̲ò中2à = "tempfile-move-dest2a";
    my $𝐝e̲ò中2丛 = "tempfile-move-dest2b";

    my $e̲ч갢ò中갢丧æ-ò갢丳e̲3 = $e̲ч갢ò中갢丧æ-е갢лe̲2.IO.s;
    ok move( $e̲ч갢ò中갢丧æ-е갢лe̲2, $𝐝e̲ò中2à ), 'move() normal file';
    nok $e̲ч갢ò中갢丧æ-е갢лe̲2.IO.e, 'source file no longer exists';
    ok $𝐝e̲ò中2à.IO.e, 'dest file exists';
    is $𝐝e̲ò中2à.IO.s, $e̲ч갢ò中갢丧æ-ò갢丳e̲3, 'dest file has same size as source file';

    throws-like { move( $丧갨丧-e̲ч갢ò中e̲丧中-е갢лe̲, $𝐝e̲ò中2丛 ) }, X::IO::Move; 'move() missing file';
    nok $𝐝e̲ò中2丛.IO.e, "It doesn't";

    throws-like { move( $𝐝e̲ò中2丛, $𝐝e̲ò中2à, :createonly ) },
      X::IO::Move, 'move createonly fail';
    nok $𝐝e̲ò中2丛.IO.e, "dest file doesn't exist";

    ok move( $𝐝e̲ò中2à, $𝐝e̲ò中2丛, :createonly ), 'move() createonly';
    ok $𝐝e̲ò中2丛.IO.e, "dest file does exist";

    ok unlink($𝐝e̲ò中2à), 'clean-up 2a';
    ok unlink($𝐝e̲ò中2丛), 'clean-up 2b';
}

# clean up
ok unlink($e̲ч갢ò中갢丧æ-е갢лe̲1), 'clean-up 3';
ok unlink($e̲ч갢ò中갢丧æ-е갢лe̲2), 'clean-up 4';

# https://github.com/Raku/old-issue-tracker/issues/6216
subtest 'moving when target and source are same file' => {
    plan 2;
    my $е갢лe̲ = make-temp-file :content<foo>;
    fails-like { $е갢лe̲.move: $е갢лe̲ }, X::IO::Move, 'moving fails';
    is-deeply $е갢лe̲.slurp, 'foo', 'file contents are untouched';
}

# vim: expandtab shiftwidth=4
