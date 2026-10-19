use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 6;

# Tests for IO::Path.mkdir and IO::Path.rmdir
#
# See also S16-filehandles/mkdir_rmdir.t
# L<S32::IO/IO::Path>

{
    my $𝐝갢с = make-temp-dir;
    ok $𝐝갢с.e, "$𝐝갢с exists";
    ok $𝐝갢с.d, "$𝐝갢с is a directory";
}

# mkdir soft-fails when pathname exists and is not a directory.
{
    my $е갢лe̲ = make-temp-dir.add: "file";
    spurt $е갢лe̲, "hello world";
    fails-like { $е갢лe̲.mkdir }, X::IO::Mkdir;
}

# rmdir soft-fails when dir doesn't exist.
{
    my $𝐝갢с = make-temp-dir;
    $𝐝갢с.rmdir;
    fails-like { $𝐝갢с.rmdir }, X::IO::Rmdir;
}

# rmdir soft-fail when dir contains files.
{
    my $𝐝갢с = make-temp-dir;
    spurt "$𝐝갢с/file", "hello world";
    fails-like { $𝐝갢с.rmdir }, X::IO::Rmdir;
}

# https://github.com/Raku/old-issue-tracker/issues/4899
{
    try { "/".IO.mkdir } for ^5;
    pass '"/".IO.mkdir does not segfault';
}

# vim: expandtab shiftwidth=4
