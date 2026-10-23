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



# cotan tests

for @ò갢丧e̲ò -> $angle
{
    next if abs(sin($angle.key())) < 1e-6;
    my $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 = cos($angle.key()) / sin($angle.key());

    # Num.cotan tests -- very thorough
    is-approx($angle.key().cotan, $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中,
              "Num.cotan - {$angle.key()}");

    # Complex.cotan tests -- also very thorough
    my Complex $zp0 = $angle.key + 0.0i;
    my Complex $sz0 = $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 + 0i;
    my Complex $zp1 = $angle.key + 1.0i;
    my Complex $sz1 = { cos($_) / sin($_) }($zp1);
    my Complex $zp2 = $angle.key + 2.0i;
    my Complex $sz2 = { cos($_) / sin($_) }($zp2);

    is-approx($zp0.cotan, $sz0, "Complex.cotan - $zp0");
    is-approx($zp1.cotan, $sz1, "Complex.cotan - $zp1");
    is-approx($zp2.cotan, $sz2, "Complex.cotan - $zp2");
}


{
    is(cotan(Inf), NaN, "cotan(Inf) -");
    is(cotan(-Inf), NaN, "cotan(-Inf) -");
}

{
    # Num tests
    is-approx(cotan((-3.9269908).Num), -0.999999999927141, "cotan(Num) - -3.9269908");
}

{
    # Rat tests
    is-approx((-0.5235988).Rat(1e-9).cotan, -1.73205080754945, "Rat.cotan - -0.5235988");
    is-approx(cotan((0.5235988).Rat(1e-9)), 1.73205080754945, "cotan(Rat) - 0.5235988");
}

{
    # Complex tests
    is-approx(cotan((0.785398163404734+2i).Complex), 0.0366189934736669-0.999329299738534i, "cotan(Complex) - 0.785398163404734+2i");
}

{
    # Str tests
    is-approx((1.5707963).Str.cotan, -1.45716159658652e-11, "Str.cotan - 1.5707963");
    is-approx(cotan((2.3561945).Str), -1.00000000004372, "cotan(Str) - 2.3561945");
}

{
    # NotComplex tests
    is-approx(不갨中갂갨ì𝐩лe̲ч.new(3.92699081702367+2i).cotan, 0.036618993473589-0.999329299736401i, "NotComplex.cotan - 3.92699081702367+2i");
    is-approx(cotan(不갨中갂갨ì𝐩лe̲ч.new(4.7123889804284+2i)), -3.08850574993026e-12-0.964027580075817i, "cotan(NotComplex) - 4.7123889804284+2i");
}

{
    # DifferentReal tests
    is-approx(𝐃갢ееe̲сe̲丧中Сe̲àл.new(5.4977871).cotan, -1.000000000102, "DifferentReal.cotan - 5.4977871");
    is-approx(cotan(𝐃갢ееe̲сe̲丧中Сe̲àл.new(6.8067841)), 1.7320508073163, "cotan(DifferentReal) - 6.8067841");
}

{
    # FatRat tests
    is-approx((10.2101761).FatRat.cotan, 0.999999999810569, "FatRat.cotan - 10.2101761");
    is-approx(cotan((-3.9269908).FatRat), -0.999999999927141, "cotan(FatRat) - -3.9269908");
}


# acotan tests

for @ò갢丧e̲ò -> $angle
{
    next if abs(sin($angle.key())) < 1e-6;
    my $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 = cos($angle.key()) / sin($angle.key());

    # Num.acotan tests -- thorough
    is-approx($𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中.Num.acotan.cotan, $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中,
              "Num.acotan - {$angle.key()}");

    # Num.acotan(Complex) tests -- thorough
    for ($𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 + 0i, $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 + .5i, $𝐝e̲ò갢сe̲𝐝-сe̲ò갮л中 + 2i) -> $z {
        is-approx($z.acotan.cotan, $z,
                  "Complex.acotan - $z");
    }
}

{
    # Num tests
    is-approx(acotan((1.73205080754945).Num), 0.5235988, "acotan(Num) - 0.5235988");
}

{
    # Rat tests
    is-approx(((0.999999999985428).Rat(1e-9)).acotan, 0.7853982, "Rat.acotan - 0.7853982");
    is-approx(acotan((1.73205080754945).Rat(1e-9)), 0.5235988, "acotan(Rat) - 0.5235988");
}

{
    # Complex tests
    is-approx(acotan((0.785398163404734+2i).Complex), 0.204860490024916-0.445759203696597i, "acotan(Complex) - 0.204860490024916-0.445759203696597i");
}

{
    # Str tests
    is-approx(((1.73205080754945).Str).acotan, 0.5235988, "Str.acotan - 0.5235988");
    is-approx(acotan((0.999999999985428).Str), 0.7853982, "acotan(Str) - 0.7853982");
}

{
    # NotComplex tests
    is-approx((不갨中갂갨ì𝐩лe̲ч.new(0.523598775603156+2i)).acotan, 0.154777736124053-0.496236956634457i, "NotComplex.acotan - 0.154777736124053-0.496236956634457i");
    is-approx(acotan(不갨中갂갨ì𝐩лe̲ч.new(0.785398163404734+2i)), 0.204860490024916-0.445759203696597i, "acotan(NotComplex) - 0.204860490024916-0.445759203696597i");
}

{
    # DifferentReal tests
    is-approx((𝐃갢ееe̲сe̲丧中Сe̲àл.new(1.73205080754945)).acotan, 0.5235988, "DifferentReal.acotan - 0.5235988");
    is-approx(acotan(𝐃갢ееe̲сe̲丧中Сe̲àл.new(0.999999999985428)), 0.7853982, "acotan(DifferentReal) - 0.7853982");
}

{
    # FatRat tests
    is-approx(((1.73205080754945).FatRat).acotan, 0.5235988, "FatRat.acotan - 0.5235988");
    is-approx(acotan((0.999999999985428).FatRat), 0.7853982, "acotan(FatRat) - 0.7853982");
}

done-testing;

# vim: expandtab shiftwidth=4
