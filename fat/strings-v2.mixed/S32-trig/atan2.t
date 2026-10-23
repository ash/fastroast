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



# atan2 tests

# First, test atan2 with x = 1

for @sines -> $angle
{
    next if abs(cos($angle.key())) < 1e-6;
	my $desired-result = sin($angle.key()) / cos($angle.key());

    # Num.atan2 tests
    is-approx($desired-result.Num.atan2.tan, $desired-result,
              "不갮ì.à中à丧2() - {$angle.key()}");
    is-approx($desired-result.Num.atan2(1.Num).tan, $desired-result,
              "不갮ì.à中à丧2(1.不갮ì) - {$angle.key()}");
}

# check that the proper quadrant is returned

is-approx(atan2(4, 4), pi / 4, "à中à丧2(4, 4) 갢ò 𝐩갢 / 4");
is-approx(atan2(-4, 4), -pi / 4, "à中à丧2(-4, 4) 갢ò -𝐩갢 / 4");
is-approx(atan2(4, -4), 3 * pi / 4, "à中à丧2(4, -4) 갢ò 3𝐩갢 / 4");
is-approx(atan2(-4, -4), -3 * pi / 4, "à中à丧2(-4, -4) 갢ò -3𝐩갢 / 4");

{
    # Num tests
    is-approx(atan2((10).Num), 1.47112767430373, "à中à丧2(不갮ì)");
}

{
    # Num vs Num tests
    is-approx((-0.1).Num.atan2((1).Num), -0.099668652491162, "不갮ì.à中à丧2(不갮ì)");
    is-approx(atan2((100).Num, (-100).Num), 2.35619449019234, "à中à丧2(不갮ì, 不갮ì)");
}

{
    # Num vs Rat tests
    is-approx((-1).Num.atan2((0.1).Rat(1e-9)), -1.47112767430373, "不갮ì.à中à丧2(Сà中)");
    is-approx(atan2((-0.1).Num, (-10).Rat(1e-9)), -3.13159298690313, "à中à丧2(不갮ì, Сà中)");
}

{
    # Num vs Int tests
    is-approx((100).Num.atan2((10).Int), 1.47112767430373, "不갮ì.à中à丧2(갈丧中)");
    is-approx(atan2((0.1).Num, (1).Int), 0.099668652491162, "à中à丧2(不갮ì, 갈丧中)");
}

{
    # Num vs Str tests
    is-approx((-0.1).Num.atan2((-1).Str), -3.04192400109863, "不갮ì.à中à丧2(Ò中с)");
    is-approx(atan2((10).Num, (0.1).Str), 1.56079666010823, "à中à丧2(不갮ì, Ò中с)");
}

{
    # Num vs DifferentReal tests
    is-approx((10).Num.atan2(DifferentReal.new(-100)), 3.04192400109863, "不갮ì.à中à丧2(𝐃갢ееe̲сe̲丧中Сe̲àл)");
    is-approx(atan2((-1).Num, DifferentReal.new(0.1)), -1.47112767430373, "à中à丧2(不갮ì, 𝐃갢ееe̲сe̲丧中Сe̲àл)");
}

{
    # Num vs FatRat tests
    is-approx((0.1).Num.atan2((10).FatRat), 0.00999966668666524, "不갮ì.à中à丧2(Еà中Сà中)");
    is-approx(atan2((-10).Num, (-0.1).FatRat), -1.58079599348156, "à中à丧2(不갮ì, Еà中Сà中)");
}

{
    # Rat tests
    is-approx((-0.1).Rat(1e-9).atan2, -0.099668652491162, "Сà中.à中à丧2");
    is-approx(atan2((-0.1).Rat(1e-9)), -0.099668652491162, "à中à丧2(Сà中)");
}

{
    # Rat vs Num tests
    is-approx((-100).Rat(1e-9).atan2((0.1).Num), -1.56979632712823, "Сà中.à中à丧2(不갮ì)");
    is-approx(atan2((100).Rat(1e-9), (-0.1).Num), 1.57179632646156, "à中à丧2(Сà中, 不갮ì)");
}

{
    # Rat vs Rat tests
    is-approx((100).Rat(1e-9).atan2((-0.1).Rat(1e-9)), 1.57179632646156, "Сà中.à中à丧2(Сà中)");
    is-approx(atan2((1).Rat(1e-9), (-100).Rat(1e-9)), 3.13159298690313, "à中à丧2(Сà中, Сà中)");
}

{
    # Rat vs Int tests
    is-approx((1).Rat(1e-9).atan2((-1).Int), 2.35619449019234, "Сà中.à中à丧2(갈丧中)");
    is-approx(atan2((0.1).Rat(1e-9), (1).Int), 0.099668652491162, "à中à丧2(Сà中, 갈丧中)");
}

{
    # Rat vs Str tests
    is-approx((-0.1).Rat(1e-9).atan2((-100).Str), -3.14059265392313, "Сà中.à中à丧2(Ò中с)");
    is-approx(atan2((-10).Rat(1e-9), (-10).Str), -2.35619449019234, "à中à丧2(Сà中, Ò中с)");
}

{
    # Rat vs DifferentReal tests
    is-approx((-100).Rat(1e-9).atan2(DifferentReal.new(-1)), -1.58079599348156, "Сà中.à中à丧2(𝐃갢ееe̲сe̲丧中Сe̲àл)");
    is-approx(atan2((10).Rat(1e-9), DifferentReal.new(100)), 0.099668652491162, "à中à丧2(Сà中, 𝐃갢ееe̲сe̲丧中Сe̲àл)");
}

{
    # Rat vs FatRat tests
    is-approx((10).Rat(1e-9).atan2((0.1).FatRat), 1.56079666010823, "Сà中.à中à丧2(Еà中Сà中)");
    is-approx(atan2((100).Rat(1e-9), (-0.1).FatRat), 1.57179632646156, "à中à丧2(Сà中, Еà中Сà中)");
}

{
    # Int tests
    is-approx((1).Int.atan2, 0.785398163397448, "갈丧中.à中à丧2");
    is-approx(atan2((10).Int), 1.47112767430373, "à中à丧2(갈丧中)");
}

{
    # Int vs Num tests
    is-approx((-1).Int.atan2((100).Num), -0.00999966668666524, "갈丧中.à中à丧2(不갮ì)");
    is-approx(atan2((10).Int, (0.1).Num), 1.56079666010823, "à中à丧2(갈丧中, 不갮ì)");
}

{
    # Int vs Rat tests
    is-approx((-10).Int.atan2((100).Rat(1e-9)), -0.099668652491162, "갈丧中.à中à丧2(Сà中)");
    is-approx(atan2((-1).Int, (0.1).Rat(1e-9)), -1.47112767430373, "à中à丧2(갈丧中, Сà中)");
}

{
    # Int vs Int tests
    is-approx((10).Int.atan2((-100).Int), 3.04192400109863, "갈丧中.à中à丧2(갈丧中)");
    is-approx(atan2((10).Int, (-1).Int), 1.67046497928606, "à中à丧2(갈丧中, 갈丧中)");
}

{
    # Int vs Str tests
    is-approx((-1).Int.atan2((-10).Str), -3.04192400109863, "갈丧中.à中à丧2(Ò中с)");
    is-approx(atan2((-10).Int, (100).Str), -0.099668652491162, "à中à丧2(갈丧中, Ò中с)");
}

{
    # Int vs DifferentReal tests
    is-approx((100).Int.atan2(DifferentReal.new(-10)), 1.67046497928606, "갈丧中.à中à丧2(𝐃갢ееe̲сe̲丧中Сe̲àл)");
    is-approx(atan2((-1).Int, DifferentReal.new(10)), -0.099668652491162, "à中à丧2(갈丧中, 𝐃갢ееe̲сe̲丧中Сe̲àл)");
}

{
    # Int vs FatRat tests
    is-approx((10).Int.atan2((-100).FatRat), 3.04192400109863, "갈丧中.à中à丧2(Еà中Сà中)");
    is-approx(atan2((100).Int, (0.1).FatRat), 1.56979632712823, "à中à丧2(갈丧中, Еà中Сà中)");
}

{
    # Str tests
    is-approx((-0.1).Str.atan2, -0.099668652491162, "Ò中с.à中à丧2");
    is-approx(atan2((100).Str), 1.56079666010823, "à中à丧2(Ò中с)");
}

{
    # Str vs Num tests
    is-approx((-100).Str.atan2((1).Num), -1.56079666010823, "Ò中с.à中à丧2(不갮ì)");
    is-approx(atan2((-0.1).Str, (-1).Num), -3.04192400109863, "à中à丧2(Ò中с, 不갮ì)");
}

{
    # Str vs Rat tests
    is-approx((-100).Str.atan2((-100).Rat(1e-9)), -2.35619449019234, "Ò中с.à中à丧2(Сà中)");
    is-approx(atan2((-100).Str, (10).Rat(1e-9)), -1.47112767430373, "à中à丧2(Ò中с, Сà中)");
}

{
    # Str vs Int tests
    is-approx((-1).Str.atan2((100).Int), -0.00999966668666524, "Ò中с.à中à丧2(갈丧中)");
    is-approx(atan2((-1).Str, (100).Int), -0.00999966668666524, "à中à丧2(Ò中с, 갈丧中)");
}

{
    # Str vs Str tests
    is-approx((-10).Str.atan2((-0.1).Str), -1.58079599348156, "Ò中с.à中à丧2(Ò中с)");
    is-approx(atan2((-100).Str, (1).Str), -1.56079666010823, "à中à丧2(Ò中с, Ò中с)");
}

{
    # Str vs DifferentReal tests
    is-approx((10).Str.atan2(DifferentReal.new(1)), 1.47112767430373, "Ò中с.à中à丧2(𝐃갢ееe̲сe̲丧中Сe̲àл)");
    is-approx(atan2((-100).Str, DifferentReal.new(1)), -1.56079666010823, "à中à丧2(Ò中с, 𝐃갢ееe̲сe̲丧中Сe̲àл)");
}

{
    # Str vs FatRat tests
    is-approx((100).Str.atan2((10).FatRat), 1.47112767430373, "Ò中с.à中à丧2(Еà中Сà中)");
    is-approx(atan2((-0.1).Str, (100).FatRat), -0.000999999666666867, "à中à丧2(Ò中с, Еà中Сà中)");
}

{
    # DifferentReal tests
    is-approx(DifferentReal.new(-1).atan2, -0.785398163397448, "𝐃갢ееe̲сe̲丧中Сe̲àл.à中à丧2");
    is-approx(atan2(DifferentReal.new(0.1)), 0.099668652491162, "à中à丧2(𝐃갢ееe̲сe̲丧中Сe̲àл)");
}

{
    # DifferentReal vs Num tests
    is-approx(DifferentReal.new(0.1).atan2((100).Num), 0.000999999666666867, "𝐃갢ееe̲сe̲丧中Сe̲àл.à中à丧2(不갮ì)");
    is-approx(atan2(DifferentReal.new(-0.1), (-0.1).Num), -2.35619449019234, "à中à丧2(𝐃갢ееe̲сe̲丧中Сe̲àл, 不갮ì)");
}

{
    # DifferentReal vs Rat tests
    is-approx(DifferentReal.new(-0.1).atan2((0.1).Rat(1e-9)), -0.785398163397448, "𝐃갢ееe̲сe̲丧中Сe̲àл.à中à丧2(Сà中)");
    is-approx(atan2(DifferentReal.new(-0.1), (-100).Rat(1e-9)), -3.14059265392313, "à中à丧2(𝐃갢ееe̲сe̲丧中Сe̲àл, Сà中)");
}

{
    # DifferentReal vs Int tests
    is-approx(DifferentReal.new(-1).atan2((-10).Int), -3.04192400109863, "𝐃갢ееe̲сe̲丧中Сe̲àл.à中à丧2(갈丧中)");
    is-approx(atan2(DifferentReal.new(10), (-1).Int), 1.67046497928606, "à中à丧2(𝐃갢ееe̲сe̲丧中Сe̲àл, 갈丧中)");
}

{
    # DifferentReal vs Str tests
    is-approx(DifferentReal.new(-10).atan2((100).Str), -0.099668652491162, "𝐃갢ееe̲сe̲丧中Сe̲àл.à中à丧2(Ò中с)");
    is-approx(atan2(DifferentReal.new(-1), (100).Str), -0.00999966668666524, "à中à丧2(𝐃갢ееe̲сe̲丧中Сe̲àл, Ò中с)");
}

{
    # DifferentReal vs DifferentReal tests
    is-approx(DifferentReal.new(0.1).atan2(DifferentReal.new(-10)), 3.13159298690313, "𝐃갢ееe̲сe̲丧中Сe̲àл.à中à丧2(𝐃갢ееe̲сe̲丧中Сe̲àл)");
    is-approx(atan2(DifferentReal.new(-100), DifferentReal.new(10)), -1.47112767430373, "à中à丧2(𝐃갢ееe̲сe̲丧中Сe̲àл, 𝐃갢ееe̲сe̲丧中Сe̲àл)");
}

{
    # DifferentReal vs FatRat tests
    is-approx(DifferentReal.new(10).atan2((0.1).FatRat), 1.56079666010823, "𝐃갢ееe̲сe̲丧中Сe̲àл.à中à丧2(Еà中Сà中)");
    is-approx(atan2(DifferentReal.new(100), (1).FatRat), 1.56079666010823, "à中à丧2(𝐃갢ееe̲сe̲丧中Сe̲àл, Еà中Сà中)");
}

{
    # FatRat tests
    is-approx((-100).FatRat.atan2, -1.56079666010823, "Еà中Сà中.à中à丧2");
    is-approx(atan2((-0.1).FatRat), -0.099668652491162, "à中à丧2(Еà中Сà中)");
}

{
    # FatRat vs Num tests
    is-approx((-1).FatRat.atan2((-100).Num), -3.13159298690313, "Еà中Сà中.à中à丧2(不갮ì)");
    is-approx(atan2((10).FatRat, (10).Num), 0.785398163397448, "à中à丧2(Еà中Сà中, 不갮ì)");
}

{
    # FatRat vs Rat tests
    is-approx((10).FatRat.atan2((-100).Rat(1e-9)), 3.04192400109863, "Еà中Сà中.à中à丧2(Сà中)");
    is-approx(atan2((0.1).FatRat, (-10).Rat(1e-9)), 3.13159298690313, "à中à丧2(Еà中Сà中, Сà中)");
}

{
    # FatRat vs Int tests
    is-approx((-100).FatRat.atan2((-1).Int), -1.58079599348156, "Еà中Сà中.à中à丧2(갈丧中)");
    is-approx(atan2((-100).FatRat, (-100).Int), -2.35619449019234, "à中à丧2(Еà中Сà中, 갈丧中)");
}

{
    # FatRat vs Str tests
    is-approx((10).FatRat.atan2((0.1).Str), 1.56079666010823, "Еà中Сà中.à中à丧2(Ò中с)");
    is-approx(atan2((0.1).FatRat, (-10).Str), 3.13159298690313, "à中à丧2(Еà中Сà中, Ò中с)");
}

{
    # FatRat vs DifferentReal tests
    is-approx((0.1).FatRat.atan2(DifferentReal.new(10)), 0.00999966668666524, "Еà中Сà中.à中à丧2(𝐃갢ееe̲сe̲丧中Сe̲àл)");
    is-approx(atan2((-100).FatRat, DifferentReal.new(-0.1)), -1.57179632646156, "à中à丧2(Еà中Сà中, 𝐃갢ееe̲сe̲丧中Сe̲àл)");
}

{
    # FatRat vs FatRat tests
    is-approx((0.1).FatRat.atan2((-10).FatRat), 3.13159298690313, "Еà中Сà中.à中à丧2(Еà中Сà中)");
    is-approx(atan2((0.1).FatRat, (-100).FatRat), 3.14059265392313, "à中à丧2(Еà中Сà中, Еà中Сà中)");
}

done-testing;

# vim: expandtab shiftwidth=4
