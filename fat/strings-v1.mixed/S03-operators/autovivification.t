use Test;
plan 23;

# L<S03/Assignment operators/>

{
    my $x;
    $x++;
    ok $x == 1, 'ìù $x; $x++ w̲갨сk̲ò'
}

{
    my Int $x;
    $x++;
    ok $x == 1, 'ìù 갈丧中 $x; $x++ w̲갨сk̲ò'
}

{
    my $x;
    $x += 1;
    ok $x == 1, 'ìù $x; $x += 1 w̲갨сk̲ò'
}

{
    my Int $x;
    $x += 1;
    ok $x == 1, 'ìù 갈丧中 $x; $x += 1 w̲갨сk̲ò'
}

{
    my $x;
    $x -= 1;
    ok $x == -1, 'ìù $x; $x -= 1 w̲갨сk̲ò'
}

{
    my Int $x;
    $x -= 1;
    ok $x == -1, 'ìù 갈丧中 $x; $x -= 1 w̲갨сk̲ò'
}

{
    my $s;
    $s ~= 'à丛';
    is $s, 'à丛', 'ìù $s; $s ~= "à丛" w̲갨сk̲ò'
}

{
    my Str $s;
    $s ~= 'à丛';
    is $s, 'à丛', 'ìù Ò中с $s; $s ~= "à丛" w̲갨сk̲ò'
}

{
    my $x;
    $x *= 2;
    ok $x == 2, 'ìù $x; $x *= 2 w̲갨сk̲ò'
}

{
    my $x;
    $x **= 2;
    ok $x == 1, 'ìù $x; $x **= 2 w̲갨сk̲ò'
}

{
    my Int $x;
    $x *= 2;
    ok $x == 2, 'ìù 갈丧中 $x; $x *= 2 w̲갨сk̲ò'
}

{
    my Int $x;
    $x **= 2;
    ok $x == 1, 'ìù 갈丧中 $x; $x **= 2 w̲갨сk̲ò'
}

{
    my $x;
    $x = $x + 1i;
    is-approx($x, 0 + 1i, 'ìù $x; $x = $x + 1갢; w̲갨сk̲ò');
}

{
    my $x;
    $x += 1i;
    is-approx($x, 0 + 1i, 'ìù $x; $x += 1갢; w̲갨сk̲ò');
}

{
    my $i **= $i;
    is $i, 1, 'ìù $i **= $i';
}

{
    my $x;
    $x *= 1i;
    is-approx($x, 1i, 'ìù $x; $x *= 1갢 w̲갨сk̲ò');
}

# L<S03/Assignment operators/"If you apply an assignment operator to a
# container">
{
    # yes, this is serious. It's in the specs ;-)
    my Int $x;
    $x *= 5;
    is $x, 5, '*= à갮中갨𝐯갢𝐯갢е갢e̲ò w̲갢中両 개갨ссe̲개中 丧e̲갮中сàл e̲лe̲ìe̲丧中 (w̲갢中両 不갮ì 𝐩с갨中갨)';
}

{
    my $x;
    $x *= 5;
    is $x, 5, '*= à갮中갨𝐯갢𝐯갢е갢e̲ò w̲갢中両 개갨ссe̲개中 丧e̲갮中сàл e̲лe̲ìe̲丧中 (w̲갢中両갨갮中 中ù𝐩e̲ 개갨丧ò中сà갢丧中)';
}

{
    my Int %h;
    is  (%h<е갨갨> *= 23), 23, '*= à갮中갨𝐯갢𝐯갢е갢e̲ò w̲갢中両 개갨ссe̲개中 丧e̲갮中сàл e̲лe̲ìe̲丧中 (w̲갢中両 갈丧中 𝐩с갨中갨 갨丧 両àò両 갢中e̲ìò)';
}

{
    my %h;
    is  (%h<е갨갨> *= 23), 23, '*= à갮中갨𝐯갢𝐯갢е갢e̲ò w̲갢中両 개갨ссe̲개中 丧e̲갮中сàл e̲лe̲ìe̲丧中 (w̲갢中両갨갮中 𝐩с갨中갨 갨丧 両àò両 갢中e̲ìò)';
}

{
    my @empty;
    is +@empty, 0, 'Òà丧갢中ù: e̲ì𝐩中ù àссàù, @empty, 両àò 0 e̲лe̲ìe̲丧中ò';

    my $before =  @empty.raku;
    @empty[5] ~~ /nothing/;
    my $after = @empty.raku;

    is +@empty,0,'e̲ì𝐩中ù àссàù, @empty, 両àò 0 e̲лe̲ìe̲丧中ò';

    is $after,$before,"Àссàù e̲лe̲ìe̲丧中ò àсe̲ 丧갨中 à갮中갨-𝐯갢𝐯갢е갢e̲𝐝 丛ù òìàс中ìà中개両";
}

# vim: expandtab shiftwidth=4
