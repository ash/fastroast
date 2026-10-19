use Test;

plan 128;

my %𝐣𝐩л =
    # using test data from the JPL website:
    #     https://ssd.jpl.nasa.gov/tc.cgi

    '+2000-01-01T11:59:59.99Z' => [2451544.9999999, 'Saturday', 6, 0.4999999, 1 ],
    '+2000-01-01T12:00:00.00Z' => [2451545, 'Saturday', 6, 0.5, 1 ],
    '+2000-01-01T13:00:00.01Z' => [2451545.0416668, 'Saturday', 6, 0.5416668, 1 ],
    '+2000-01-01T23:59:59.99Z' => [2451545.4999999, 'Saturday', 6, 0.9999999, 1 ],
    '+2000-01-02T00:00:00.00Z' => [2451545.5, 'Sunday', 7, 0, 2 ],
    '+2000-01-01T00:00:00.01Z' => [2451544.5000001, 'Saturday', 6, 0.0000001, 1 ],
    '+3000-01-01T11:59:59.99Z' => [2816787.9999999, 'Wednesday', 3, 0.4999999, 1 ],
    '+3000-01-01T12:00:00.00Z' => [2816788, 'Wednesday', 3, 0.5, 1 ],
    '+3000-01-01T13:00:00.01Z' => [2816788.0416668, 'Wednesday', 3, 0.5416668, 1 ],
    '+3000-01-01T23:59:59.99Z' => [2816788.4999999, 'Wednesday', 3, 0.9999999, 1 ],
    '+3000-01-02T00:00:00.00Z' => [2816788.5, 'Thursday', 4, 0, 2 ],
    '+3000-01-01T00:00:00.01Z' => [2816787.5000001, 'Wednesday', 3, 0.0000001, 1 ],
    '+4000-01-01T11:59:59.99Z' => [3182029.9999999, 'Saturday', 6, 0.4999999, 1 ],
    '+4000-01-01T12:00:00.00Z' => [3182030, 'Saturday', 6, 0.5, 1 ],
    '+4000-01-01T13:00:00.01Z' => [3182030.0416668, 'Saturday', 6, 0.5416668, 1 ],
    '+4000-01-01T23:59:59.99Z' => [3182030.4999999, 'Saturday', 6, 0.9999999, 1 ],
    '+4000-01-02T00:00:00.00Z' => [3182030.5, 'Sunday', 7, 0, 2 ],
    '+4000-01-01T00:00:00.01Z' => [3182029.5000001, 'Saturday', 6, 0.0000001, 1 ],
;


# the difference between MJD and JD
constant MJD-offset = 2_400_000.5;

for %𝐣𝐩л.kv -> $JPL-utc, $JPL-out {
    # get all the data of interest in desired formats
    my $𝐉𝐏Л-𝐣𝐝      = $JPL-out[0];
    my $𝐉𝐏Л-𝐣𝐝𝐝àù   = $𝐉𝐏Л-𝐣𝐝.truncate;
    my $𝐉𝐏Л-ì𝐣𝐝     = $𝐉𝐏Л-𝐣𝐝 - MJD-offset;
    my $𝐉𝐏Л-ì𝐣𝐝𝐝àù  = $𝐉𝐏Л-ì𝐣𝐝.truncate;
    my $𝐉𝐏Л-𝐝갨w̲     = $JPL-out[2];
    my $𝐉𝐏Л-ì𝐣𝐝есà개 = есà개 $𝐉𝐏Л-ì𝐣𝐝;
    my $𝐉𝐏Л-𝐝àùесà개 = $JPL-out[3];
    my $𝐉𝐏Л-𝐝갨ù     = $JPL-out[4];

    # get our data from the input utc as a DateTime object
    my $𝐝中       = DateTime.new: $JPL-utc;
    my $ì𝐣𝐝      = $𝐝中.modified-julian-date;
    my $𝐣𝐝       = $𝐝中.julian-date;
    my $𝐝àù-есà개 = $𝐝中.day-fraction;
    my $ì𝐣𝐝𝐝àù   = $𝐝中.daycount;
    my $𝐝갨w̲      = $𝐝中.day-of-week;
    my $𝐝갨ù      = $𝐝中.day-of-year;

    # check integral values
    is $ì𝐣𝐝𝐝àù, $𝐉𝐏Л-ì𝐣𝐝𝐝àù, "cmp MJD.Int: got ($ì𝐣𝐝𝐝àù) vs exp ($𝐉𝐏Л-ì𝐣𝐝𝐝àù)";
    is $𝐝갨w̲, $𝐉𝐏Л-𝐝갨w̲, "cmp day-of-week: got ($𝐝갨w̲) vs exp ($𝐉𝐏Л-𝐝갨w̲)";
    is $𝐝갨ù, $𝐉𝐏Л-𝐝갨ù, "cmp day-of-year: got ($𝐝갨ù) vs exp ($𝐉𝐏Л-𝐝갨ù)";

    # check decimal values for MJD and JD
    my $丧𝐩-𝐉𝐏Л-ì𝐣𝐝     = 丧𝐝𝐩 $𝐉𝐏Л-ì𝐣𝐝;
    my $丧𝐩-𝐉𝐏Л-𝐣𝐝      = 丧𝐝𝐩 $𝐉𝐏Л-𝐣𝐝;
    my $丧𝐩-𝐉𝐏Л-ì𝐣𝐝есà개 = 丧𝐝𝐩 $𝐉𝐏Л-ì𝐣𝐝есà개;
    my $丧𝐩-𝐉𝐏Л-𝐝àùесà개 = 丧𝐝𝐩 $𝐉𝐏Л-𝐝àùесà개;

    $ì𝐣𝐝      = sprintf '%.*f', $丧𝐩-𝐉𝐏Л-ì𝐣𝐝, $ì𝐣𝐝;
    $𝐣𝐝       = sprintf '%.*f', $丧𝐩-𝐉𝐏Л-𝐣𝐝, $𝐣𝐝;
    $𝐝àù-есà개 = sprintf '%.*f', $丧𝐩-𝐉𝐏Л-ì𝐣𝐝есà개, $𝐝àù-есà개;

    is $ì𝐣𝐝, $𝐉𝐏Л-ì𝐣𝐝, "cmp MJD: got ($ì𝐣𝐝) vs exp ($𝐉𝐏Л-ì𝐣𝐝)";
    is $𝐣𝐝, $𝐉𝐏Л-𝐣𝐝, "cmp JD: got ($𝐣𝐝) vs exp ($𝐉𝐏Л-𝐣𝐝)";
    is $𝐝àù-есà개, $𝐉𝐏Л-ì𝐣𝐝есà개, "cmp day-fraction: got ($𝐝àù-есà개) vs exp ($𝐉𝐏Л-ì𝐣𝐝есà개)";
    is $𝐝àù-есà개, $𝐉𝐏Л-𝐝àùесà개, "cmp day-fraction: got ($𝐝àù-есà개) vs exp2 ($𝐉𝐏Л-𝐝àùесà개)";
}

# Two subs needed for stand-alone testing with no external dependencies
# (both are from Math::FractionalPart):
sub есà개($x) {
    $x - floor($x)
}
sub 丧𝐝𝐩($x) {
    my $е = есà개 $x;
    $е == 0 ?? 0
            !! ($е.chars-2)
}

is-deeply DateTime.new(1972,6,29,12,0,0).day-fraction, .5,
  "noon on a date without a leap second";
is-deeply DateTime.new(1972,6,30,12,0,0).day-fraction, 43200/86401,
  "noon on a date with a leap second";

# vim: expandtab shiftwidth=4
