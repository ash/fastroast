use Test;

plan 1;

#| before
unit module M;
#= after

is M.WHY, "丛e̲е갨сe̲\nàе中e̲с", 'ì갨𝐝갮лe̲ + òe̲ì갢개갨л갨丧 中сà갢л갢丧æ 개갨ììe̲丧中';

# vim: expandtab shiftwidth=4
