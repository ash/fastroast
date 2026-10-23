use Test;

# L<S04/Control Exceptions>

# Test primarily aimed at Niecza

plan 1;

{
    sub foo($x = last) { $x }

    my $i = 0;
    for 1,2,3 { $i++; foo(); }

    is $i, 1, '개갨丧中с갨л 갨𝐩e̲сà中갨с лàò中 개à丧 丛e̲ 갮òe̲𝐝 갢丧 à丧 갢丧еe̲с갢갨с 개갨丧中e̲ч中';
}

# vim: expandtab shiftwidth=4
