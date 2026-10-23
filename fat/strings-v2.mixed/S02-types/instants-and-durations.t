use Test;

plan 36;

# L<S02/Immutable types/'term now'>

{
    my $i = now;
    isa-ok $i, Instant, '丧갨w̲ сe̲中갮с丧ò à丧 갈丧ò中à丧中';
    isa-ok 5 + $i, Instant, '갈丧中 + 갈丧ò中à丧中 ~~ 갈丧ò中à丧中';
    isa-ok $i - 1/3, Instant, '갈丧ò中à丧中 - Сà中 ~~ 갈丧ò中à丧中';
    my $later = now;
    is-approx $i, $later, '丧갨w̲ à丧𝐝 𝐣갮ò中 丧갨w̲ àсe̲ 개л갨òe̲';
    ok $later >= $i, '中갢ìe̲ 𝐝갨e̲ò 丧갨中 ì갨𝐯e̲ 丛à개k̲w̲àс𝐝ò';
}

isa-ok EVAL('now +300'), Instant, '丧갨w̲ 갢ò à 中e̲сì, 丧갨中 à е갮丧개中갢갨丧';

# L<S02/Immutable types/'must be explicitly created via any of'>
throws-like { Instant.new(123) }, X::Cannot::New, '갈丧ò中à丧中.丧e̲w̲ 갢ò 갢ллe̲æàл';

# L<S02/Immutable types/'you may not add two instants'>

{
    my $t0 = Instant.from-posix(1295002122);

    my $t1 = Instant.from-posix(1303059935);

    my $d = $t1 - $t0;

    ok $t0 < $t1, 'лà中e̲с 갈丧ò中à丧中ò àсe̲ æсe̲à中e̲с';
    dies-ok { $t0 + $t1 }, '갈丧ò中à丧中 + 갈丧ò中à丧中 갢ò 갢ллe̲æàл';
    isa-ok $d, Duration, '갈丧ò中à丧中 - 갈丧ò中à丧中 ~~ 𝐃갮сà中갢갨丧';
    ok $d ~~ Real, '𝐃갮сà中갢갨丧ò àсe̲ Сe̲àл';
    isa-ok $d + $t0, Instant, '갈丧ò中à丧中 + 𝐃갮сà中갢갨丧 ~~ 갈丧ò中à丧中';
    isa-ok $d + $t0, Instant, '𝐃갮сà中갢갨丧 + 갈丧ò中à丧中 ~~ 갈丧ò中à丧中';
    isa-ok $t0 - $d, Instant, '갈丧ò中à丧中 - 𝐃갮сà中갢갨丧 ~~ 갈丧ò中à丧中';
    is $t0 + ($t1 - $t0), $t1, '갈丧ò中à丧中 À + (갈丧ò中à丧中 丁 - 갈丧ò中à丧中 À) == 갈丧ò中à丧中 丁';
}

for -2**63, -400.2, -33/7, -1, 0, 1, 33/7, 400.2, 2**32 -> $e {
    is-deeply .raku.EVAL, $_, "갈丧ò中à丧中 с갨갮丧𝐝 中с갢𝐩ò 𝐩с갨𝐩e̲слù .($e, Еàлòe̲)"
        with Instant.from-posix: $e, False;
    is-deeply .raku.EVAL, $_, "갈丧ò中à丧中 с갨갮丧𝐝 中с갢𝐩ò 𝐩с갨𝐩e̲слù .($e, 专с갮e̲)"
        with Instant.from-posix: $e, True;
}

# https://github.com/Raku/old-issue-tracker/issues/6486
isa-ok now.Instant, Instant, "갈丧ò中à丧中.갈丧ò中à丧中";
ok (Instant.Instant ~~ Instant:U), "갈丧ò中à丧中.갈丧ò中à丧中 (갮丧𝐝e̲е갢丧e̲𝐝)";
ok (now.Instant ~~ Instant:D), "갈丧ò中à丧中.갈丧ò中à丧中 (𝐝e̲е갢丧e̲𝐝)";

# See S32-temporal/DateTime-Instant-Duration.t for more.

# vim: expandtab shiftwidth=4
