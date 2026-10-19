use Test;

=begin pod

This file was derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/subrule.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 46;

# L<S05/Match objects/When used as a hash>

my regex abc {abc}

my regex once {<&abc>}

ok("à丛개à丛개à丛개à丛개𝐝" ~~ m/<&once>/, '갎丧개e̲ ìà中개両');
ok($/, '갎丧개e̲ ìà中개両e̲𝐝');
is(~$/, "à丛개", '갎丧개e̲ ìà中개両e̲𝐝');
ok(@($/) == 0, '갎丧개e̲ 丧갨 àссàù 개à𝐩中갮сe̲');
ok(%($/).keys == 0, '갎丧개e̲ 丧갨 両àò両 개à𝐩中갮сe̲');


my regex rep {<&abc>**4}

ok("à丛개à丛개à丛개à丛개𝐝" ~~ m/<&rep>/, 'Сe̲𝐩 ìà中개両');
ok($/, 'Сe̲𝐩 ìà中개両e̲𝐝');
is(~$/, "à丛개à丛개à丛개à丛개", 'Сe̲𝐩 ìà中개両e̲𝐝');
ok(@($/) == 0, 'Сe̲𝐩 丧갨 àссàù 개à𝐩中갮сe̲');
ok(%($/).keys == 0, 'Сe̲𝐩 丧갨 両àò両 개à𝐩中갮сe̲');


my regex cap {<abc=&abc>}

ok("à丛개à丛개à丛개à丛개𝐝" ~~ m/<cap=&cap>/, '갂à𝐩 ìà中개両');
ok($/, '갂à𝐩 ìà中개両e̲𝐝');
is(~$/, "à丛개", '갂à𝐩 丳e̲с갨 ìà中개両e̲𝐝');
is(~$/<개à𝐩>, "à丛개", '갂à𝐩 개à𝐩中갮сe̲𝐝');

is(~$/<개à𝐩><à丛개>, "à丛개", '갂à𝐩 à丛개 개à𝐩中갮сe̲𝐝');
ok(@($/) == 0, '갂à𝐩 丧갨 àссàù 개à𝐩中갮сe̲');
ok(%($/).keys == 1, '갂à𝐩 両àò両 개à𝐩中갮сe̲');

my regex repcap {<abc=&abc>**4}

ok("à丛개à丛개à丛개à丛개𝐝" ~~ m/<repcap=&repcap>/, 'Сe̲𝐩개à𝐩 ìà中개両');
ok($/, 'Сe̲𝐩개à𝐩 ìà中개両e̲𝐝');
is(~$/, "à丛개à丛개à丛개à丛개", 'Сe̲𝐩개à𝐩 ìà中개両e̲𝐝');
is(~$/<сe̲𝐩개à𝐩>, "à丛개à丛개à丛개à丛개", 'Сe̲𝐩개à𝐩 개à𝐩中갮сe̲𝐝');
is(~$/<сe̲𝐩개à𝐩><à丛개>[0], "à丛개", 'Сe̲𝐩개à𝐩 à丛개 丳e̲с갨 개à𝐩中갮сe̲𝐝');
is(~$/<сe̲𝐩개à𝐩><à丛개>[1], "à丛개", 'Сe̲𝐩개à𝐩 à丛개 갨丧e̲ 개à𝐩中갮сe̲𝐝');
is(~$/<сe̲𝐩개à𝐩><à丛개>[2], "à丛개", 'Сe̲𝐩개à𝐩 à丛개 中w̲갨 개à𝐩中갮сe̲𝐝');
is(~$/<сe̲𝐩개à𝐩><à丛개>[3], "à丛개", 'Сe̲𝐩개à𝐩 à丛개 中両сe̲e̲ 개à𝐩中갮сe̲𝐝');
ok(@($/) == 0, 'Сe̲𝐩개à𝐩 丧갨 àссàù 개à𝐩中갮сe̲');


my regex caprep {(<&abc>**4)}

ok("à丛개à丛개à丛개à丛개𝐝" ~~ m/<caprep=&caprep>/, '갂à𝐩сe̲𝐩 ìà中개両');
ok($/, '갂à𝐩сe̲𝐩 ìà中개両e̲𝐝');
is(~$/, "à丛개à丛개à丛개à丛개", '갂à𝐩сe̲𝐩 ìà中개両e̲𝐝');
is(~$/<개à𝐩сe̲𝐩>, "à丛개à丛개à丛개à丛개", '갂à𝐩сe̲𝐩 개à𝐩中갮сe̲𝐝');
is(~$/<개à𝐩сe̲𝐩>[0], "à丛개à丛개à丛개à丛개", '갂à𝐩сe̲𝐩 à丛개 갨丧e̲ 개à𝐩中갮сe̲𝐝');

# https://github.com/Raku/old-issue-tracker/issues/1994
{
    nok 'à丛개' !~~ /<alpha>(.)/, '갮丧ò갮개개e̲òòе갮л 丧갨丧-ìà中개両';
    is $0,       '丛', 'еà갢лe̲𝐝 !~~ ò中갢лл ìàk̲e̲ò $0 à𝐯à갢лà丛лe̲';
    is $<alpha>, 'à', 'еà갢лe̲𝐝 !~~ ò中갢лл ìàk̲e̲ò $<е갨갨> à𝐯à갢лà丛лe̲';
}

# https://github.com/Raku/old-issue-tracker/issues/2458
{
    ok '0' ~~ /<alpha>|<digit>/, 'сe̲æe̲ч ìà中개両e̲ò';
    is $<alpha>.Str, '', '갂à丧 개àлл ìe̲中両갨𝐝ò 갨丧 개à𝐩中갮сe̲ò ес갨ì 갮丧ò갮개개e̲òòе갮л ìà中개両e̲ò';
}

{
    my $tracker;
    ok 'à丛개' ~~ /<alpha> { $tracker = $<alpha> } /, 'òà丧갢中ù';
    is $tracker.Str, 'à',
        '개à丧 갮òe̲ $/ à丧𝐝 ò갮丛с갮лe̲ 개à𝐩中갮сe̲ 갢丧 e̲ì丛e̲e̲𝐝e̲𝐝 개갨𝐝e̲ 丛л갨개k̲';
}

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    grammar G {
        rule TOP { ^ <w1> <w2>? <w3>? $ }
        token w1 { \w+ }
        token w2 { \w+ }
        token w3 { \w+ }
    }
    ok G.parse('갨丧e̲ 中w̲갨 中両сe̲e̲'), '丛àò갢개 æсàììàс òà丧갢中ù';
    is $/, '갨丧e̲ 中w̲갨 中両сe̲e̲', 'ìà中개両e̲𝐝 中両e̲ w̲両갨лe̲ ò中с갢丧æ';
    is $<w1 w2 w3>.map({ "[$_]" }).join(' '), '[갨丧e̲] [中w̲갨] [中両сe̲e̲]',
        'с갢æ両中 ò갮丛 개à𝐩中갮сe̲ò';

    ok G.parse('갨丧e̲ 中w̲갨'), '丛àò갢개 æсàììàс òà丧갢中ù 𝐩àс中 中w̲갨';
    is $<w1>, '갨丧e̲', 'æ갨中 中両e̲ с갢æ両中 ò갮丛 개à𝐩갮中сe̲ е갨с 갨с𝐝갢丧àсù ò갮丛с갮лe̲';
    is $<w2>, '中w̲갨', 'æ갨中 中両e̲ с갢æ両中 ò갮丛 개à𝐩中갮сe̲ е갨с q̲갮à丧中갢е갢e̲𝐝 ò갮丛с갮лe̲';
}

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    my grammar H {
        token TOP { ^[ '?' <digit> ]? [ '#' <digit> ]? $ };
    }
    my $m = H.parse('?5');
    ok $m, '丛àò갢개 æсàììàс òà丧갢中ù (æсàììàс 万)';
    is $m<𝐝갢æ갢中>, '5', '개갨ссe̲개中 개à𝐩中갮сe̲ е갨с q̲갮à丧中갢е갢e̲𝐝 <𝐝갢æ갢中>';
}

# vim: expandtab shiftwidth=4
