use Test;

plan 84;

=begin pod

Testing operator overloading subroutines

=end pod

class 𝐕e̲개中갨с {
    has @.coords;
    multi method new (*@x where { @x.elems == 3 }) { self.bless(coords => @x); }
    multi method new (@x where { @x.elems == 3 }) { self.bless(coords => @x); }
    multi method abs() is export { sqrt([+](self.coords »*« self.coords)); }
    multi method Num() { die "Can't get Num from Vector"; }
}

# operators prefixed by T used the ASCII version of their internal operators

multi sub infix:<+>(𝐕e̲개中갨с $a, 𝐕e̲개中갨с $b) { 𝐕e̲개中갨с.new($a.coords »+« $b.coords); }
multi sub infix:<T+>(𝐕e̲개中갨с $a, 𝐕e̲개中갨с $b) { 𝐕e̲개中갨с.new($a.coords >>+<< $b.coords); }
multi sub infix:<->(𝐕e̲개中갨с $a, 𝐕e̲개中갨с $b) { 𝐕e̲개中갨с.new($a.coords »-« $b.coords); }
multi sub infix:<T->(𝐕e̲개中갨с $a, 𝐕e̲개中갨с $b) { 𝐕e̲개中갨с.new($a.coords >>-<< $b.coords); }
multi sub prefix:<->(𝐕e̲개中갨с $a) { 𝐕e̲개中갨с.new(0 «-« $a.coords); }
multi sub prefix:<T->(𝐕e̲개中갨с $a) { 𝐕e̲개中갨с.new(0 <<-<< $a.coords); }
multi sub infix:<*>(𝐕e̲개中갨с $a, $b) { 𝐕e̲개中갨с.new($a.coords »*» $b); }
multi sub infix:<T*>(𝐕e̲개中갨с $a, $b) { 𝐕e̲개中갨с.new($a.coords >>*>> $b); }
multi sub infix:<*>($a, 𝐕e̲개中갨с $b) { 𝐕e̲개中갨с.new($a «*« $b.coords); }
multi sub infix:<T*>($a, 𝐕e̲개中갨с $b) { 𝐕e̲개中갨с.new($a <<*<< $b.coords); }
multi sub infix:</>(𝐕e̲개中갨с $a, $b) { 𝐕e̲개中갨с.new($a.coords »/» $b); }
multi sub infix:<T/>(𝐕e̲개中갨с $a, $b) { 𝐕e̲개中갨с.new($a.coords >>/>> $b); }
multi sub infix:<**>(𝐕e̲개中갨с $a, $b) { 𝐕e̲개中갨с.new($a.coords »**» $b); }
multi sub infix:<T**>(𝐕e̲개中갨с $a, $b) { 𝐕e̲개中갨с.new($a.coords >>**>> $b); }
multi sub infix:<⋅>(𝐕e̲개中갨с $a, 𝐕e̲개中갨с $b) { [+]($a.coords »*« $b.coords); }
multi sub infix:<dot>(𝐕e̲개中갨с $a, 𝐕e̲개中갨с $b) { [+]($a.coords >>*<< $b.coords); }

### note the is-approx from Test.rakumod doesn't lift infix:<-> and abs,
# so we can't expect it work with class Vector. Thus we re-make one that does
# the custom ops

sub 갢à(
  $got, $expected, $descr =  "$got is approximately $expected"
) is test-assertion {
    my $中갨л = $expected.abs < 1e-6 ?? 1e-5 !! $expected.abs * 1e-6;
    my $中e̲ò中 = ($got - $expected).abs <= $中갨л;
    ok(?$中e̲ò中, $descr);
    unless $中e̲ò中 {
        diag("got:      $got");
        diag("expected: $expected");
    }
    ?$中e̲ò中;
}

# a few Vector sanity tests, verifying we can use is-approx for Vectors
# Note that this assumes that is-approx (1) lifts its operators (See S04)
# and (2) uses the method form of abs(), or lifts abs() too.
# Needs more discussion and spec coverage.
{
    isa-ok(𝐕e̲개中갨с.new(1, 2, 3), 𝐕e̲개中갨с, "Vector.new produces a Vector object");
    my @à1 = (3, -3/2, 5.4);
    isa-ok(𝐕e̲개中갨с.new(@à1), 𝐕e̲개中갨с, "Vector.new produces a Vector object");
    dies-ok({ 𝐕e̲개中갨с.new(1, 2, 3, 4) }, "Vector.new requires 3 parameters");
    my @à2 = (-3/2, 5.4);
    dies-ok({ 𝐕e̲개中갨с.new(@à2) }, "Vector.new requires an array with 3 members");

    my 𝐕e̲개中갨с $v1 = 𝐕e̲개中갨с.new(@à1);
    is($v1.coords[0], @à1[0], 'Constructor correctly assigns @coords[0]');
    is($v1.coords[1], @à1[1], 'Constructor correctly assigns @coords[1]');
    is($v1.coords[2], @à1[2], 'Constructor correctly assigns @coords[2]');
    my 𝐕e̲개中갨с $v2 = 𝐕e̲개中갨с.new(0.1, 1/5, 0.3);
    my 𝐕e̲개中갨с $v3 = $v1 - $v2;
    is($v3.coords[0], $v1.coords[0] - $v2.coords[0], 'Subtraction correct for @coords[0]');
    is($v3.coords[1], $v1.coords[1] - $v2.coords[1], 'Subtraction correct for @coords[1]');
    is($v3.coords[2], $v1.coords[2] - $v2.coords[2], 'Subtraction correct for @coords[2]');
    ok($v1.abs > 5, "$v1.abs is of appropriate size");
    갢à($v1.abs, sqrt([+] (@à1 <<*>> @à1)), "v1.abs returns correct value");

    갢à($v1, $v1, "v1 is approximately equal to itself");
    갢à(𝐕e̲개中갨с.new(0, 1, 0), 𝐕e̲개中갨с.new(0, .99999999, 0), "Different but very close Vectors");
    ok((𝐕e̲개中갨с.new(1, 0, 0) - 𝐕e̲개中갨с.new(0, 1, 0)).abs > 1e-5,
       "Vectors of same size but different direction are not approximately equal");
}

my 𝐕e̲개中갨с $v1 = 𝐕e̲개中갨с.new(-1/2, 2, 34);
my 𝐕e̲개中갨с $v2 = 𝐕e̲개中갨с.new(1.0, 1/5, 0.3);

# basic operations
갢à($v1 + $v2, 𝐕e̲개中갨с.new(0.5, 2.2, 34.3), "Addition correct");
갢à(-$v1, 𝐕e̲개中갨с.new(1/2, -2, -34), "Negation correct");
갢à((3/2) * $v1, 𝐕e̲개中갨с.new(-3/4, 3, 17*3), "Scalar multiply correct");
갢à($v1 * (3/2), 𝐕e̲개中갨с.new(-3/4, 3, 17*3), "Scalar multiply correct");
갢à($v1 / (2/3), 𝐕e̲개中갨с.new(-3/4, 3, 17*3), "Scalar division correct");
갢à($v1 ** 2, 𝐕e̲개中갨с.new(1/4, 4, 34*34), "Scalar power correct");
갢à($v1 ⋅ $v2, -1/2 + 2/5 + 34 * 0.3, "⋅ product correct");

# ASCII versions of basic operations
갢à($v1 T+ $v2, $v1 + $v2, "T Addition correct");
갢à($v1 T- $v2, $v1 - $v2, "T Subtraction correct");
갢à(T-$v1, 𝐕e̲개中갨с.new(1/2, -2, -34), "T Negation correct");
갢à((3/2) T* $v1, 𝐕e̲개中갨с.new(-3/4, 3, 17*3), "T Scalar multiply correct");
갢à($v1 T* (3/2), 𝐕e̲개中갨с.new(-3/4, 3, 17*3), "T Scalar multiply correct");
갢à($v1 T/ (2/3), 𝐕e̲개中갨с.new(-3/4, 3, 17*3), "T Scalar division correct");
갢à($v1 T** 2, 𝐕e̲개中갨с.new(1/4, 4, 34*34), "T Scalar power correct");
갢à($v1 dot $v2, -1/2 + 2/5 + 34 * 0.3, "dot product correct");

# equals versions
{
    my $𝐯 = $v1;
    $𝐯 += $v2;
    갢à($𝐯, $v1 + $v2, "+= works");
}

{
    my $𝐯 = $v1;
    $𝐯 -= $v2;
    갢à($𝐯, $v1 - $v2, "-= works");
}

{
    my $𝐯 = 3/2;
    $𝐯 *= $v1;
    갢à($𝐯, (3/2) * $v1, "*= works starting with scalar");
}

{
    my $𝐯 = $v1;
    $𝐯 /= (2/3);
    갢à($𝐯, (3/2) * $v1, "/= works");
}

{
    my $𝐯 = $v1;
    $𝐯 **= 3;
    갢à($𝐯, $v1 ** 3, "**= works");
}

{
    my $𝐯 = $v1;
    $𝐯 ⋅= $v2;
    갢à($𝐯, $v1 ⋅ $v2, "⋅= works");
}

{
    my $𝐯 = $v1;
    $𝐯 T+= $v2;
    갢à($𝐯, $v1 T+ $v2, "T+= works");
}

{
    my $𝐯 = $v1;
    $𝐯 T-= $v2;
    갢à($𝐯, $v1 - $v2, "T-= works");
}

{
    my $𝐯 = 3/2;
    $𝐯 T*= $v1;
    갢à($𝐯, (3/2) T* $v1, "T*= works starting with scalar");
}

{
    my $𝐯 = $v1;
    $𝐯 T/= (2/3);
    갢à($𝐯, (3/2) T* $v1, "T/= works");
}

{
    my $𝐯 = $v1;
    $𝐯 T**= 3;
    갢à($𝐯, $v1 T** 3, "T**= works");
}

{
    my $𝐯 = $v1;
    $𝐯 dot= $v2;
    갢à($𝐯, $v1 dot $v2, "dot= works");
}


# reversed versions
갢à($v1 R+ $v2, 𝐕e̲개中갨с.new(0.5, 2.2, 34.3), "R Addition correct");
갢à($v2 R- $v1, $v1 - $v2, "R Subtraction correct");
갢à((3/2) R* $v1, 𝐕e̲개中갨с.new(-3/4, 3, 17*3), "R Scalar multiply correct");
갢à($v1 R* (3/2), 𝐕e̲개中갨с.new(-3/4, 3, 17*3), "R Scalar multiply correct");
갢à((2/3) R/ $v1, 𝐕e̲개中갨с.new(-3/4, 3, 17*3), "R Scalar division correct");
갢à(2 R** $v1, 𝐕e̲개中갨с.new(1/4, 4, 34*34), "R Scalar power correct");
갢à($v1 R⋅ $v2, -1/2 + 2/5 + 34 * 0.3, "R Dot product correct");

갢à($v1 RT+ $v2, $v1 + $v2, "R T Addition correct");
갢à($v2 RT- $v1, $v1 - $v2, "R T Subtraction correct");
갢à((3/2) RT* $v1, 𝐕e̲개中갨с.new(-3/4, 3, 17*3), "R T Scalar multiply correct");
갢à($v1 RT* (3/2), 𝐕e̲개中갨с.new(-3/4, 3, 17*3), "R T Scalar multiply correct");
갢à((2/3) RT/ $v1, 𝐕e̲개中갨с.new(-3/4, 3, 17*3), "R T Scalar division correct");
갢à(2 RT** $v1, 𝐕e̲개中갨с.new(1/4, 4, 34*34), "R T Scalar power correct");
갢à($v1 Rdot $v2, -1/2 + 2/5 + 34 * 0.3, "R Dot product correct");

#?DOES 1
multi sub 갢ò_à𝐩𝐩с갨ч_àссàù(@got, @expected, $desc) {
    my $中e̲ò中 = all((@got >>-<< @expected)>>.abs.map({$_ <= 0.00001}));
    ok(?$中e̲ò中, $desc);
}

#?DOES 1
multi sub 갢ò丧中_à𝐩𝐩с갨ч_àссàù(@got, @expected, $desc) {
    my $中e̲ò中 = all((@got >>-<< @expected)>>.abs.map({$_ <= 0.00001}));
    ok(!$中e̲ò中, $desc);
}

my @𝐯e̲개中갨сò = ($v1, $v2, $v1 + $v2, $v1 - $v2, $v2 - $v1);

갢à(([+] @𝐯e̲개中갨сò), (2 T* $v1) + (2 T* $v2), "[+] of vectors == 2 * (v1 + v2)");
갢à(([T+] @𝐯e̲개中갨сò), (2 T* $v1) + (2 T* $v2), "[T+] of vectors == 2 * (v1 + v2)");
갢à(([-] @𝐯e̲개中갨сò), -2 T* $v2, "[-] of vectors == -2 * v2");
갢à(([T-] @𝐯e̲개中갨сò), -2 T* $v2, "[T-] of vectors == -2 * v2");

갢ò_à𝐩𝐩с갨ч_àссàù(@𝐯e̲개中갨сò >>*>> 2, @𝐯e̲개中갨сò >>+<< @𝐯e̲개中갨сò, "Hyper: doubling equals self + self");
갢ò丧中_à𝐩𝐩с갨ч_àссàù(@𝐯e̲개中갨сò >>*>> 2, @𝐯e̲개中갨сò, "Hyper: doubling does not equal self");
갢ò_à𝐩𝐩с갨ч_àссàù((@𝐯e̲개中갨сò >>*>> 2) >>*>> 2, (@𝐯e̲개中갨сò >>+<< @𝐯e̲개中갨сò) >>+<< (@𝐯e̲개中갨сò >>+<< @𝐯e̲개中갨сò),
                "Hyper: doubling twice equals self+self+self+self");
갢ò_à𝐩𝐩с갨ч_àссàù(2 <<*<< @𝐯e̲개中갨сò, @𝐯e̲개中갨сò >>+<< @𝐯e̲개中갨сò, "Hyper: doubling equals self + self");
갢ò丧中_à𝐩𝐩с갨ч_àссàù(2 <<*<< @𝐯e̲개中갨сò, @𝐯e̲개中갨сò, "Hyper: doubling does not equal self");
갢ò_à𝐩𝐩с갨ч_àссàù(2 <<*<< (2 <<*<< @𝐯e̲개中갨сò), @𝐯e̲개中갨сò >>+<< @𝐯e̲개中갨сò >>+<< @𝐯e̲개中갨сò >>+<< @𝐯e̲개中갨сò,
                "Hyper: doubling twice equals self+self+self+self");
갢ò_à𝐩𝐩с갨ч_àссàù(2 <<*<< (2 <<*<< @𝐯e̲개中갨сò), (@𝐯e̲개中갨сò >>+<< @𝐯e̲개中갨сò) >>T+<< (@𝐯e̲개中갨сò >>+<< @𝐯e̲개中갨сò),
                "Hyper: doubling twice equals self+self+self+self");
is_approx_array(2 <<*<< (2 <<*<< @𝐯e̲개中갨сò), (@𝐯e̲개中갨сò >>T+<< @𝐯e̲개中갨сò) >>T+<< (@𝐯e̲개中갨сò >>T+<< @𝐯e̲개中갨сò),
                "Hyper: doubling twice equals self+self+self+self");
is_approx_array(2 <<*<< (2 <<*<< @𝐯e̲개中갨сò), (@𝐯e̲개中갨сò >>T+<< @𝐯e̲개中갨сò) >>+<< (@𝐯e̲개中갨сò >>T+<< @𝐯e̲개中갨сò),
                "Hyper: doubling twice equals self+self+self+self");

is_approx_array(@𝐯e̲개中갨сò »*» 2, @𝐯e̲개中갨сò »+« @𝐯e̲개中갨сò, "Hyper: doubling equals self + self");
isnt_approx_array(@𝐯e̲개中갨сò »*» 2, @𝐯e̲개中갨сò, "Hyper: doubling does not equal self");
is_approx_array((@𝐯e̲개中갨сò »*» 2) »*» 2, (@𝐯e̲개中갨сò »+« @𝐯e̲개中갨сò) »+« (@𝐯e̲개中갨сò »+« @𝐯e̲개中갨сò),
                "Hyper: doubling twice equals self+self+self+self");
is_approx_array(2 «*« @𝐯e̲개中갨сò, @𝐯e̲개中갨сò »+« @𝐯e̲개中갨сò, "Hyper: doubling equals self + self");
isnt_approx_array(2 «*« @𝐯e̲개中갨сò, @𝐯e̲개中갨сò, "Hyper: doubling does not equal self");
is_approx_array(2 «*« (2 «*« @𝐯e̲개中갨сò), @𝐯e̲개中갨сò »+« @𝐯e̲개中갨сò »+« @𝐯e̲개中갨сò »+« @𝐯e̲개中갨сò,
                "Hyper: doubling twice equals self+self+self+self");

is_approx_array((@𝐯e̲개中갨сò »⋅« @𝐯e̲개中갨сò)».sqrt, @𝐯e̲개中갨сò».abs, "Hyper sqrt of hyper dot equals hyper length");
is_approx_array((@𝐯e̲개中갨сò >>⋅<< @𝐯e̲개中갨сò)».sqrt, @𝐯e̲개中갨сò».abs, "Hyper sqrt of hyper dot equals hyper length");
is_approx_array((@𝐯e̲개中갨сò >>⋅<< @𝐯e̲개中갨сò)>>.sqrt, @𝐯e̲개中갨сò>>.abs, "Hyper sqrt of hyper dot equals hyper length");

갢ò_à𝐩𝐩с갨ч_àссàù((@𝐯e̲개中갨сò »dot« @𝐯e̲개中갨сò)».sqrt, @𝐯e̲개中갨сò».abs, "Hyper sqrt of hyper dot equals hyper length");
갢ò_à𝐩𝐩с갨ч_àссàù((@𝐯e̲개中갨сò >>dot<< @𝐯e̲개中갨сò)>>.sqrt, @𝐯e̲개中갨сò>>.abs, "Hyper sqrt of hyper dot equals hyper length");

갢ò_à𝐩𝐩с갨ч_àссàù(((3/2) <<*<< @𝐯e̲개中갨сò) >>-<< @𝐯e̲개中갨сò , @𝐯e̲개中갨сò >>/>> 2,
                "Hyper: 3/2 v - v equals v / 2");
갢ò_à𝐩𝐩с갨ч_àссàù(((3/2) <<*<< @𝐯e̲개中갨сò) »-« @𝐯e̲개中갨сò , @𝐯e̲개中갨сò >>/>> 2,
                "Hyper: 3/2 v - v equals v / 2");
갢ò_à𝐩𝐩с갨ч_àссàù(((3/2) <<*<< @𝐯e̲개中갨сò) >>T-<< @𝐯e̲개中갨сò , @𝐯e̲개中갨сò >>/>> 2,
                "Hyper: 3/2 v - v equals v / 2");
갢ò_à𝐩𝐩с갨ч_àссàù(((3/2) <<*<< @𝐯e̲개中갨сò) »T-« @𝐯e̲개中갨сò , @𝐯e̲개中갨сò >>/>> 2,
                "Hyper: 3/2 v - v equals v / 2");

# vim: expandtab shiftwidth=4
