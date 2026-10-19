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



# sin tests

for @ò갢丧e̲ò -> $angle
{

    my $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 = $angle.value;

    # Num.sin tests -- very thorough
    is-approx($angle.key().sin, $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中,
              "Num.sin - {$angle.key()}");

    # Complex.sin tests -- also very thorough
    my Complex $zp0 = $angle.key + 0.0i;
    my Complex $sz0 = $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 + 0i;
    my Complex $zp1 = $angle.key + 1.0i;
    my Complex $sz1 = { (exp($_ * 1i) - exp(-$_ * 1i)) / 2i }($zp1);
    my Complex $zp2 = $angle.key + 2.0i;
    my Complex $sz2 = { (exp($_ * 1i) - exp(-$_ * 1i)) / 2i }($zp2);

    is-approx($zp0.sin, $sz0, "Complex.sin - $zp0");
    is-approx($zp1.sin, $sz1, "Complex.sin - $zp1");
    is-approx($zp2.sin, $sz2, "Complex.sin - $zp2");
}


{
    is(sin(Inf), NaN, "sin(Inf) -");
    is(sin(-Inf), NaN, "sin(-Inf) -");
}

{
    # Num tests
    is-approx(sin((-6.283185).Num), 0, "sin(Num) - -6.283185");
}

{
    # Rat tests
    is-approx((-3.9269908).Rat(1e-9).sin, 0.707106781186548, "Rat.sin - -3.9269908");
    is-approx(sin((-0.5235988).Rat(1e-9)), -0.5, "sin(Rat) - -0.5235988");
}

{
    # Complex tests
    is-approx(sin((0+2i).Complex), 0+3.62686040784702i, "sin(Complex) - 0+2i");
}

{
    # Str tests
    is-approx((0.5235988).Str.sin, 0.5, "Str.sin - 0.5235988");
    is-approx(sin((0.7853982).Str), 0.707106781186548, "sin(Str) - 0.7853982");
}

{
    # NotComplex tests
    is-approx(不갨中갂갨ì𝐩лe̲ч.new(1.57079632680947+2i).sin, 3.76219569108363-5.28492170249481e-11i, "NotComplex.sin - 1.57079632680947+2i");
    is-approx(sin(不갨中갂갨ì𝐩лe̲ч.new(2.3561944902142+2i)), 2.6602740852579-2.56457758886169i, "sin(NotComplex) - 2.3561944902142+2i");
}

{
    # DifferentReal tests
    is-approx(𝐃갢ееe̲сe̲丧中Сe̲àл.new(3.141593).sin, 0, "DifferentReal.sin - 3.141593");
    is-approx(sin(𝐃갢ееe̲сe̲丧中Сe̲àл.new(3.9269908)), -0.707106781186548, "sin(DifferentReal) - 3.9269908");
}

{
    # FatRat tests
    is-approx((4.7123890).FatRat.sin, -1, "FatRat.sin - 4.7123890");
    is-approx(sin((5.4977871).FatRat), -0.707106781186548, "sin(FatRat) - 5.4977871");
}


# asin tests

for @ò갢丧e̲ò -> $angle
{

    my $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 = $angle.value;

    # Num.asin tests -- thorough
    is-approx($𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中.Num.asin.sin, $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中,
              "Num.asin - {$angle.key()}");

    # Num.asin(Complex) tests -- thorough
    for ($𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 + 0i, $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 + .5i, $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 + 2i) -> $z {
        is-approx($z.asin.sin, $z,
                  "Complex.asin - $z");
    }
}

{
    # Num tests
    is-approx(asin((0.5).Num), 0.5235988, "asin(Num) - 0.5235988");
}

{
    # Rat tests
    is-approx(((0.707106781186548).Rat(1e-9)).asin, 0.7853982, "Rat.asin - 0.7853982");
    is-approx(asin((0.5).Rat(1e-9)), 0.5235988, "asin(Rat) - 0.5235988");
}

{
    # Complex tests
    is-approx(asin((0.785398163404734+2i).Complex), 0.341338918259482+1.49709293866352i, "asin(Complex) - 0.341338918259482+1.49709293866352i");
}

{
    # Str tests
    is-approx(((0.5).Str).asin, 0.5235988, "Str.asin - 0.5235988");
    is-approx(asin((0.707106781186548).Str), 0.7853982, "asin(Str) - 0.7853982");
}

{
    # NotComplex tests
    is-approx((不갨中갂갨ì𝐩лe̲ч.new(0.523598775603156+2i)).asin, 0.231190695652916+1.46781890096429i, "NotComplex.asin - 0.231190695652916+1.46781890096429i");
    is-approx(asin(不갨中갂갨ì𝐩лe̲ч.new(0.785398163404734+2i)), 0.341338918259482+1.49709293866352i, "asin(NotComplex) - 0.341338918259482+1.49709293866352i");
}

{
    # DifferentReal tests
    is-approx((𝐃갢ееe̲сe̲丧中Сe̲àл.new(0.5)).asin, 0.5235988, "DifferentReal.asin - 0.5235988");
    is-approx(asin(𝐃갢ееe̲сe̲丧中Сe̲àл.new(0.707106781186548)), 0.7853982, "asin(DifferentReal) - 0.7853982");
}

{
    # FatRat tests
    is-approx(((0.5).FatRat).asin, 0.5235988, "FatRat.asin - 0.5235988");
    is-approx(asin((0.707106781186548).FatRat), 0.7853982, "asin(FatRat) - 0.7853982");
}

done-testing;

# vim: expandtab shiftwidth=4
