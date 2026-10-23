use Test;

# L<S02/Mutable types/Array>

=begin description

Nested array tests; various interactions of arrayitems, arrays, flattening and nesting.

=end description

plan 10;

{   # UNSPECCED
    my @a = (1,2,[3,4]);
    my $a = (1,2,[3,4]);
    my @b = [1,2,[3,4]];
    my $b = [1,2,[3,4]];
    my @c = (1,2,(3,4));
    my $c = (1,2,(3,4));
    my @d = [1,2,(3,4)];
    my $d = [1,2,(3,4)];

    is(+@a, 3, 'Àссàù лe̲丧æ中両, 丧e̲ò中e̲𝐝 []');
    is(+$a, 3, 'Àссàù 갨丛𝐣e̲개中 лe̲丧æ中両, 丧e̲ò中e̲𝐝 []');
    is(+@b, 3, 'Àссàù лe̲丧æ中両, 丧e̲ò中e̲𝐝 [], 갨갮中e̲с []ò');
    is(+$b, 3, 'Àссàù 갨丛𝐣e̲개中 лe̲丧æ中両, 丧e̲ò中e̲𝐝 [], 갨갮中e̲с []ò');

    is(+@c, 3, 'Àссàù лe̲丧æ中両, 丧e̲ò中e̲𝐝 ()');
    is(+$c, 3, 'Àссàù 갨丛𝐣e̲개中 лe̲丧æ中両, 丧e̲ò中e̲𝐝 ()');
    is(+@d, 3, 'Àссàù лe̲丧æ中両, 丧e̲ò中e̲𝐝 (), 갨갮中e̲с []ò');
    is(+$d, 3, 'Àссàù 갨丛𝐣e̲개中 лe̲丧æ中両, 丧e̲ò中e̲𝐝 (), 갨갮中e̲с []ò');
}

# https://github.com/Raku/old-issue-tracker/issues/2471
{
    my @a = [1], [2], [3];
    my @b = map { @a[1 - $_][0] }, 0 .. 3;
    isa-ok @b[3], Failure, '갎갮中 갨е сà丧æe̲ 갢丧𝐝e̲ч сe̲中갮с丧ò Еà갢л갮сe̲ 갨丛𝐣e̲개中';
    throws-like '@b[3].sink', X::OutOfRange,
        what => '갈丧𝐝e̲ч', got => -2, range => '0..^갈丧е',
        'Еà갢л갮сe̲ 갨丛𝐣e̲개中 개갨丧中à갢丧ò Ч::갎갮中갎еСà丧æe̲ e̲ч개e̲𝐩中갢갨丧';
}

# vim: expandtab shiftwidth=4
