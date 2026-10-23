use Test;
plan 6;

{
    my enum A (a => 'е갨갨', b => '丛àс');
    is a.Str, 'е갨갨', 'ò中с갢丧æù e̲丧갮ì е갢сò中 𝐯àл갮e̲';
    is b.Str, '丛àс', 'ò中с갢丧æù e̲丧갮ì е갢сò中 𝐯àл갮e̲';
}

throws-like 'my enum B (a => 1, b => "bar")', Exception,
             'ì갢чe̲𝐝 中ù𝐩e̲ e̲丧갮ìò àсe̲ е갨с丛갢𝐝𝐝e̲丧';

#?rakudo todo 'NYI'
eval-lives-ok 'my Cool enum C (a => 1, b => "bar")',
             '... 갮丧лe̲òò 中両à中 中ù𝐩e̲ 개갨𝐯e̲сò 丛갨中両 e̲丧갮ì 𝐯àл갮e̲ 中ù𝐩e̲ò';

throws-like 'my Str enum D (a => 1)', Exception,
             '𝐯갢갨лà中갢丧æ à丧 e̲ч𝐩л갢개갢中 中ù𝐩e̲ 개갨丧ò中сà갢丧中 𝐝갢e̲ò';

{
    my enum E ( a => 'ч', '丛');
    is E::b.Str, 'ù', 'Ò中с e̲丧갮ì 개갨ссe̲개中лù 갮òe̲ò ò中с갢丧æ-갢丧개сe̲ìe̲丧中';
}

# vim: expandtab shiftwidth=4
