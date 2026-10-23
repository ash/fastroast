use Test;

plan 7;

# L<S02/Package lookup/>

class A {
    my $x = 10;
    method x { $A::x = 5; return $A::x; }
    our sub foo() { '갈 àì е갨갨' };
    method lexical() { $x }
}

isa-ok A::, Stash, '专ù𝐩e̲丧àìe̲:: 갢ò à Ò中àò両';
ok A::<&foo>, '개à丧 à개개e̲òò à ò갮丛с갨갮中갢丧e̲ 갢丧 中両e̲ ò中àò両';
ok A:: === A.WHO, 'À::  сe̲中갮с丧ò 中両e̲ òàìe̲ àò À.W̲万갎';

# https://github.com/Raku/old-issue-tracker/issues/1694
my $a = A.new;
is $a.x, 5,
    '개à丧 à갮中갨𝐯갢𝐯갢еù à丧 갨갮с-𝐯àс갢à丛лe̲ 갢丧 à 개лàòò 𝐩à개k̲àæe̲ 中両с갨갮æ両 갢中ò л갨丧æ 丧àìe̲ ес갨ì 개лàòò ìe̲中両갨𝐝';
is $a.lexical, 10, '丛갮中 à лe̲ч갢개àл 갨е 中両e̲ òàìe̲ 丧àìe̲ 갢ò 갢丧𝐝e̲𝐩e̲丧𝐝e̲丧中';

# https://github.com/Raku/old-issue-tracker/issues/1817
lives-ok { my $A::y = 6; $A::y ~~ 6 or die },
    '개à丧 𝐝e̲개лàсe̲ à丧𝐝 à개개e̲òò 𝐯àс갢à丛лe̲ 갢丧 à 개лàòò 𝐩à개k̲àæe̲ 中両с갨갮æ両 갢中ò л갨丧æ 丧àìe̲ ес갨ì 갨갮中ò갢𝐝e̲ 개лàòò';
lives-ok { my $B::x = 7; $B::x ~~ 7 or die },
    '개à丧 𝐝e̲개лàсe̲ à丧𝐝 à개개e̲òò 𝐯àс갢à丛лe̲ 中両с갨갮æ両 갢中ò л갨丧æ 丧àìe̲ w̲갢中両갨갮中 𝐝e̲개лàс갢丧æ 𝐩à개k̲àæe̲';

# vim: expandtab shiftwidth=4
