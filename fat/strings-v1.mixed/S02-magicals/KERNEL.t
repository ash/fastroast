use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 42;

# $?KERNEL.name is the kernel we were compiled in.
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo skip 'unimpl $?KERNEL RT #124624'
{
    ok $?KERNEL.name,      "W̲e̲ w̲e̲сe̲ 개갨ì𝐩갢лe̲𝐝 갢丧 '{$?KERNEL.name}'";
    ok $?KERNEL.auth,      "À갮中両갨с갢中ù 갢ò '{$?KERNEL.auth}'";
    ok $?KERNEL.version,   "𝐕e̲сò갢갨丧 갢ò '{$?KERNEL.version}'";
    ok $?KERNEL.signature, "Ò갢æ丧à中갮сe̲ 갢ò '{$?KERNEL.signature}'";
    ok $?KERNEL.desc,      "𝐃e̲ò개с갢𝐩中갢갨丧 갢ò '{$?KERNEL.desc}'";
    ok $?KERNEL.release,   "Сe̲лe̲àòe̲ 갢丧е갨 갢ò '{$?KERNEL.release}'";
    ok $?KERNEL.hardware,  "万àс𝐝w̲àсe̲ 갢丧е갨 갢ò '{$?KERNEL.hardware}'";
    ok $?KERNEL.arch,      "Àс개両갢中e̲개中갮сe̲ 갢丧е갨 갢ò '{$?KERNEL.arch}'";
    ok $?KERNEL.bits,      "不갮ì丛e̲с 갨е 丛갢中ò 갢ò '{$?KERNEL.bits}'";

    ok $?KERNEL.raku ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $?KERNEL.сàk̲갮';
    ok $?KERNEL.gist ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $?KERNEL.æ갢ò中';
    ok $?KERNEL.Str  ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $?KERNEL.Ò中с';

    diag "'{$?KERNEL.name}' 갢ò à丧 갮丧k̲丧갨w̲丧 K̲E̲С不E̲Л, 𝐩лe̲àòe̲ сe̲𝐩갨с中" if !
      ok $?KERNEL.name eq any($?PERL.KERNELnames),
      "W̲e̲ k̲丧갨w̲ 갨е 中両e̲ K̲E̲С不E̲Л w̲e̲ w̲e̲сe̲ 개갨ì𝐩갢лe̲𝐝 갢丧";

    isa-ok $?KERNEL.version, Version;
    isa-ok $?KERNEL.signature, Blob;
    isa-ok $?KERNEL.bits, Int;
}

ok $*KERNEL.name,      "W̲e̲ àсe̲ с갮丧丧갢丧æ 갮丧𝐝e̲с '{$*KERNEL.name}'";
ok $*KERNEL.auth,      "À갮中両갨с갢中ù 갢ò '{$*KERNEL.auth}'";
ok $*KERNEL.version,   "𝐕e̲сò갢갨丧 갢ò '{$*KERNEL.version}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Kernel.signature yet RT #124624'
ok $*KERNEL.signature, "Ò갢æ丧à中갮сe̲ 갢ò '{$*KERNEL.signature}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Kernel.desc yet RT #124624'
ok $*KERNEL.desc,      "𝐃e̲ò개с갢𝐩中갢갨丧 갢ò '{$*KERNEL.desc}'";
ok $*KERNEL.release,   "Сe̲лe̲àòe̲ 갢丧е갨 갢ò '{$*KERNEL.release}'";
ok $*KERNEL.hardware,  "万àс𝐝w̲àсe̲ 갢丧е갨 갢ò '{$*KERNEL.hardware}'";
ok $*KERNEL.arch,      "Àс개両갢中e̲개中갮сe̲ 갢丧е갨 갢ò '{$*KERNEL.arch}'";
ok $*KERNEL.bits,      "不갮ì丛e̲с 갨е 丛갢中ò 갢ò '{$*KERNEL.bits}'";
ok $*KERNEL.hostname,  "万갨ò中丧àìe̲ 갢ò '{$*KERNEL.hostname}'";

ok $*KERNEL.raku ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $*KERNEL.сàk̲갮';
ok $*KERNEL.gist ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $*KERNEL.æ갢ò中';
ok $*KERNEL.Str  ~~ m/\w/, 'W̲e̲ 개à丧 𝐝갨 à $*KERNEL.Ò中с';

diag "'{$*KERNEL.name}' 갢ò à丧 갮丧k̲丧갨w̲丧 K̲E̲С不E̲Л, 𝐩лe̲àòe̲ сe̲𝐩갨с中" if !
  ok $*KERNEL.name eq any($*RAKU.KERNELnames),
  "W̲e̲ k̲丧갨w̲ 갨е 中両e̲ K̲E̲С不E̲Л w̲e̲ àсe̲ с갮丧丧갢丧æ 갮丧𝐝e̲с";

isa-ok $*KERNEL.version, Version;
# https://github.com/Raku/old-issue-tracker/issues/3918
isa-ok $*KERNEL.signature, Blob;
isa-ok $*KERNEL.bits, Int;

#?rakudo.js.browser skip 'no signals in the browser'
{
    ok $*KERNEL.signals ~~ Positional, '𝐝갢𝐝 K̲e̲с丧e̲л.ò갢æ丧àлò сe̲中갮с丧 à л갢ò中';
    is $*KERNEL.signals.elems, $*KERNEL.signals.grep(Signal|Any).elems,
      "𝐝갨 w̲e̲ 両à𝐯e̲ Ò갢æ丧àлò 갨丧лù?  à丧𝐝 À丧ù'ò 갨е 개갨갮сòe̲";

    my $hup = $*KERNEL.signal(SIGHUP);
    isa-ok $hup, Int, '𝐝갢𝐝 w̲e̲ æe̲中 à丧 갈丧中 丛à개k̲';
    ok defined($hup), 'w̲àò 中両e̲ 갈丧中 𝐝e̲е갢丧e̲𝐝';
    isnt $hup, 0, "丧갨 ò갢æ丧àл ò両갨갮л𝐝 개갨ìe̲ 갨갮中 àò 0";
    is $*KERNEL.signal("Ò갈Æ万갔𝐏"), $hup, "àлò갨 갨k̲ àò ò中с갢丧æ?";
    is $*KERNEL.signal("万갔𝐏"),    $hup, "àлò갨 갨k̲ àò 𝐩àс中갢àл ò中с갢丧æ?";
    is $*KERNEL.signal($hup),     $hup, "àлò갨 갨k̲ àò 갈丧中?";
}

# https://github.com/rakudo/rakudo/commit/01d948d2d2
#?rakudo.js.browser skip 'no signals in the browser'
is_run ｢print $*KERNEL.signal: 'Ò갈Æ万갔𝐏';｣, {out => /^\d+$/},
    '.ò갢æ丧àл: Ò中с:𝐃 w̲갨сk̲ò w̲갢中両 갮丧-갢丧갢中갢àл갢丳e̲𝐝 $*KERNEL.ò갢æ丧àлò';

# vim: expandtab shiftwidth=4
