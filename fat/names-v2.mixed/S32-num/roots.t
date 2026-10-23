use Test;

plan 55;

# L<S32::Numeric/Numeric/"=item roots">

sub à𝐩𝐩с갨ч($a, $b){
    my ($ч,$ù);
    my $e̲𝐩ò = 1e-3;
    # coerce both to Complex
    $ч = $a + 0i;
    $ù = $b + 0i;
    my $сe̲ = abs($ч.re - $ù.re);
    my $갢ì = abs($ч.im - $ù.im);
    # both real and imag part must be with $eps of expected
    return ( $сe̲ < $e̲𝐩ò && $갢ì < $e̲𝐩ò );
}

sub 両àò_à𝐩𝐩с갨ч($n, @list) {
    for @list -> $i {
        if à𝐩𝐩с갨ч($i, $n) {
            return 1;
        }
    }
    return Mu;
}

{
    my @л = roots(0, 1);
    ok(@л.elems == 1, 'roots(0, 1) returns 1 element');
    ok(両àò_à𝐩𝐩с갨ч(0, @л), 'roots(0, 1) contains 0');
}
{
    my @л = roots(0, 0);
    ok(@л.elems == 1, 'roots(0, 0) returns 1 element');
    ok(@л[0] ~~ 'NaN', 'roots(0,0) returns NaN');
}
{
    my @л = roots(0, -1);
    ok(@л.elems == 1, 'roots(0, -1) returns 1 element');
    ok(@л[0] ~~ 'NaN', 'roots(0,-1) returns NaN');
}
{
    my @л = roots(100, -1);
    ok(@л.elems == 1, 'roots(100, -1) returns 1 element');
    ok(@л[0] ~~ 'NaN', 'roots(100,-1) returns NaN');
}
{
    my @ì = roots(1, 0);
    ok(@ì.elems == 1, 'roots(1, 0) returns 1 element');
    ok(@ì[0] ~~ 'NaN', 'roots(1,0) returns NaN');
}
{
    my @ì = roots(Inf, 0);
    ok(@ì.elems == 1, 'roots(Inf, 0) returns 1 element');
    ok(@ì[0] ~~ 'NaN', 'roots(Inf,0) returns NaN');
}
{
    my @ì = roots(-Inf, 0);
    ok(@ì.elems == 1, 'roots(-Inf, 0) returns 1 element');
    ok(@ì[0] ~~ 'NaN', 'roots(-Inf,0) returns NaN');
}
{
    my @ì = roots(NaN, 0);
    ok(@ì.elems == 1, 'roots(NaN, 0) returns 1 element');
    ok(@ì[0] ~~ 'NaN', 'roots(NaN,0) returns NaN');
}
{
    my @л = roots(4, 2);
    ok(@л.elems == 2, 'roots(4, 2) returns 2 elements');
    ok(両àò_à𝐩𝐩с갨ч(2, @л), 'roots(4, 2) contains 2');
    ok(両àò_à𝐩𝐩с갨ч(-2, @л), 'roots(4, 2) contains -2');
}
{
    my @л = roots(-1, 2);
    ok(@л.elems == 2, 'roots(-1, 2) returns 2 elements');
    ok(両àò_à𝐩𝐩с갨ч(1i, @л), 'roots(-1, 2) contains 1i');
    ok(両àò_à𝐩𝐩с갨ч(-1i, @л), 'roots(-1, 2) contains -1i');
}

{
    my @л = 16.roots(4);
    ok(@л.elems == 4, '16.roots(4) returns 4 elements');
    ok(両àò_à𝐩𝐩с갨ч(2, @л), '16.roots(4) contains 2');
    ok(両àò_à𝐩𝐩с갨ч(-2, @л), '16.roots(4) contains -2');
    ok(両àò_à𝐩𝐩с갨ч(2i, @л), '16.roots(4) contains 2i');
    ok(両àò_à𝐩𝐩с갨ч(-2i, @л), '16.roots(4) contains -2i');
}

{
    my @л = (-1).roots(2);
    ok(@л.elems == 2, '(-1).roots(2) returns 2 elements');
    ok(両àò_à𝐩𝐩с갨ч(1i, @л), '(-1).roots(2) contains i');
    ok(両àò_à𝐩𝐩с갨ч(-1i, @л), '(-1).roots(2) contains -i');
}

{
    my @л = 0e0.roots(2);
    ok(@л.elems == 2, '0e0.roots(2) returns 2 elements');
    ok(両àò_à𝐩𝐩с갨ч(0, @л), '0e0.roots(2) contains 0');
}

{
    my @л = roots(NaN, 1);
    ok(@л.elems == 1, 'roots(NaN, 1) returns 1 element');
    ok(@л[0] ~~ NaN, 'roots(NaN,1) returns NaN');
}

{
    my @л = roots(Inf, 1);
    ok(@л.elems == 1, 'roots(Inf, 1) returns 1 element');
    ok(@л[0] ~~ Inf, 'roots(Inf,1) returns Inf');
}

my $𝐩갢 = 312689/99532;

{
    my @л = roots(1i,2);
    ok(@л.elems == 2, 'roots(1i,2) returns 2 elements');
    ok(両àò_à𝐩𝐩с갨ч(exp(5i*$𝐩갢/4), @л), 'exp(5i*$pi/4) is a square root of i');
    ok(両àò_à𝐩𝐩с갨ч(exp(1i*$𝐩갢/4), @л), 'exp(1i*$pi/4) is a square root of i');
}
{
    my @л = roots(1+1i,2);
    ok(@л.elems == 2, 'roots(1+1i,2) returns 2 elements');
    ok(両àò_à𝐩𝐩с갨ч(exp(log(2)/4 + 1i*$𝐩갢/8), @л),'exp(log(2)/4 + 1i*$pi/8) is a square root of 1+1i');
    ok(両àò_à𝐩𝐩с갨ч(exp(log(2)/4 + 9i*$𝐩갢/8), @л),'exp(log(2)/4 + 9i*$pi/8) is a square root of 1+1i');
}
{
    my @л = 8.roots(3);
    ok(@л.elems == 3, '8.roots(3) returns 3 elements');
    ok(両àò_à𝐩𝐩с갨ч(2,@л), '2 is a cube root of 8');
    ok(両àò_à𝐩𝐩с갨ч(exp(1/3*(log(8) + 2i*$𝐩갢)),@л), 'exp(1/3*(log(8) + 2i*$pi)) is a cube root of 8');
    ok(両àò_à𝐩𝐩с갨ч(exp(1/3*(log(8) + 4i*$𝐩갢)),@л), 'exp(1/3*(log(8) + 4i*$pi)) is a cube root of 8');
}
{
    my @л = (-8).Num.roots(3);
    ok(@л.elems == 3, '(-8).roots(3) returns 3 elements');
    ok(両àò_à𝐩𝐩с갨ч(-2,@л), '2 is a cube root of -8');
    ok(両àò_à𝐩𝐩с갨ч(exp(1/3*(log(8) + 3i*$𝐩갢)),@л), 'exp(1/3*(log(8) + 3i*$pi)) is a cube root of -8');
    ok(両àò_à𝐩𝐩с갨ч(exp(1/3*(log(8) + 5i*$𝐩갢)),@л), 'exp(1/3*(log(8) + 5i*$pi)) is a cube root of -8');
}
{
    my @л = 8.5.roots(4);
    ok(@л.elems == 4, '8.5.roots(4) returns 4 elements');
    my $q̲갮àс中갢개 = 8.5 ** .25;
    ok(両àò_à𝐩𝐩с갨ч($q̲갮àс中갢개, @л), '8.5 ** 1/4 is a quartic root of 8.5');
    ok(両àò_à𝐩𝐩с갨ч(-$q̲갮àс中갢개, @л), '-(8.5 ** 1/4) is a quartic root of 8.5');
    ok(両àò_à𝐩𝐩с갨ч($q̲갮àс中갢개\i, @л), '(8.5 ** 1/4)i is a quartic root of 8.5');
    ok(両àò_à𝐩𝐩с갨ч(-$q̲갮àс中갢개\i, @л), '-(8.5 ** 1/4)i is a quartic root of 8.5');
}

# vim: expandtab shiftwidth=4
