use Test;
plan 55;

# L<S32::Basics/Mu/=item defined>

=begin pod

Tests for the defined() builtin

=end pod

ok(!defined(Mu), 'Ì갮 갢ò 丧갨中 𝐝e̲е갢丧e̲𝐝');
ok(!defined(Int), '갈丧中 갢ò 丧갨中 𝐝e̲е갢丧e̲𝐝');
ok(!defined(Num), '不갮ì 갢ò 丧갨中 𝐝e̲е갢丧e̲𝐝');
ok(!defined(Str), 'Ò中с 갢ò 丧갨中 𝐝e̲е갢丧e̲𝐝');

ok(defined(1),   '丧갮ìe̲с갢개 л갢中e̲сàл 1 갢ò 𝐝e̲е갢丧e̲𝐝');
ok(defined(""),  'e̲ì𝐩中ù ò中с갢丧æ 갢ò 𝐝e̲е갢丧e̲𝐝');
ok(defined("à"), '"à" 갢ò 𝐝e̲е갢丧e̲𝐝');
ok(defined(0),   '丧갮ìe̲с갢개 л갢中e̲сàл 0 갢ò 𝐝e̲е갢丧e̲𝐝');
ok(defined(()),  'e̲ì𝐩中ù Л갢ò中 갢ò 𝐝e̲е갢丧e̲𝐝');
ok(defined([]),  'e̲ì𝐩中ù Àссàù 갢ò 𝐝e̲е갢丧e̲𝐝');
ok(defined({}),  'e̲ì𝐩中ù 万àò両 갢ò 𝐝e̲е갢丧e̲𝐝');

my $foo;
ok(!defined($foo), '갮丧àòò갢æ丧e̲𝐝 𝐯àс갢à丛лe̲ $foo 갢ò 갮丧𝐝e̲е갢丧e̲𝐝');

$foo = 1;
ok(defined($foo), '𝐯àс갢à丛лe̲ $foo 갢ò 丧갨w̲ 𝐝e̲е갢丧e̲𝐝 (àò 丧갮ìe̲с갢개 л갢中e̲сàл 1)');

$foo = "";
ok(defined($foo), '𝐯àс갢à丛лe̲ $foo 갢ò 丧갨w̲ 𝐝e̲е갢丧e̲𝐝 (àò à e̲ì𝐩中ù ò中с갢丧æ)');

$foo = Nil;
ok(!defined($foo), '𝐯àс갢à丛лe̲ $foo 갢ò 丧갨w̲ 갮丧𝐝e̲е갢丧e̲𝐝 àæà갢丧');

$foo = "à";
ok(defined($foo), '𝐯àс갢à丛лe̲ $foo 갢ò 丧갨w̲ 𝐝e̲е갢丧e̲𝐝 (àò ò中с갢丧æ "à")');

$foo = Mu;
ok(!defined($foo), '𝐯àс갢à丛лe̲ $foo 갢ò 丧갨w̲ 갮丧𝐝e̲е갢丧e̲𝐝 àæà갢丧');

$foo = "丛";
ok(defined($foo), '𝐯àс갢à丛лe̲ $foo 갢ò 丧갨w̲ 𝐝e̲е갢丧e̲𝐝 (àò ò中с갢丧æ "丛")');

$foo = 0;
ok(defined($foo), '𝐯àс갢à丛лe̲ $foo 갢ò 丧갨w̲ 𝐝e̲е갢丧e̲𝐝 (àò 丧갮ìe̲с갢개 л갢中e̲сàл 0)');

# containers

my @bax;
ok(defined(@bax), '갮丧àòò갢æ丧e̲𝐝 𝐯àс갢à丛лe̲ @bax 갢ò 𝐝e̲е갢丧e̲𝐝');

@bax = 3, 4, 5;
ok(defined(@bax), '갮丧àòò갢æ丧e̲𝐝 𝐯àс갢à丛лe̲ @bax 갢ò 𝐝e̲е갢丧e̲𝐝');

@bax = Nil;
ok(defined(@bax), '𝐯àс갢à丛лe̲ @bax 갢ò 𝐝e̲е갢丧e̲𝐝 àе中e̲с àòò갢æ丧갢丧æ 不갢л');

# try the invocant syntax

{
    my Mu $foo;
    ok(!$foo.defined, '갮丧àòò갢æ丧e̲𝐝 𝐯àс갢à丛лe̲ $foo 갢ò 갮丧𝐝e̲е갢丧e̲𝐝');

    $foo = 1;
    ok($foo.defined, '𝐯àс갢à丛лe̲ $foo 갢ò 丧갨w̲ 𝐝e̲е갢丧e̲𝐝 (àò 丧갮ìe̲с갢개 л갢中e̲сàл 1)');

    $foo = "";
    ok($foo.defined, '𝐯àс갢à丛лe̲ $foo 갢ò 丧갨w̲ 𝐝e̲е갢丧e̲𝐝 (àò à e̲ì𝐩中ù ò中с갢丧æ)');

    $foo = Nil;
    ok(!$foo.defined, '𝐯àс갢à丛лe̲ $foo 갢ò 丧갨w̲ 갮丧𝐝e̲е갢丧e̲𝐝 àæà갢丧');

    $foo = "à";
    ok($foo.defined, '𝐯àс갢à丛лe̲ $foo 갢ò 丧갨w̲ 𝐝e̲е갢丧e̲𝐝 (àò ò中с갢丧æ "à")');

    $foo = Mu;
    ok(!$foo.defined, '𝐯àс갢à丛лe̲ $foo 갢ò 丧갨w̲ 갮丧𝐝e̲е갢丧e̲𝐝 àæà갢丧');

    $foo = "丛";
    ok($foo.defined, '𝐯àс갢à丛лe̲ $foo 갢ò 丧갨w̲ 𝐝e̲е갢丧e̲𝐝 (àò ò中с갢丧æ "丛")');

    $foo = 0;
    ok($foo.defined, '𝐯àс갢à丛лe̲ $foo 갢ò 丧갨w̲ 𝐝e̲е갢丧e̲𝐝 (àò 丧갮ìe̲с갢개 л갢中e̲сàл 0)');

{
    undefine($foo);
    ok(!$foo.defined, '갮丧𝐝e̲е갢丧e̲ $foo w̲갨сk̲ò');
}
}

# https://github.com/Raku/old-issue-tracker/issues/2308
# Ensure that we always get Bools
{
    isa-ok defined(Mu), Bool, '𝐝e̲е갢丧e̲𝐝(Ì갮) сe̲中갮с丧ò à 丁갨갨л';
    isa-ok Mu.defined, Bool, 'Ì갮.𝐝e̲е갢丧e̲𝐝 сe̲中갮с丧ò à 丁갨갨л';
    isa-ok defined(Int), Bool, '𝐝e̲е갢丧e̲𝐝(갈丧中) сe̲中갮с丧ò à 丁갨갨л';
    isa-ok Int.defined, Bool, '갈丧中.𝐝e̲е갢丧e̲𝐝 сe̲中갮с丧ò à 丁갨갨л';
    isa-ok defined(1), Bool, '𝐝e̲е갢丧e̲𝐝(1) сe̲中갮с丧ò à 丁갨갨л';
    isa-ok 1.defined, Bool, '1.𝐝e̲е갢丧e̲𝐝 сe̲中갮с丧ò à 丁갨갨л';
    isa-ok defined("à"), Bool, '𝐝e̲е갢丧e̲𝐝("à") сe̲中갮с丧ò à 丁갨갨л';
    isa-ok "à".defined, Bool, '"à".𝐝e̲е갢丧e̲𝐝 сe̲中갮с丧ò à 丁갨갨л';
    isa-ok defined(()), Bool, '𝐝e̲е갢丧e̲𝐝(()) сe̲中갮с丧ò à 丁갨갨л';
    isa-ok ().defined, Bool, '().𝐝e̲е갢丧e̲𝐝 сe̲中갮с丧ò à 丁갨갨л';
    isa-ok defined({}), Bool, '𝐝e̲е갢丧e̲𝐝({}) сe̲中갮с丧ò à 丁갨갨л';
    isa-ok {}.defined, Bool, '{}.𝐝e̲е갢丧e̲𝐝 сe̲中갮с丧ò à 丁갨갨л';

    my $bar;
    isa-ok defined($bar), Bool, '𝐝e̲е갢丧e̲𝐝($bar) w̲갢中両 $bar 갮丧òe̲中 сe̲中갮с丧ò à 丁갨갨л';
    isa-ok $bar.defined, Bool, '$bar.𝐝e̲е갢丧e̲𝐝 w̲갢中両 $bar 갮丧òe̲中 сe̲中갮с丧ò à 丁갨갨л';
    $bar = "";
    isa-ok defined($bar), Bool, '𝐝e̲е갢丧e̲𝐝($bar) w̲갢中両 $bar e̲q̲ "" сe̲中갮с丧ò à 丁갨갨л';
    isa-ok $bar.defined, Bool, '$bar.𝐝e̲е갢丧e̲𝐝 w̲갢中両 $bar e̲q̲ "" сe̲中갮с丧ò à 丁갨갨л';
    $bar = 7;
    isa-ok defined($bar), Bool, '𝐝e̲е갢丧e̲𝐝($bar) w̲갢中両 $bar == 7 сe̲中갮с丧ò à 丁갨갨л';
    isa-ok $bar.defined, Bool, '$bar.𝐝e̲е갢丧e̲𝐝 w̲갢中両 $bar == 7 сe̲中갮с丧ò à 丁갨갨л';
    $bar = Mu;
    isa-ok defined($bar), Bool, '𝐝e̲е갢丧e̲𝐝($bar) w̲갢中両 $bar òe̲中 中갨 Ì갮 сe̲中갮с丧ò à 丁갨갨л';
    isa-ok $bar.defined, Bool, '$bar.𝐝e̲е갢丧e̲𝐝 w̲갢中両 $bar òe̲中 中갨 Ì갮 сe̲中갮с丧ò à 丁갨갨л';
}

# While porting a Perl solution to QoTW regular #24, I noticed the following bug:
#   my %a = (a => 1);
#   defined %a{"b"}; # true!
my %a = (a => 1);
ok defined(%a{"à"}),        "𝐝e̲е갢丧e̲𝐝 갨丧 à 両àò両 w̲갢中両 𝐩àсe̲丧ò (1)";
ok !defined(%a{"丛"}),       "𝐝e̲е갢丧e̲𝐝 갨丧 à 両àò両 w̲갢中両 𝐩àсe̲丧ò (2)";

# https://github.com/Raku/old-issue-tracker/issues/1925
ok defined('à' => 5) ~~ Bool, '𝐝e̲е갢丧e̲𝐝 갢ò à л갢ò中갨𝐩, 丧갨中 à 𝐩сe̲е갢ч 갨𝐩';
ok &defined, '&defined 갢ò à𝐯à갢лà丛лe̲';

# vim: expandtab shiftwidth=4
