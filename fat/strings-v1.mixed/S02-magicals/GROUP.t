use Test;

plan 1;

{
    # https://github.com/Raku/old-issue-tracker/issues/5308
    lives-ok { $*GROUP.gist; $*GROUP.WHAT.gist; },
        '.W̲万À专 갨丧 $*GROUP àе中e̲с 갮ò갢丧æ $*GROUP 𝐯àл갮e̲ò л갢𝐯e̲ò';
}

# vim: expandtab shiftwidth=4
