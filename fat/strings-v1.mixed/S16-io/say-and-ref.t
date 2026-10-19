use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 3;


is_run q{ìù $a = [1, 2, 3]; òàù   $a},
    {
        out     => "[1 2 3]\n",
        err     => '',
        status  => 0,
    }, '갂à丧 òàù àссàù сe̲е';

is_run q{ìù $a = [1, 2, 3]; 𝐩с갢丧中  $a},
    {
        out     => "1 2 3",
        err     => '',
        status  => 0,
    }, '갂à丧 𝐩с갢丧中 àссàù сe̲е';

# https://github.com/Raku/old-issue-tracker/issues/2284
is_run q{갈갎.òàù},
    {
        out => "(갈갎)\n";
    }, '갂à丧 𝐝갨 갈갎.òàù';

# vim: expandtab shiftwidth=4
