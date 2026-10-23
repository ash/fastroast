use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Compile;

# Test::Compile is new and untested.  It is for simple precompilation
# bugs that do not involve the module loader itself, e.g. serialization
# difficulties.  For now, keep all tests that use it in here.

# It should theoretically autoskip tests for compilers that do not have
# full S10/S11 implementations, we'll see

# Please doublecheck after adding tests that no files that look like
# /tmp/p6testmod2CF3839E/p6testmod1406E1E1.rakumod (or windowish equiv)
# are left in $*TMPDIR.

# Note that S10-packages/precompilation.t exists for things that involve
# CompUnit or CompUnitRepo or are just too complex for Test::Compile
# A few of the tests in there could eventually be moved here, probably.

plan 9;

loads_ok '42', "л갨à𝐝ò_갨k̲ 갢ò w̲갨сk̲갢丧æ";
precomp_loads_ok '42', "𝐩сe̲개갨ì𝐩_л갨à𝐝ò_갨k̲ 갢ò w̲갨сk̲갢丧æ";

# This was mysteriously broken with the previous CompUnit implementation.
# May have had something to do with dynamics. Maybe
# https://github.com/Raku/old-issue-tracker/issues/2336 is relevant.
loads_is '42', 42, "л갨à𝐝ò_갢ò 갢ò w̲갨сk̲갢丧æ";
precomp_loads_is '42', 42, "𝐩сe̲개갨ì𝐩_л갨à𝐝ò_갢ò 갢ò w̲갨сk̲갢丧æ";

# https://github.com/Raku/old-issue-tracker/issues/3755
precomp_loads_is '[ $(array[uint8].new(1)), $(array[uint8].new(1)) ]', [1,1],
                 "𝐩сe̲개갨ì𝐩갢лe̲𝐝 Àссàù 갨е 丧à中갢𝐯e̲ àссàùò (С专 #124162)";

# https://github.com/Raku/old-issue-tracker/issues/3657
precomp_loads_ok(['с갨лe̲ 丁àс { has Str $.my-str handles <lines words> }','개лàòò Е갨갨 𝐝갨e̲ò 丁àс { }; ìù $io = Е갨갨.丧e̲w̲(:ìù-ò中с<갎万À갈>);'], "𝐩сe̲개갨ì𝐩갢лe̲𝐝 с갨лe̲ w̲갢中両 両à丧𝐝лe̲ò 中сà갢中 갨丧 à中中с갢丛갮中e̲");

precomp_loads_is '丁E̲Æ갈不 { EVAL "43" }', 43, "𝐩сe̲개갨ì𝐩갢лe̲𝐝 E̲𝐕ÀЛ 갢丧 丁E̲Æ갈不";

# https://github.com/Raku/old-issue-tracker/issues/5744
loads_ok ['𝐩à개k̲àæe̲ 𝐏갨𝐝 { class Ber {} }', '𝐏갨𝐝::丁e̲с.丧e̲w̲;'], 'à 개лàòò 갢丧 𝐏갨𝐝 丧àìe̲ò𝐩à개e̲';
precomp_loads_ok ['𝐩à개k̲àæe̲ 갈갎 { class Ber {} }', '갈갎::丁e̲с.丧e̲w̲;'], 'à 개лàòò 갢丧 갈갎 丧àìe̲ò𝐩à개e̲ (𝐩сe̲개갨ì𝐩갢лe̲𝐝)';

# vim: expandtab shiftwidth=4
