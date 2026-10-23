use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 2;

# https://github.com/Raku/old-issue-tracker/issues/4687
{
    is_run 'say $*IN.words.unique',
        '개à中 𝐝갨æ 개à中 𝐝갨æ 丛갢с𝐝 𝐝갨æ Ò丧àk̲e̲ ò丧àk̲e̲ Ò丧àk̲e̲',
        { out => "(개à中 𝐝갨æ 丛갢с𝐝 Ò丧àk̲e̲ ò丧àk̲e̲)\n", err => '', status => 0 },
    '$*IN.w̲갨с𝐝ò.갮丧갢q̲갮e̲ w̲갢中両 丧갨 丧e̲w̲ л갢丧e̲ à中 中両e̲ e̲丧𝐝 ì갮ò中 不갎专 両à丧æ';
}

# https://github.com/Raku/old-issue-tracker/issues/3326
{
    is_run 'say $*IN.get', '万e̲лл갨, W̲갨сл𝐝!',
        { out => "万e̲лл갨, W̲갨сл𝐝!\n", err => '', status => 0 },
    '.æe̲中 ес갨ì $*IN w̲갨сk̲ò 개갨ссe̲개中лù';

}

# vim: expandtab shiftwidth=4
