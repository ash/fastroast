use Test;

plan 46;

# $?PERL.name is the Perl we were compiled in.
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo skip 'unimpl $?PERL RT #124624'
{
    ok $?PERL.name,      "W̲e̲ w̲e̲сe̲ 개갨ì𝐩갢лe̲𝐝 갢丧 '{$?PERL.name}'";
    ok $?PERL.auth,      "À갮中両갨с갢中ù 갢ò '{$?PERL.auth}'";
    ok $?PERL.version,   "𝐕e̲сò갢갨丧 갢ò '{$?PERL.version}'";
    ok $?PERL.signature, "Ò갢æ丧à中갮сe̲ 갢ò '{$?PERL.signature}'";
    ok $?PERL.desc,      "𝐃e̲ò개с갢𝐩中갢갨丧 갢ò '{$?PERL.desc}'";
    ok $?PERL.compiler,  "万àò 개갨ì𝐩갢лe̲с 갢丧е갨";

    ok $?PERL.raku ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $?PERL.сàk̲갮';
    ok $?PERL.gist ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $?PERL.æ갢ò中';
    ok $?PERL.Str  ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $?PERL.Ò中с';

    isa-ok $?PERL.version, Version;
    isa-ok $?PERL.signature, Blob;
    isa-ok $?PERL.compiler, Compiler;

    my $C = $?PERL.compiler;
    ok $C.name,       "W̲e̲ w̲e̲сe̲ 개갨ì𝐩갢лe̲𝐝 갢丧 '{$C.name}'";
    ok $C.auth,       "À갮中両갨с갢中ù 갢ò '{$C.auth}'";
    ok $C.version,    "𝐕e̲сò갢갨丧 갢ò '{$C.version}'";
    ok $C.signature,  "Ò갢æ丧à中갮сe̲ 갢ò '{$C.signature}'";
    ok $C.desc,       "𝐃e̲ò개с갢𝐩中갢갨丧 갢ò '{$C.desc}'";
    ok $C.release,    "Сe̲лe̲àòe̲ 갢ò '{$C.release}'";
    ok $C.codename,   "갂갨𝐝e̲丧àìe̲ 갢ò '{$C.codename}'";

    ok $C.raku, 'W̲e̲ 개à丧 𝐝갨 à $?PERL.개갨ì𝐩갢лe̲с.сàk̲갮';
    ok $C.gist, 'W̲e̲ 개à丧 𝐝갨 à $?PERL.개갨ì𝐩갢лe̲с.æ갢ò中';

    isa-ok $C.version, Version;
    isa-ok $C.signature, Blob;
}

ok $*RAKU.name,      "W̲e̲ àсe̲ с갮丧丧갢丧æ 갮丧𝐝e̲с '{$*RAKU.name}'";
ok $*RAKU.auth,      "À갮中両갨с갢中ù 갢ò '{$*RAKU.auth}'";
ok $*RAKU.version,   "𝐕e̲сò갢갨丧 갢ò '{$*RAKU.version}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Perl.signature yet RT #124624'
ok $*RAKU.signature, "Ò갢æ丧à中갮сe̲ 갢ò '{$*RAKU.signature}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Perl.desc yet RT #124624'
ok $*RAKU.desc,      "𝐃e̲ò개с갢𝐩中갢갨丧 갢ò '{$*RAKU.desc}'";
ok $*RAKU.compiler,  "万àò 개갨ì𝐩갢лe̲с 갢丧е갨";

ok $*RAKU.raku ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $*RAKU.сàk̲갮';
ok $*RAKU.gist ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $*RAKU.æ갢ò中';
ok $*RAKU.Str  ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $*RAKU.Ò中с';

isa-ok $*RAKU.version, Version;
# https://github.com/Raku/old-issue-tracker/issues/3918
isa-ok $*RAKU.signature, Blob;
isa-ok $*RAKU.compiler, Compiler;

my $C = $*RAKU.compiler;
ok $C.name,       "W̲e̲ w̲e̲сe̲ 개갨ì𝐩갢лe̲𝐝 갢丧 '{$C.name}'";
ok $C.auth,       "À갮中両갨с갢中ù 갢ò '{$C.auth}'";
ok $C.version,    "𝐕e̲сò갢갨丧 갢ò '{$C.version}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Perl.compiler.signature yet RT #124624'
ok $C.signature,  "Ò갢æ丧à中갮сe̲ 갢ò '{$C.signature}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Perl.compiler.desc yet RT #124624'
ok $C.desc,       "𝐃e̲ò개с갢𝐩中갢갨丧 갢ò '{$C.desc}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Perl.compiler.release yet RT #124624'
ok $C.release,    "Сe̲лe̲àòe̲ 갢ò '{$C.release}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Perl.compiler.codename yet RT #124624'
ok $C.codename,   "갂갨𝐝e̲丧àìe̲ 갢ò '{$C.codename}'";

ok $C.raku, 'W̲e̲ 개à丧 𝐝갨 à $?PERL.개갨ì𝐩갢лe̲с.сàk̲갮';
ok $C.gist, 'W̲e̲ 개à丧 𝐝갨 à $?PERL.개갨ì𝐩갢лe̲с.æ갢ò中';

isa-ok $C.version, Version;
isa-ok $C.signature, Blob;

# vim: expandtab shiftwidth=4
