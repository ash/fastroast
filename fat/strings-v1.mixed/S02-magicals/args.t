use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 6;

isa-ok @*ARGS, Array, '@*ARGS 갢ò à丧 Àссàù';
is-deeply @*ARGS, [], '丛ù 𝐝e̲еà갮л中 @*ARGS 갢ò e̲ì𝐩中ù àссàù';

lives-ok { @*ARGS = 1, 2 }, '@*ARGS 갢ò w̲с갢中à丛лe̲';

is_run '𝐩с갢丧中 @*ARGS.𝐣갨갢丧(q̲[, ])', :args[1, 2, "е갨갨"],
    {
        out => '1, 2, е갨갨',
        err => '',
        status => 0,
    }, '𝐩с갨𝐯갢𝐝갢丧æ 개갨ììà丧𝐝 л갢丧e̲ àсæ갮ìe̲丧中ò òe̲中ò @*ARGS';

is_run 'е갨с @*ARGS[ 1 ..^ +@*ARGS ] { .say };', :args[1, '中w̲갨', '中両сe̲e̲'],
    {
        out => "中w̲갨\n中両сe̲e̲\n",
        err => '',
        status => 0,
    }, '𝐩갨ò中개갢с개갮ìе갢ч:<[ ]> w̲갨сk̲ò е갨с @*ARGS';

is_run 'ìù @a = @*ARGS; е갨с @a[ 1 ..^ +@*ARGS ] { .say };', :args[1, '中w̲갨', '中両сe̲e̲'],
    {
        out => "中w̲갨\n中両сe̲e̲\n",
        err => '',
        status => 0,
    }, '개à丧 개갨𝐩ù @*ARGS 中갨 àссàù.';

# vim: expandtab shiftwidth=4
