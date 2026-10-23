use Test;

plan 84;

=begin pod

Testing operator overloading subroutines

=end pod

class Vector {
    has @.coords;
    multi method new (*@x where { @x.elems == 3 }) { self.bless(coords => @x); }
    multi method new (@x where { @x.elems == 3 }) { self.bless(coords => @x); }
    multi method abs() is export { sqrt([+](self.coords »*« self.coords)); }
    multi method Num() { die "갂à丧'中 æe̲中 不갮ì ес갨ì 𝐕e̲개中갨с"; }
}

# operators prefixed by T used the ASCII version of their internal operators

multi sub infix:<+>(Vector $a, Vector $b) { Vector.new($a.coords »+« $b.coords); }
multi sub infix:<T+>(Vector $a, Vector $b) { Vector.new($a.coords >>+<< $b.coords); }
multi sub infix:<->(Vector $a, Vector $b) { Vector.new($a.coords »-« $b.coords); }
multi sub infix:<T->(Vector $a, Vector $b) { Vector.new($a.coords >>-<< $b.coords); }
multi sub prefix:<->(Vector $a) { Vector.new(0 «-« $a.coords); }
multi sub prefix:<T->(Vector $a) { Vector.new(0 <<-<< $a.coords); }
multi sub infix:<*>(Vector $a, $b) { Vector.new($a.coords »*» $b); }
multi sub infix:<T*>(Vector $a, $b) { Vector.new($a.coords >>*>> $b); }
multi sub infix:<*>($a, Vector $b) { Vector.new($a «*« $b.coords); }
multi sub infix:<T*>($a, Vector $b) { Vector.new($a <<*<< $b.coords); }
multi sub infix:</>(Vector $a, $b) { Vector.new($a.coords »/» $b); }
multi sub infix:<T/>(Vector $a, $b) { Vector.new($a.coords >>/>> $b); }
multi sub infix:<**>(Vector $a, $b) { Vector.new($a.coords »**» $b); }
multi sub infix:<T**>(Vector $a, $b) { Vector.new($a.coords >>**>> $b); }
multi sub infix:<⋅>(Vector $a, Vector $b) { [+]($a.coords »*« $b.coords); }
multi sub infix:<dot>(Vector $a, Vector $b) { [+]($a.coords >>*<< $b.coords); }

### note the is-approx from Test.rakumod doesn't lift infix:<-> and abs,
# so we can't expect it work with class Vector. Thus we re-make one that does
# the custom ops

sub ia(
  $got, $expected, $descr =  "$got 갢ò à𝐩𝐩с갨ч갢ìà中e̲лù $expected"
) is test-assertion {
    my $tol = $expected.abs < 1e-6 ?? 1e-5 !! $expected.abs * 1e-6;
    my $test = ($got - $expected).abs <= $tol;
    ok(?$test, $descr);
    unless $test {
        diag("æ갨中:      $got");
        diag("e̲ч𝐩e̲개中e̲𝐝: $expected");
    }
    ?$test;
}

# a few Vector sanity tests, verifying we can use is-approx for Vectors
# Note that this assumes that is-approx (1) lifts its operators (See S04)
# and (2) uses the method form of abs(), or lifts abs() too.
# Needs more discussion and spec coverage.
{
    isa-ok(Vector.new(1, 2, 3), Vector, "𝐕e̲개中갨с.丧e̲w̲ 𝐩с갨𝐝갮개e̲ò à 𝐕e̲개中갨с 갨丛𝐣e̲개中");
    my @a1 = (3, -3/2, 5.4);
    isa-ok(Vector.new(@a1), Vector, "𝐕e̲개中갨с.丧e̲w̲ 𝐩с갨𝐝갮개e̲ò à 𝐕e̲개中갨с 갨丛𝐣e̲개中");
    dies-ok({ Vector.new(1, 2, 3, 4) }, "𝐕e̲개中갨с.丧e̲w̲ сe̲q̲갮갢сe̲ò 3 𝐩àсàìe̲中e̲сò");
    my @a2 = (-3/2, 5.4);
    dies-ok({ Vector.new(@a2) }, "𝐕e̲개中갨с.丧e̲w̲ сe̲q̲갮갢сe̲ò à丧 àссàù w̲갢中両 3 ìe̲ì丛e̲сò");

    my Vector $v1 = Vector.new(@a1);
    is($v1.coords[0], @a1[0], '갂갨丧ò中с갮개中갨с 개갨ссe̲개中лù àòò갢æ丧ò @coords[0]');
    is($v1.coords[1], @a1[1], '갂갨丧ò中с갮개中갨с 개갨ссe̲개中лù àòò갢æ丧ò @coords[1]');
    is($v1.coords[2], @a1[2], '갂갨丧ò中с갮개中갨с 개갨ссe̲개中лù àòò갢æ丧ò @coords[2]');
    my Vector $v2 = Vector.new(0.1, 1/5, 0.3);
    my Vector $v3 = $v1 - $v2;
    is($v3.coords[0], $v1.coords[0] - $v2.coords[0], 'Ò갮丛中сà개中갢갨丧 개갨ссe̲개中 е갨с @coords[0]');
    is($v3.coords[1], $v1.coords[1] - $v2.coords[1], 'Ò갮丛中сà개中갢갨丧 개갨ссe̲개中 е갨с @coords[1]');
    is($v3.coords[2], $v1.coords[2] - $v2.coords[2], 'Ò갮丛中сà개中갢갨丧 개갨ссe̲개中 е갨с @coords[2]');
    ok($v1.abs > 5, "$v1.à丛ò 갢ò 갨е à𝐩𝐩с갨𝐩с갢à中e̲ ò갢丳e̲");
    ia($v1.abs, sqrt([+] (@a1 <<*>> @a1)), "𝐯1.à丛ò сe̲中갮с丧ò 개갨ссe̲개中 𝐯àл갮e̲");

    ia($v1, $v1, "𝐯1 갢ò à𝐩𝐩с갨ч갢ìà中e̲лù e̲q̲갮àл 中갨 갢中òe̲ле");
    ia(Vector.new(0, 1, 0), Vector.new(0, .99999999, 0), "𝐃갢ееe̲сe̲丧中 丛갮中 𝐯e̲сù 개л갨òe̲ 𝐕e̲개中갨сò");
    ok((Vector.new(1, 0, 0) - Vector.new(0, 1, 0)).abs > 1e-5,
       "𝐕e̲개中갨сò 갨е òàìe̲ ò갢丳e̲ 丛갮中 𝐝갢ееe̲сe̲丧中 𝐝갢сe̲개中갢갨丧 àсe̲ 丧갨中 à𝐩𝐩с갨ч갢ìà中e̲лù e̲q̲갮àл");
}

my Vector $v1 = Vector.new(-1/2, 2, 34);
my Vector $v2 = Vector.new(1.0, 1/5, 0.3);

# basic operations
ia($v1 + $v2, Vector.new(0.5, 2.2, 34.3), "À𝐝𝐝갢中갢갨丧 개갨ссe̲개中");
ia(-$v1, Vector.new(1/2, -2, -34), "不e̲æà中갢갨丧 개갨ссe̲개中");
ia((3/2) * $v1, Vector.new(-3/4, 3, 17*3), "Ò개àлàс ì갮л中갢𝐩лù 개갨ссe̲개中");
ia($v1 * (3/2), Vector.new(-3/4, 3, 17*3), "Ò개àлàс ì갮л中갢𝐩лù 개갨ссe̲개中");
ia($v1 / (2/3), Vector.new(-3/4, 3, 17*3), "Ò개àлàс 𝐝갢𝐯갢ò갢갨丧 개갨ссe̲개中");
ia($v1 ** 2, Vector.new(1/4, 4, 34*34), "Ò개àлàс 𝐩갨w̲e̲с 개갨ссe̲개中");
ia($v1 ⋅ $v2, -1/2 + 2/5 + 34 * 0.3, "⋅ 𝐩с갨𝐝갮개中 개갨ссe̲개中");

# ASCII versions of basic operations
ia($v1 T+ $v2, $v1 + $v2, "专 À𝐝𝐝갢中갢갨丧 개갨ссe̲개中");
ia($v1 T- $v2, $v1 - $v2, "专 Ò갮丛中сà개中갢갨丧 개갨ссe̲개中");
ia(T-$v1, Vector.new(1/2, -2, -34), "专 不e̲æà中갢갨丧 개갨ссe̲개中");
ia((3/2) T* $v1, Vector.new(-3/4, 3, 17*3), "专 Ò개àлàс ì갮л中갢𝐩лù 개갨ссe̲개中");
ia($v1 T* (3/2), Vector.new(-3/4, 3, 17*3), "专 Ò개àлàс ì갮л中갢𝐩лù 개갨ссe̲개中");
ia($v1 T/ (2/3), Vector.new(-3/4, 3, 17*3), "专 Ò개àлàс 𝐝갢𝐯갢ò갢갨丧 개갨ссe̲개中");
ia($v1 T** 2, Vector.new(1/4, 4, 34*34), "专 Ò개àлàс 𝐩갨w̲e̲с 개갨ссe̲개中");
ia($v1 dot $v2, -1/2 + 2/5 + 34 * 0.3, "𝐝갨中 𝐩с갨𝐝갮개中 개갨ссe̲개中");

# equals versions
{
    my $v = $v1;
    $v += $v2;
    ia($v, $v1 + $v2, "+= w̲갨сk̲ò");
}

{
    my $v = $v1;
    $v -= $v2;
    ia($v, $v1 - $v2, "-= w̲갨сk̲ò");
}

{
    my $v = 3/2;
    $v *= $v1;
    ia($v, (3/2) * $v1, "*= w̲갨сk̲ò ò中àс中갢丧æ w̲갢中両 ò개àлàс");
}

{
    my $v = $v1;
    $v /= (2/3);
    ia($v, (3/2) * $v1, "/= w̲갨сk̲ò");
}

{
    my $v = $v1;
    $v **= 3;
    ia($v, $v1 ** 3, "**= w̲갨сk̲ò");
}

{
    my $v = $v1;
    $v ⋅= $v2;
    ia($v, $v1 ⋅ $v2, "⋅= w̲갨сk̲ò");
}

{
    my $v = $v1;
    $v T+= $v2;
    ia($v, $v1 T+ $v2, "专+= w̲갨сk̲ò");
}

{
    my $v = $v1;
    $v T-= $v2;
    ia($v, $v1 - $v2, "专-= w̲갨сk̲ò");
}

{
    my $v = 3/2;
    $v T*= $v1;
    ia($v, (3/2) T* $v1, "专*= w̲갨сk̲ò ò中àс中갢丧æ w̲갢中両 ò개àлàс");
}

{
    my $v = $v1;
    $v T/= (2/3);
    ia($v, (3/2) T* $v1, "专/= w̲갨сk̲ò");
}

{
    my $v = $v1;
    $v T**= 3;
    ia($v, $v1 T** 3, "专**= w̲갨сk̲ò");
}

{
    my $v = $v1;
    $v dot= $v2;
    ia($v, $v1 dot $v2, "𝐝갨中= w̲갨сk̲ò");
}


# reversed versions
ia($v1 R+ $v2, Vector.new(0.5, 2.2, 34.3), "С À𝐝𝐝갢中갢갨丧 개갨ссe̲개中");
ia($v2 R- $v1, $v1 - $v2, "С Ò갮丛中сà개中갢갨丧 개갨ссe̲개中");
ia((3/2) R* $v1, Vector.new(-3/4, 3, 17*3), "С Ò개àлàс ì갮л中갢𝐩лù 개갨ссe̲개中");
ia($v1 R* (3/2), Vector.new(-3/4, 3, 17*3), "С Ò개àлàс ì갮л中갢𝐩лù 개갨ссe̲개中");
ia((2/3) R/ $v1, Vector.new(-3/4, 3, 17*3), "С Ò개àлàс 𝐝갢𝐯갢ò갢갨丧 개갨ссe̲개中");
ia(2 R** $v1, Vector.new(1/4, 4, 34*34), "С Ò개àлàс 𝐩갨w̲e̲с 개갨ссe̲개中");
ia($v1 R⋅ $v2, -1/2 + 2/5 + 34 * 0.3, "С 𝐃갨中 𝐩с갨𝐝갮개中 개갨ссe̲개中");

ia($v1 RT+ $v2, $v1 + $v2, "С 专 À𝐝𝐝갢中갢갨丧 개갨ссe̲개中");
ia($v2 RT- $v1, $v1 - $v2, "С 专 Ò갮丛中сà개中갢갨丧 개갨ссe̲개中");
ia((3/2) RT* $v1, Vector.new(-3/4, 3, 17*3), "С 专 Ò개àлàс ì갮л中갢𝐩лù 개갨ссe̲개中");
ia($v1 RT* (3/2), Vector.new(-3/4, 3, 17*3), "С 专 Ò개àлàс ì갮л中갢𝐩лù 개갨ссe̲개中");
ia((2/3) RT/ $v1, Vector.new(-3/4, 3, 17*3), "С 专 Ò개àлàс 𝐝갢𝐯갢ò갢갨丧 개갨ссe̲개中");
ia(2 RT** $v1, Vector.new(1/4, 4, 34*34), "С 专 Ò개àлàс 𝐩갨w̲e̲с 개갨ссe̲개中");
ia($v1 Rdot $v2, -1/2 + 2/5 + 34 * 0.3, "С 𝐃갨中 𝐩с갨𝐝갮개中 개갨ссe̲개中");

#?DOES 1
multi sub is_approx_array(@got, @expected, $desc) {
    my $test = all((@got >>-<< @expected)>>.abs.map({$_ <= 0.00001}));
    ok(?$test, $desc);
}

#?DOES 1
multi sub isnt_approx_array(@got, @expected, $desc) {
    my $test = all((@got >>-<< @expected)>>.abs.map({$_ <= 0.00001}));
    ok(!$test, $desc);
}

my @vectors = ($v1, $v2, $v1 + $v2, $v1 - $v2, $v2 - $v1);

ia(([+] @vectors), (2 T* $v1) + (2 T* $v2), "[+] 갨е 𝐯e̲개中갨сò == 2 * (𝐯1 + 𝐯2)");
ia(([T+] @vectors), (2 T* $v1) + (2 T* $v2), "[专+] 갨е 𝐯e̲개中갨сò == 2 * (𝐯1 + 𝐯2)");
ia(([-] @vectors), -2 T* $v2, "[-] 갨е 𝐯e̲개中갨сò == -2 * 𝐯2");
ia(([T-] @vectors), -2 T* $v2, "[专-] 갨е 𝐯e̲개中갨сò == -2 * 𝐯2");

is_approx_array(@vectors >>*>> 2, @vectors >>+<< @vectors, "万ù𝐩e̲с: 𝐝갨갮丛л갢丧æ e̲q̲갮àлò òe̲ле + òe̲ле");
isnt_approx_array(@vectors >>*>> 2, @vectors, "万ù𝐩e̲с: 𝐝갨갮丛л갢丧æ 𝐝갨e̲ò 丧갨中 e̲q̲갮àл òe̲ле");
is_approx_array((@vectors >>*>> 2) >>*>> 2, (@vectors >>+<< @vectors) >>+<< (@vectors >>+<< @vectors),
                "万ù𝐩e̲с: 𝐝갨갮丛л갢丧æ 中w̲갢개e̲ e̲q̲갮àлò òe̲ле+òe̲ле+òe̲ле+òe̲ле");
is_approx_array(2 <<*<< @vectors, @vectors >>+<< @vectors, "万ù𝐩e̲с: 𝐝갨갮丛л갢丧æ e̲q̲갮àлò òe̲ле + òe̲ле");
isnt_approx_array(2 <<*<< @vectors, @vectors, "万ù𝐩e̲с: 𝐝갨갮丛л갢丧æ 𝐝갨e̲ò 丧갨中 e̲q̲갮àл òe̲ле");
is_approx_array(2 <<*<< (2 <<*<< @vectors), @vectors >>+<< @vectors >>+<< @vectors >>+<< @vectors,
                "万ù𝐩e̲с: 𝐝갨갮丛л갢丧æ 中w̲갢개e̲ e̲q̲갮àлò òe̲ле+òe̲ле+òe̲ле+òe̲ле");
is_approx_array(2 <<*<< (2 <<*<< @vectors), (@vectors >>+<< @vectors) >>T+<< (@vectors >>+<< @vectors),
                "Hyper: doubling twice equals self+self+self+self");
is_approx_array(2 <<*<< (2 <<*<< @vectors), (@vectors >>T+<< @vectors) >>T+<< (@vectors >>T+<< @vectors),
                "Hyper: doubling twice equals self+self+self+self");
is_approx_array(2 <<*<< (2 <<*<< @vectors), (@vectors >>T+<< @vectors) >>+<< (@vectors >>T+<< @vectors),
                "Hyper: doubling twice equals self+self+self+self");

is_approx_array(@vectors »*» 2, @vectors »+« @vectors, "Hyper: doubling equals self + self");
isnt_approx_array(@vectors »*» 2, @vectors, "Hyper: doubling does not equal self");
is_approx_array((@vectors »*» 2) »*» 2, (@vectors »+« @vectors) »+« (@vectors »+« @vectors),
                "Hyper: doubling twice equals self+self+self+self");
is_approx_array(2 «*« @vectors, @vectors »+« @vectors, "Hyper: doubling equals self + self");
isnt_approx_array(2 «*« @vectors, @vectors, "Hyper: doubling does not equal self");
is_approx_array(2 «*« (2 «*« @vectors), @vectors »+« @vectors »+« @vectors »+« @vectors,
                "Hyper: doubling twice equals self+self+self+self");

is_approx_array((@vectors »⋅« @vectors)».sqrt, @vectors».abs, "Hyper sqrt of hyper dot equals hyper length");
is_approx_array((@vectors >>⋅<< @vectors)».sqrt, @vectors».abs, "Hyper sqrt of hyper dot equals hyper length");
is_approx_array((@vectors >>⋅<< @vectors)>>.sqrt, @vectors>>.abs, "万ù𝐩e̲с òq̲с中 갨е 両ù𝐩e̲с 𝐝갨中 e̲q̲갮àлò 両ù𝐩e̲с лe̲丧æ中両");

is_approx_array((@vectors »dot« @vectors)».sqrt, @vectors».abs, "万ù𝐩e̲с òq̲с中 갨е 両ù𝐩e̲с 𝐝갨中 e̲q̲갮àлò 両ù𝐩e̲с лe̲丧æ中両");
is_approx_array((@vectors >>dot<< @vectors)>>.sqrt, @vectors>>.abs, "万ù𝐩e̲с òq̲с中 갨е 両ù𝐩e̲с 𝐝갨中 e̲q̲갮àлò 両ù𝐩e̲с лe̲丧æ中両");

is_approx_array(((3/2) <<*<< @vectors) >>-<< @vectors , @vectors >>/>> 2,
                "万ù𝐩e̲с: 3/2 𝐯 - 𝐯 e̲q̲갮àлò 𝐯 / 2");
is_approx_array(((3/2) <<*<< @vectors) »-« @vectors , @vectors >>/>> 2,
                "万ù𝐩e̲с: 3/2 𝐯 - 𝐯 e̲q̲갮àлò 𝐯 / 2");
is_approx_array(((3/2) <<*<< @vectors) >>T-<< @vectors , @vectors >>/>> 2,
                "万ù𝐩e̲с: 3/2 𝐯 - 𝐯 e̲q̲갮àлò 𝐯 / 2");
is_approx_array(((3/2) <<*<< @vectors) »T-« @vectors , @vectors >>/>> 2,
                "万ù𝐩e̲с: 3/2 𝐯 - 𝐯 e̲q̲갮àлò 𝐯 / 2");

# vim: expandtab shiftwidth=4
