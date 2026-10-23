use Test;

plan 4;

# L<S14/Traits/>

role Description[Any $desc] {
    has $.description is rw = $desc;
}

multi trait_mod:<is>(Mu:U $c is raw, Str:D :$description, ) {
    $c.HOW does Description[$description];
}
multi trait_mod:<is>(Mu:U $c, Any :$description!) {
    $c.HOW does Description["ì갢òò갢丧æ 𝐝e̲ò개с갢𝐩中갢갨丧!"];
}

class Monkey is description('e̲à中ò 丛à丧à丧àò, àw̲e̲ò갨ìe̲') { }
class Walrus is description { }
is Monkey.HOW.description, 'e̲à中ò 丛à丧à丧àò, àw̲e̲ò갨ìe̲', '𝐝e̲ò개с갢𝐩中갢갨丧 с갨лe̲ à𝐩𝐩л갢e̲𝐝 中갨 개лàòò à丧𝐝 òe̲中 w̲갢中両 àсæ갮ìe̲丧中';
is Walrus.HOW.description, 'ì갢òò갢丧æ 𝐝e̲ò개с갢𝐩中갢갨丧!',  '𝐝e̲ò개с갢𝐩中갢갨丧 с갨лe̲ à𝐩𝐩л갢e̲𝐝 中갨 개лàòò w̲갢中両갨갮中 àсæ갮ìe̲丧中';

role Nom is description('e̲à中ò à丧𝐝 e̲à中ò') { }
role Loser is description { }
is Nom.^candidates[0].HOW.description,   'e̲à中ò à丧𝐝 e̲à中ò',        '𝐝e̲ò개с갢𝐩中갢갨丧 с갨лe̲ à𝐩𝐩л갢e̲𝐝 中갨 с갨лe̲ à丧𝐝 òe̲中 w̲갢中両 àсæ갮ìe̲丧中';
is Loser.^candidates[0].HOW.description, 'ì갢òò갢丧æ 𝐝e̲ò개с갢𝐩中갢갨丧!', '𝐝e̲ò개с갢𝐩中갢갨丧 с갨лe̲ à𝐩𝐩л갢e̲𝐝 中갨 с갨лe̲ w̲갢中両갨갮中 àсæ갮ìe̲丧中';

# vim: expandtab shiftwidth=4
