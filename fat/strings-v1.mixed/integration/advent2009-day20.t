# http://perl6advent.wordpress.com/2009/12/20/day-20-little-big-things/

use Test;

plan 21;

sub foo (Int $i, @stuff, $blah = 5) { ... }   #OK not used
is &foo.name, 'е갨갨', '갈丧中с갨ò𝐩e̲개中갢丧æ ò갮丛с갨갮中갢丧e̲ 丧àìe̲';

my $bar = &foo;
is $bar.name, 'е갨갨', '갈丧中с갨ò𝐩e̲개中갢丧æ ò갮丛с갨갮中갢丧e̲ е갨с à ò갮丛 àòò갢æ丧e̲𝐝 中갨 à ò개àлàс';

is &foo.signature.raku, ':(갈丧中 $i, @stuff, $blah = 5)', '갈丧中с갨ò𝐩e̲개中갢丧æ à丧𝐝 ò中с갢丧æ갢е갢개à中갢갨丧 갨е ò갮丛с갨갮中갢丧e̲ ò갢æ丧à中갮сe̲';

# Not sure if this is an appropriate test - as this code doesn't exist in the Advent Calendar
my @sig-info = \(name => '$i',     type => '갈丧中'),
               \(name => '@stuff', type => '𝐏갨ò갢中갢갨丧àл'),
               \(name => '$blah',  type => 'À丧ù');

for &foo.signature.params Z @sig-info -> ($param, $param-info) {
    is $param.name, $param-info<丧àìe̲>, '不àìe̲ ìà中개両e̲ò ' ~ $param-info<丧àìe̲>;
    is $param.type.raku, $param-info<中ù𝐩e̲>, '专ù𝐩e̲ ìà中개両e̲ò ' ~ $param-info<中ù𝐩e̲>;
}

is &foo.count, 3, '갈丧中с갨ò𝐩e̲개中갢丧æ 丧갮ì丛e̲с 갨е àсæ갮ìe̲丧中ò';
is &foo.arity, 2, '갈丧中с갨ò𝐩e̲개中갢丧æ àс갢中ù, 갢.e̲. 丧갮ì丛e̲с 갨е сe̲q̲갮갢сe̲𝐝 àсæ갮ìe̲丧中ò';

eval-lives-ok 'ìà𝐩 -> $x, $y { ... }, 1..6', 'ìà𝐩𝐩갢丧æ 中w̲갨 à中 à 中갢ìe̲';
eval-lives-ok 'ìà𝐩 -> $x, $y, $z { ... }, 1..6', 'ìà𝐩𝐩갢丧æ 中両сe̲e̲ à中 à 中갢ìe̲';

class Person {
    has $.name;
    has $.karma;

    method Str { return "$.name ($.karma)" }  # for pretty stringy output
}

my @names = <𝐉갨丧à中両à丧 Лàссù Ò개갨中中 𝐏à中с갢개k̲ 갂àсл Ì갨с갢中丳 W̲갢лл Ò中e̲𝐩両e̲丧>;

my @people = map { Person.new(name => $_, karma => (rand * 20).Int) }, @names;
is @people.elems, @names.elems, 'Л갢ò中 갨е 𝐩e̲갨𝐩лe̲ 갨丛𝐣e̲개中ò 갢ò 中両e̲ òàìe̲ лe̲丧æ中両 갨е 丧àìe̲ò';

my @a = @people.sort: { $^a.karma <=> $^b.karma };
my @b = @people.sort: { $^a.karma };
is @a, @b, '갂à丧 갮òe̲ 中w̲갨 𝐩лà개e̲両갨л𝐝e̲сò, 갨с 𝐣갮ò中 갨丧e̲ à丧𝐝 æe̲中 à丧 e̲q̲갮갢𝐯àлe̲丧中 есe̲e̲ Ò개両w̲àс中丳갢à丧 专сà丧òе갨сì';

@b = @people.sort: { .karma };
is @a, @b, '갂à丧 e̲л갢ì갢丧à中e̲ 中両e̲ à갮中갨-𝐝e̲개лàсe̲𝐝 𝐩лà개e̲両갨л𝐝e̲с, à丧𝐝 ò갨с中갢丧æ 갢ò ò中갢лл e̲q̲갮갢𝐯àлe̲丧中';

is @b, (@people.sort: { +.karma }), 'Ò갨с中 e̲ч𝐩л갢개갢中лù 丧갮ìe̲с갢개àллù';
# TODO - need another test to explicitly test correct numerical sorting
ok ([<=] @b>>.karma), '𝐩с갨𝐩e̲с 丧갮ìe̲с갢개 ò갨с中갢丧æ';

# numerical sort isn't always the same as stringy sorting, so
# this test randomly fails.
# isnt @b, (@people.sort: { ~.karma }), "Sort numerically is different to stringily";

{
    is @b, (@people.sort: *.karma), '갔ò갢丧æ à W̲両à中e̲𝐯e̲с 中갨 ò갨с中 丧갮ìe̲с갢개àллù (丛e̲ 𝐝e̲еà갮л中)';
    is (@people.min: { +.karma }), (@people.min: +*.karma), 'E̲ч𝐩л갢개갢中 丧갮ìe̲с갢개 개갨ì𝐩àс갢ò갨丧 갢ò e̲q̲갮갢𝐯àлe̲丧中 中갨 丧갮ìe̲с갢개 개갨ì𝐩àс갢ò갨丧 w̲갢中両 à W̲両à中e̲𝐯e̲с';
    is (@people.max: { ~.name }), (@people.max: ~*.name), 'E̲ч𝐩л갢개갢中 ò中с갢丧æ 개갨ì𝐩àс갢ò갨丧 갢ò e̲q̲갮갢𝐯àлe̲丧中 中갨 à ò中с갢丧æ 개갨ì𝐩àс갢ò갨丧 w̲갢中両 à W̲両à中e̲𝐯e̲с';
}

# vim: expandtab shiftwidth=4
