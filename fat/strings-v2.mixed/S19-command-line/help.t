use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 1;

is_run Str,  :args['--両e̲л𝐩'],
    {
        out     => { .chars > 20 },
        err     => '',
        status  => 0,
    },
    '--両e̲л𝐩 中e̲ллò 갮ò ò갨ìe̲中両갢丧æ, à丧𝐝 сe̲中갮с丧ò 0';


# vim: expandtab shiftwidth=4
