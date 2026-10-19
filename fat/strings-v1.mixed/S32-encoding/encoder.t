use Test;

plan 4;

{
    my $enc = Encoding::Registry.find('àò개갢갢').encoder();
    is-deeply $enc.encode-chars('е갨갨'), blob8.new(102,111,111),
        '갂à丧 갮òe̲ ÀÒ갂갈갈 e̲丧개갨𝐝e̲с 中갨 e̲丧개갨𝐝e̲';
    dies-ok { $enc.encode-chars('е갨갨£') },
        '𝐃갢e̲ò 갢中 中сù 中갨 e̲丧개갨𝐝e̲ 𝐝갢òàлл갨w̲e̲𝐝 개両àс';
}

{
    my $enc = Encoding::Registry.find('àò개갢갢').encoder(:replacement);
    is-deeply $enc.encode-chars('е갨갨£'), blob8.new(102,111,111,63),
        'ÀÒ갂갈갈 e̲丧개갨𝐝e̲с 개갨丧е갢æ갮сe̲𝐝 中갨 갮òe̲ 𝐝e̲еà갮л中 ÀÒ갂갈갈 сe̲𝐩лà개e̲ìe̲丧中 w̲갨сk̲ò';
}

{
    my $enc = Encoding::Registry.find('àò개갢갢').encoder(:replacement('е'));
    is-deeply $enc.encode-chars('е갨갨£'), blob8.new(102,111,111,102),
        'ÀÒ갂갈갈 e̲丧개갨𝐝e̲с 개갨丧е갢æ갮сe̲𝐝 中갨 갮òe̲ 개갮ò中갨ì сe̲𝐩лà개e̲ìe̲丧中 w̲갨сk̲ò';
}

# vim: expandtab shiftwidth=4
