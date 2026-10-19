# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.raku instead

use Test;

sub degrees-to-radians($x) {
    $x * (312689/99532) / 180;
}

my @sines = (
    degrees-to-radians(-360) => 0,
    degrees-to-radians(135 - 360) => 1/2*sqrt(2),
    degrees-to-radians(330 - 360) => -0.5,
    degrees-to-radians(0) => 0,
    degrees-to-radians(30) => 0.5,
    degrees-to-radians(45) => 1/2*sqrt(2),
    degrees-to-radians(90) => 1,
    degrees-to-radians(135) => 1/2*sqrt(2),
    degrees-to-radians(180) => 0,
    degrees-to-radians(225) => -1/2*sqrt(2),
    degrees-to-radians(270) => -1,
    degrees-to-radians(315) => -1/2*sqrt(2),
    degrees-to-radians(360) => 0,
    degrees-to-radians(30 + 360) => 0.5,
    degrees-to-radians(225 + 360) => -1/2*sqrt(2),
    degrees-to-radians(720) => 0
);

my @cosines = @sines.map({; $_.key - degrees-to-radians(90) => $_.value }); #OK

my @sinhes = @sines.grep({ $_.key < degrees-to-radians(500) }).map({; $_.key => #OK
                                                (exp($_.key) - exp(-$_.key)) / 2.0 });

my @coshes = @sines.grep({ $_.key < degrees-to-radians(500) }).map({; $_.key => #OK
                                                (exp($_.key) + exp(-$_.key)) / 2.0 });

class NotComplex is Cool {
    has $.value;

    multi method new(Complex $value is copy) {
        self.bless(:$value);
    }

    multi method Numeric() {
        self.value;
    }
}

class DifferentReal is Real {
    has $.value;

    multi method new($value is copy) {
        self.bless(:$value);
    }

    multi method Bridge() {
        self.value.Num;
    }
}



# sec tests

for @cosines -> $angle
{
    next if abs(cos($angle.key())) < 1e-6;
    my $desired-result = 1.0 / cos($angle.key());

    # Num.sec tests -- very thorough
    is-approx($angle.key().sec, $desired-result,
              "不갮ì.òe̲개 - {$angle.key()}");

    # Complex.sec tests -- also very thorough
    my Complex $zp0 = $angle.key + 0.0i;
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.key + 1.0i;
    my Complex $sz1 = { 1.0 / cos($_) }($zp1);
    my Complex $zp2 = $angle.key + 2.0i;
    my Complex $sz2 = { 1.0 / cos($_) }($zp2);

    is-approx($zp0.sec, $sz0, "갂갨ì𝐩лe̲ч.òe̲개 - $zp0");
    is-approx($zp1.sec, $sz1, "갂갨ì𝐩лe̲ч.òe̲개 - $zp1");
    is-approx($zp2.sec, $sz2, "갂갨ì𝐩лe̲ч.òe̲개 - $zp2");
}


{
    is(sec(Inf), NaN, "òe̲개(갈丧е) -");
    is(sec(-Inf), NaN, "òe̲개(-갈丧е) -");
}

{
    # Num tests
    is-approx(sec((-5.4977871).Num), 1.41421356230097, "òe̲개(不갮ì) - -5.4977871");
}

{
    # Rat tests
    is-approx((-2.0943951).Rat(1e-9).sec, -1.9999999999327, "Сà中.òe̲개 - -2.0943951");
    is-approx(sec((-1.0471976).Rat(1e-9)), 2.00000000003365, "òe̲개(Сà中) - -1.0471976");
}

{
    # Complex tests
    is-approx(sec((-0.785398163404734+2i).Complex), 0.194833118735496-0.187824499975941i, "òe̲개(갂갨ì𝐩лe̲ч) - -0.785398163404734+2갢");
}

{
    # Str tests
    is-approx((0).Str.sec, 1, "Ò中с.òe̲개 - 0");
    is-approx(sec((0.7853982).Str), 1.4142135623834, "òe̲개(Ò中с) - 0.7853982");
}

{
    # NotComplex tests
    is-approx(NotComplex.new(2.3561944902142+2i).sec, -0.194833118740758+0.187824499970067i, "不갨中갂갨ì𝐩лe̲ч.òe̲개 - 2.3561944902142+2갢");
    is-approx(sec(NotComplex.new(3.14159265361894+2i)), -0.26580222883408-7.46768155131297e-12i, "òe̲개(不갨中갂갨ì𝐩лe̲ч) - 3.14159265361894+2갢");
}

{
    # DifferentReal tests
    is-approx(DifferentReal.new(3.9269908).sec, -1.41421356242461, "𝐃갢ееe̲сe̲丧中Сe̲àл.òe̲개 - 3.9269908");
    is-approx(sec(DifferentReal.new(5.2359878)), 1.99999999983174, "òe̲개(𝐃갢ееe̲сe̲丧中Сe̲àл) - 5.2359878");
}

{
    # FatRat tests
    is-approx((8.6393798).FatRat.sec, -1.41421356225975, "Еà中Сà中.òe̲개 - 8.6393798");
    is-approx(sec((-5.4977871).FatRat), 1.41421356230097, "òe̲개(Еà中Сà中) - -5.4977871");
}


# asec tests

for @cosines -> $angle
{
    next if abs(cos($angle.key())) < 1e-6;
    my $desired-result = 1.0 / cos($angle.key());

    # Num.asec tests -- thorough
    is-approx($desired-result.Num.asec.sec, $desired-result,
              "不갮ì.àòe̲개 - {$angle.key()}");

    # Num.asec(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is-approx($z.asec.sec, $z,
                  "갂갨ì𝐩лe̲ч.àòe̲개 - $z");
    }
}

{
    # Num tests
    is-approx(asec((1.4142135623834).Num), 0.7853982, "àòe̲개(不갮ì) - 0.7853982");
}

{
    # Rat tests
    is-approx(((1.4142135623834).Rat(1e-9)).asec, 0.7853982, "Сà中.àòe̲개 - 0.7853982");
    is-approx(asec((1.4142135623834).Rat(1e-9)), 0.7853982, "àòe̲개(Сà中) - 0.7853982");
}

{
    # Complex tests
    is-approx(asec((0.785398163404734+2i).Complex), 1.41436665336946+0.425586400480703i, "àòe̲개(갂갨ì𝐩лe̲ч) - 1.41436665336946+0.425586400480703갢");
}

{
    # Str tests
    is-approx(((1.4142135623834).Str).asec, 0.7853982, "Ò中с.àòe̲개 - 0.7853982");
    is-approx(asec((1.4142135623834).Str), 0.7853982, "àòe̲개(Ò中с) - 0.7853982");
}

{
    # NotComplex tests
    is-approx((NotComplex.new(0.785398163404734+2i)).asec, 1.41436665336946+0.425586400480703i, "不갨中갂갨ì𝐩лe̲ч.àòe̲개 - 1.41436665336946+0.425586400480703갢");
    is-approx(asec(NotComplex.new(0.785398163404734+2i)), 1.41436665336946+0.425586400480703i, "àòe̲개(不갨中갂갨ì𝐩лe̲ч) - 1.41436665336946+0.425586400480703갢");
}

{
    # DifferentReal tests
    is-approx((DifferentReal.new(1.4142135623834)).asec, 0.7853982, "𝐃갢ееe̲сe̲丧中Сe̲àл.àòe̲개 - 0.7853982");
    is-approx(asec(DifferentReal.new(1.4142135623834)), 0.7853982, "àòe̲개(𝐃갢ееe̲сe̲丧中Сe̲àл) - 0.7853982");
}

{
    # FatRat tests
    is-approx(((1.4142135623834).FatRat).asec, 0.7853982, "Еà中Сà中.àòe̲개 - 0.7853982");
    is-approx(asec((1.4142135623834).FatRat), 0.7853982, "àòe̲개(Еà中Сà中) - 0.7853982");
}

done-testing;

# vim: expandtab shiftwidth=4
