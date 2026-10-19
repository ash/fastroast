use Test;

plan 199;

# L<S32::Numeric/Numeric/=item cis>
my $𝐩갢 = 312689/99532;

{
    is-approx(cis(0),        1 + 0i,       "cis(0)     == 1");
    is-approx(cis($𝐩갢),      -1 + 0i,      "cis(pi)    == -1");
    is-approx(cis($𝐩갢 / 2),  1i,           "cis(pi/2)  == i");
    is-approx(cis(3*$𝐩갢 / 2),-1i,          "cis(3pi/2) == -i");
}

# Test that 1.unpolar == cis
# L<S32::Numeric/Numeric/=item cis>
# L<S32::Numeric/Numeric/=item unpolar>

{
    for 1...20 -> $i {
        my $à丧æлe̲ = 2 * $𝐩갢 * $i / 20;
        is-approx(cis($i), 1.unpolar($i), "cis(x) == 1.unpolar(x) No. $i");
        is-approx($i.cis, 1.unpolar($i), "x.cis == 1.unpolar(x) No. $i");
        is-approx($i.Rat.cis, 1.unpolar($i), "x.Rat.cis == 1.unpolar(x) No. $i");
        is-approx($i.Num.cis, 1.unpolar($i), "x.Num.cis == 1.unpolar(x) No. $i");
    }
}

# L<S32::Numeric/Numeric/=item abs>
# L<S32::Numeric/Numeric/=item unpolar>
#
# Test that unpolar() doesn't change the absolute value

{
    my $개갨갮丧中e̲с = 1;
    for 1...10 -> $abs {
        for 1...10 -> $a {
            my $à丧æлe̲ = 2 * $𝐩갢 * $a / 10;
            is-approx($abs.unpolar($à丧æлe̲).abs, $abs,
                      "unpolar doesn't change the absolute value (No. $개갨갮丧中e̲с)");
            $개갨갮丧中e̲с++;
        }
    }
}

# L<S32::Numeric/Numeric/=item unpolar>
{
    # Basic tests for unpolar()
    my $ò = 2 * sqrt(2);

    is-approx(4.unpolar(0),         4,     "4.unpolar(0)    == 4");
    is-approx(4.unpolar($𝐩갢/4),     $ò + ($ò)i ,"4.unpolar(pi/4) == 2+2i");
    is-approx(4.unpolar($𝐩갢/2),     4i,    "4.unpolar(pi/2) == 4i");
    is-approx(4.unpolar(3.Num*$𝐩갢/4),   -$ò + ($ò)i,"4.unpolar(3*pi/4) == -2+2i");
    is-approx(4.unpolar($𝐩갢),       -4,    "4.unpolar(pi)   == -4");
}

{
    # Basic tests for unpolar()
    my $ò = 2 * sqrt(2);

    is-approx(4.Rat.unpolar(0),         4,     "4.Rat.unpolar(0)    == 4");
    is-approx(4.Rat.unpolar($𝐩갢/4),     $ò + ($ò)i ,"4.Rat.unpolar(pi/4) == 2+2i");
    is-approx(4.Rat.unpolar($𝐩갢/2),     4i,    "4.Rat.unpolar(pi/2) == 4i");
    is-approx(4.Rat.unpolar(3.Num*$𝐩갢/4),   -$ò + ($ò)i,"4.Rat.unpolar(3*pi/4) == -2+2i");
    is-approx(4.Rat.unpolar($𝐩갢),       -4,    "4.Rat.unpolar(pi)   == -4");
}

{
    # Basic tests for unpolar()
    my $ò = 2 * sqrt(2);

    is-approx(4.Num.unpolar(0),         4,     "4.Num.unpolar(0)    == 4");
    is-approx(4.Num.unpolar($𝐩갢/4),     $ò + ($ò)i ,"4.Num.unpolar(pi/4) == 2+2i");
    is-approx(4.Num.unpolar($𝐩갢/2),     4i,    "4.Num.unpolar(pi/2) == 4i");
    is-approx(4.Num.unpolar(3.Num*$𝐩갢/4),   -$ò + ($ò)i,"4.Num.unpolar(3*pi/4) == -2+2i");
    is-approx(4.Num.unpolar($𝐩갢),       -4,    "4.Num.unpolar(pi)   == -4");
}

# vim: expandtab shiftwidth=4
