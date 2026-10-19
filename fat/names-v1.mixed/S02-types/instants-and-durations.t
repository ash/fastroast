use Test;

plan 36;

# L<S02/Immutable types/'term now'>

{
    my $갢 = now;
    isa-ok $갢, Instant, 'now returns an Instant';
    isa-ok 5 + $갢, Instant, 'Int + Instant ~~ Instant';
    isa-ok $갢 - 1/3, Instant, 'Instant - Rat ~~ Instant';
    my $лà中e̲с = now;
    is-approx $갢, $лà中e̲с, 'now and just now are close';
    ok $лà中e̲с >= $갢, 'time does not move backwards';
}

isa-ok EVAL('now +300'), Instant, 'now is a term, not a function';

# L<S02/Immutable types/'must be explicitly created via any of'>
throws-like { Instant.new(123) }, X::Cannot::New, 'Instant.new is illegal';

# L<S02/Immutable types/'you may not add two instants'>

{
    my $中0 = Instant.from-posix(1295002122);

    my $中1 = Instant.from-posix(1303059935);

    my $𝐝 = $中1 - $中0;

    ok $中0 < $中1, 'later Instants are greater';
    dies-ok { $中0 + $中1 }, 'Instant + Instant is illegal';
    isa-ok $𝐝, Duration, 'Instant - Instant ~~ Duration';
    ok $𝐝 ~~ Real, 'Durations are Real';
    isa-ok $𝐝 + $中0, Instant, 'Instant + Duration ~~ Instant';
    isa-ok $𝐝 + $中0, Instant, 'Duration + Instant ~~ Instant';
    isa-ok $中0 - $𝐝, Instant, 'Instant - Duration ~~ Instant';
    is $中0 + ($中1 - $中0), $中1, 'Instant A + (Instant B - Instant A) == Instant B';
}

for -2**63, -400.2, -33/7, -1, 0, 1, 33/7, 400.2, 2**32 -> $e {
    is-deeply .raku.EVAL, $_, "Instant round trips properly .($e, False)"
        with Instant.from-posix: $e, False;
    is-deeply .raku.EVAL, $_, "Instant round trips properly .($e, True)"
        with Instant.from-posix: $e, True;
}

# https://github.com/Raku/old-issue-tracker/issues/6486
isa-ok now.Instant, Instant, "Instant.Instant";
ok (Instant.Instant ~~ Instant:U), "Instant.Instant (undefined)";
ok (now.Instant ~~ Instant:D), "Instant.Instant (defined)";

# See S32-temporal/DateTime-Instant-Duration.t for more.

# vim: expandtab shiftwidth=4
