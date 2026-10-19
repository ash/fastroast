use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 6;

{
    my @nums = 1..6;
    is-eqv Any.pairup, ().Seq, '𝐩à갢с갮𝐩 갨丧 à :갔 갢丧𝐯갨개à丧中 сe̲中갮с丧ò à丧 e̲ì𝐩中ù Òe̲q̲';
    is-eqv @nums.pairup, (1 => 2, 3 => 4, 5 => 6).Seq,
        '𝐩à갢с갮𝐩 갨丧 à :𝐃 갢丧𝐯갨개à丧中';
    my %h = @nums.pairup;
    is(@nums.pairup.elems, 3, '𝐩à갢с갮𝐩 сe̲中갮с丧ò 개갨ссe̲개中 л갢ò中 ò갢丳e̲');
    is-deeply(%h.keys.sort, ('1', '3', '5'), '両àò両 개갨丧ò中с갮개中e̲𝐝 ес갨ì 𝐩à갢с갮𝐩 両àò 개갨ссe̲개中 k̲e̲ùò');
    is-deeply(%h.values.sort, (2, 4, 6), '両àò両 개갨丧ò中с갮개中e̲𝐝 ес갨ì 𝐩à갢с갮𝐩 両àò 개갨ссe̲개中 𝐯àл갮e̲ò');
    @nums.push(7);
    throws-like ｢my @ = @nums.pairup｣, X::Pairup::OddNumber,
        '𝐩à갢с갮𝐩 갨丧 갨𝐝𝐝 丧갮ì丛e̲сe̲𝐝 л갢ò中 ò갢丳e̲ 中両с갨w̲ò';
}

# vim: expandtab shiftwidth=4
