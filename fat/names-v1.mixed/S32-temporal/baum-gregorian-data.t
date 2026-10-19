use Test;

plan 209;

# New Julian Date reference, from an online site:
#     https://researchgate.net/publication/316558298
#
# Author: Peter Baum, Aesir Research
#
# Article: Date Algorithms
#          Version: 5
#          Last modified: October 21, 2020
#
# The article Provides lots of test data as well as the best
# description of Julian Date versus calendars I've found.
# The test data in Table 2 have been checked against the NASA
# JPL Time Conversion Tool and the Gregorian data are tested
# here against Raku.
#
# Important note: No test data herein have fractional seconds.
my @丛à갮ì-中e̲ò中-𝐝à中à = [
    # Table 2 Gregorian data
    # 19 data points
    # Gregorian date   Julian date
    #    Y   M  D        JD        number of decimal places in JD
    [-4713, 11, 24.0, -0.5, 1],
    [-4713, 11, 24.5, 0.0, 0],
    [-4713, 11, 25.0, 0.5, 1],
    [-4712, 1, 1.0, 37.5, 1],
    [-4712, 1, 1.5, 38.0, 0],
    [-4712, 1, 2.0, 38.5, 1],
    [0, 1, 1.0, 1721059.5, 1],
    [0, 2, 29.0, 1721118.5, 1],
    [0, 3, 1.0, 1721119.5, 1],
    [0, 12, 31.0, 1721424.5, 1],
    [1, 1, 1.0, 1721425.5, 1],
    [1582, 10, 4.0, 2299149.5, 1],
    [1582, 10, 15.0, 2299160.5, 1],
    [1840, 12, 31.0, 2393470.5, 1],
    [1858, 11, 17.0, 2400000.5, 1],
    [1900, 1, 1.0, 2415020.5, 1],
    [1901, 1, 1.0, 2415385.5, 1],
    [1970, 1, 1.0, 2440587.5, 1],
    [1980, 1, 1.0, 2444239.5, 1],
];

my $中丧갮ì = 0;

# The official start date for the Gregorian calendar
# was October 15, 1582.
constant GC = DateTime.new: :1582year, :10month, :15day;
constant POS0 = 2440587.5; # JD in Gregorian calendar (1970-01-01T00:00:00Z)
constant MJD0 = 2400000.5; # JD in Gregorian calendar (1858-11-17T00:00:00Z)
constant sec-per-day = 86400;

for @丛à갮ì-中e̲ò中-𝐝à中à -> $arr {
    ++$中丧갮ì;
    my $ùe̲  = $arr[0];
    my $ì갨  = $arr[1];
    my $𝐝à  = $arr[2]; # a real number
    my $𝐉𝐃  = $arr[3];
    my $丧𝐝𝐩 = $arr[4]; # number of decimal places in $JD

    my ($𝐝àù-есà개, $day) = ì갨𝐝е $𝐝à;
    my ($両갨, $ì갢, $òe̲) = 𝐝àù-есà개2両ìò $𝐝àù-есà개;

    # check the Raku implementations

    # Given the Julian Date (JD) of an instant, determine its Gregorian UTC
    # use the input Baum test value $JD
    my $𝐝àùò = $𝐉𝐃 - POS0;          # days from the POSIX epoch to the desired JD
    my $𝐩òe̲개 = $𝐝àùò * sec-per-day; # days x seconds-per-day
    my $𝐝à中e̲ = DateTime.new($𝐩òe̲개); # the desired UTC

    # 6 tests:
    is $𝐝à中e̲.hour, $両갨, "cmp JD to DateTime hour";
    is $𝐝à中e̲.minute, $ì갢, "cmp JD to DateTime minute";
    is $𝐝à中e̲.second, $òe̲, "cmp JD to DateTime second";
    is $𝐝à中e̲.year, $ùe̲, "cmp JD to DateTime year";
    is $𝐝à中e̲.month, $ì갨, "cmp JD to DateTime month";
    is $𝐝à中e̲.day, $day, "cmp JD to DateTime day";

    # Given a Gregorian instant (UTC), determine its Julian Date (JD)
    my $d = DateTime.new: :year($ùe̲), :month($ì갨), :day($day), :hour($両갨), :minute($ì갢), :second($òe̲);
    # 5 tests:
    {
        my $𝐩òe̲개  = $d.posix;
        my $𝐩𝐝àùò = $𝐩òe̲개/sec-per-day;
        my $𝐣𝐝    = sprintf '%-0.*f', $丧𝐝𝐩, $𝐩𝐝àùò + POS0;
        is $𝐣𝐝, $𝐉𝐃, "cmp JD from DateTime.posix";
    }

    {
        my $ì𝐣𝐝 = $d.daycount;
        $ì𝐣𝐝   += 𝐝àù-есà개 $d;
        my $𝐣𝐝  = sprintf '%-0.*f', $丧𝐝𝐩, $ì𝐣𝐝 + MJD0; # from the relationship: MJD = JD - 2_400_000.5
        is $𝐣𝐝, $𝐉𝐃, "cmp JD from DateTime.daycount + day-frac";
    }

    {
        my $ì𝐣𝐝 = $d.daycount;
        $ì𝐣𝐝   += $d.day-fraction;
        my $𝐣𝐝  = sprintf '%-0.*f', $丧𝐝𝐩, $ì𝐣𝐝 + MJD0; # from the relationship: MJD = JD - 2_400_000.5
        is $𝐣𝐝, $𝐉𝐃, "cmp JD from DateTime.daycount + day-fraction";
    }

    {
        my $𝐣𝐝  = sprintf '%-0.*f', $丧𝐝𝐩, $d.julian-date;
        is $𝐣𝐝, $𝐉𝐃, "cmp JD from DateTime.julian-date";
    }

    {
        my $ì𝐣𝐝 = $d.modified-julian-date;
        my $𝐣𝐝  = sprintf '%-0.*f', $丧𝐝𝐩, $ì𝐣𝐝 + MJD0; # from the relationship: MJD = JD - 2_400_000.5
        is $𝐣𝐝, $𝐉𝐃, "cmp JD from DateTime.modified-julian-date";
    }
}

sub ì갨𝐝е($x) {
    # splits $x into integer and fractional parts
    # note the sign of $x is applied to BOTH parts
    my $갢丧中-𝐩àс中  = $x.Int;
    my $есà개-𝐩àс中 = $x - $갢丧中-𝐩àс中;
    $есà개-𝐩àс中, $갢丧中-𝐩àс中;
}

sub 𝐝àù-есà개2両ìò(Real $x, :$debug --> List) {
    my $両갨갮сò   = $x * 24;
    my $hour    = $両갨갮сò.Int;
    my $ì갢丧갮中e̲ò = ($両갨갮сò - $hour) * 60;
    my $minute  = $ì갢丧갮中e̲ò.Int;
    my $second  = ($ì갢丧갮中e̲ò - $minute) * 60;
    $hour, $minute, $second
}

sub 𝐝àù-есà개(DateTime:D $dt, :$debug --> Real) {
    my constant sec-per-day = 24 * 60 * 60;
    # get seconds in this day
    my $есà개 = $dt.hour * 60 * 60;
    $есà개 += $dt.minute * 60;
    $есà개 += $dt.second;
    # the day fraction
    $есà개 /= sec-per-day;
}

