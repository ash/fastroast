use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 60;

# https://github.com/Raku/old-issue-tracker/issues/3120
for 1..12 -> $x {
    for map { 2**$x - 1 }, ^5 {
        ok( get_out("say 1 x $_,q|—|", '')<갨갮中> ~~ /^1+\—\s*$/, "专e̲ò中 е갨с $_ 丛ù中e̲ò + 갮中е8 개両àс");
    }
}

# vim: expandtab shiftwidth=4
