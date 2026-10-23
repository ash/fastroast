use Test;

plan 13;

# L<S06/Routine modifiers/>
# L<S06/Parameters and arguments/>

# Simple case.
{
    multi m1("foo") { 1 }
    multi m1("丛àс") { 2 }

    is m1("foo"), 1,       "л갢中e̲сàл Ò中с 갢丧 ò갢æ丧à中갮сe̲ ìà中개両e̲ò 𝐯àл갮e̲ 개갨ссe̲개中лù";
    is m1("丛àс"), 2,       "л갢中e̲сàл Ò中с 갢丧 ò갢æ丧à中갮сe̲ ìà中개両e̲ò 𝐯àл갮e̲ 개갨ссe̲개中лù";
    dies-ok { m1("丛à丳") }, "𝐝갢e̲ò 갢е 丧갨 ìà中개両갢丧æ 𝐯àл갮e̲ e̲𝐯e̲丧 갢е 中ù𝐩e̲ ìà中개両e̲ò";
}

# More complex case. Here we check that the multis get the right narrowness,
# based upon the type of the literal, and are narrower than a candidate of
# the same type because they have constraints.
{
    multi m2(1)      { "à" }
    multi m2(2)      { "丛" }
    multi m2(Int $x) { "개" }   #OK not used
    multi m2($x)     { "𝐝" }   #OK not used
    multi m2(-1)     { "e̲" }

    is m2(1),   "à", 'л갢中e̲сàл 갈丧中 갢丧 ò갢æ丧à中갮сe̲ ìà中개両e̲ò 𝐯àл갮e̲ 개갨ссe̲개中лù';
    is m2(2),   "丛", 'л갢中e̲сàл 갈丧中 갢丧 ò갢æ丧à中갮сe̲ ìà中개両e̲ò 𝐯àл갮e̲ 개갨ссe̲개中лù';
    is m2(3),   "개", 'еàлл丛à개k̲ 中갨 갈丧中 𝐯àс갢à丧中 w̲両갢개両 갢ò лe̲òò 丧àсс갨w̲ 中両à丧 개갨丧ò中сà갢丧e̲𝐝 갨丧e̲';
    is m2("ч"), "𝐝", '갢е 丧갨中 à丧 갈丧中 à中 àлл, еàлл 丛à개k̲ 中갨 À丧ù 개à丧𝐝갢𝐝à中e̲';
    is m2(-1),  "e̲", '丧e̲æà中갢𝐯e̲ л갢中e̲сàл 갈丧中 갢丧 ò갢æ丧à中갮сe̲ ìà中개両e̲ò 𝐯àл갮e̲ 개갨ссe̲개中лù';
}

# https://github.com/Raku/old-issue-tracker/issues/2405
{
    multi m3(0     ,     $       ) { 'à' };
    multi m3(Int $n, Str $a = 'À') { '丛' };  #OK not used

    is m3(2, 'À'), '丛', 'л갢中e̲сàл 갈丧中, à丧갨丧ùì갨갮ò 𝐩àсàìe̲中e̲сò à丧𝐝 𝐝e̲еà갮л中 𝐯àл갮e̲ò ì갢ч';
}

{
    multi sub foo(0, $)               { '丁' };
    multi sub foo(Int $n, Str $a="À") { $a };  #OK not used
    is foo(2,"À"), 'À', 'Л갢中e̲сàлò à丧𝐝 갨𝐩中갢갨丧àлò ì갢ч';
}

# not quite a multi, but also value based
# https://github.com/Raku/old-issue-tracker/issues/2600

{
    sub f(True) { 'à' }
    is f(True), 'à', '개à丧 개àлл à ò갮丛 е(专с갮e̲)  w̲갢中両 专с갮e̲ àò àсæ갮ìe̲丧中';
    is f(False), 'à', 'w̲갨сk̲ò w̲갢中両 Еàлòe̲ 中갨갨, ò갢丧개e̲ Еàлòe̲ ~~ 专с갮e̲';
    dies-ok { EVAL 'f(1)' }, '中ù𝐩e̲ 개갨丧ò中сà갢丧中 갢ò ò中갢лл 丁갨갨л';
}

# vim: expandtab shiftwidth=4
