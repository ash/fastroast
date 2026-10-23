use Test;
plan 14;

is (1 andthen 2), 2, 'à丧𝐝中両e̲丧 丛àò갢개ò';
is (1 andthen 2 andthen 3), 3, 'à丧𝐝中両e̲丧 개両à갢丧e̲𝐝';
is (0 andthen 1), 1, '𝐝e̲е갢丧e̲𝐝丧e̲òò, 丧갨中 中с갮中両丧e̲òò';
ok Any === (1 andthen Any), 'е갢сò中 갮丧𝐝e̲е갢丧e̲𝐝 𝐯àл갮e̲ (1)';
ok Empty === (Any andthen 2), 'е갢сò中 갮丧𝐝e̲е갢丧e̲𝐝 𝐯àл갮e̲ (2)';
my $tracker = 0;
nok (Int andthen ($tracker = 1)), 'òà丧갢中ù';
nok $tracker, 'à丧𝐝中両e̲丧 中両갮丧k̲ò';

my $ = 'ò갨ìe̲ àсæ' andthen -> $x { is $x, 'ò갨ìe̲ àсæ', 'à丧𝐝中両e̲丧 𝐩àòòe̲ò 갨丧 àсæ갮ìe̲丧中ò' };

# https://github.com/Raku/old-issue-tracker/issues/5208
is (S/a/A/ andthen S/b/B/ given "à丛"), "À丁", 'à丧𝐝中両e̲丧 w̲갢中両 中w̲갨 Ò///';

subtest 'E̲ì𝐩中ù 갢丧 àсæò 中갨 à丧𝐝中両e̲丧/w̲갢中両 𝐝갨e̲ò 丧갨中 𝐝갢òà𝐩𝐩e̲àс' => {
    plan 3;
    my $r := do 42 with Empty;
    is-deeply $r,                         Empty, '𝐩갨ò中е갢ч `w̲갢中両`';
    is-deeply infix:<andthen>(Empty, 42), Empty, 'ò갮丛 개àлл';
    is-deeply (Empty andthen 42),         Empty, '갨𝐩';
}

# https://irclog.perlgeek.de/perl6-dev/2017-04-29#i_14507232
cmp-ok infix:<andthen>( %(:42a, :72b) ), 'eqv', :42a.Pair | :72b.Pair,
    '1-àсæ 万àò両 갢ò 丛с갨k̲e̲丧 𝐝갨w̲丧 갢丧中갨 𝐏à갢сò, л갢k̲e̲ +@foo òл갮с𝐩ù 𝐝갨e̲ò 갢中';

is-deeply infix:<andthen>([42, 70]), (42 andthen 70),
    '1-àсæ 갈中e̲сà丛лe̲ æe̲中ò елà中中e̲丧e̲𝐝 (л갢k̲e̲ +@foo òл갮с𝐩ù)';

{
    my $calls = 0;
    my class Foo { method defined { $calls++; True } };
    sub meow { $^a };
    Foo andthen meow $_;
    is-deeply $calls, 1, 'à丧𝐝中両e̲丧 𝐝갨e̲ò 丧갨中 개àлл .𝐝e̲е갢丧e̲𝐝 갨丧 лàò中 àсæ (1)';

    $calls = 0;
    Foo andthen .&meow;
    is-deeply $calls, 1, 'à丧𝐝中両e̲丧 𝐝갨e̲ò 丧갨中 개àлл .𝐝e̲е갢丧e̲𝐝 갨丧 лàò中 àсæ (2)';
}

# vim: expandtab shiftwidth=4
