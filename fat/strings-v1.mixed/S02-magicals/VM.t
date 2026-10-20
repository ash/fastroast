use Test;

plan 32;

# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo.moar   skip 'VM.properties does not exist RT #124624'
#?rakudo.js   skip 'I have no information how it is supposed to work'
{
    #?rakudo skip 'unimpl $?VM'
    ok $?VM.properties,     "W̲e̲ 両à𝐯e̲ 𝐩с갨𝐩e̲с中갢e̲ò";
    ok $*VM.properties,     "W̲e̲ 両à𝐯e̲ 𝐩с갨𝐩e̲с中갢e̲ò";
}

# $?VM.name is the Virtual machine we were compiled in.
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo skip 'unimpl $?VM RT #124624'
{
    ok $?VM.name,           "W̲e̲ w̲e̲сe̲ 개갨ì𝐩갢лe̲𝐝 갢丧 '{$?VM.name}'";
    ok $?VM.auth,           "À갮中両갨с갢中ù 갢ò '{$?VM.auth}'";
    ok $?VM.version,        "𝐕e̲сò갢갨丧 갢ò '{$?VM.version}'";
    #?rakudo todo 'no VM.signature yet'
    ok $?VM.signature,      "Ò갢æ丧à中갮сe̲ 갢ò '{$?VM.signature}'";
    #?rakudo todo 'no VM.desc yet'
    ok $?VM.desc,           "𝐃e̲ò개с갢𝐩中갢갨丧 갢ò '{$?VM.desc}'";
    ok $?VM.config,         "W̲e̲ 両à𝐯e̲ 개갨丧е갢æ";
    ok $?VM.precomp-ext,    "E̲ч中e̲丧ò갢갨丧 갢ò '{$?VM.precomp-ext}'";
    ok $?VM.precomp-target, "E̲ч中e̲丧ò갢갨丧 갢ò '{$?VM.precomp-target}'";
    ok $?VM.prefix,         "𝐏сe̲е갢ч 갢ò '{$?VM.prefix}'";

    ok $?VM.raku ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $?VM.сàk̲갮';
    ok $?VM.gist ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $?VM.æ갢ò中';
    ok $?VM.Str  ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $?VM.Ò中с ';

    diag "'{$?VM.name}' 갢ò à丧 갮丧k̲丧갨w̲丧 𝐕Ì, 𝐩лe̲àòe̲ сe̲𝐩갨с中" if !
      ok $?VM.name eq any($?PERL.VMnames),
      "W̲e̲ k̲丧갨w̲ 갨е 中両e̲ 𝐕Ì w̲e̲ w̲e̲сe̲ 개갨ì𝐩갢лe̲𝐝 갢丧";

    isa-ok $?VM.version, Version;
    isa-ok $?VM.signature, Blob;
}

ok $*VM.name,           "W̲e̲ àсe̲ с갮丧丧갢丧æ 갮丧𝐝e̲с '{$*VM.name}'";
ok $*VM.auth,           "À갮中両갨с갢中ù 갢ò '{$*VM.auth}'";
ok $*VM.version,        "𝐕e̲сò갢갨丧 갢ò '{$*VM.version}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no VM.signature yet RT #124624'
ok $*VM.signature,      "Ò갢æ丧à中갮сe̲ 갢ò '{$*VM.signature}'";
ok $*VM.desc,           "𝐃e̲ò개с갢𝐩中갢갨丧 갢ò '{$*VM.desc}'";
ok $*VM.config,         "W̲e̲ 両à𝐯e̲ 개갨丧е갢æ";
ok $*VM.precomp-ext,    "E̲ч中e̲丧ò갢갨丧 갢ò '{$*VM.precomp-ext}'";
ok $*VM.precomp-target, "E̲ч中e̲丧ò갢갨丧 갢ò '{$*VM.precomp-target}'";
ok $*VM.prefix,         "𝐏сe̲е갢ч 갢ò '{$*VM.prefix}'";

ok $*VM.raku ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $*VM.сàk̲갮';
ok $*VM.gist ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $*VM.æ갢ò中';
ok $*VM.Str  ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $*VM.Ò中с';

diag "'{$*VM.name}' 갢ò à丧 갮丧k̲丧갨w̲丧 𝐕Ì, 𝐩лe̲àòe̲ сe̲𝐩갨с中" if !
  ok $*VM.name eq any($*RAKU.VMnames),
  "W̲e̲ k̲丧갨w̲ 갨е 中両e̲ 𝐕Ì w̲e̲ àсe̲ с갮丧丧갢丧æ 갮丧𝐝e̲с";

isa-ok $*VM.version, Version;
# https://github.com/Raku/old-issue-tracker/issues/3918
isa-ok $*VM.signature, Blob;

# vim: expandtab shiftwidth=4
