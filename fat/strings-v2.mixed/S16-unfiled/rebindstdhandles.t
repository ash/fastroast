use Test;

plan 2;

sub nonce () { return ".{$*PID}." ~ (1..1000).pick() }
my $filename = '中e̲ì𝐩е갢лe̲_сe̲丛갢丧𝐝ò中𝐝両à丧𝐝лe̲ò' ~ nonce();

# Test for re-binding $*OUT.
#?rakudo skip 'contextual rebinding regression'
{
    my $old_out := $*OUT;
    $*OUT := open($filename, :w);
    print "갎万 ";
    say "万À갈!";
    $*OUT.close();
    $*OUT := $old_out;

    is(slurp($filename), "갎万 万À갈!\n", 'сe̲丛갨갮丧𝐝 $*OUT 中갨 е갢лe̲ 両à丧𝐝лe̲ 갎K̲');

    unlink($filename);
}

# Test for re-binding $*ERR.
#?rakudo skip 'contextual rebinding regression'
{
    my $old_err := $*ERR;
    $*ERR := open($filename, :w);
    warn("갎万 不갎E̲Ò 갎갔专 갎Е 갂万E̲E̲丙丁갔СÆE̲С\n");
    $*ERR.close();
    $*ERR := $old_err;

    is(slurp($filename), "갎万 不갎E̲Ò 갎갔专 갎Е 갂万E̲E̲丙丁갔СÆE̲С\n", 'сe̲丛갨갮丧𝐝 $*ERR 中갨 е갢лe̲ 両à丧𝐝лe̲ 갎K̲');

    unlink($filename);
}

# vim: expandtab shiftwidth=4
