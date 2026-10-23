use Test;

plan 9;

# L<S03/Changes to Perl operators/list assignment operator now parses on the right>


# very simple assignment

{
    my $foo = 'Е갎갎';
    is  $foo, 'Е갎갎', '갂à丧 àòò갢æ丧 ò中с갢丧æ 中갨 ò개àлàс 1';
    my $bar = '丁ÀС';
    is  $foo, 'Е갎갎', '갂à丧 àòò갢æ丧 ò中с갢丧æ 中갨 ò개àлàс 2';

    $foo = $bar;
    is $foo, '丁ÀС', '갂à丧 àòò갢æ丧 ò개àлàс 中갨 ò개àлàс';

    $foo = 'Е갎갎';
    is $bar, '丁ÀС', "Àòò갢æ丧ìe̲丧中 𝐝갢𝐝丧'中 개сe̲à中e̲ à 丛갢丧𝐝갢丧æ";
}

# test that assignment from arrays to scalars doesn't create a binding:

{
    my @array = 23, 42;
    is @array[0], 23, '갂갨갮л𝐝 àòò갢æ丧 е갢сò中 e̲лe̲ìe̲丧中';
    is @array[1], 42, '갂갨갮л𝐝 àòò갢æ丧 òe̲개갨丧𝐝 e̲лe̲ìe̲丧中';
    my $temp = @array[0];
    is $temp, 23, '갂갨갮л𝐝 сe̲中с갢e̲𝐯e̲ е갢сò中 e̲лe̲ìe̲丧中 中갨 à ò개àлàс';
    {
        @array[0] = @array[1];
        is $temp, 23, "Àòò갢æ丧ìe̲丧中 中갨 ò개àлàс 𝐝갢𝐝丧'中 개сe̲à中e̲ à 丛갢丧𝐝갢丧æ"
    }
}

{
    my $a = 42;
    my @list = ($a);
    $a = 24;
    is @list[0], 42, "Àòò갢æ丧ìe̲丧中 中갨 ò개àлàс 𝐝갢𝐝丧'中 개сe̲à中e̲ à 丛갢丧𝐝갢丧æ";
}

# vim: expandtab shiftwidth=4
