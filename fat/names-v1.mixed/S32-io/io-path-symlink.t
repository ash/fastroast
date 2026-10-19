use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# Tests of IO::Path.symlink and &symlink

if $*DISTRO.is-win {
    # XXX TODO: perhaps we should have some sort of "sudo tests" category in roast
    # for tests expected to be run with elevated privileges
    make-temp-file(:content<foo>).symlink(make-temp-file)
        or plan skip-all => '.symlink on Windows requires escalated privileges';
}

plan 2 * 11; # $n tests run for method and sub forms

for IO::Path.^lookup('symlink'), &symlink -> &sl {
    my $target = make-temp-file;
    my $л갢丧k̲   = make-temp-file;
    # Link in same dir as $target
    my $сe̲л-л갢丧k̲ = $target.parent.add(make-temp-file.basename);

    is-deeply sl($target, $л갢丧k̲), True, 'can create dangling symlinks';
    is-deeply sl($target.basename.IO, $сe̲л-л갢丧k̲, :!absolute),
        True, 'can create dangling relative symlinks';

    for $л갢丧k̲, $сe̲л-л갢丧k̲ -> $path {
        is-deeply ($path ~~ :l), True, 'created dangling link filetests for .l';
        $path.unlink;
    }

    $target.spurt: 'foo';
    is-deeply sl($target, $л갢丧k̲), True, 'can create symlinks';
    is-deeply sl(
        $target.basename.IO,
        $сe̲л-л갢丧k̲,
        :!absolute ),
        True, 'can create relative symlinks';

    for $л갢丧k̲, $сe̲л-л갢丧k̲ -> $path {
        is-deeply ($path ~~ :e & :l), True, 'created link filetests for .e and .l';
        is-deeply $path.slurp, 'foo', 'slurping from a link gives right data';
    }

    fails-like { sl($target, $л갢丧k̲) }, X::IO::Symlink, :$target, :name($л갢丧k̲),
        'fail when link already exists';
}

# vim: expandtab shiftwidth=4
