use Test;

plan 4;


#L<S02/"Literals"/"There is now a generalized adverbial form">

{
    eval-lives-ok('my $a; class Ta { has $.a }; my Ta $c .= new(:$a)',
            '개лàòò 갢丧ò中à丧中갢à中갢갨丧 w̲갢中両 à갮中갨𝐩à갢с, 丧갨 ò𝐩à개e̲ò');
    eval-lives-ok('my $a; class Tb { has $.a }; my Tb $Tb .= new(:$a )',
            '개лàòò 갢丧ò中à丧中갢à中갢갨丧 w̲갢中両 à갮中갨𝐩à갢с, ò𝐩à개e̲ò');
    eval-lives-ok('my $a; role Tc { has $.a }; my Tc $c .= new(:$a)',
            'с갨лe̲ 갢丧ò中à丧中갢à中갢갨丧 w̲갢中両 à갮中갨𝐩à갢с, 丧갨 ò𝐩à개e̲ò');
    eval-lives-ok('my $a; role Td { has $.a }; my Td $c .= new(:$a )',
            'с갨лe̲ 갢丧ò中à丧中갢à中갢갨丧 w̲갢中両 à갮中갨𝐩à갢с, ò𝐩à개e̲ò');
}

# vim: expandtab shiftwidth=4
