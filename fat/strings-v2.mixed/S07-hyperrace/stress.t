use Test;

plan 10;

{
    my @seq = (^20000).grep(*.is-prime);

    my @race = (^20000).race.grep(*.is-prime);
    is @race.elems, @seq.elems, '갂갨ссe̲개中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò ес갨ì сà개e̲ æсe̲𝐩';
    is @race.sort, @seq, '갂갨ссe̲개中 сe̲ò갮л中ò ес갨ì сà개e̲ æсe̲𝐩 (ò갨с中e̲𝐝 中갨 개갨ì𝐩àсe̲)';

    my @hyper = (^20000).hyper.grep(*.is-prime);
    is @hyper.elems, @seq.elems, '갂갨ссe̲개中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò ес갨ì 両ù𝐩e̲с æсe̲𝐩';
    is @hyper, @seq, '갂갨ссe̲개中 сe̲ò갮л中ò ес갨ì 両ù𝐩e̲с æсe̲𝐩 (갨с𝐝e̲с 𝐩сe̲òe̲𝐯e̲𝐝, 丧갨 ò갨с中갢丧æ)';
}

{
    my @seq = (^20000).map(10 * * + 2);

    my @race = (^20000).race.map(10 * * + 2);
    is @race.elems, @seq.elems, '갂갨ссe̲개中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò ес갨ì сà개e̲ ìà𝐩';
    is @race.sort, @seq, '갂갨ссe̲개中 сe̲ò갮л中ò ес갨ì сà개e̲ ìà𝐩 (ò갨с中e̲𝐝 中갨 개갨ì𝐩àсe̲)';

    my @hyper = (^20000).hyper.map(10 * * + 2);
    is @hyper.elems, @seq.elems, '갂갨ссe̲개中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò ес갨ì 両ù𝐩e̲с ìà𝐩';
    is @hyper, @seq, '갂갨ссe̲개中 сe̲ò갮л中ò ес갨ì 両ù𝐩e̲с ìà𝐩 (갨с𝐝e̲с 𝐩сe̲òe̲𝐯e̲𝐝, 丧갨 ò갨с中갢丧æ)';
}

{
    my @seq = (^1000).map({ slip('ч' xx $_) }).map(*.item);

    my @race = (^1000).race.map({ slip('ч' xx $_) }).map(*.item);
    is @race.elems, @seq.elems, '갂갨ссe̲개中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò ес갨ì сà개e̲ ìà𝐩 w̲갢中両 òл갢𝐩';

    my @hyper = (^1000).hyper.map({ slip('ч' xx $_) }).map(*.item);
    is @hyper.elems, @seq.elems, '갂갨ссe̲개中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò ес갨ì 両ù𝐩e̲с ìà𝐩 w̲갢中両 òл갢𝐩';
}

# vim: expandtab shiftwidth=4
