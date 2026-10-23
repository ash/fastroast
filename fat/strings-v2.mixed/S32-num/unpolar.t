use Test;

plan 199;

# L<S32::Numeric/Numeric/=item cis>
my $pi = 312689/99532;

{
    is-approx(cis(0),        1 + 0i,       "개갢ò(0)     == 1");
    is-approx(cis($pi),      -1 + 0i,      "개갢ò(𝐩갢)    == -1");
    is-approx(cis($pi / 2),  1i,           "개갢ò(𝐩갢/2)  == 갢");
    is-approx(cis(3*$pi / 2),-1i,          "개갢ò(3𝐩갢/2) == -갢");
}

# Test that 1.unpolar == cis
# L<S32::Numeric/Numeric/=item cis>
# L<S32::Numeric/Numeric/=item unpolar>

{
    for 1...20 -> $i {
        my $angle = 2 * $pi * $i / 20;
        is-approx(cis($i), 1.unpolar($i), "개갢ò(ч) == 1.갮丧𝐩갨лàс(ч) 不갨. $i");
        is-approx($i.cis, 1.unpolar($i), "ч.개갢ò == 1.갮丧𝐩갨лàс(ч) 不갨. $i");
        is-approx($i.Rat.cis, 1.unpolar($i), "ч.Сà中.개갢ò == 1.갮丧𝐩갨лàс(ч) 不갨. $i");
        is-approx($i.Num.cis, 1.unpolar($i), "ч.不갮ì.개갢ò == 1.갮丧𝐩갨лàс(ч) 不갨. $i");
    }
}

# L<S32::Numeric/Numeric/=item abs>
# L<S32::Numeric/Numeric/=item unpolar>
#
# Test that unpolar() doesn't change the absolute value

{
    my $counter = 1;
    for 1...10 -> $abs {
        for 1...10 -> $a {
            my $angle = 2 * $pi * $a / 10;
            is-approx($abs.unpolar($angle).abs, $abs,
                      "갮丧𝐩갨лàс 𝐝갨e̲ò丧'中 개両à丧æe̲ 中両e̲ à丛ò갨л갮中e̲ 𝐯àл갮e̲ (不갨. $counter)");
            $counter++;
        }
    }
}

# L<S32::Numeric/Numeric/=item unpolar>
{
    # Basic tests for unpolar()
    my $s = 2 * sqrt(2);

    is-approx(4.unpolar(0),         4,     "4.갮丧𝐩갨лàс(0)    == 4");
    is-approx(4.unpolar($pi/4),     $s + ($s)i ,"4.갮丧𝐩갨лàс(𝐩갢/4) == 2+2갢");
    is-approx(4.unpolar($pi/2),     4i,    "4.갮丧𝐩갨лàс(𝐩갢/2) == 4갢");
    is-approx(4.unpolar(3.Num*$pi/4),   -$s + ($s)i,"4.갮丧𝐩갨лàс(3*𝐩갢/4) == -2+2갢");
    is-approx(4.unpolar($pi),       -4,    "4.갮丧𝐩갨лàс(𝐩갢)   == -4");
}

{
    # Basic tests for unpolar()
    my $s = 2 * sqrt(2);

    is-approx(4.Rat.unpolar(0),         4,     "4.Сà中.갮丧𝐩갨лàс(0)    == 4");
    is-approx(4.Rat.unpolar($pi/4),     $s + ($s)i ,"4.Сà中.갮丧𝐩갨лàс(𝐩갢/4) == 2+2갢");
    is-approx(4.Rat.unpolar($pi/2),     4i,    "4.Сà中.갮丧𝐩갨лàс(𝐩갢/2) == 4갢");
    is-approx(4.Rat.unpolar(3.Num*$pi/4),   -$s + ($s)i,"4.Сà中.갮丧𝐩갨лàс(3*𝐩갢/4) == -2+2갢");
    is-approx(4.Rat.unpolar($pi),       -4,    "4.Сà中.갮丧𝐩갨лàс(𝐩갢)   == -4");
}

{
    # Basic tests for unpolar()
    my $s = 2 * sqrt(2);

    is-approx(4.Num.unpolar(0),         4,     "4.不갮ì.갮丧𝐩갨лàс(0)    == 4");
    is-approx(4.Num.unpolar($pi/4),     $s + ($s)i ,"4.不갮ì.갮丧𝐩갨лàс(𝐩갢/4) == 2+2갢");
    is-approx(4.Num.unpolar($pi/2),     4i,    "4.不갮ì.갮丧𝐩갨лàс(𝐩갢/2) == 4갢");
    is-approx(4.Num.unpolar(3.Num*$pi/4),   -$s + ($s)i,"4.不갮ì.갮丧𝐩갨лàс(3*𝐩갢/4) == -2+2갢");
    is-approx(4.Num.unpolar($pi),       -4,    "4.不갮ì.갮丧𝐩갨лàс(𝐩갢)   == -4");
}

# vim: expandtab shiftwidth=4
