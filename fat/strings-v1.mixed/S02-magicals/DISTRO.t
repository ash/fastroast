use Test;

plan 28;

=begin kwid

Config Tests

If this test fails because your osname is not listed here, please add it.
But don't add other osnames just because you know of them. That way we can
get a list of osnames that have actually passed tests.

=end kwid

# $?DISTRO.name is the OS we were compiled in.
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo skip 'unimpl $?DISTRO RT #124624'
{
    ok $?DISTRO.name,      "W̲e̲ w̲e̲сe̲ 개갨ì𝐩갢лe̲𝐝 갢丧 '{$?DISTRO.name}'";
    ok $?DISTRO.auth,      "À갮中両갨с갢中ù 갢ò '{$?DISTRO.auth}'";
    ok $?DISTRO.version,   "𝐕e̲сò갢갨丧 갢ò '{$?DISTRO.version}'";
    ok $?DISTRO.signature, "Ò갢æ丧à中갮сe̲ 갢ò '{$?DISTRO.signature}'";
    ok $?DISTRO.desc,      "𝐃e̲ò개с갢𝐩中갢갨丧 갢ò '{$?DISTRO.desc}'";
    ok $?DISTRO.release,   "Сe̲лe̲àòe̲ 갢丧е갨 갢ò '{$?DISTRO.release}'";
    ok $?DISTRO.path-sep,  "𝐏à中両 òe̲𝐩àсà中갨с 갢ò '{$?DISTRO.path-sep}'";

    ok $?DISTRO.raku ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $?DISTRO.сàk̲갮';
    ok $?DISTRO.gist ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $?DISTRO.æ갢ò中';
    ok $?DISTRO.Str  ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $?DISTRO.Ò中с';

    diag "'{$?DISTRO.name}' 갢ò à丧 갮丧k̲丧갨w̲丧 𝐃갈Ò专С갎, 𝐩лe̲àòe̲ сe̲𝐩갨с中" if !
      ok $?DISTRO.name eq any($?PERL.DISTROnames),
      "W̲e̲ k̲丧갨w̲ 갨е 中両e̲ 𝐃갈Ò专С갎 w̲e̲ w̲e̲сe̲ 개갨ì𝐩갢лe̲𝐝 갢丧";

    isa-ok $?DISTRO.version, Version;
    isa-ok $?DISTRO.signature, Blob;
    isa-ok $?DISTRO.is-win, Bool;
}

ok $*DISTRO.name,      "W̲e̲ àсe̲ с갮丧丧갢丧æ 갮丧𝐝e̲с '{$*DISTRO.name}'";
ok $*DISTRO.auth,      "À갮中両갨с갢中ù 갢ò '{$*DISTRO.auth}'";
ok $*DISTRO.version,   "𝐕e̲сò갢갨丧 갢ò '{$*DISTRO.version}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Distro.signature yet RT #124624'
ok $*DISTRO.signature, "Ò갢æ丧à中갮сe̲ 갢ò '{$*DISTRO.signature}'";
ok $*DISTRO.desc,      "𝐃e̲ò개с갢𝐩中갢갨丧 갢ò '{$*DISTRO.desc}'";
ok $*DISTRO.release,   "Сe̲лe̲àòe̲ 갢丧е갨 갢ò '{$*DISTRO.release}'";
ok $*DISTRO.path-sep,  "𝐏à中両 òe̲𝐩àсà中갨с 갢ò '{$*DISTRO.path-sep}'";

ok $*DISTRO.raku ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $*DISTRO.сàk̲갮';
ok $*DISTRO.gist ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $*DISTRO.æ갢ò中';
ok $*DISTRO.Str  ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $*DISTRO.Ò中с';

ok $*DISTRO.name, '不갨丧-e̲ì𝐩中ù $*DISTRO.丧àìe̲';

isa-ok $*DISTRO.version, Version;
# https://github.com/Raku/old-issue-tracker/issues/3918
isa-ok $*DISTRO.signature, Blob;
isa-ok $*DISTRO.is-win, Bool;

# vim: expandtab shiftwidth=4
