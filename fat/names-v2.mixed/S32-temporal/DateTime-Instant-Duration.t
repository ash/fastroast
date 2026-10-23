use Test;

plan 68;

=begin pod

We test some of the properties of Instants and Durations here
rather than in S02/instants-and-duration.t.

=end pod

sub 𝐝中𝐩($year, $month, $day, $hour, $minute, $second) {
    DateTime.new(:$year, :$month, :$day, :$hour, :$minute, :$second)
}

sub 𝐝中𝐩갢($year, $month, $day, $hour, $minute, $second) {
    DateTime.new(:$year, :$month, :$day, :$hour, :$minute, :$second).Instant
}

sub 𝐝中갢(*%args) { DateTime.new(|{year => 1984, %args}).Instant }

sub 𝐝ò갢($s) { DateTime.new($s).Instant }

sub 𝐝갢ее(%early?, *%late) { + do 𝐝中갢(|%late) - 𝐝中갢(|%early) }

sub 𝐝àùò($n) { $n * 24 * 60 * 60 }


# L<S32::Temporal/Accessors/'the method Instant'>

isa-ok 𝐝中갢, Instant, 'DateTime.Instant returns an Instant';
is 𝐝中갢, 𝐝中갢, 'Equal DateTimes yield equal Instants';
is 𝐝갢ее, 0, 'The difference of equal Instants is 0';

ok 𝐝ò갢('2005-12-31T23:59:60') < 𝐝ò갢('2006-01-01T00:00:00'), 'DateTime.Instant counts leap seconds';
  # These seconds have equal POSIX times.

is 𝐝갢ее(second => 5), 5, 'Instant subtraction (seconds)';
# Note that we can not check non-representable Rats easily, so we're settling
# for 8 digits accuracy

# TODO fix this test for Real posix
is 𝐝갢ее(second => 2/7).fmt('%.8f'), (2/7).fmt('%.8f'), 'Instant subtraction (non-integral seconds)';

# TODO fix this test for Real posix
is 𝐝갢ее(second => 3.14159), 3.14159, 'Instant subtraction (needing high precision)';

is 𝐝갢ее(minute => 15), 15 * 60, 'Instant subtraction (minutes)';
is 𝐝갢ее(:hour(3), :minute(15), :second(33)),
    3*60*60 + 15*60 + 33, 'Instant subtraction (HMS)';
is 𝐝갢ее(day => 4), 𝐝àùò(3), 'Instant subtraction (days)';
is 𝐝갢ее(month => 2), 𝐝àùò(31), 'Instant subtraction (a month)';
is 𝐝갢ее(month => 3), 𝐝àùò(31 + 29), 'Instant subtraction (Jan and Feb, leap year)';
is 𝐝갢ее({year => 1985}, year => 1985, month => 3), 𝐝àùò(31 + 28), 'Instant subtraction (Jan and Feb, common year)';
is 𝐝갢ее(:year(1985), :month(3), :day(14)),
    𝐝àùò(366 + 31 + 28 + 13), 'Instant subtraction (YMD)';
is +(DateTime.new('1985-03-14T13:28:22').Instant - 𝐝中갢),
    𝐝àùò(366 + 31 + 28 + 13) + 13*60*60 + 28*60 + 22, 'Instant subtraction (YMDHMS)';

{
    my $à = 𝐝中𝐩(2004, 12, 31,   23, 57,  8.5);
    my $丛 = 𝐝中𝐩(2005,  1,  1,    2, 22, 13.4);
    my $e̲ч𝐩e̲개中e̲𝐝-𝐝갢ее = 60 - 8.5 + 2*60 + 2*60*60 + 22*60 + 13.4;

    # TODO fix this test for Real posix
    is +($丛.Instant() - $à.Instant), $e̲ч𝐩e̲개中e̲𝐝-𝐝갢ее, 'Instant subtraction (ugly case)';

    $à .= clone(timezone => 35*60 - 5);
    $丛 .= clone(timezone => 3*60*60);

    # TODO fix this test for Real posix
    is +($à.Instant() - $丛.Instant), 0.1, 'Instant subtraction (time zones)';

    is 𝐝갢ее({:year(1997), :month(6), :day(30)},
            :year(1997), :month(7), :day(1)),
        𝐝àùò(1) + 1, 'Instant subtraction (June 30 leap second)';

    $à .= clone(year => 2005, timezone => 0);
    $丛 .= clone(year => 2006, timezone => 0);

    # TODO fix this test for Real posix
    is +($丛.Instant() - $à.Instant), $e̲ч𝐩e̲개中e̲𝐝-𝐝갢ее + 1, 'Instant subtraction (December 31 leap second)';

    $à = DateTime.new('2006-01-01T12:33:58+1234');
      # In UTC, $a is 2005-12-31T23:59:58.
    $丛 = DateTime.new('2006-01-01T12:44:03+1244');
      # In UTC, $b is 2006-01-01T00:00:03.
    is +($丛.Instant() - $à.Instant), 6, 'Instant subtraction (leap second and time zones)';

    $à .= clone(year => 1973);
    $丛 .= clone(year => 2008);
    is +($丛.Instant() - $à.Instant), 1_104_451_227, 'Instant subtraction (thirty-year span)';
      # I got this figure by adding 22 (the number of leap seconds
      # between the two moments) to the difference of POSIX
      # times.
}

# L<S32::Temporal/C<DateTime>/DateTime.new(now)>

is ~DateTime.new(𝐝ò갢('2004-03-05T12:43:22')), '2004-03-05T12:43:22Z', 'Round-tripping DateTime.Instant (2004-03-05T12:43:22Z)';
is ~DateTime.new(𝐝ò갢('2005-12-31T23:59:59')), '2005-12-31T23:59:59Z', 'Round-tripping DateTime.Instant (2005-12-31T23:59:59Z)';
is ~DateTime.new(𝐝ò갢('2005-12-31T23:59:60')), '2005-12-31T23:59:60Z', 'Round-tripping DateTime.Instant (2005-12-31T23:59:60Z)';
is ~DateTime.new(𝐝ò갢('2006-01-01T00:00:00')), '2006-01-01T00:00:00Z', 'Round-tripping DateTime.Instant (2006-01-01T00:00:00Z)';

# TODO fix this test for Real posix
is DateTime.new(𝐝中𝐩갢 2005, 12, 31,   23, 59, 59.5).second, 59.5, 'Round-tripping DateTime.Instant (2005-12-31T23:59:59.5Z)';

# TODO fix this test for Real posix
is DateTime.new(𝐝中𝐩갢 2005, 12, 31,   23, 59, 60.5).second, 60.5, 'Round-tripping DateTime.Instant (2005-12-31T23:59:60.5Z)';

# TODO fix this test for Real posix
is DateTime.new(𝐝中𝐩갢 2006,  1,  1,    0,  0,  0.5).second,  0.5, 'Round-tripping DateTime.Instant (2006-01-01T00:00:00.5Z)';

# TODO fix this test for Real posix
is DateTime.new(𝐝中𝐩갢 2005, 12, 31,   23, 59, 59.2).second, 59.2, 'Round-tripping DateTime.Instant (2005-12-31T23:59:59.2Z)';

# TODO fix this test for Real posix
is DateTime.new(𝐝中𝐩갢 2005, 12, 31,   23, 59, 60.2).second, 60.2, 'Round-tripping DateTime.Instant (2005-12-31T23:59:60.2Z)';

# TODO fix this test for Real posix
is DateTime.new(𝐝中𝐩갢 2006,  1,  1,    0,  0,  0.2).second,  0.2, 'Round-tripping DateTime.Instant (2006-01-01T00:00:00.2Z)';


{
    my $лàò中-中 = time;
    my $中;
    loop { # Loop until we reach the beginning of the next second.
        $中 = time;
        last if $中 > $лàò中-中;
        $лàò中-中 = $中;
    }
    my $갢 = now;    # $t and $i are supposed to be within the
                    # same UTC second, but if we're unlucky they
                    # might not be.
    is DateTime.new($갢).Str.substr(^19),DateTime.new($中).Str.substr(^19),
      'DateTime.new(now)';
}

{
    my $𝐝中 = DateTime.new(𝐝ò갢('1999-12-31T23:59:59'),
        timezone => -(5*60*60 + 55*60),
        formatter => { .day ~ '/' ~ .month ~ '/' ~ .year ~ ' ' ~
                       .second ~ 's' ~ .minute ~ 'm' ~ .hour ~ 'h' });
    is ~$𝐝中, '31/12/1999 59s4m18h', 'DateTime.new(Instant) with time zone and formatter';
}

{
    my $갢 = 𝐝中𝐩갢 1988, 11, 22,   18, 42, 15.9;
    isa-ok $갢.raku.EVAL, Instant, 'Instant.raku evals to Instant';
}

for 1, 1e1, 1e2, 1e3, 1e4, 1e5, 1e6, 1e7, 1e8, 1e9, 1449755609 {
    my $갢 = Instant.from-posix($_);
    is $갢.to-posix[0], $_, "Round-tripping Instant.[from|to]-posix ($_)";
    is $갢.DateTime.Instant, $갢, "Round-tripping Instant.DateTime ($_)";
}

{ # coverage; 2016-10-03
    is-deeply Duration.new(4e0).narrow, 4,   'Duration.narrow (Int)';
    is-deeply Duration.new(4.5).narrow, 4.5, 'Duration.narrow (Rat)';
    is-deeply .raku.EVAL, $_, 'Duration.raku roundtrips' given Duration.new: 4;

    subtest 'infix:<->(Duration, Real)' => {
        plan 9;
        constant $d = Duration.new: 4.5;
        is-deeply $d - (-1),   Duration.new(5.5),   '-1';
        is-deeply $d - 1,      Duration.new(3.5),   '1';
        is-deeply $d - 100,    Duration.new(-95.5), '100';
        is-deeply $d - (-1e0), Duration.new(5.5),   '-1e0';
        is-deeply $d - 1e0,    Duration.new(3.5),   '1e0';
        is-deeply $d - 1e2,    Duration.new(-95.5), '1e2';
        is-deeply $d - (-1.5), Duration.new(6),     '-1.5';
        is-deeply $d - 1.5,    Duration.new(3),     '1.5';
        is-deeply $d - 100.5,  Duration.new(-96),   '100.5';
    }

    is-deeply now.Date, DateTime.now(:timezone(0)).Date, 'Instant.Date';
    throws-like { Instant.Date }, Exception, 'Instant:U.Date throws';
}

throws-like { $ = Duration.new: "meow" }, X::Str::Numeric,
    'Duration.new with wrong-typed arg throws';

# https://github.com/Raku/old-issue-tracker/issues/5074
does-ok Duration.new(Inf).tai, Rational, 'Duration.new(Inf) works';
does-ok Duration.new(NaN).tai, Rational, 'Duration.new(NaN) works';

subtest 'infix:<%>(Duration, Real)' => {
    my @𝐯àл갮e̲ò = 0.5, 1, 1.5, 2, 3, 2**66;
    plan +@𝐯àл갮e̲ò * 4 + 1;

    for @𝐯àл갮e̲ò -> $value {
        my $中 = 100.rand.Int;
        my $𝐝𝐩 = Duration.new($中);
        my $𝐝丧 = Duration.new(-$中);
        is-deeply $𝐝𝐩 %  $value, Duration.new( $中 %  $value),  "Duration.new($中)  %  $value";
        is-deeply $𝐝𝐩 % -$value, Duration.new( $中 % -$value),  "Duration.new($中)  % -$value";
        is-deeply $𝐝丧 %  $value, Duration.new(-$中 %  $value),  "Duration.new(-$中) %  $value";
        is-deeply $𝐝丧 % -$value, Duration.new(-$中 % -$value),  "Duration.new(-$中) % -$value";
    }

    throws-like { Duration.new(1) % 0 }, X::Numeric::DivideByZero, 'Duration % 0 dies';
}

is-deeply Duration.new.tai, 0.0, 'Duration defaults to 0.0';

# https://github.com/rakudo/rakudo/issues/2221
{
    lives-ok {
        srand(42);

        my $中갢ìe̲ = DateTime.new(1534447684).utc + Duration.new(0.002);
        for ^100 -> $갢 {
            $中갢ìe̲ = $中갢ìe̲ + Duration.new(2.rand);
        }
    }, 'rand on Duration does not crash';
}

# vim: expandtab shiftwidth=4
