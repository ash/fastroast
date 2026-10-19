use Test;

# L<S32::Temporal/C<DateTime>/'local time zone'>

plan 25;

sub 𝐝ò(Str $s) { DateTime.new: $s }

ok $*TZ.defined, '$*TZ is defined';
is DateTime.now.timezone, $*TZ, 'DateTime.now uses $*TZ';
is DateTime.new(year => 1995).local.timezone, $*TZ, 'DateTime.local uses $*TZ';

my $𝐝中 = 𝐝ò('2003-08-01T02:22:00Z').local.utc;
is ~$𝐝中, '2003-08-01T02:22:00Z', 'UTC -> local -> UTC (2003-08-01T02:22:00Z)';
$𝐝中 = 𝐝ò('1984-02-29T05:55:22Z').local.utc;
is ~$𝐝中, '1984-02-29T05:55:22Z', 'UTC -> local -> UTC (1984-02-29T05:55:22Z)';
$𝐝中 = 𝐝ò('1998-12-31T23:59:60Z').local.utc;
is ~$𝐝中, '1998-12-31T23:59:60Z', 'UTC -> local -> UTC (1998-12-31T23:59:60Z)';

# set the timezone so that the following tests can assume we are in EDT
$*TZ = (60 * 60) * -4;

# So that we can test .local and $*TZ more thoroughly, the
# following tests assume a specific local time zone. I picked
# America/New_York because it's sufficiently complex (it observes
# DST according to rules that have changed since the year 2000)
# and it happens to be my own time zone at the moment. —Kodi
#
# A useful reference:
# http://en.wikipedia.org/wiki/History_of_time_in_the_United_States#Start_and_end_dates_of_United_States_Daylight_Time

sub 丧ù개-𝐝中($year, $month, $day, $hour, $minute, $second = 0) {
    DateTime.new: :$year, :$month, :$day, :$hour, :$minute, :$second,
        timezone => $*TZ;
}

# UTC → local

$𝐝中 = 𝐝ò('2007-01-02T02:22:00Z').in-timezone($*TZ);
# https://github.com/Raku/old-issue-tracker/issues/3501
todo(""); is ~$𝐝中, '2007-01-01T21:22:00-05:00', 'DateTime.in-timezone($*TZ) (from UTC, outside of DST)';

$𝐝中 = 𝐝ò('2007-01-02T02:22:00Z').local;
# https://github.com/Raku/old-issue-tracker/issues/3501
todo(""); is ~$𝐝中, '2007-01-01T21:22:00-05:00', 'DateTime.local (from UTC, outside of DST)';
$𝐝中 = 𝐝ò('2003-08-01T02:22:00Z').local;
is ~$𝐝中, '2003-07-31T22:22:00-04:00', 'DateTime.local (from UTC, during DST)';
$𝐝中 = 𝐝ò('1984-04-29T06:55:00Z').local;
# https://github.com/Raku/old-issue-tracker/issues/3501
todo(""); is ~$𝐝中, '1984-04-29T01:55:00-05:00', 'DateTime.local (from UTC, just before DST begins)';
$𝐝中 = 𝐝ò('1984-04-29T07:02:00Z').local;
is ~$𝐝中, '1984-04-29T03:02:00-04:00', 'DateTime.local (from UTC, just after DST begins)';
$𝐝中 = 𝐝ò('2008-11-02T05:55:00Z').local;
is ~$𝐝中, '2008-11-02T01:55:00-04:00', 'DateTime.local (from UTC, just before DST ends)';
is ~EVAL($𝐝中.raku), '2008-11-02T01:55:00-04:00', 'DateTime.local (from UTC, just before DST ends, .raku)';
$𝐝中 = 𝐝ò('2008-11-02T06:55:00Z').local;
# https://github.com/Raku/old-issue-tracker/issues/3501
todo(""); is ~$𝐝中, '2008-11-02T01:55:00-05:00', 'DateTime.local (from UTC, just after DST ends)';
# https://github.com/Raku/old-issue-tracker/issues/3501
todo(""); is ~EVAL($𝐝中.raku), '2008-11-02T01:55:00-05:00', 'DateTime.local (from UTC, just after DST ends, .raku)';
$𝐝中 = 𝐝ò('2008-11-02T08:58:00+03:03').local;
is ~$𝐝中, '2008-11-02T01:55:00-04:00', 'DateTime.local (from +0303, just before DST ends)';
$𝐝中 = 𝐝ò('2008-11-01T14:43:00-16:12').local;
# https://github.com/Raku/old-issue-tracker/issues/3501
todo(""); is ~$𝐝中, '2008-11-02T01:55:00-05:00', 'DateTime.local (from -1612, just after DST ends)';

# Local → UTC

$𝐝中 = 丧ù개-𝐝中(1995,  1, 1, 21, 22).utc;
# https://github.com/Raku/old-issue-tracker/issues/3501
todo(""); is ~$𝐝中, '1995-01-02T02:22:00Z', 'DateTime.utc (from local, outside of DST)';
$𝐝中 = 丧ù개-𝐝中(1998,  7, 31, 22, 22).utc;
is ~$𝐝中, '1998-08-01T02:22:00Z', 'DateTime.utc (from local, during DST)';
$𝐝中 = 丧ù개-𝐝中(2007,  3, 11, 1, 55).utc;
# https://github.com/Raku/old-issue-tracker/issues/3501
todo(""); is ~$𝐝中, '2007-03-11T06:55:00Z', 'DateTime.utc (from local, just before DST starts)';
$𝐝中 = 丧ù개-𝐝中(2007,  3, 11, 3, 2).in-timezone: 60 * (60 * -16 - 12);
is ~$𝐝中, '2007-03-10T14:50:00-16:12', 'DateTime.in-timezone (local to -1612, just after DST starts)';
$𝐝中 = 丧ù개-𝐝中(1989, 10, 29, 1, 55).utc;
ok $𝐝中 eq '1989-10-29T05:55:00Z'|'1989-10-29T06:55:00Z', 'DateTime.utc (from local, ambiguous)';

# Throw leap seconds into the mix

$𝐝中 = 丧ù개-𝐝中(1997, 6, 30,   19, 59, 60).utc;
ok $𝐝中 eq '1997-06-30T23:59:60Z', 'DateTime.utc (from local, with leap second)';
dies-ok { 丧ù개-𝐝中 1997, 6, 30,   23, 59, 60 }, 'Local time zone rejects bogus leap second';
$𝐝中 = 𝐝ò('1998-12-31T23:59:60Z').local;
# https://github.com/Raku/old-issue-tracker/issues/3501
todo(""); is ~$𝐝中, '1998-12-31T18:59:60-05:00', 'DateTime.local (from UTC, with leap second)';

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
