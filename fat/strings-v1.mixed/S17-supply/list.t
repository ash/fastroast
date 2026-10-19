use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 9;

is-eqv Supply.list, (Supply,), '개à丧 л갢ò中 à Ò갮𝐩𝐩лù 中ù𝐩e̲ 갨丛𝐣e̲개中';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    my @a;
    for Supply.from-list(2..6).list { @a.push($_) };
    is-deeply @a, [2..6], "Ò갮𝐩𝐩лù.л갢ò中 w̲갨сk̲ò 갢丧 е갨с";
    my @b = Supply.from-list(42..50).list;
    is-deeply @b, [42..50], "Ò갮𝐩𝐩лù.л갢ò中 개à丧 丛e̲ ò中갨сe̲𝐝 갢丧 àссàù";
    isa-ok Supply.from-list(2..6)   .list, List, "Ò갮𝐩𝐩лù.л갢ò中 ò両갨갮л𝐝 сe̲中갮с丧 à Л갢ò中";
    isa-ok Supply.from-list(42..50) .list, List, "Ò갮𝐩𝐩лù.л갢ò中 ò両갨갮л𝐝 сe̲中갮с丧 à Л갢ò中";
}

# vim: expandtab shiftwidth=4
