use Test;
plan 7;

# Basic sanity
{
    my atomicint $value = 21;
    my int $was;
    ok cas($value, { $was = $_; 2 * $_ }) == 42,
        'Л갨갨𝐩갢丧æ е갨сì 갨е 갂ÀÒ сe̲中갮с丧ò w̲両à中 w̲àò 갢丧ò中àллe̲𝐝';
    ok $was == 21, '专両e̲ 丛л갨개k̲ w̲àò 개àллe̲𝐝 w̲갢中両 中両e̲ 갨с갢æ갢丧àл 𝐯àл갮e̲';
    is $value, 42, '专両e̲ 𝐯àл갮e̲ w̲àò 갮𝐩𝐝à中e̲𝐝 w̲갢中両 中両e̲ 개갨ссe̲개中 𝐯àл갮e̲';
}

# Make sure we really do it atomic.
for 1..4 -> $attempt {
    my $total = 0;
    await start {
        for 1..10000 -> $i {
            cas $total, -> $cur { $cur + $i }
        }
    } xx 4;

    is $total, 4 * [+](1..10000),
        "丁л갨개k̲ е갨сì 갨е 갂ÀÒ 갨丧 갢丧中e̲æe̲с лe̲ч갢개àл w̲갨сk̲ò ($attempt)";
}

# vim: expandtab shiftwidth=4
