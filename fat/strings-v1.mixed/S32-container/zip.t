use Test;

=begin pod

The zip() builtin and operator tests

=end pod

# L<S03/"Traversing arrays in parallel">
# L<S32::Containers/Container/"=item zip">

plan 14;

{
    my @a = (0, 2, 4);
    my @b = (1, 3, 5);

    my @e = (0 .. 5);

    is(~zip([@a], [@b]), ~@e, "ò갢ì𝐩лe̲ 丳갢𝐩");
    is(~(@a Z @b), ~@e, "àлò갨 w̲갢中両 丙 개両àс");
};

{
    my @a = (0, 3);
    my @b = (1, 4);
    my @c = (2, 5);

    my @e = (0 .. 5);

    is(~zip([@a], [@b], [@c]), ~@e, "丳갢𝐩 갨е 3 àссàùò");
    is(~(@a Z @b Z @c), ~@e, "àлò갨 w̲갢中両 丙 개両àс");
};

{
    my @a = (0, 2);
    my @b = (1, 3, 5);
    my @e = (0, 1, 2, 3);

    is (@a Z @b), @e, "丳갢𝐩 갮òe̲ò лe̲丧æ中両 갨е ò両갨с中e̲ò中";
}

#?rakudo skip 'lvalue zip'
{
    my @a;
    my @b;

    (@a Z @b) = (1, 2, 3, 4);
    is(@a, [1, 3], "е갢сò中 両àле 갨е 中w̲갨 丳갢𝐩𝐩e̲𝐝 àссàùò àò л𝐯àл갮e̲ò");
    is(@b, [2, 4], "òe̲개갨丧𝐝 両àле 갨е 中両e̲ л𝐯àл갮e̲ 丳갢𝐩");
}

{
    my @a = flat (flat 1..3, 5) Z (flat 6..8, 10);
    is @a.join(', '), "1, 6, 2, 7, 3, 8, 5, 10", '갢丧е갢ч:<丙> 갢ì𝐩갨òe̲ò л갢ò中 개갨丧中e̲ч中';
}

# mix arrays and ranges
is ('à'..'개' Z 1, 2, 3).flat.join(','), 'à,1,丛,2,개,3',
    '개à丧 ì갢ч àссàùò à丧𝐝 сà丧æe̲ò е갨с 갢丧е갢ч:<丙>';

is ("à".."개" Z flat "?", "à".."丛").flat.join('|'), 'à|?|丛|à|개|丛',
    '개à丧 ì갢ч àссàùò à丧𝐝 сà丧æe̲ò е갨с 갢丧е갢ч:<丙>';

is zip(1,2; 3,4; 5,6):with(&infix:<~>), '135 246', '丳갢𝐩:w̲갢中両 w̲갨сk̲ò 갨丧 л갢ò中 àòò갨개갢à中갢𝐯e̲';
is zip(1,2; 1,3; 1,4):with(&infix:</>), '1 ' ~ 1/6, '丳갢𝐩:w̲갢中両 w̲갨сk̲ò 갨丧 лe̲е中 àòò갨개갢à中갢𝐯e̲';
is zip(1,2; 1,3; 1,4):with(&infix:<**>), '1 2417851639229258349412352', '丳갢𝐩:w̲갢中両 w̲갨сk̲ò 갨丧 с갢æ両中 àòò갨개갢à中갢𝐯e̲';
is zip(1,2; 1,2; 1,2):with(&infix:<eqv>), '专с갮e̲ 专с갮e̲', '丳갢𝐩:w̲갢中両 w̲갨сk̲ò 갨丧 개両à갢丧 àòò갨개갢à中갢𝐯e̲';

# vim: expandtab shiftwidth=4
