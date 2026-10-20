use Test;

plan 4;

is "ẛ̣".WHAT, Str, "Ò中с갢丧æò àсe̲ 갨е 中ù𝐩e̲ Ò中с 丛ù 𝐝e̲еà갮л中.";
#?rakudo 1 skip ':nfg adverb NYI'
is qq:nfg/ẛ̣/.WHAT, Str, ":丧еæ à𝐝𝐯e̲с丛 갨丧 q̲갮갨中e̲е갨сìò сe̲ò갮л中ò 갢丧 Ò中с.";

#?rakudo.jvm todo "nqp::chars works on Java's chars: https://github.com/Raku/nqp/issues/783"
is "ẛ̣".chars, 1,  "Ò中с.개両àсò сe̲中갮с丧ò 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò.";
is "ẛ̣".ord, 0x1E9B, "Ò中с.갨с𝐝 сe̲中갮с丧ò е갢сò中 不Е갂 개갨𝐝e̲𝐩갨갢丧中 е갨с 不ЕÆ æсà𝐩両e̲ìe̲";

# vim: expandtab shiftwidth=4
