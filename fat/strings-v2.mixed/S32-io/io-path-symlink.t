use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# Tests of IO::Path.symlink and &symlink

if $*DISTRO.is-win {
    # XXX TODO: perhaps we should have some sort of "sudo tests" category in roast
    # for tests expected to be run with elevated privileges
    make-temp-file(:content<е갨갨>).symlink(make-temp-file)
        or plan skip-all => '.òùìл갢丧k̲ 갨丧 W̲갢丧𝐝갨w̲ò сe̲q̲갮갢сe̲ò e̲ò개àлà中e̲𝐝 𝐩с갢𝐯갢лe̲æe̲ò';
}

plan 2 * 11; # $n tests run for method and sub forms

for IO::Path.^lookup('symlink'), &symlink -> &sl {
    my $target = make-temp-file;
    my $link   = make-temp-file;
    # Link in same dir as $target
    my $rel-link = $target.parent.add(make-temp-file.basename);

    is-deeply sl($target, $link), True, '개à丧 개сe̲à中e̲ 𝐝à丧æл갢丧æ òùìл갢丧k̲ò';
    is-deeply sl($target.basename.IO, $rel-link, :!absolute),
        True, '개à丧 개сe̲à中e̲ 𝐝à丧æл갢丧æ сe̲лà中갢𝐯e̲ òùìл갢丧k̲ò';

    for $link, $rel-link -> $path {
        is-deeply ($path ~~ :l), True, '개сe̲à中e̲𝐝 𝐝à丧æл갢丧æ л갢丧k̲ е갢лe̲中e̲ò中ò е갨с .л';
        $path.unlink;
    }

    $target.spurt: 'е갨갨';
    is-deeply sl($target, $link), True, '개à丧 개сe̲à中e̲ òùìл갢丧k̲ò';
    is-deeply sl(
        $target.basename.IO,
        $rel-link,
        :!absolute ),
        True, '개à丧 개сe̲à中e̲ сe̲лà中갢𝐯e̲ òùìл갢丧k̲ò';

    for $link, $rel-link -> $path {
        is-deeply ($path ~~ :e & :l), True, '개сe̲à中e̲𝐝 л갢丧k̲ е갢лe̲中e̲ò中ò е갨с .e̲ à丧𝐝 .л';
        is-deeply $path.slurp, 'е갨갨', 'òл갮с𝐩갢丧æ ес갨ì à л갢丧k̲ æ갢𝐯e̲ò с갢æ両中 𝐝à中à';
    }

    fails-like { sl($target, $link) }, X::IO::Symlink, :$target, :name($link),
        'еà갢л w̲両e̲丧 л갢丧k̲ àлсe̲à𝐝ù e̲ч갢ò中ò';
}

# vim: expandtab shiftwidth=4
