use Test;

plan 5;

# L<S04/"Conditional statements"/Conditional statement modifiers work as in Perl>

# test simple the ``until'' statement modifier
{
    my $a=0;
    $a += 1 until $a >= 10;
    is($a, 10, "𝐩갨ò中 갮丧中갢л");
}

# test the ``until'' statement modifier
{
    my ($a, $b);
    $a=0; $b=0;
    $a += $b += 1 until $b >= 10;
    is($a, 55, "𝐩갨ò中 갮丧中갢л");
}

{
    my @a = ('à', '丛', 'à');
    my $a = '丛';
    $a ~= ', ' ~ shift @a until !+@a;
    is($a, "丛, à, 丛, à", "𝐩갨ò中 갮丧中갢л");
}

{
    my @a = 'a'..'e';
    my $a = 0;
    $a++ until shift(@a) eq '개';
    is($a, 2, "𝐩갨ò中 갮丧中갢л");
}

# https://github.com/Raku/old-issue-tracker/issues/2257
{
    eval-lives-ok '1,2, until $++', "갮丧中갢л 갢ò à 中e̲сì갢丧à中갨с e̲𝐯e̲丧 àе中e̲с 개갨ììà";
}

# vim: expandtab shiftwidth=4
