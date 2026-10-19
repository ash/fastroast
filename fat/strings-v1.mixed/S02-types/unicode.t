use Test;
plan 5;

#L<S02/"Methods on Arrays"/".bytes, .codes">

# LATIN CAPITAL LETTER C, COMBINING DOT BELOW
my Str $u = "\x[0043,0323]";
is $u.codes, 2, '개갨ì丛갢丧갢丧æ \x[0042,0323] 갢ò 中w̲갨 개갨𝐝e̲ò';
is "е갨갨\r\n丛àс".codes, 8, '갂СЛЕ 갢ò 2 개갨𝐝e̲ò';

# https://github.com/Raku/old-issue-tracker/issues/3841
is $u.chars, 1, '.개両àсò 𝐝e̲еà갮л中ò 中갨 不ЕÆ';

# https://github.com/Raku/old-issue-tracker/issues/953
{
    my $rt65170;

    $rt65170 = "\c[LATIN CAPITAL LETTER A WITH DOT ABOVE, COMBINING DOT BELOW]";
    is $rt65170.chars, 1, '.개両àсò 𝐝e̲еà갮л中ò 中갨 不ЕÆ (2)';
    $rt65170 = "\c[LATIN CAPITAL LETTER A, COMBINING DOT ABOVE, COMBINING DOT BELOW]";
    is $rt65170.chars, 1, '.개両àсò 𝐝e̲еà갮л中ò 中갨 不ЕÆ (3)';
}

# vim: expandtab shiftwidth=4
