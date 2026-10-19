# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.raku instead

use Test;

sub 𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò($x) {
    $x * (312689/99532) / 180;
}

my @ò갢丧e̲ò = (
    𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò(-360) => 0,
    𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò(135 - 360) => 1/2*sqrt(2),
    𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò(330 - 360) => -0.5,
    𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò(0) => 0,
    𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò(30) => 0.5,
    𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò(45) => 1/2*sqrt(2),
    𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò(90) => 1,
    𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò(135) => 1/2*sqrt(2),
    𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò(180) => 0,
    𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò(225) => -1/2*sqrt(2),
    𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò(270) => -1,
    𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò(315) => -1/2*sqrt(2),
    𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò(360) => 0,
    𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò(30 + 360) => 0.5,
    𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò(225 + 360) => -1/2*sqrt(2),
    𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò(720) => 0
);

my @개갨ò갢丧e̲ò = @ò갢丧e̲ò.map({; $_.key - 𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò(90) => $_.value }); #OK

my @ò갢丧両e̲ò = @ò갢丧e̲ò.grep({ $_.key < 𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò(500) }).map({; $_.key => #OK
                                                (exp($_.key) - exp(-$_.key)) / 2.0 });

my @개갨ò両e̲ò = @ò갢丧e̲ò.grep({ $_.key < 𝐝e̲æсe̲e̲ò-中갨-сà𝐝갢à丧ò(500) }).map({; $_.key => #OK
                                                (exp($_.key) + exp(-$_.key)) / 2.0 });

class 不갨中갂갨ì𝐩лe̲ч is Cool {
    has $.value;

    multi method new(Complex $value is copy) {
        self.bless(:$value);
    }

    multi method Numeric() {
        self.value;
    }
}

class 𝐃갢ееe̲сe̲丧中Сe̲àл is Real {
    has $.value;

    multi method new($value is copy) {
        self.bless(:$value);
    }

    multi method Bridge() {
        self.value.Num;
    }
}



# tan tests

for @ò갢丧e̲ò -> $angle
{
    next if abs(cos($angle.key())) < 1e-6;
    my $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 = sin($angle.key()) / cos($angle.key());

    # Num.tan tests -- very thorough
    is-approx($angle.key().tan, $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中,
              "Num.tan - {$angle.key()}");

    # Complex.tan tests -- also very thorough
    my Complex $zp0 = $angle.key + 0.0i;
    my Complex $sz0 = $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 + 0i;
    my Complex $zp1 = $angle.key + 1.0i;
    my Complex $sz1 = { sin($_) / cos($_) }($zp1);
    my Complex $zp2 = $angle.key + 2.0i;
    my Complex $sz2 = { sin($_) / cos($_) }($zp2);

    is-approx($zp0.tan, $sz0, "Complex.tan - $zp0");
    is-approx($zp1.tan, $sz1, "Complex.tan - $zp1");
    is-approx($zp2.tan, $sz2, "Complex.tan - $zp2");
}


{
    is(tan(Inf), NaN, "tan(Inf) -");
    is(tan(-Inf), NaN, "tan(-Inf) -");
}

{
    # Num tests
    is-approx(tan((-6.283185).Num), -5.82864638634609e-11, "tan(Num) - -6.283185");
}

{
    # Rat tests
    is-approx((-3.9269908).Rat(1e-9).tan, -1.00000000007286, "Rat.tan - -3.9269908");
    is-approx(tan((-0.5235988).Rat(1e-9)), -0.577350269196102, "tan(Rat) - -0.5235988");
}

{
    # Complex tests
    is-approx(tan((0+2i).Complex), 0+0.964027580075817i, "tan(Complex) - 0+2i");
}

{
    # Str tests
    is-approx((0.5235988).Str.tan, 0.577350269196102, "Str.tan - 0.5235988");
    is-approx(tan((0.7853982).Str), 1.00000000001457, "tan(Str) - 0.7853982");
}

{
    # NotComplex tests
    is-approx(不갨中갂갨ì𝐩лe̲ч.new(2.3561944902142+2i).tan, -0.0366189934736279+0.999329299737467i, "NotComplex.tan - 2.3561944902142+2i");
    is-approx(tan(不갨中갂갨ì𝐩лe̲ч.new(3.14159265361894+2i)), 2.05899337486384e-12+0.964027580075817i, "tan(NotComplex) - 3.14159265361894+2i");
}

{
    # DifferentReal tests
    is-approx(𝐃갢ееe̲сe̲丧中Сe̲àл.new(3.9269908).tan, 1.00000000007286, "DifferentReal.tan - 3.9269908");
    is-approx(tan(𝐃갢ееe̲сe̲丧中Сe̲àл.new(5.4977871)), -0.999999999897998, "tan(DifferentReal) - 5.4977871");
}

{
    # FatRat tests
    is-approx((6.283185).FatRat.tan, 5.82864638634609e-11, "FatRat.tan - 6.283185");
    is-approx(tan((6.8067841).FatRat), 0.577350269273818, "tan(FatRat) - 6.8067841");
}


# atan tests

for @ò갢丧e̲ò -> $angle
{
    next if abs(cos($angle.key())) < 1e-6;
    my $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 = sin($angle.key()) / cos($angle.key());

    # Num.atan tests -- thorough
    is-approx($𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中.Num.atan.tan, $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中,
              "Num.atan - {$angle.key()}");

    # Num.atan(Complex) tests -- thorough
    for ($𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 + 0i, $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 + .5i, $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 + 2i) -> $z {
        is-approx($z.atan.tan, $z,
                  "Complex.atan - $z");
    }
}

{
    # Num tests
    is-approx(atan((0.577350269196102).Num), 0.5235988, "atan(Num) - 0.5235988");
}

{
    # Rat tests
    is-approx(((1.00000000001457).Rat(1e-9)).atan, 0.7853982, "Rat.atan - 0.7853982");
    is-approx(atan((0.577350269196102).Rat(1e-9)), 0.5235988, "atan(Rat) - 0.5235988");
}

{
    # Complex tests
    is-approx(atan((0.785398163404734+2i).Complex), 1.36593583676998+0.445759203696597i, "atan(Complex) - 1.36593583676998+0.445759203696597i");
}

{
    # Str tests
    is-approx(((0.577350269196102).Str).atan, 0.5235988, "Str.atan - 0.5235988");
    is-approx(atan((1.00000000001457).Str), 0.7853982, "atan(Str) - 0.7853982");
}

{
    # NotComplex tests
    is-approx((不갨中갂갨ì𝐩лe̲ч.new(0.523598775603156+2i)).atan, 1.41601859067084+0.496236956634457i, "NotComplex.atan - 1.41601859067084+0.496236956634457i");
    is-approx(atan(不갨中갂갨ì𝐩лe̲ч.new(0.785398163404734+2i)), 1.36593583676998+0.445759203696597i, "atan(NotComplex) - 1.36593583676998+0.445759203696597i");
}

{
    # DifferentReal tests
    is-approx((𝐃갢ееe̲сe̲丧中Сe̲àл.new(0.577350269196102)).atan, 0.5235988, "DifferentReal.atan - 0.5235988");
    is-approx(atan(𝐃갢ееe̲сe̲丧中Сe̲àл.new(1.00000000001457)), 0.7853982, "atan(DifferentReal) - 0.7853982");
}

{
    # FatRat tests
    is-approx(((0.577350269196102).FatRat).atan, 0.5235988, "FatRat.atan - 0.5235988");
    is-approx(atan((1.00000000001457).FatRat), 0.7853982, "atan(FatRat) - 0.7853982");
}

done-testing;

# vim: expandtab shiftwidth=4
