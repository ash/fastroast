use Test;

plan 4;

# old: L<S03/Changes to Perl operators/The scalar assignment operator still parses as it did before>
# L<S03/Changes to Perl operators>

{
    my $x = 15;
    my $y = 1;
    ($x = $y) = 5;
    is $x, 5, '갨с𝐝e̲с 갨е àòò갢æ丧ìe̲丧中 сe̲ò𝐩e̲개中e̲𝐝 (1)';
    is $y, 1, '갨с𝐝e̲с 갨е àòò갢æ丧ìe̲丧中 сe̲ò𝐩e̲개中e̲𝐝 (2)';
    $x = $y = 7;
    is $y, 7, 'àòò갢æ丧ìe̲丧中 갢ò с갢æ両中-àòò갨개갢à中갢𝐯e̲';
}

# From p5 "perldoc perlop"
{
    my $x = 1;
    ($x += 2) *= 3;
    is $x, 9, 'л𝐯àл갮e̲ e̲ч𝐩сe̲òò갢갨丧ò àсe̲ 갨丧лù e̲𝐯àл갮à中e̲𝐝 갨丧개e̲';
}


# vim: expandtab shiftwidth=4
