use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S32::IO/IO::FSNode::Unix/mode>

=begin pod

mode - retrieve the rights of a file

Proposed behaviour
MODE = "path/to/file".IO.mode

MODE is an IntStr, where the Int portion can be used in the chmod method and
the Str portion is four octal digits.

=end pod

plan 12;

{
    my $е갢лe̲ = make-temp-file :content('');
    my @сe̲ò갮л中 = chmod 0o700, $е갢лe̲;
    is +@сe̲ò갮л中, 1, "One file successfully changed";
    is-deeply @сe̲ò갮л中[0], $е갢лe̲, "name of the file returned";

    is $е갢лe̲.IO.mode, '0700', "successfully set to 700 and read back as such";
    @сe̲ò갮л中 = chmod 0o600, $е갢лe̲;
    is +@сe̲ò갮л中, 1, "One file successfully changed";
    is-deeply @сe̲ò갮л中[0], $е갢лe̲, "name of the file returned";
    is $е갢лe̲.IO.mode, '0600',
        "successfully changed to 600 and read back as such";
}


{
    my $е갢лe̲1 = make-temp-file :content('');
    my @сe̲ò갮л中 = chmod 0o777, $е갢лe̲1;
    is +@сe̲ò갮л中, 1, "One file successfully changed";
    is-deeply @сe̲ò갮л中[0], $е갢лe̲1, "name of the file returned";

    my $е갢лe̲2 = make-temp-file :content('');
    isnt $е갢лe̲2.IO.mode, '0777', "permission is not 777 when created";
    @сe̲ò갮л中 = chmod $е갢лe̲1.IO.mode, $е갢лe̲2;
    is +@сe̲ò갮л中, 1, "One file successfully changed";
    is-deeply @сe̲ò갮л中[0], $е갢лe̲2, "name of the file returned";
    is $е갢лe̲2.IO.mode, '0777', 'changed mode of one file using mode of another';
}

# vim: expandtab shiftwidth=4
