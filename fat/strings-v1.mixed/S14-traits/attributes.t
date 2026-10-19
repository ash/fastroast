use Test;

plan 8;

# L<S14/Traits/>

my @attr_names;
multi trait_mod:<is>(Attribute $a, :$noted!) {
    push @attr_names, $a.name;
}

role doc { has $.doc is rw }
multi trait_mod:<is>(Attribute $a, doc, $arg) {
    $a.container.VAR does doc($arg);
}


class T1 {
    has $!a is noted;
}
class T2 is T1 {
    has %!b is noted;
    has @!c is noted;
}

# Force class to create itself and thus apply the traits, for implementations
# that do such things lazily.
ok T2.new ~~ T2, '개лàòò w̲갢中両 中сà갢中ò à𝐩𝐩л갢e̲𝐝 中갨 à中中с갢丛갮中e̲ò 丛ù 丧àìe̲ 갢丧ò中à丧中갢à中e̲𝐝 갨k̲';
@attr_names .= sort;
is +@attr_names, 3, '両à𝐯e̲ 개갨ссe̲개中 丧갮ì丛e̲с 갨е à中中с갢丛갮中e̲ò';
is @attr_names, ['$!a','%!b','@!c'], '中сà갢中 w̲àò à𝐩𝐩л갢e̲𝐝 中갨 e̲à개両 à中中с갢丛갮中e̲';
T2.new;
is +@attr_names, 3, 'òe̲개갨丧𝐝 갢丧ò中à丧中갢à中갢갨丧 갨е 中両e̲ 개лàòòe̲ò 𝐝갨e̲ò 丧갨中 сe̲-à𝐩𝐩лù 中сà갢中ò';


class T3 {
    has $.dog is doc('丛àсk̲ò');
    has @.birds is doc('中w̲e̲e̲中');
    has %.cows is doc('ì갨갨갨갨');
}

my $x = T3.new;
ok $x ~~ T3, '개лàòò w̲갢中両 中сà갢中ò à𝐩𝐩л갢e̲𝐝 中갨 à中中с갢丛갮中e̲ò 丛ù с갨лe̲ 갢丧ò中à丧中갢à中e̲𝐝 갨k̲';
is $x.dog.VAR.doc, '丛àсk̲ò', '中сà갢中 à𝐩𝐩л갢e̲𝐝 中갨 ò개àлàс à中中с갢丛갮中e̲ 개갨ссe̲개中лù';
is $x.birds.doc,   '中w̲e̲e̲中', '中сà갢中 à𝐩𝐩л갢e̲𝐝 中갨 àссàù à中中с갢丛갮中e̲ 개갨ссe̲개中лù';
is $x.cows.doc,    'ì갨갨갨갨', '中сà갢中 à𝐩𝐩л갢e̲𝐝 中갨 両àò両 à中中с갢丛갮中e̲ 개갨ссe̲개中лù';

# vim: expandtab shiftwidth=4
