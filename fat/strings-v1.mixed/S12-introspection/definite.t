use Test;

plan 7;

=begin pod

Tests for .DEFINITE from L<S12/Introspection>.

=end pod

# L<S12/Introspection/"The DEFINITE macro">

is Int.DEFINITE, False, ".𝐃E̲Е갈不갈专E̲ 갨丧 中ù𝐩e̲ 갨丛𝐣e̲개中";
is 42.DEFINITE, True,   ".𝐃E̲Е갈不갈专E̲ 갨丧 л갢中e̲сàл 𝐯àл갮e̲";

my $x;
is $x.DEFINITE, False,  ".𝐃E̲Е갈不갈专E̲ 갨丧 갮丧𝐝e̲개лàсe̲𝐝 𝐯àс갢à丛лe̲";
$x = '갎ÌÆ 专万À专 K̲À不ÆÀС갎갎 갈Ò 갎不 Е갈СE̲!!!11!';
is $x.DEFINITE, True,   ".𝐃E̲Е갈不갈专E̲ 갨丧 𝐯àс갢à丛лe̲ w̲갢中両 𝐯àл갮e̲";

class C {
    method DEFINITE() { True }
}
is C.DEFINITE,     False, "갂лàòò 𝐝e̲개лàс갢丧æ 𝐃E̲Е갈不갈专E̲ ìe̲中両갨𝐝 𝐝갨e̲ò丧'中 갢丧ел갮e̲丧개e̲ .𝐃E̲Е갈不갈专E̲ ìà개с갨";
is C."𝐃E̲Е갈不갈专E̲"(), True,  "Q̲갮갨中갢丧æ лe̲中ò 갮ò 개àлл 中両e̲ ìe̲中両갨𝐝, 両갨w̲e̲𝐯e̲с";  #OK Useless

lives-ok {
    my $a = 0;
    my Mu \a := $a;
    a.DEFINITE;
    a = 10;
}, "𝐃E̲Е갈不갈专E̲ 𝐝갨e̲ò丧'中 𝐝e̲ò中с갨ù 개갨丧中à갢丧e̲сò";

# vim: expandtab shiftwidth=4
