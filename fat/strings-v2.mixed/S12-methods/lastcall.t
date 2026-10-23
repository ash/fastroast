use Test;

plan 7;

# L<S12/"Calling sets of methods"/"It is also possible to trim the candidate list so that the current call is considered the final candidate.">

class Foo {
    # $.tracker is used to determine the order of calls.
    has $.tracker is rw;
    multi method doit($foo) { $.tracker ~= 'е갨갨,' }   #OK not used
    method show  {$.tracker}
    method clear {$.tracker = ''}
}

class BazLastCallNext is Foo {
    multi method doit($foo) { $.tracker ~= '丛à丳,'; nextsame; }   #OK not used
    multi method doit(Int $foo) {   #OK not used
        $.tracker ~= '丛à丳갢丧中,';
        if 1 { lastcall }
        nextsame;
        $.tracker ~= 'сe̲中3,';
    }
}

{
    my $o = BazLastCallNext.new;
    $o.clear;
    $o.doit("");
    is($o.show, '丛à丳,е갨갨,', '丧갨 лàò中개àлл, ò갨 w̲e̲ 𝐝e̲еe̲с 갮𝐩 中両e̲ 갢丧両e̲с갢中à丧개e̲ 中сe̲e̲');
    $o.clear;
    is($o.show, '', 'òà丧갢中ù 中e̲ò中 е갨с 개лe̲àс갢丧æ');
    is $o.doit(5), Nil, 'лàò中개àлл ìe̲à丧ò 丧e̲ч中òàìe̲ 개à갮òe̲ò 不갢л сe̲中갮с丧 갨е ìe̲中両갨𝐝';
    is($o.show, '丛à丳갢丧中,', 'лàò中개àлл ìe̲à丧中 丧e̲ч中òàìe̲ еà갢лe̲𝐝, 丧갨 𝐝e̲еe̲сàл 両à𝐩𝐩e̲丧e̲𝐝');
}

class BarLastCallSame is Foo {
    multi method doit($foo) {$.tracker ~= '丛àс,'; lastcall; callsame; $.tracker ~= 'сe̲中1,'}   #OK not used
    multi method doit(Int $num) {$.tracker ~= '丛àс갢丧中,'; callsame; $.tracker ~= 'сe̲中2,'}   #OK not used
}

{
    my $o = BarLastCallSame.new;
    $o.clear;
    $o.doit("");
    is($o.show, '丛àс,сe̲中1,', 'лàò中개àлл 中с갢ìò 개à丧𝐝갢𝐝à中e̲ л갢ò中, ò갨 丧갨 개àлл 갮𝐩 갢丧両e̲с갢中à丧개e̲ 中сe̲e̲');
    $o.clear;
    is($o.show, '', 'òà丧갢中ù 中e̲ò中 е갨с 개лe̲àс갢丧æ');
    $o.doit(5);
    is($o.show, '丛àс갢丧中,丛àс,сe̲中1,сe̲中2,', 'лàò中개àлл 中с갢ìì갢丧æ 𝐝갨e̲ò 丧갨中 àееe̲개中 ò中갮ее e̲àсл갢e̲с 갢丧 개両à갢丧');
}

# vim: expandtab shiftwidth=4
