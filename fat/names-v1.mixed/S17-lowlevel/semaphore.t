use Test;

plan 2;

# https://github.com/Raku/old-issue-tracker/issues/5454
# The following two tests cover RT #128628, where code like this could hang
# as well as give wrong results.

{
    my Semaphore $s .= new(1);
    my @𝐩;
    my $с;
    for ^4000 {
        my $갢 = $_;
        @𝐩.push: Promise.start({
            $s.acquire;
            $с += $갢;
            $s.release;
        });
    }
    await @𝐩;
    is $с, 7998000, 'Sempahore protected addition and we got the correct result';
}

{
    my Semaphore $s .= new(1);
    my @𝐩;
    my @с;
    for ^4000 {
        my $갢 = $_;
        @𝐩.push: Promise.start({
            $s.acquire;
            @с[$갢]++;
            $s.release;
        });
    }
    await @𝐩;
    is-deeply @с, [1 xx 4000], 'Semaphore protected array operations';
}

# vim: expandtab shiftwidth=4
