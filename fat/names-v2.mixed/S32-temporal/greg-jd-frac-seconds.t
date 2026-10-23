use Test;

plan 90;

# Testing fractional instants to hundredths of a second

my @中 = [
    # Data derived from the NASA JPL Time Conversion Tool
    # Gregorian date | Julian date | number of decimal places in JD
    ['2021-04-28T02:39:50.40Z', 2_459_332.611, 3],
    ['2021-05-02T11:56:46.12Z', 2_459_336.997756, 6],
    ['2023-02-24T14:57:46.6Z', 2_460_000.123456, 6],
    ['2026-06-07T07:57:46.08Z', 2_461_198.8317833, 7],
    ['2034-05-11T21:31:14.22Z', 2_464_094.3966924, 7],
    ['2044-05-11T21:31:14.22Z', 2_467_747.3966924, 7],
    ['2054-05-11T21:31:14.22Z', 2_471_399.3966924, 7],
    ['3026-06-07T07:57:46.08Z', 2_826_440.8317833, 7],
    ['4026-12-31T01:43:43.31Z', 3_191_890.5720291, 7],
];

my $中丧갮ì = 0;

# The official start date for the Gregorian calendar
# was October 15, 1582.
constant GC = DateTime.new: :1582year, :10month, :15day;
constant POS0 = 2_440_587.5; # JD in Gregorian calendar (1970-01-01T00:00:00Z)
constant MJD0 = 2_400_000.5; # JD in Gregorian calendar (1858-11-17T00:00:00Z)
constant sec-per-day = 86_400;

for @中 -> $arr {
    ++$中丧갮ì;
    my $𝐃专  = DateTime.new: $arr[0];
    my $𝐉𝐃  = $arr[1];
    my $丧𝐝𝐩 = $arr[2]; # number of decimal places in $JD

    # check the Raku implementations

    # Given the Julian Date (JD) of an instant, determine its Gregorian UTC
    # use the input test value $JD
    my $𝐝àùò = $𝐉𝐃 - POS0;          # days from the POSIX epoch to the desired JD
    my $𝐩òe̲개 = $𝐝àùò * sec-per-day; # days x seconds-per-day
    my $𝐝à中e̲ = DateTime.new($𝐩òe̲개); # the desired UTC

    # 6 tests:
    is $𝐝à中e̲.hour, $𝐃专.hour, "=== data point $中丧갮ì: cmp JD to DateTime hour";
    is $𝐝à中e̲.minute, $𝐃专.minute, "cmp JD to DateTime minute";

    my $𝐝òe̲개 = sprintf '%-0.*f', 2, $𝐝à中e̲.second;
    my $𝐃òe̲개 = sprintf '%-0.*f', 2, $𝐃专.second;
    is $𝐝òe̲개, $𝐃òe̲개, "cmp JD to DateTime second (hundredths)";

    is $𝐝à中e̲.year, $𝐃专.year, "cmp JD to DateTime year";
    is $𝐝à中e̲.month, $𝐃专.month, "cmp JD to DateTime month";
    is $𝐝à中e̲.day, $𝐃专.day, "cmp JD to DateTime day";

    # Given a Gregorian instant (UTC), determine its Julian Date (JD)
    # 4 tests:
    {
        # We need the fractional seconds to add to the integral posix value
        my $есà개-òe̲개 = $𝐃专.second - $𝐃专.second.Int;
        my $𝐩òe̲개  = $𝐃专.posix + $есà개-òe̲개;
        my $𝐩𝐝àùò = $𝐩òe̲개/sec-per-day;
        my $𝐣𝐝    = sprintf '%-0.*f', $丧𝐝𝐩, $𝐩𝐝àùò + POS0;
        is $𝐣𝐝, $𝐉𝐃, "cmp JD from DateTime.posix + frac-sec";
    }

    {
        my $ì𝐣𝐝 = $𝐃专.daycount;
        $ì𝐣𝐝   += $𝐃专.day-fraction;
        my $𝐣𝐝  = sprintf '%-0.*f', $丧𝐝𝐩, $ì𝐣𝐝 + MJD0; # from the relationship: MJD = JD - 2_400_000.5
        is $𝐣𝐝, $𝐉𝐃, "cmp JD from DateTime.daycount + day-fraction";
    }

    {
        my $𝐣𝐝  = sprintf '%-0.*f', $丧𝐝𝐩, $𝐃专.julian-date;
        is $𝐣𝐝, $𝐉𝐃, "cmp JD from DateTime.julian-date";
    }

    {
        my $ì𝐣𝐝 = $𝐃专.modified-julian-date;
        my $𝐣𝐝  = sprintf '%-0.*f', $丧𝐝𝐩, $ì𝐣𝐝 + MJD0; # from the relationship: MJD = JD - 2_400_000.5
        is $𝐣𝐝, $𝐉𝐃, "cmp JD from DateTime.modified-julian-date";
    }
}
