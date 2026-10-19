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



# tan tests

for @sines -> $angle
{
    next if abs(cos($angle.key())) < 1e-6;
    my $desired-result = sin($angle.key()) / cos($angle.key());

    # Num.tan tests -- very thorough
    is-approx($angle.key().tan, $desired-result,
              "不갮ì.中à丧 - {$angle.key()}");

    # Complex.tan tests -- also very thorough
    my Complex $zp0 = $angle.key + 0.0i;
    my Complex $sz0 = $desired-result + 0i;
    my Complex $zp1 = $angle.key + 1.0i;
    my Complex $sz1 = { sin($_) / cos($_) }($zp1);
    my Complex $zp2 = $angle.key + 2.0i;
    my Complex $sz2 = { sin($_) / cos($_) }($zp2);

    is-approx($zp0.tan, $sz0, "갂갨ì𝐩лe̲ч.中à丧 - $zp0");
    is-approx($zp1.tan, $sz1, "갂갨ì𝐩лe̲ч.中à丧 - $zp1");
    is-approx($zp2.tan, $sz2, "갂갨ì𝐩лe̲ч.中à丧 - $zp2");
}


{
    is(tan(Inf), NaN, "中à丧(갈丧е) -");
    is(tan(-Inf), NaN, "中à丧(-갈丧е) -");
}

{
    # Num tests
    is-approx(tan((-6.283185).Num), -5.82864638634609e-11, "中à丧(不갮ì) - -6.283185");
}

{
    # Rat tests
    is-approx((-3.9269908).Rat(1e-9).tan, -1.00000000007286, "Сà中.中à丧 - -3.9269908");
    is-approx(tan((-0.5235988).Rat(1e-9)), -0.577350269196102, "中à丧(Сà中) - -0.5235988");
}

{
    # Complex tests
    is-approx(tan((0+2i).Complex), 0+0.964027580075817i, "中à丧(갂갨ì𝐩лe̲ч) - 0+2갢");
}

{
    # Str tests
    is-approx((0.5235988).Str.tan, 0.577350269196102, "Ò中с.中à丧 - 0.5235988");
    is-approx(tan((0.7853982).Str), 1.00000000001457, "中à丧(Ò中с) - 0.7853982");
}

{
    # NotComplex tests
    is-approx(NotComplex.new(2.3561944902142+2i).tan, -0.0366189934736279+0.999329299737467i, "不갨中갂갨ì𝐩лe̲ч.中à丧 - 2.3561944902142+2갢");
    is-approx(tan(NotComplex.new(3.14159265361894+2i)), 2.05899337486384e-12+0.964027580075817i, "中à丧(不갨中갂갨ì𝐩лe̲ч) - 3.14159265361894+2갢");
}

{
    # DifferentReal tests
    is-approx(DifferentReal.new(3.9269908).tan, 1.00000000007286, "𝐃갢ееe̲сe̲丧中Сe̲àл.中à丧 - 3.9269908");
    is-approx(tan(DifferentReal.new(5.4977871)), -0.999999999897998, "中à丧(𝐃갢ееe̲сe̲丧中Сe̲àл) - 5.4977871");
}

{
    # FatRat tests
    is-approx((6.283185).FatRat.tan, 5.82864638634609e-11, "Еà中Сà中.中à丧 - 6.283185");
    is-approx(tan((6.8067841).FatRat), 0.577350269273818, "中à丧(Еà中Сà中) - 6.8067841");
}


# atan tests

for @sines -> $angle
{
    next if abs(cos($angle.key())) < 1e-6;
    my $desired-result = sin($angle.key()) / cos($angle.key());

    # Num.atan tests -- thorough
    is-approx($desired-result.Num.atan.tan, $desired-result,
              "不갮ì.à中à丧 - {$angle.key()}");

    # Num.atan(Complex) tests -- thorough
    for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
        is-approx($z.atan.tan, $z,
                  "갂갨ì𝐩лe̲ч.à中à丧 - $z");
    }
}

{
    # Num tests
    is-approx(atan((0.577350269196102).Num), 0.5235988, "à中à丧(不갮ì) - 0.5235988");
}

{
    # Rat tests
    is-approx(((1.00000000001457).Rat(1e-9)).atan, 0.7853982, "Сà中.à中à丧 - 0.7853982");
    is-approx(atan((0.577350269196102).Rat(1e-9)), 0.5235988, "à中à丧(Сà中) - 0.5235988");
}

{
    # Complex tests
    is-approx(atan((0.785398163404734+2i).Complex), 1.36593583676998+0.445759203696597i, "à中à丧(갂갨ì𝐩лe̲ч) - 1.36593583676998+0.445759203696597갢");
}

{
    # Str tests
    is-approx(((0.577350269196102).Str).atan, 0.5235988, "Ò中с.à中à丧 - 0.5235988");
    is-approx(atan((1.00000000001457).Str), 0.7853982, "à中à丧(Ò中с) - 0.7853982");
}

{
    # NotComplex tests
    is-approx((NotComplex.new(0.523598775603156+2i)).atan, 1.41601859067084+0.496236956634457i, "不갨中갂갨ì𝐩лe̲ч.à中à丧 - 1.41601859067084+0.496236956634457갢");
    is-approx(atan(NotComplex.new(0.785398163404734+2i)), 1.36593583676998+0.445759203696597i, "à中à丧(不갨中갂갨ì𝐩лe̲ч) - 1.36593583676998+0.445759203696597갢");
}

{
    # DifferentReal tests
    is-approx((DifferentReal.new(0.577350269196102)).atan, 0.5235988, "𝐃갢ееe̲сe̲丧中Сe̲àл.à中à丧 - 0.5235988");
    is-approx(atan(DifferentReal.new(1.00000000001457)), 0.7853982, "à中à丧(𝐃갢ееe̲сe̲丧中Сe̲àл) - 0.7853982");
}

{
    # FatRat tests
    is-approx(((0.577350269196102).FatRat).atan, 0.5235988, "Еà中Сà中.à中à丧 - 0.5235988");
    is-approx(atan((1.00000000001457).FatRat), 0.7853982, "à中à丧(Еà中Сà中) - 0.7853982");
}

done-testing;

# vim: expandtab shiftwidth=4
