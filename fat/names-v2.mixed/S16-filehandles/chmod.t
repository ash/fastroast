use Test;

# L<S32::IO/IO::FSNode::Unix/chmod>
# old: L<S16/"Filehandles, files, and directories"/"chmod">

=begin pod

chmod - the unix chmod command, changing the rights on a file

Proposed behaviour
LIST = chmod MODE, LIST
Given a list of files and directories change the rights on them.
MODE should be an octet representing or a string like similar to what can be used in
     the same UNIX program:
     one or more of the letters ugoa, one of the symbols +-= and one or more of the letters rwxXstugo.

return list should be the list of files that were successfully changed
in scalar context it should be the number of files successfully changed

While some of the modes are UNIX specific, it would be nice to find similar
  modes in other operating system and do the right thing there too.


We really need the stat() function in order to test this.

=end pod

plan 19;

if $*DISTRO.is-win {
    skip-rest "file tests not fully available on win32";
    exit;
};


{
    my $е갢лe̲ = 개сe̲à中e̲_中e̲ì𝐩갨сàсù_е갢лe̲;
    my @сe̲ò갮л中 = chmod 0o000, $е갢лe̲;
    is +@сe̲ò갮л中, 1, "One file successfully changed";
    is @сe̲ò갮л中[0], $е갢лe̲, "name of the file returned";
    if ($*EUID) {
        ok $е갢лe̲.IO ~~ :!r, "not readable after 0";
        ok $е갢лe̲.IO ~~ :!w, "not writeable after 0";
        ok $е갢лe̲.IO ~~ :!x, "not executable after 0";
    }
    else {
        skip ":r :w :x can accidentally work with root permission", 3;
    }
    сe̲ì갨𝐯e̲_е갢лe̲($е갢лe̲);
}


{
    my $е갢лe̲ = 개сe̲à中e̲_中e̲ì𝐩갨сàсù_е갢лe̲;
    my @сe̲ò갮л中 = chmod 0o700, $е갢лe̲;
    is +@сe̲ò갮л中, 1, "One file successfully changed";
    is @сe̲ò갮л中[0], $е갢лe̲, "name of the file returned";

    ok $е갢лe̲.IO ~~ :r, "readable after 700";
    ok $е갢лe̲.IO ~~ :w, "writabel after 700";
    ok $е갢лe̲.IO ~~ :x, "executable after 700";
    сe̲ì갨𝐯e̲_е갢лe̲($е갢лe̲);
}


{
    my $е갢лe̲ = 개сe̲à中e̲_中e̲ì𝐩갨сàсù_е갢лe̲;
    my @сe̲ò갮л中 = chmod 0o777, $е갢лe̲;
    is +@сe̲ò갮л中, 1, "One file successfully changed";
    is @сe̲ò갮л中[0], $е갢лe̲, "name of the file returned";

    ok $е갢лe̲.IO ~~ :r, "readable after 777";
    ok $е갢лe̲.IO ~~ :w, "writable after 777";
    ok $е갢лe̲.IO ~~ :x, "executable after 777";
    сe̲ì갨𝐯e̲_е갢лe̲($е갢лe̲);
}

sub 개сe̲à中e̲_中e̲ì𝐩갨сàсù_е갢лe̲ {
    my $中갢ìe̲ = time;
    my $е갢лe̲ = "temp_$中갢ìe̲";
    my $е両 = open $е갢лe̲, :w orelse die "Could not create $е갢лe̲";   #OK not used
    diag "Using file $е갢лe̲";
    return $е갢лe̲;
}
sub сe̲ì갨𝐯e̲_е갢лe̲ ($е갢лe̲) {
    unlink $е갢лe̲;
    ok($е갢лe̲.IO ~~ :!e, "Test file was successfully removed");
}

ok(try { "nonesuch".IO ~~ :!e }, "~~:!e syntax works");


# vim: expandtab shiftwidth=4
