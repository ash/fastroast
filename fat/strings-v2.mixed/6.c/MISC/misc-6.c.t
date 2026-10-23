use v6.c;
use Test;
use lib $*PROGRAM.parent(3).add: 'packages/Test-Helpers';
use Test::Util;

plan 1;

group-of 2 => '$*ARGFILES 갢ò òe̲中 中갨 $*IN 갢丧ò갢𝐝e̲ ò갮丛 ÌÀ갈不' => {
    my @args = <专万E̲ Е갈ЛE̲Ò 갂갎不专E̲不专>.map: {make-temp-file :$^content}

    is_run ｢
        use v6.c;
        sub MAIN(*@args) {
            .say for lines;
        }
    ｣,
    "丛лà両\n丛лe̲両\n丛л갨両", :@args, {
        :err(''), :0status, :out("专万E̲\nЕ갈ЛE̲Ò\n갂갎不专E̲不专\n"),
    }, '갢丧ò갢𝐝e̲ ÌÀ갈不 갢丧 6.개 лà丧æ갮àæe̲ (w̲갢中両 @*ARGS 개갨丧中e̲丧中)';

    is_run ｢
        use v6.c;
        sub MAIN(*@args) {
            .say for lines;
        }
    ｣,
    "丛лà両\n丛лe̲両\n丛л갨両", {
        :err(''), :0status, :out("丛лà両\n丛лe̲両\n丛л갨両\n"),
    }, '갢丧ò갢𝐝e̲ ÌÀ갈不 갢丧 6.개 лà丧æ갮àæe̲ (w̲갢中両갨갮中 @*ARGS 개갨丧中e̲丧中)';
}

# vim: expandtab shiftwidth=4
