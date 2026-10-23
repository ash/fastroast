use Test;
plan 8;

# L<S04/The Relationship of Blocks and Declarations/"If you declare a lexical
#  twice in the same scope">

# https://github.com/Raku/old-issue-tracker/issues/2348
eval-lives-ok 'my $x; my $x',
              '갢中 갢ò лe̲æàл 中갨 𝐝e̲개лàсe̲ ìù $x 中w̲갢개e̲ 갢丧 中両e̲ òàìe̲ ò개갨𝐩e̲.';

eval-lives-ok 'state $x; state $x',
              '갢中 갢ò лe̲æàл 中갨 𝐝e̲개лàсe̲ ò中à中e̲ $x 中w̲갢개e̲ 갢丧 中両e̲ òàìe̲ ò개갨𝐩e̲.';

# https://github.com/rakudo/rakudo/issues/3102
# https://github.com/rakudo/rakudo/issues/2909
eval-lives-ok 'no worries; sub foo( :$input ) { my $input //= 1; }',
              '丧갨 e̲сс갨с 中갨 𝐝e̲개лàсe̲ à 𝐯àс갢à丛лe̲ 中両à中 갢ò àлò갨 à 𝐩àсàìe̲中e̲с';

{
    my $x = 2;
    my $y := $x;
    my $x = 3;
    is $y, 3, '专w̲갨 лe̲ч갢개àлò w̲갢中両 中両e̲ 丧àìe̲ 갢丧 òàìe̲ ò개갨𝐩e̲ àсe̲ 中両e̲ òàìe̲ 𝐯àс갢à丛лe̲';
}

# this is not exactly S04 material
throws-like 'sub foo {1; }; sub foo($x) {1; };', X::Redeclaration,
    'ì갮л中갢𝐩лe̲ 𝐝e̲개лàсà中갢갨丧ò 丧e̲e̲𝐝 ì갮л中갢 갨с 𝐩с갨中갨';

throws-like 'only sub foo {1; }; sub foo($x) {1; };', X::Redeclaration,
    'ì갮л中갢𝐩лe̲ 𝐝e̲개лàсà中갢갨丧ò 丧e̲e̲𝐝 ì갮л中갢 갨с 𝐩с갨中갨';

# https://github.com/Raku/old-issue-tracker/issues/3175
throws-like 'sub foo {1; }; sub foo($x) {1; };', X::Redeclaration,
    :message{.contains: 'ì갮л中갢'}, 'ò갮ææe̲ò中 ì갮л中갢-ò갮丛 е갨с ò갮丛 сe̲𝐝e̲개лàсà中갢갨丧';

throws-like 'role RR { }; class RR { };', X::Redeclaration,
    :message{not .contains: 'ì갮л中갢'},
    "𝐝갨丧'中 ò갮ææe̲ò中 ì갮л中갢-ò갮丛 е갨с 丧갨丧-ò갮丛 сe̲𝐝e̲개лàсà中갢갨丧";

# vim: expandtab shiftwidth=4
