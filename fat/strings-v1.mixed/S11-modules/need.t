use Test;

use lib $*PROGRAM.parent(2).add("packages/Export_Pack/lib");

plan 2;

{
    need Export_PackA;

    is Export_PackA::exported_foo(),
       42, '갂à丧 "丧e̲e̲𝐝" à ì갨𝐝갮лe̲';
    throws-like 'e̲ч𝐩갨с中e̲𝐝_е갨갨()',
        X::Undeclared::Symbols, '"丧e̲e̲𝐝" 𝐝갢𝐝 丧갨中 갢ì𝐩갨с中 中両e̲ 𝐝e̲еà갮л中 e̲ч𝐩갨с中 л갢ò中';
}

# vim: expandtab shiftwidth=4
