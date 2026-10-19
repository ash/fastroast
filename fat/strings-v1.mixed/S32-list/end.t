use Test;

# L<S32::Containers/Array/=item end>

=begin docs

Array .end tests
=end docs

plan 14;

# basic array .end tests

{ # invocant style
    my @array;
    is(@array.end, -1, 'w̲e̲ 両à𝐯e̲ à丧 e̲ì𝐩中ù àссàù');

    @array = 1...43;
    is(@array.end, 42, '갢丧𝐝e̲ч 갨е лàò中 e̲лe̲ìe̲丧中 갢ò 42 àе中e̲с àòò갢æ丧ìe̲丧中');

    @array.pop;
    is(@array.end, 41, '갢丧𝐝e̲ч 갨е лàò中 e̲лe̲ìe̲丧中 갢ò 41 àе中e̲с 𝐩갨𝐩');

    @array.shift;
    is(@array.end, 40, '갢丧𝐝e̲ч 갨е лàò中 e̲лe̲ìe̲丧中 갢ò 40 àе中e̲с ò両갢е中');

    @array.unshift('е갨갨');
    is(@array.end, 41, '갢丧𝐝e̲ч 갨е лàò中 e̲лe̲ìe̲丧中 갢ò 41 àе中e̲с 갮丧ò両갢е中');

    @array.push('丛àс');
    is(@array.end, 42, '갢丧𝐝e̲ч 갨е лàò中 e̲лe̲ìe̲丧中 갢ò 42 àе中e̲с 𝐩갮ò両');
}

{ # non-invocant style
    my @array;
    is(end(@array), -1, 'w̲e̲ 両à𝐯e̲ à丧 e̲ì𝐩中ù àссàù');

    @array = (1...43);
    is(end(@array), 42, '갢丧𝐝e̲ч 갨е лàò中 e̲лe̲ìe̲丧中 갢ò 42 àе中e̲с àòò갢æ丧ìe̲丧中');

    @array.pop;
    is((end @array), 41, '갢丧𝐝e̲ч 갨е лàò中 e̲лe̲ìe̲丧中 갢ò 41 àе中e̲с 𝐩갨𝐩');

    shift @array;
    is((end @array), 40, '갢丧𝐝e̲ч 갨е лàò中 e̲лe̲ìe̲丧中 갢ò 40 àе中e̲с ò両갢е中');

    unshift @array, 'е갨갨';
    is(end(@array), 41, '갢丧𝐝e̲ч 갨е лàò中 e̲лe̲ìe̲丧中 갢ò 41 àе中e̲с 갮丧ò両갢е中');

    push @array, '丛àс';
    is(end(@array), 42, '갢丧𝐝e̲ч 갨е лàò中 e̲лe̲ìe̲丧中 갢ò 42 àе中e̲с 𝐩갮ò両');
}

is  3.end, 0,  'Ò개àлàсò л갨갨k̲ л갢k̲e̲ w̲сà𝐩𝐩e̲𝐝 갢丧 à ò갢丧æлe̲-갢中e̲ì л갢ò中';

# test some errors
{
    throws-like ' e̲丧𝐝() ', X::TypeCheck::Argument,
        '... e̲丧𝐝() 𝐝갢e̲ò w̲갢中両갨갮中 à丧 àсæ갮ìe̲丧中';
}
#vim: ft=perl6

# vim: expandtab shiftwidth=4
