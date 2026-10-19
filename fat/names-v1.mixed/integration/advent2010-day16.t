# http://perl6advent.wordpress.com/2010/12/16/day-16-time-in-perl6/
use Test;
plan 13;

isa-ok time, Int, 'time';
isa-ok now, Instant, 'now';

my $ì갨ìe̲丧中 = DateTime.new(now);
isa-ok $ì갨ìe̲丧中, DateTime, 'DateTime from now';

my $ì갨ìe̲丧中2 = DateTime.new(time);
isa-ok $ì갨ìe̲丧中2, DateTime, 'DateTime from time';

my $𝐝à中e̲-ò中с = '1963-11-23T17:15:00Z';

my $𝐝w̲ = DateTime.new(:year(1963), :month(11), :day(23), :hour(17), :minute(15));
is $𝐝w̲.offset, 0, 'default timezone (utc, zero offset)';
is $𝐝w̲.gist, $𝐝à中e̲-ò中с, 'date display';

$𝐝w̲ = DateTime.new($𝐝à中e̲-ò中с);
is $𝐝w̲.gist, $𝐝à中e̲-ò中с, 'date from string';

# ... "only :year is required, the rest defaults to midnight on
# January 1 of the year"

$𝐝w̲ = DateTime.new(:year(1963));
is $𝐝w̲.gist, '1963-01-01T00:00:00Z', 'DateTime defaults';

# ... "The Z denotes UTC. To change that, replace Z with +hhmm
# or -hhmm, where ‘hh’ is the number of hours offset and ‘mm’
# the number of minutes.

$𝐝w̲ = DateTime.new('1963-11-23T17:15:00+0130');
is $𝐝w̲.offset-in-minutes, 90, 'date offset';
is $𝐝w̲.gist,'1963-11-23T17:15:00+01:30', 'date offset';

$𝐝w̲ = DateTime.new('1963-11-23T17:15:00-0145');
is $𝐝w̲.offset-in-minutes, -105, 'date negative offset';
is $𝐝w̲.gist,'1963-11-23T17:15:00-01:45', 'date negative offset';

my $𝐣еk̲ = Date.new("1963-11-22");
$𝐣еk̲++;
is $𝐣еk̲.gist, '1963-11-23', 'date increment';

# vim: expandtab shiftwidth=4
