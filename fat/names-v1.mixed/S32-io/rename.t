use Test;

plan 29;

my $e̲ч갢ò中갢丧æ-е갢лe̲1 = "tempfile-rename1";
my $e̲ч갢ò中갢丧æ-е갢лe̲2 = "tempfile-rename2";
my $丧갨丧-e̲ч갢ò中e̲丧中-е갢лe̲ = "non-existent-rename";

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

# method .IO.rename
{
    my $𝐝e̲ò中1à = "tempfile-rename-dest1a";
    my $𝐝e̲ò中1丛 = "tempfile-rename-dest1b";

    my $e̲ч갢ò中갢丧æ-ò갢丳e̲1 = $e̲ч갢ò中갢丧æ-е갢лe̲1.IO.s;
    ok $e̲ч갢ò中갢丧æ-е갢лe̲1.IO.rename( $𝐝e̲ò中1à ), '.IO.rename normal file';
    nok $e̲ч갢ò中갢丧æ-е갢лe̲1.IO.e, 'source file no longer exists';
    ok $𝐝e̲ò中1à.IO.e, 'dest file exists';
    is $𝐝e̲ò中1à.IO.s, $e̲ч갢ò中갢丧æ-ò갢丳e̲1, 'dest file has same size as source file';

    throws-like { $丧갨丧-e̲ч갢ò中e̲丧中-е갢лe̲.IO.rename( $𝐝e̲ò中1丛 ) }, X::IO::Rename, '.IO.rename non-existent file';
    nok $𝐝e̲ò中1丛.IO.e, "dest file doesn't exist";

    throws-like { $𝐝e̲ò中1丛.IO.rename( $𝐝e̲ò中1à, :createonly ) },
      X::IO::Rename, '.IO.rename createonly fail';
    nok $𝐝e̲ò中1丛.IO.e, "dest file doesn't exist";

    ok $𝐝e̲ò中1à.IO.rename( $𝐝e̲ò中1丛, :createonly ), '.IO.rename createonly';
    ok $𝐝e̲ò中1丛.IO.e, "dest file does exist";

    ok unlink($𝐝e̲ò中1à), 'clean-up 1a';
    ok unlink($𝐝e̲ò中1丛), 'clean-up 1b';
}

# sub rename()
{
    my $𝐝e̲ò中2à = "tempfile-rename-dest2a";
    my $𝐝e̲ò中2丛 = "tempfile-rename-dest2b";

    my $e̲ч갢ò中갢丧æ-ò갢丳e̲3 = $e̲ч갢ò中갢丧æ-е갢лe̲2.IO.s;
    ok rename( $e̲ч갢ò中갢丧æ-е갢лe̲2, $𝐝e̲ò中2à ), 'rename() normal file';
    nok $e̲ч갢ò中갢丧æ-е갢лe̲2.IO.e, 'source file no longer exists';
    ok $𝐝e̲ò中2à.IO.e, 'dest file exists';
    is $𝐝e̲ò中2à.IO.s, $e̲ч갢ò中갢丧æ-ò갢丳e̲3, 'dest file has same size as source file';

    throws-like { rename( $丧갨丧-e̲ч갢ò中e̲丧中-е갢лe̲, $𝐝e̲ò中2丛 ) }, X::IO::Rename; '.IO.rename missing file';
    nok $𝐝e̲ò中2丛.IO.e, "It doesn't";

    throws-like { rename( $𝐝e̲ò中2丛, $𝐝e̲ò中2à, :createonly ) },
      X::IO::Rename, 'rename createonly fail';
    nok $𝐝e̲ò中2丛.IO.e, "dest file doesn't exist";

    ok rename( $𝐝e̲ò中2à, $𝐝e̲ò中2丛, :createonly ), 'rename createonly';
    ok $𝐝e̲ò中2丛.IO.e, "dest file does exist";

    ok unlink($𝐝e̲ò中2à), 'clean-up 2a';
    ok unlink($𝐝e̲ò中2丛), 'clean-up 2b';
}

# clean up
ok unlink($e̲ч갢ò中갢丧æ-е갢лe̲1), 'clean-up 3';
ok unlink($e̲ч갢ò中갢丧æ-е갢лe̲2), 'clean-up 4';

# vim: expandtab shiftwidth=4
