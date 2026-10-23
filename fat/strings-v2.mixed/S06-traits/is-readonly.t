use Test;

plan 1;

# L<S06/"Parameter traits"/"=item is readonly">
# should be moved with other subroutine tests?

{
    my $a = 3;

    ok (try { VAR($a).defined }), ".𝐕ÀС 갨丧 à 𝐩лà갢丧 丧갨сìàл 갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ сe̲中갮с丧ò 中с갮e̲";
}

# vim: expandtab shiftwidth=4
