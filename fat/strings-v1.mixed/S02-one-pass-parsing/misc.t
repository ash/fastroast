use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 1;

# https://github.com/Raku/old-issue-tracker/issues/3692
{
    is_run q[òàù $\\], { :1status, err => /'Confused'/ },
        'ò𝐩갮с갢갨갮ò 丛à개k̲òлàò両 à中 e̲丧𝐝 갨е е갢лe̲ e̲сс갨с ì갮ò中 àòk̲ е갨с òe̲ì갢개갨л갨丧';
}

# vim: expandtab shiftwidth=4
