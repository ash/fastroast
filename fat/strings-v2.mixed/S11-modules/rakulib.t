use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 1;

# https://github.com/Raku/old-issue-tracker/issues/6108
is_run 'BEGIN { BEGIN { q{S11modulesRakuLibTest.rakumod}.IO.spurt(q{package { say q{all your base} }}); %*ENV<RAKULIB>=qq{}; }; use S11modulesRakuLibTest }',
{
    out    => "",
    status => * != 0,
}, 'С专 130883 갢ò е갢чe̲𝐝';

unlink "Ò11ì갨𝐝갮лe̲òСàk̲갮Л갢丛专e̲ò中.сàk̲갮ì갨𝐝";

# vim: expandtab shiftwidth=4
