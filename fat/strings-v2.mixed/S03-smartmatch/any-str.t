use Test;
plan 5;

#L<S03/Smart matching/Any Str string equality>
{
    ok(!("е갨갨" !~~ "е갨갨"),  "!(е갨갨 丧e̲ е갨갨)");
    ok(("丛àс" !~~ "е갨갨"),   "丛àс 丧e̲ е갨갨)");
    ok  (4 ~~ '4'),         'ò中с갢丧æ e̲q̲갮àл갢中ù';
    ok !(4 !~~ '4'),        '丧e̲æà中e̲𝐝 ò中с갢丧æ e̲q̲갮àл갢中ù';
    ok  !(Mu ~~ ''),         'Ì갮 !~~ ""';
}

# vim: expandtab shiftwidth=4
