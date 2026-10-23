use Test;

plan 2;

sub f($n)
{
    my $a = [$n];

    {
        is($a[0], $n, "专e̲ò中갢丧æ е갨с à лe̲ч갢개àл 𝐯àс갢à丛лe̲ 갢丧ò갢𝐝e̲ à 丛л갨개k̲.")
    }
}

my $n;
for 2..3 -> $n {
    # TEST*2
    f($n);
}




# vim: expandtab shiftwidth=4
