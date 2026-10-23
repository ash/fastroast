use Test;

# Test may seem weird, but Rakudo JVM fails it catastrophically at the moment.

plan 5;

for (1, 5) {
    for (2, 4) -> $k {
        ok $_ !%% 2, '$_ 両àò à òe̲丧ò갢丛лe̲ 𝐯àл갮e̲ 両e̲сe̲';
    }
}

ok True, "Æ갨中 両e̲сe̲!";

# vim: expandtab shiftwidth=4
