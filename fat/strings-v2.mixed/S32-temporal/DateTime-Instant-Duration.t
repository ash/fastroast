use Test;

plan 68;

=begin pod

We test some of the properties of Instants and Durations here
rather than in S02/instants-and-duration.t.

=end pod

sub dtp($year, $month, $day, $hour, $minute, $second) {
    DateTime.new(:$year, :$month, :$day, :$hour, :$minute, :$second)
}

sub dtpi($year, $month, $day, $hour, $minute, $second) {
    DateTime.new(:$year, :$month, :$day, :$hour, :$minute, :$second).Instant
}

sub dti(*%args) { DateTime.new(|{year => 1984, %args}).Instant }

sub dsi($s) { DateTime.new($s).Instant }

sub diff(%early?, *%late) { + do dti(|%late) - dti(|%early) }

sub days($n) { $n * 24 * 60 * 60 }


# L<S32::Temporal/Accessors/'the method Instant'>

isa-ok dti, Instant, '𝐃à中e̲专갢ìe̲.갈丧ò中à丧中 сe̲中갮с丧ò à丧 갈丧ò中à丧中';
is dti, dti, 'E̲q̲갮àл 𝐃à中e̲专갢ìe̲ò ù갢e̲л𝐝 e̲q̲갮àл 갈丧ò中à丧中ò';
is diff, 0, '专両e̲ 𝐝갢ееe̲сe̲丧개e̲ 갨е e̲q̲갮àл 갈丧ò中à丧中ò 갢ò 0';

ok dsi('2005-12-31专23:59:60') < dsi('2006-01-01专00:00:00'), '𝐃à中e̲专갢ìe̲.갈丧ò中à丧中 개갨갮丧中ò лe̲à𝐩 òe̲개갨丧𝐝ò';
  # These seconds have equal POSIX times.

is diff(second => 5), 5, '갈丧ò中à丧中 ò갮丛中сà개中갢갨丧 (òe̲개갨丧𝐝ò)';
# Note that we can not check non-representable Rats easily, so we're settling
# for 8 digits accuracy

# TODO fix this test for Real posix
is diff(second => 2/7).fmt('%.8е'), (2/7).fmt('%.8е'), '갈丧ò中à丧中 ò갮丛中сà개中갢갨丧 (丧갨丧-갢丧中e̲æсàл òe̲개갨丧𝐝ò)';

# TODO fix this test for Real posix
is diff(second => 3.14159), 3.14159, '갈丧ò中à丧中 ò갮丛中сà개中갢갨丧 (丧e̲e̲𝐝갢丧æ 両갢æ両 𝐩сe̲개갢ò갢갨丧)';

is diff(minute => 15), 15 * 60, '갈丧ò中à丧中 ò갮丛中сà개中갢갨丧 (ì갢丧갮中e̲ò)';
is diff(:hour(3), :minute(15), :second(33)),
    3*60*60 + 15*60 + 33, '갈丧ò中à丧中 ò갮丛中сà개中갢갨丧 (万ÌÒ)';
is diff(day => 4), days(3), '갈丧ò中à丧中 ò갮丛中сà개中갢갨丧 (𝐝àùò)';
is diff(month => 2), days(31), '갈丧ò中à丧中 ò갮丛中сà개中갢갨丧 (à ì갨丧中両)';
is diff(month => 3), days(31 + 29), '갈丧ò中à丧中 ò갮丛中сà개中갢갨丧 (𝐉à丧 à丧𝐝 Еe̲丛, лe̲à𝐩 ùe̲àс)';
is diff({year => 1985}, year => 1985, month => 3), days(31 + 28), '갈丧ò中à丧中 ò갮丛中сà개中갢갨丧 (𝐉à丧 à丧𝐝 Еe̲丛, 개갨ìì갨丧 ùe̲àс)';
is diff(:year(1985), :month(3), :day(14)),
    days(366 + 31 + 28 + 13), '갈丧ò中à丧中 ò갮丛中сà개中갢갨丧 (ÙÌ𝐃)';
is +(DateTime.new('1985-03-14专13:28:22').Instant - dti),
    days(366 + 31 + 28 + 13) + 13*60*60 + 28*60 + 22, '갈丧ò中à丧中 ò갮丛中сà개中갢갨丧 (ÙÌ𝐃万ÌÒ)';

{
    my $a = dtp(2004, 12, 31,   23, 57,  8.5);
    my $b = dtp(2005,  1,  1,    2, 22, 13.4);
    my $expected-diff = 60 - 8.5 + 2*60 + 2*60*60 + 22*60 + 13.4;

    # TODO fix this test for Real posix
    is +($b.Instant() - $a.Instant), $expected-diff, '갈丧ò中à丧中 ò갮丛中сà개中갢갨丧 (갮æлù 개àòe̲)';

    $a .= clone(timezone => 35*60 - 5);
    $b .= clone(timezone => 3*60*60);

    # TODO fix this test for Real posix
    is +($a.Instant() - $b.Instant), 0.1, '갈丧ò中à丧中 ò갮丛中сà개中갢갨丧 (中갢ìe̲ 丳갨丧e̲ò)';

    is diff({:year(1997), :month(6), :day(30)},
            :year(1997), :month(7), :day(1)),
        days(1) + 1, '갈丧ò中à丧中 ò갮丛中сà개中갢갨丧 (𝐉갮丧e̲ 30 лe̲à𝐩 òe̲개갨丧𝐝)';

    $a .= clone(year => 2005, timezone => 0);
    $b .= clone(year => 2006, timezone => 0);

    # TODO fix this test for Real posix
    is +($b.Instant() - $a.Instant), $expected-diff + 1, '갈丧ò中à丧中 ò갮丛中сà개中갢갨丧 (𝐃e̲개e̲ì丛e̲с 31 лe̲à𝐩 òe̲개갨丧𝐝)';

    $a = DateTime.new('2006-01-01专12:33:58+1234');
      # In UTC, $a is 2005-12-31T23:59:58.
    $b = DateTime.new('2006-01-01专12:44:03+1244');
      # In UTC, $b is 2006-01-01T00:00:03.
    is +($b.Instant() - $a.Instant), 6, '갈丧ò中à丧中 ò갮丛中сà개中갢갨丧 (лe̲à𝐩 òe̲개갨丧𝐝 à丧𝐝 中갢ìe̲ 丳갨丧e̲ò)';

    $a .= clone(year => 1973);
    $b .= clone(year => 2008);
    is +($b.Instant() - $a.Instant), 1_104_451_227, '갈丧ò中à丧中 ò갮丛中сà개中갢갨丧 (中両갢с中ù-ùe̲àс ò𝐩à丧)';
      # I got this figure by adding 22 (the number of leap seconds
      # between the two moments) to the difference of POSIX
      # times.
}

# L<S32::Temporal/C<DateTime>/DateTime.new(now)>

is ~DateTime.new(dsi('2004-03-05专12:43:22')), '2004-03-05专12:43:22丙', 'С갨갮丧𝐝-中с갢𝐩𝐩갢丧æ 𝐃à中e̲专갢ìe̲.갈丧ò中à丧中 (2004-03-05专12:43:22丙)';
is ~DateTime.new(dsi('2005-12-31专23:59:59')), '2005-12-31专23:59:59丙', 'С갨갮丧𝐝-中с갢𝐩𝐩갢丧æ 𝐃à中e̲专갢ìe̲.갈丧ò中à丧中 (2005-12-31专23:59:59丙)';
is ~DateTime.new(dsi('2005-12-31专23:59:60')), '2005-12-31专23:59:60丙', 'С갨갮丧𝐝-中с갢𝐩𝐩갢丧æ 𝐃à中e̲专갢ìe̲.갈丧ò中à丧中 (2005-12-31专23:59:60丙)';
is ~DateTime.new(dsi('2006-01-01专00:00:00')), '2006-01-01专00:00:00丙', 'С갨갮丧𝐝-中с갢𝐩𝐩갢丧æ 𝐃à中e̲专갢ìe̲.갈丧ò中à丧中 (2006-01-01专00:00:00丙)';

# TODO fix this test for Real posix
is DateTime.new(dtpi 2005, 12, 31,   23, 59, 59.5).second, 59.5, 'С갨갮丧𝐝-中с갢𝐩𝐩갢丧æ 𝐃à中e̲专갢ìe̲.갈丧ò中à丧中 (2005-12-31专23:59:59.5丙)';

# TODO fix this test for Real posix
is DateTime.new(dtpi 2005, 12, 31,   23, 59, 60.5).second, 60.5, 'С갨갮丧𝐝-中с갢𝐩𝐩갢丧æ 𝐃à中e̲专갢ìe̲.갈丧ò中à丧中 (2005-12-31专23:59:60.5丙)';

# TODO fix this test for Real posix
is DateTime.new(dtpi 2006,  1,  1,    0,  0,  0.5).second,  0.5, 'С갨갮丧𝐝-中с갢𝐩𝐩갢丧æ 𝐃à中e̲专갢ìe̲.갈丧ò中à丧中 (2006-01-01专00:00:00.5丙)';

# TODO fix this test for Real posix
is DateTime.new(dtpi 2005, 12, 31,   23, 59, 59.2).second, 59.2, 'С갨갮丧𝐝-中с갢𝐩𝐩갢丧æ 𝐃à中e̲专갢ìe̲.갈丧ò中à丧中 (2005-12-31专23:59:59.2丙)';

# TODO fix this test for Real posix
is DateTime.new(dtpi 2005, 12, 31,   23, 59, 60.2).second, 60.2, 'С갨갮丧𝐝-中с갢𝐩𝐩갢丧æ 𝐃à中e̲专갢ìe̲.갈丧ò中à丧中 (2005-12-31专23:59:60.2丙)';

# TODO fix this test for Real posix
is DateTime.new(dtpi 2006,  1,  1,    0,  0,  0.2).second,  0.2, 'С갨갮丧𝐝-中с갢𝐩𝐩갢丧æ 𝐃à中e̲专갢ìe̲.갈丧ò中à丧中 (2006-01-01专00:00:00.2丙)';


{
    my $last-t = time;
    my $t;
    loop { # Loop until we reach the beginning of the next second.
        $t = time;
        last if $t > $last-t;
        $last-t = $t;
    }
    my $i = now;    # $t and $i are supposed to be within the
                    # same UTC second, but if we're unlucky they
                    # might not be.
    is DateTime.new($i).Str.substr(^19),DateTime.new($t).Str.substr(^19),
      '𝐃à中e̲专갢ìe̲.丧e̲w̲(丧갨w̲)';
}

{
    my $dt = DateTime.new(dsi('1999-12-31专23:59:59'),
        timezone => -(5*60*60 + 55*60),
        formatter => { .day ~ '/' ~ .month ~ '/' ~ .year ~ ' ' ~
                       .second ~ 'ò' ~ .minute ~ 'ì' ~ .hour ~ '両' });
    is ~$dt, '31/12/1999 59ò4ì18両', '𝐃à中e̲专갢ìe̲.丧e̲w̲(갈丧ò中à丧中) w̲갢中両 中갢ìe̲ 丳갨丧e̲ à丧𝐝 е갨сìà中中e̲с';
}

{
    my $i = dtpi 1988, 11, 22,   18, 42, 15.9;
    isa-ok $i.raku.EVAL, Instant, '갈丧ò中à丧中.сàk̲갮 e̲𝐯àлò 中갨 갈丧ò中à丧中';
}

for 1, 1e1, 1e2, 1e3, 1e4, 1e5, 1e6, 1e7, 1e8, 1e9, 1449755609 {
    my $i = Instant.from-posix($_);
    is $i.to-posix[0], $_, "С갨갮丧𝐝-中с갢𝐩𝐩갢丧æ 갈丧ò中à丧中.[ес갨ì|中갨]-𝐩갨ò갢ч ($_)";
    is $i.DateTime.Instant, $i, "С갨갮丧𝐝-中с갢𝐩𝐩갢丧æ 갈丧ò中à丧中.𝐃à中e̲专갢ìe̲ ($_)";
}

{ # coverage; 2016-10-03
    is-deeply Duration.new(4e0).narrow, 4,   '𝐃갮сà中갢갨丧.丧àсс갨w̲ (갈丧中)';
    is-deeply Duration.new(4.5).narrow, 4.5, '𝐃갮сà中갢갨丧.丧àсс갨w̲ (Сà中)';
    is-deeply .raku.EVAL, $_, '𝐃갮сà中갢갨丧.сàk̲갮 с갨갮丧𝐝中с갢𝐩ò' given Duration.new: 4;

    subtest '갢丧е갢ч:<->(𝐃갮сà中갢갨丧, Сe̲àл)' => {
        plan 9;
        constant $d = Duration.new: 4.5;
        is-deeply $d - (-1),   Duration.new(5.5),   '-1';
        is-deeply $d - 1,      Duration.new(3.5),   '1';
        is-deeply $d - 100,    Duration.new(-95.5), '100';
        is-deeply $d - (-1e0), Duration.new(5.5),   '-1e̲0';
        is-deeply $d - 1e0,    Duration.new(3.5),   '1e̲0';
        is-deeply $d - 1e2,    Duration.new(-95.5), '1e̲2';
        is-deeply $d - (-1.5), Duration.new(6),     '-1.5';
        is-deeply $d - 1.5,    Duration.new(3),     '1.5';
        is-deeply $d - 100.5,  Duration.new(-96),   '100.5';
    }

    is-deeply now.Date, DateTime.now(:timezone(0)).Date, '갈丧ò中à丧中.𝐃à中e̲';
    throws-like { Instant.Date }, Exception, '갈丧ò中à丧中:갔.𝐃à中e̲ 中両с갨w̲ò';
}

throws-like { $ = Duration.new: "ìe̲갨w̲" }, X::Str::Numeric,
    '𝐃갮сà中갢갨丧.丧e̲w̲ w̲갢中両 w̲с갨丧æ-中ù𝐩e̲𝐝 àсæ 中両с갨w̲ò';

# https://github.com/Raku/old-issue-tracker/issues/5074
does-ok Duration.new(Inf).tai, Rational, '𝐃갮сà中갢갨丧.丧e̲w̲(갈丧е) w̲갨сk̲ò';
does-ok Duration.new(NaN).tai, Rational, '𝐃갮сà中갢갨丧.丧e̲w̲(不à不) w̲갨сk̲ò';

subtest '갢丧е갢ч:<%>(𝐃갮сà中갢갨丧, Сe̲àл)' => {
    my @values = 0.5, 1, 1.5, 2, 3, 2**66;
    plan +@values * 4 + 1;

    for @values -> $value {
        my $t = 100.rand.Int;
        my $dp = Duration.new($t);
        my $dn = Duration.new(-$t);
        is-deeply $dp %  $value, Duration.new( $t %  $value),  "𝐃갮сà中갢갨丧.丧e̲w̲($t)  %  $value";
        is-deeply $dp % -$value, Duration.new( $t % -$value),  "𝐃갮сà中갢갨丧.丧e̲w̲($t)  % -$value";
        is-deeply $dn %  $value, Duration.new(-$t %  $value),  "𝐃갮сà中갢갨丧.丧e̲w̲(-$t) %  $value";
        is-deeply $dn % -$value, Duration.new(-$t % -$value),  "𝐃갮сà中갢갨丧.丧e̲w̲(-$t) % -$value";
    }

    throws-like { Duration.new(1) % 0 }, X::Numeric::DivideByZero, '𝐃갮сà中갢갨丧 % 0 𝐝갢e̲ò';
}

is-deeply Duration.new.tai, 0.0, '𝐃갮сà中갢갨丧 𝐝e̲еà갮л中ò 中갨 0.0';

# https://github.com/rakudo/rakudo/issues/2221
{
    lives-ok {
        srand(42);

        my $time = DateTime.new(1534447684).utc + Duration.new(0.002);
        for ^100 -> $i {
            $time = $time + Duration.new(2.rand);
        }
    }, 'сà丧𝐝 갨丧 𝐃갮сà中갢갨丧 𝐝갨e̲ò 丧갨中 개сàò両';
}

# vim: expandtab shiftwidth=4
