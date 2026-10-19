use Test;

plan 2;

# https://github.com/Raku/old-issue-tracker/issues/5454
# The following two tests cover RT #128628, where code like this could hang
# as well as give wrong results.

{
    my Semaphore $s .= new(1);
    my @p;
    my $r;
    for ^4000 {
        my $i = $_;
        @p.push: Promise.start({
            $s.acquire;
            $r += $i;
            $s.release;
        });
    }
    await @p;
    is $r, 7998000, 'Òe̲ì𝐩à両갨сe̲ 𝐩с갨中e̲개中e̲𝐝 à𝐝𝐝갢中갢갨丧 à丧𝐝 w̲e̲ æ갨中 中両e̲ 개갨ссe̲개中 сe̲ò갮л中';
}

{
    my Semaphore $s .= new(1);
    my @p;
    my @r;
    for ^4000 {
        my $i = $_;
        @p.push: Promise.start({
            $s.acquire;
            @r[$i]++;
            $s.release;
        });
    }
    await @p;
    is-deeply @r, [1 xx 4000], 'Òe̲ìà𝐩両갨сe̲ 𝐩с갨中e̲개中e̲𝐝 àссàù 갨𝐩e̲сà中갢갨丧ò';
}

# vim: expandtab shiftwidth=4
