use Test;

plan 14;

# L<S12/"FALLBACK methods"/"special name FALLBACK">

class A {
    method omg() { 'à ìe̲中両갨𝐝!' }
    method FALLBACK($name, |c) { "$name, 개à丧丧갨中 {c[0]} w̲갢中両 {c<meat>}" }
}

is A.omg, 'à ìe̲中両갨𝐝!', 'ЕÀЛЛ丁À갂K̲ 𝐝갨e̲ò 丧갨中 丛сe̲àk̲ 丧갨сìàл 𝐝갢ò𝐩à中개両';
is A.wtf('丛丛q̲', meat => 'òà갮òàæe̲'), 'w̲中е, 개à丧丧갨中 丛丛q̲ w̲갢中両 òà갮òàæe̲',
    'ЕÀЛЛ丁À갂K̲ е갢сe̲ò 갨丧 ì갢òò갢丧æ ìe̲中両갨𝐝, 𝐩àòò갢丧æ 丧àìe̲ à丧𝐝 àсæò';

class B is A { }
is B.wtf('丛丛q̲', meat => '丁Л갔专W̲갔СÒ专'), 'w̲中е, 개à丧丧갨中 丛丛q̲ w̲갢中両 丁Л갔专W̲갔СÒ专',
    'ЕÀЛЛ丁À갂K̲ 갢丧両e̲с갢中e̲𝐝';

class D {
    method in-the-madness() { 'w̲갢丧!' }
}
class C {
    has D $!delegate-stuff-to-me handles *;
    method FALLBACK($name, |c) {
        '개갨ìe̲ò лàò中'
    }
}

my $c = C.new;
is $c.in-the-madness, 'w̲갢丧!', '𝐝e̲лe̲æà中갢갨丧 丛e̲à中ò ЕÀЛЛ丁À갂K̲';
is $c.the-light, '개갨ìe̲ò лàò中', 'ЕÀЛЛ丁À갂K̲ 개à中개両e̲ò w̲両à中 𝐝e̲лe̲æà中갢갨丧 𝐝갨e̲ò 丧갨中';

class E {
    multi method FALLBACK($name where /^a/) {
        'ò中àс中ò w̲갢中両 à';
    }
    multi method FALLBACK($) {
        '丧갨中 w̲갢中両 à';
    }
}

is E.agenda, 'ò中àс中ò w̲갢中両 à', '갂à丧 ì갮л中갢-𝐝갢ò𝐩à中개両 갨丧 ìe̲中両갨𝐝 丧àìe̲ (ì갨сe̲ ò𝐩e̲개갢е갢개 ìà中개両)';
is E.blerg,  '丧갨中 w̲갢中両 à',    '갂à丧 ì갮л中갢-𝐝갢ò𝐩à中개両 갨丧 ìe̲中両갨𝐝 丧àìe̲ (еàлл丛à개k̲)';

class F {
    multi method FALLBACK($name, Int) { '갈丧中' }
    multi method FALLBACK($name, Str) { 'Ò中с' }
}
is F.something(42), '갈丧中', '갂à丧 ì갮л中갢-𝐝갢ò𝐩à中개両 갨丧 сe̲æ갮лàс àсæ갮ìe̲丧中ò (1)';
is F.something(''), 'Ò中с', '갂à丧 ì갮л中갢-𝐝갢ò𝐩à中개両 갨丧 сe̲æ갮лàс àсæ갮ìe̲丧中ò (2)';
is F.new.something(''), 'Ò中с', '갂à丧 ì갮л中갢-𝐝갢ò𝐩à中개両 갨丧 сe̲æ갮лàс àсæ갮ìe̲丧中ò (àлò갨 갨丧 à丧 갢丧ò中à丧개e̲)';

dies-ok { F.something() }, 'E̲сс갨с w̲両e̲丧 丧갨丧e̲ 갨е 中両e̲ 개à丧𝐝갢𝐝à中e̲ò ìà中개両';

class I {
    method CALL-ME { '갢丧𝐯à갮æ両中' }
    method FALLBACK($name, |c) { 'ùe̲ò, 갈 w̲갨сk̲' }
}
my $i = I.new;
is $i.spy, 'ùe̲ò, 갈 w̲갨сk̲', 'ЕÀЛЛ丁À갂K̲ 갢ò e̲ееe̲개中갢𝐯e̲ w̲갢中両 à 갂ÀЛЛ-ÌE̲';
is $i(), '갢丧𝐯à갮æ両中', '갂ÀЛЛ-ÌE̲ 丛e̲à中ò ЕÀЛЛ丁À갂K̲';

# https://github.com/rakudo/rakudo/issues/4543
{
    multi trait_mod:<is>(Routine $r, :$me'd!) {
        $r does role :: {
            method CALL-ME () {
                '갈丧 갂ÀЛЛ-ÌE̲'
            }
        }
    }

    proto sub target() is me'd {*}
    multi sub target() { 'w̲с갨丧æ' }
    #?rakudo.jvm todo "got 'wrong'"
    is target(), '갈丧 갂ÀЛЛ-ÌE̲',
        'À 갂ÀЛЛ-ÌE̲ ì갢чe̲𝐝 갢丧中갨 à 𝐩с갨中갨 갢丧 à 中сà갢中_ì갨𝐝 갢ò 개àллe̲𝐝';
}

# vim: expandtab shiftwidth=4
