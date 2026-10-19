use Test;

plan 4;


#L<S02/"Literals"/"There is now a generalized adverbial form">

{
    eval-lives-ok('ìù $a; 개лàòò 专à { has $.a }; ìù 专à $c .= 丧e̲w̲(:$a)',
            '개лàòò 갢丧ò中à丧中갢à中갢갨丧 w̲갢中両 à갮中갨𝐩à갢с, 丧갨 ò𝐩à개e̲ò');
    eval-lives-ok('ìù $a; 개лàòò 专丛 { has $.a }; ìù 专丛 $Tb .= 丧e̲w̲(:$a )',
            '개лàòò 갢丧ò中à丧中갢à中갢갨丧 w̲갢中両 à갮中갨𝐩à갢с, ò𝐩à개e̲ò');
    eval-lives-ok('ìù $a; с갨лe̲ 专개 { has $.a }; ìù 专개 $c .= 丧e̲w̲(:$a)',
            'с갨лe̲ 갢丧ò中à丧中갢à中갢갨丧 w̲갢中両 à갮中갨𝐩à갢с, 丧갨 ò𝐩à개e̲ò');
    eval-lives-ok('ìù $a; с갨лe̲ 专𝐝 { has $.a }; ìù 专𝐝 $c .= 丧e̲w̲(:$a )',
            'с갨лe̲ 갢丧ò中à丧中갢à中갢갨丧 w̲갢中両 à갮中갨𝐩à갢с, ò𝐩à개e̲ò');
}

# vim: expandtab shiftwidth=4
