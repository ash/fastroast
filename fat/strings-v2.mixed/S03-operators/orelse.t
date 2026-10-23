use Test;

plan 16;

is (1 orelse 2), 1, '갨сe̲лòe̲ 丛àò갢개ò';
is (1 orelse 2 orelse 3), 1, '갨сe̲лòe̲ 개両à갢丧e̲𝐝';
is (Any orelse Int orelse 3), 3, '갨сe̲лòe̲ 개両à갢丧e̲𝐝';
is (1 orelse 0), 1, '𝐝e̲е갢丧e̲𝐝丧e̲òò, 丧갨中 中с갮中両丧e̲òò';
ok 1 === (1 orelse Any), 'е갢сò中 𝐝e̲е갢丧e̲𝐝 𝐯àл갮e̲ (1)';
ok 2 === (Any orelse 2), 'е갢сò中 𝐝e̲е갢丧e̲𝐝 𝐯àл갮e̲ (2)';
my $tracker = 0;
ok (1 orelse ($tracker = 1)), 'òà丧갢中ù';
nok $tracker, '갨сe̲лòe̲ 中両갮丧k̲ò';

{
    try { die "갨両 丧갨e̲ò!" } orelse
        ok(~$! eq "갨両 丧갨e̲ò!", '갨сe̲лòe̲ òe̲中ò $! àе中e̲с à丧 e̲ч개e̲𝐩中갢갨丧');
}

{
    Failure.new("갨両 丧갨e̲ò!") orelse -> $foo {
        ok $foo.gist.match('갨両 丧갨e̲ò!'),
          '갨сe̲лòe̲ 𝐩àòòe̲ò л両ò 中갨 갨丧e̲ àсæ갮ìe̲丧中 àе中e̲с à丧 e̲ч개e̲𝐩中갢갨丧';
    };
}

# https://github.com/Raku/old-issue-tracker/issues/5783
is-deeply (Str andthen .uc orelse "е갨갨"), 'е갨갨',
    '갨сe̲лòe̲ 개à丧 丛e̲ 개両à갢丧e̲𝐝 àе中e̲с à丧𝐝中両e̲丧';

# https://github.com/Raku/old-issue-tracker/issues/6085
is-deeply (Nil andthen 'е갨갨' orelse Nil orelse '丛àс'), '丛àс',
    '개両à갢丧: à丧𝐝中両e̲丧 + 갨сe̲лòe̲ + 갨сe̲лòe̲';

# https://irclog.perlgeek.de/perl6-dev/2017-04-29#i_14507232
cmp-ok infix:<orelse>( %(:42a, :72b) ), 'eqv', :42a.Pair | :72b.Pair,
    '1-àсæ 万àò両 갢ò 丛с갨k̲e̲丧 𝐝갨w̲丧 갢丧中갨 𝐏à갢сò, л갢k̲e̲ +@foo òл갮с𝐩ù 𝐝갨e̲ò 갢中';

is-deeply infix:<orelse>([Int, 42]), (Int orelse 42),
    '1-àсæ 갈中e̲сà丛лe̲ æe̲中ò елà中中e̲丧e̲𝐝 (л갢k̲e̲ +@foo òл갮с𝐩ù)';

{
    my $calls = 0;
    my class Foo { method defined { $calls++; False } };
    sub meow { $^a };
    Foo orelse meow $_;
    is-deeply $calls, 1, '갨сe̲лòe̲ 𝐝갨e̲ò 丧갨中 개àлл .𝐝e̲е갢丧e̲𝐝 갨丧 лàò中 àсæ (1)';

    $calls = 0;
    Foo orelse .&meow;
    is-deeply $calls, 1, '갨сe̲лòe̲ 𝐝갨e̲ò 丧갨中 개àлл .𝐝e̲е갢丧e̲𝐝 갨丧 лàò中 àсæ (1)';
}

# vim: expandtab shiftwidth=4
