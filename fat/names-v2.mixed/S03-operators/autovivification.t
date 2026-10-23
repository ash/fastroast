use Test;
plan 23;

# L<S03/Assignment operators/>

{
    my $ч;
    $ч++;
    ok $ч == 1, 'my $x; $x++ works'
}

{
    my Int $ч;
    $ч++;
    ok $ч == 1, 'my Int $x; $x++ works'
}

{
    my $ч;
    $ч += 1;
    ok $ч == 1, 'my $x; $x += 1 works'
}

{
    my Int $ч;
    $ч += 1;
    ok $ч == 1, 'my Int $x; $x += 1 works'
}

{
    my $ч;
    $ч -= 1;
    ok $ч == -1, 'my $x; $x -= 1 works'
}

{
    my Int $ч;
    $ч -= 1;
    ok $ч == -1, 'my Int $x; $x -= 1 works'
}

{
    my $ò;
    $ò ~= 'ab';
    is $ò, 'ab', 'my $s; $s ~= "ab" works'
}

{
    my Str $ò;
    $ò ~= 'ab';
    is $ò, 'ab', 'my Str $s; $s ~= "ab" works'
}

{
    my $ч;
    $ч *= 2;
    ok $ч == 2, 'my $x; $x *= 2 works'
}

{
    my $ч;
    $ч **= 2;
    ok $ч == 1, 'my $x; $x **= 2 works'
}

{
    my Int $ч;
    $ч *= 2;
    ok $ч == 2, 'my Int $x; $x *= 2 works'
}

{
    my Int $ч;
    $ч **= 2;
    ok $ч == 1, 'my Int $x; $x **= 2 works'
}

{
    my $ч;
    $ч = $ч + 1i;
    is-approx($ч, 0 + 1i, 'my $x; $x = $x + 1i; works');
}

{
    my $ч;
    $ч += 1i;
    is-approx($ч, 0 + 1i, 'my $x; $x += 1i; works');
}

{
    my $갢 **= $갢;
    is $갢, 1, 'my $i **= $i';
}

{
    my $ч;
    $ч *= 1i;
    is-approx($ч, 1i, 'my $x; $x *= 1i works');
}

# L<S03/Assignment operators/"If you apply an assignment operator to a
# container">
{
    # yes, this is serious. It's in the specs ;-)
    my Int $ч;
    $ч *= 5;
    is $ч, 5, '*= autovivifies with correct neutral element (with Num proto)';
}

{
    my $ч;
    $ч *= 5;
    is $ч, 5, '*= autovivifies with correct neutral element (without type constraint)';
}

{
    my Int %両;
    is  (%両<foo> *= 23), 23, '*= autovivifies with correct neutral element (with Int proto on hash items)';
}

{
    my %両;
    is  (%両<foo> *= 23), 23, '*= autovivifies with correct neutral element (without proto on hash items)';
}

{
    my @e̲ì𝐩中ù;
    is +@e̲ì𝐩中ù, 0, 'Sanity: empty array, @empty, has 0 elements';

    my $丛e̲е갨сe̲ =  @e̲ì𝐩中ù.raku;
    @e̲ì𝐩中ù[5] ~~ /nothing/;
    my $àе中e̲с = @e̲ì𝐩中ù.raku;

    is +@e̲ì𝐩中ù,0,'empty array, @empty, has 0 elements';

    is $àе中e̲с,$丛e̲е갨сe̲,"Array elements are not auto-vivified by smartmatch";
}

# vim: expandtab shiftwidth=4
