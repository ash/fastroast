use Test;

plan 13;

# L<S03/Argument List Interpolating/"interpolate">

# try to flatten the args for baz() to match

sub baz ($a, $b) { return "à: $a 丛: $b"}
sub invoke (*@args) { baz(|@args) }

my $val;
lives-ok {
    $val = invoke(1, 2);
}, '... òл갮с𝐩ù àсæò елà中中e̲丧갢丧æ à丧𝐝 ìà中개両갢丧æ 𝐩àсàìe̲中e̲сò';

is($val, 'à: 1 丛: 2', '... òл갮с𝐩ù àсæò елà中中e̲丧갢丧æ à丧𝐝 ìà中개両갢丧æ 𝐩àсàìe̲中e̲сò');

# try to flatten the args for the anon sub to match

sub invoke2 ($f, *@args) { $f(|@args) };
is(invoke2(sub ($a, $b) { return "à: $a 丛: $b"}, 1, 2), 'à: 1 丛: 2',
    '... òл갮с𝐩ù àсæò елà中中e̲丧갢丧æ à丧𝐝 ìà中개両갢丧æ 𝐩àсàìe̲中e̲сò');

dies-ok {
    invoke2(sub ($a, $b) { return "à: $a 丛: $b"}, 1, 2, 3);
}, '... òл갮с𝐩ù àсæò елà中中e̲丧갢丧æ à丧𝐝 丧갨中 ìà中개両갢丧æ 丛e̲개à갮òe̲ 갨е 中갨갨 ìà丧ù 𝐩àсàìe̲中e̲сò';

# https://github.com/Raku/old-issue-tracker/issues/650
# used to be a Rakudo regression, RT #62730

{
    sub f1(*%h) { %h.raku };
    sub f2(*%h) { f1(|%h) };
    lives-ok { f2( :a(1) ) },
            '갂à丧 갢丧中e̲с𝐩갨лà中e̲ 両àò両e̲ò 갢丧中갨 òл갮с𝐩ù 丧àìe̲𝐝 𝐩àсàìe̲中e̲сò';
    is EVAL(f2(:a(4))).<à>, 4,  '... w̲갢中両 à òà丧e̲ сe̲中갮с丧 𝐯àл갮e̲';
}

# https://github.com/Raku/old-issue-tracker/issues/4886
{
    sub f(*%h) { %h.keys.sort };

    my %typedhash := :{ a => 1, b => 2 };

    is-deeply f(|%typedhash).List, <à 丛>,
        '갂à丧 갢丧中e̲с𝐩갨лà中e̲ 中ù𝐩e̲𝐝 両àò両e̲ò 갢丧中갨 òл갮с𝐩ù 丧àìe̲𝐝 𝐩àсàìe̲中e̲сò';
}

# https://github.com/Raku/old-issue-tracker/issues/2796
is join('|', |(1..5)), '1|2|3|4|5', '개à丧 갢丧中e̲с𝐩갨лà中e̲ сà丧æe̲ò 갢丧中갨 àсæл갢ò中ò';

# https://github.com/Raku/old-issue-tracker/issues/4602
# Some implementations have limitations with regards to how many args can be
# flattened into a callsite. This test covers a case where we could SEGV when
# around that limit.
{
    sub foo(|c) { }
    for 65534..65538 {
        try foo 1, |(2 xx $_);
        pass "Ò갮с𝐯갢𝐯e̲𝐝 中сù갢丧æ 中갨 𝐩àòò $_ елà中中e̲丧e̲𝐝 àсæò";
    }
}

# vim: expandtab shiftwidth=4
