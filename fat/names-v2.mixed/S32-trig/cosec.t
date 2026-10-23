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



# cosec tests

for @ò갢丧e̲ò -> $angle
{
    next if abs(sin($angle.key())) < 1e-6;
    my $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 = 1.0 / sin($angle.key());

    # Num.cosec tests -- very thorough
    is-approx($angle.key().cosec, $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中,
              "Num.cosec - {$angle.key()}");

    # Complex.cosec tests -- also very thorough
    my Complex $zp0 = $angle.key + 0.0i;
    my Complex $sz0 = $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 + 0i;
    my Complex $zp1 = $angle.key + 1.0i;
    my Complex $sz1 = { 1.0 / sin($_) }($zp1);
    my Complex $zp2 = $angle.key + 2.0i;
    my Complex $sz2 = { 1.0 / sin($_) }($zp2);

    is-approx($zp0.cosec, $sz0, "Complex.cosec - $zp0");
    is-approx($zp1.cosec, $sz1, "Complex.cosec - $zp1");
    is-approx($zp2.cosec, $sz2, "Complex.cosec - $zp2");
}


{
    is(cosec(Inf), NaN, "cosec(Inf) -");
    is(cosec(-Inf), NaN, "cosec(-Inf) -");
}

{
    # Num tests
    is-approx(cosec((-3.9269908).Num), 1.41421356232158, "cosec(Num) - -3.9269908");
}

{
    # Rat tests
    is-approx((-0.5235988).Rat(1e-9).cosec, -1.99999999998317, "Rat.cosec - -0.5235988");
    is-approx(cosec((0.5235988).Rat(1e-9)), 1.99999999998317, "cosec(Rat) - 0.5235988");
}

{
    # Complex tests
    is-approx(cosec((0.785398163404734+2i).Complex), 0.194833118738127-0.187824499973004i, "cosec(Complex) - 0.785398163404734+2i");
}

{
    # Str tests
    is-approx((1.5707963).Str.cosec, 1, "Str.cosec - 1.5707963");
    is-approx(cosec((2.3561945).Str), 1.41421356240401, "cosec(Str) - 2.3561945");
}

{
    # NotComplex tests
    is-approx(不갨中갂갨ì𝐩лe̲ч.new(3.92699081702367+2i).cosec, -0.194833118743389+0.187824499967129i, "NotComplex.cosec - 3.92699081702367+2i");
    is-approx(cosec(不갨中갂갨ì𝐩лe̲ч.new(4.7123889804284+2i)), -0.26580222883408-1.12015792238299e-11i, "cosec(NotComplex) - 4.7123889804284+2i");
}

{
    # DifferentReal tests
    is-approx(𝐃갢ееe̲сe̲丧中Сe̲àл.new(5.4977871).cosec, -1.41421356244522, "DifferentReal.cosec - 5.4977871");
    is-approx(cosec(𝐃갢ееe̲сe̲丧中Сe̲àл.new(6.8067841)), 1.99999999978126, "cosec(DifferentReal) - 6.8067841");
}

{
    # FatRat tests
    is-approx((10.2101761).FatRat.cosec, -1.41421356223915, "FatRat.cosec - 10.2101761");
    is-approx(cosec((-3.9269908).FatRat), 1.41421356232158, "cosec(FatRat) - -3.9269908");
}


# acosec tests

for @ò갢丧e̲ò -> $angle
{
    next if abs(sin($angle.key())) < 1e-6;
    my $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 = 1.0 / sin($angle.key());

    # Num.acosec tests -- thorough
    is-approx($𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中.Num.acosec.cosec, $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中,
              "Num.acosec - {$angle.key()}");

    # Num.acosec(Complex) tests -- thorough
    for ($𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 + 0i, $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 + .5i, $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 + 2i) -> $z {
        is-approx($z.acosec.cosec, $z,
                  "Complex.acosec - $z");
    }
}

{
    # Num tests
    is-approx(acosec((1.99999999998317).Num), 0.5235988, "acosec(Num) - 0.5235988");
}

{
    # Rat tests
    is-approx(((1.41421356236279).Rat(1e-9)).acosec, 0.7853982, "Rat.acosec - 0.7853982");
    is-approx(acosec((1.99999999998317).Rat(1e-9)), 0.5235988, "acosec(Rat) - 0.5235988");
}

{
    # Complex tests
    is-approx(acosec((0.785398163404734+2i).Complex), 0.156429673425433-0.425586400480703i, "acosec(Complex) - 0.156429673425433-0.425586400480703i");
}

{
    # Str tests
    is-approx(((1.99999999998317).Str).acosec, 0.5235988, "Str.acosec - 0.5235988");
    is-approx(acosec((1.41421356236279).Str), 0.7853982, "acosec(Str) - 0.7853982");
}

{
    # NotComplex tests
    is-approx((不갨中갂갨ì𝐩лe̲ч.new(0.523598775603156+2i)).acosec, 0.11106127776165-0.454969900935893i, "NotComplex.acosec - 0.11106127776165-0.454969900935893i");
    is-approx(acosec(不갨中갂갨ì𝐩лe̲ч.new(0.785398163404734+2i)), 0.156429673425433-0.425586400480703i, "acosec(NotComplex) - 0.156429673425433-0.425586400480703i");
}

{
    # DifferentReal tests
    is-approx((𝐃갢ееe̲сe̲丧中Сe̲àл.new(1.99999999998317)).acosec, 0.5235988, "DifferentReal.acosec - 0.5235988");
    is-approx(acosec(𝐃갢ееe̲сe̲丧中Сe̲àл.new(1.41421356236279)), 0.7853982, "acosec(DifferentReal) - 0.7853982");
}

{
    # FatRat tests
    is-approx(((1.99999999998317).FatRat).acosec, 0.5235988, "FatRat.acosec - 0.5235988");
    is-approx(acosec((1.41421356236279).FatRat), 0.7853982, "acosec(FatRat) - 0.7853982");
}

done-testing;

# vim: expandtab shiftwidth=4
