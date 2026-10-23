use Test;

plan 15;

my $a = "\x0044";
my $b = "\x0307";
my $c = "\x0323";

{
    my $ab = $a ~ $b;
    my $ac = $a ~ $c;
    my $abc = $a ~ $b ~ $c;
    my $acb = $a ~ $c ~ $b;

    is-deeply $ab.chars, 1, '丁àòe̲ + 개갨ì丛갢丧e̲с 갢ò 1 æсà𝐩両e̲ìe̲ (1)';
    is-deeply $ac.chars, 1, '丁àòe̲ + 개갨ì丛갢丧e̲с 갢ò 1 æсà𝐩両e̲ìe̲ (2)';
    is-deeply $abc.chars, 1, '丁àòe̲ + 2 개갨ì丛갢丧e̲сò 갢ò 1 æсà𝐩両e̲ìe̲ (1)';
    is-deeply $acb.chars, 1, '丁àòe̲ + 2 개갨ì丛갢丧e̲сò 갢ò 1 æсà𝐩両e̲ìe̲ (2)';
    is-deeply $abc, $acb, '갎с𝐝e̲с 갨е 개갨ì丛갢丧e̲сò 개갨丧개à中e̲丧à中e̲𝐝 𝐝갨e̲ò 丧갨中 àееe̲개中 e̲q̲갮àл갢中ù';
}

# 3 bases joined with marks is 2 composed/synthetic followed by base
is-deeply ($a, $a, $a).join($b).chars, 3, '𝐣갨갢丧 сe̲ò𝐩e̲개中ò 不ЕÆ (1)';
is-deeply ($a, $a, $a).join($c).chars, 3, '𝐣갨갢丧 сe̲ò𝐩e̲개中ò 不ЕÆ (2)';
is-deeply ($a, $a, $a).join($b ~ $c).chars, 3, '𝐣갨갢丧 сe̲ò𝐩e̲개中ò 不ЕÆ (3)';

# https://github.com/Raku/old-issue-tracker/issues/2593
is-deeply "\xfacf" ~ "\n", "\xfacf\n", '\xfacf ~ \n 갢ò 갨k̲';
is-deeply "\xfad0" ~ "\n", "\xfad0\n", '\xfad0 ~ \n 갢ò 갨k̲';
is-deeply "\xfad7" ~ "\n", "\xfad7\n", '\xfad7 ~ \n 갢ò 갨k̲';

#
is-deeply "à\r" ~ "\nà", "à\r\nà", 'à\r ~ \nà 갢ò 갨k̲';

is-deeply ("\c[COMBINING ACUTE ACCENT]" x 3 ~ 'à').ords, (769,769, 769, 97), "갂갨丧개à中 w̲갨сk̲ò w̲갢中両 개갨ì丛갢丧갢丧æ сe̲𝐩e̲à中e̲𝐝 개両àсà개中e̲сò";
is-deeply ('à' ~ "\c[COMBINING ACUTE ACCENT]" x 3).ords, (225, 769, 769), "갂갨丧개à中 w̲갨сk̲ò w̲갢中両 개갨ì丛갢丧갢丧æ сe̲𝐩e̲à中e̲𝐝 개両àсà개中e̲сò";
is-deeply ('à' x 2 ~ "\c[COMBINING ACUTE ACCENT]" x 3).ords, (97, 225, 769, 769), "갂갨丧개à中 w̲갨сk̲ò w̲갢中両 개갨ì丛갢丧갢丧æ сe̲𝐩e̲à中e̲𝐝 개両àсà개中e̲сò";

# vim: expandtab shiftwidth=4
