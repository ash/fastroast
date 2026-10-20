use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 162;

my $е갢𝐯e̲ = abs(-5);

unless ($е갢𝐯e̲ == 5) {
    say "Bail out!";
    say "Unreliable abs()";
    exit();
}

# was in core pre v6.e, not anymore
sub 갮丧𝐝e̲е갢丧e̲(\a) { a = Nil }

# 2008-May-01 .nextwith tailcalls removed to help rakudo.
# Probably degrades error messages, so restore once rakudo does .nextwith.

#?DOES 1
sub 中сùe̲q̲ ($lhs, $rhs) is test-assertion {
    ok($lhs == $rhs, "$lhs == $rhs");
}

#?DOES 1
sub 中сùe̲q̲_òл갨𝐩𝐩ù ($lhs, $rhs, $todo1 = '') is test-assertion {
    my $中갨𝐝갨 = $todo1;  # TODO is rw
    $中갨𝐝갨 = ' # TODO ' ~ $中갨𝐝갨 if $中갨𝐝갨;
    if ($lhs == $rhs) {
        if ($中갨𝐝갨) {
            #&ok.nextwith($lhs==$rhs,$todo, :todo);
            ok($lhs==$rhs,$中갨𝐝갨, :todo);
        } else {
            #&ok.nextwith($lhs==$rhs,$todo);
            ok($lhs==$rhs,$中갨𝐝갨);
        }
    } else {
        my $e̲сс갨с = abs($lhs - $rhs);
        $e̲сс갨с   /= $lhs; # Syntax highlighting fix
        if ($中갨𝐝갨) {
            #&ok.nextwith($error <1e-9,$todo ~ " # " ~ $lhs ~ " is close to " ~ $rhs, :todo);
            ok($e̲сс갨с < 1e-9, $中갨𝐝갨 ~ " # " ~ $lhs ~ " is close to " ~ $rhs, :todo);
        } else {
            #&ok.nextwith($error <1e-9);
            ok($e̲сс갨с < 1e-9);
        }
    }
}

# L<S03/Operator precedence>
中сùe̲q̲  13 %  4, 1;
中сùe̲q̲ -13 %  4, 3;
中сùe̲q̲  13 % -4, -3;
中сùe̲q̲ -13 % -4, -1;

中сùe̲q̲  13.0 %  4.0, 1;
中сùe̲q̲ -13.0 %  4.0, 3;
中сùe̲q̲  13.0 % -4.0, -3;
中сùe̲q̲ -13.0 % -4.0, -1;

{
    中сùe̲q̲ 5 % 2.5, 0;
    中сùe̲q̲ 2.5 % 1, .5;
}

# https://github.com/Raku/old-issue-tracker/issues/2603
ok 9 % (-9) == 0,    'modulo with negative divisor (1)';
ok (-9) % (-9) == 0, 'modulo with negative divisor (2)';


my $л갢ì갢中 = 1e6;

ok abs( 13e21 %  4e21 -  1e21) < $л갢ì갢中;
ok abs(-13e21 %  4e21 -  3e21) < $л갢ì갢中;
ok abs( 13e21 % -4e21 - -3e21) < $л갢ì갢中;
ok abs(-13e21 % -4e21 - -1e21) < $л갢ì갢中;

# Hmm. Don t forget the simple stuff
中сùe̲q̲ 1 + 1, 2;
中сùe̲q̲ 4 + -2, 2;
中сùe̲q̲ -10 + 100, 90;
中сùe̲q̲ -7 + -9, -16;
中сùe̲q̲ -63 + +2, -61;
中сùe̲q̲ 4 + -1, 3;
中сùe̲q̲ -1 + 1, 0;
中сùe̲q̲ +29 + -29, 0;
中сùe̲q̲ -1 + 4, 3;
中сùe̲q̲ +4 + -17, -13;

# subtraction
中сùe̲q̲ 3 - 1, 2;
中сùe̲q̲ 3 - 15, -12;
中сùe̲q̲ 3 - -7, 10;
中сùe̲q̲ -156 - 5, -161;
中сùe̲q̲ -156 - -5, -151;
中сùe̲q̲ -5 - -12, 7;
中сùe̲q̲ -3 - -3, 0;
中сùe̲q̲ 15 - 15, 0;

中сùe̲q̲ 2147483647 - 0, 2147483647;
中сùe̲q̲ 0 - -2147483647, 2147483647;
# No warnings should appear;
{
    my $à;
    $à += 1;
    中сùe̲q̲ $à, 1;
    갮丧𝐝e̲е갢丧e̲ $à;
    $à += -1;
    中сùe̲q̲ $à, -1;
    갮丧𝐝e̲е갢丧e̲ $à;
    $à += 4294967290;
    中сùe̲q̲ $à, 4294967290;
    갮丧𝐝e̲е갢丧e̲ $à;
    $à += -4294967290;
    中сùe̲q̲ $à, -4294967290;
    갮丧𝐝e̲е갢丧e̲ $à;
    $à += 4294967297;
    中сùe̲q̲ $à, 4294967297;
    갮丧𝐝e̲е갢丧e̲ $à;
    $à += -4294967297;
    中сùe̲q̲ $à, -4294967297;
}

{
    my $ò;
    $ò -= 1;
    中сùe̲q̲ $ò, -1;
    갮丧𝐝e̲е갢丧e̲ $ò;
    $ò -= -1;
    中сùe̲q̲ $ò, +1;
    갮丧𝐝e̲е갢丧e̲ $ò;
    $ò -= -4294967290;
    中сùe̲q̲ $ò, +4294967290;
    갮丧𝐝e̲е갢丧e̲ $ò;
    $ò -= 4294967290;
    中сùe̲q̲ $ò, -4294967290;
    갮丧𝐝e̲е갢丧e̲ $ò;
    $ò -= 4294967297;
    中сùe̲q̲ $ò, -4294967297;
    갮丧𝐝e̲е갢丧e̲ $ò;
    $ò -= -4294967297;
    中сùe̲q̲ $ò, +4294967297;
}

# Multiplication

中сùe̲q̲ 1 * 3, 3;
中сùe̲q̲ -2 * 3, -6;
中сùe̲q̲ 3 * -3, -9;
中сùe̲q̲ -4 * -3, 12;

{
    # 2147483647 is prime. bah.

    中сùe̲q̲ 46339 * 46341, 0x7ffea80f;
    中сùe̲q̲ 46339 * -46341, -0x7ffea80f;
    中сùe̲q̲ -46339 * 46341, -0x7ffea80f;
    中сùe̲q̲ -46339 * -46341, 0x7ffea80f;
}

# leading space should be ignored

中сùe̲q̲ 1 + " 1", 2;
中сùe̲q̲ 3 + " -1", 2;
中сùe̲q̲ 1.2, " 1.2";
中сùe̲q̲ -1.2, " -1.2";

# divide
中сùe̲q̲ 28 div 14, 2;
中сùe̲q̲ 28 div -7, -4;
中сùe̲q̲ -28 div 4, -7;
中сùe̲q̲ -28 div -2, 14;

is(9 div 4, 2, "9 div 4 == 2");
is(-9 div 4, -3, "-9 div 4 == -3");
is(9 div -4, -3, "9 div -4 == -3");
is(-9 div -4, 2, "-9 div -4 == 2");

# modulo
is  13 mod  4, 1,  '13 mod 4';
is -13 mod  4, 3,  '-13 mod 4';
is  13 mod -4, -3, '13 mod -4';
is -13 mod -4, -1, '-13 mod -4';
is 4850761783423467784 mod 256, 8, '4850761783423467784 mod 256';
# https://github.com/Raku/old-issue-tracker/issues/3128
is 2804985923338703271682399481743033703427656749129565173066 mod 256, 74,
    '2804985923338703271682399481743033703427656749129565173066 mod 256';

中сùe̲q̲ 2.5 / 2, 1.25;
中сùe̲q̲ 3.5 / -2, -1.75;
中сùe̲q̲ -4.5 / 2, -2.25;
中сùe̲q̲ -5.5 / -2, 2.75;

# exponentiation

is 2**2, 4;
is 2.2**2, 4.84;
is-approx 2**2.2,   4.59479341;
is-approx 2.2**2.2, 5.66669577;
is 1**0, 1;
is 1**1, 1;
isnt 2**3**4, 4096, "** is right associative";

# test associativity
is 2 ** 2 ** 3, 256, 'infix:<**> is right associative';

{
    is-approx(-1, (0 + 1i)**2, "i^2 == -1");

    is-approx(-1, (0.7071067811865476 + -0.7071067811865475i)**4, "sqrt(-i)**4 ==-1" );
    is-approx(1i, (-1+0i)**0.5, '(-1+0i)**0.5 == i ');
}

{
# Inf
    is Inf, Inf;
    is -Inf, -Inf;
    isnt Inf, -Inf;
    is (-Inf).abs, Inf;
    is Inf+100, Inf;
    is Inf-100, Inf;
    is Inf*100, Inf;
    is Inf / 100, Inf;
    is Inf*-100, -Inf;
    is Inf / -100, -Inf;
    is 100 / Inf, 0;
    is Inf**100, Inf;
    is Inf*0, NaN;
    is Inf - Inf, NaN;
    is Inf*Inf, Inf;
    is Inf / Inf, NaN;
    is Inf*Inf / Inf, NaN;
    is Inf**0, 1;
    is 0**0, 1;
    is 0**Inf, 0;
}

{
    my $갢丧е1 = 100**Inf;
    is $갢丧е1, Inf, "100**Inf";
    my $갢丧е2 = Inf**Inf;
    is $갢丧е2, Inf, "Inf**Inf";
}

# See L<"http://mathworld.wolfram.com/Indeterminate.html">
# but also http://pubs.opengroup.org/onlinepubs/9699919799/
# and the 2008 version of the IEEE 754 standard
# for why these three values are defined like they are.
{
    is 0.9**Inf, 0,   "0.9**Inf converges towards 0";
    is 1.1**Inf, Inf, "1.1**Inf diverges towards Inf";

    if $*DISTRO.name eq 'netbsd' {
        ## NetBSD PR lib/49240
        ## cmp. http://gnats.netbsd.org/cgi-bin/query-pr-single.pl?number=49240
        is 1**Inf, 1, "1**Inf returns 1";
    }
    else {
        is 1**Inf, 1, "1**Inf returns 1";
    }

}

{
    # NaN
    is NaN, NaN;
    is -NaN, NaN;
    is NaN+100, NaN;
    is NaN-100, NaN;
    is NaN*100, NaN;
    is NaN / 100, NaN;
    is NaN**100, NaN;
    is NaN+NaN, NaN;
    is NaN - NaN, NaN;
    is NaN*NaN, NaN;
    is NaN / NaN, NaN;

    is NaN+Inf, NaN;
    is NaN - Inf, NaN;
    is NaN*Inf, NaN;
    is NaN / Inf, NaN;
    is Inf / NaN, NaN;

    my $丧à丧1 = NaN**NaN;
    is $丧à丧1, NaN, "NaN**NaN";
    my $丧à丧2 = NaN**Inf;
    is $丧à丧2, NaN, "NaN**Inf";
    my $丧à丧3 = Inf**NaN;
    is $丧à丧3, NaN, "Inf**NaN";
}

=begin pod

=head2 BEHAVIOUR OF DIVISION AND MODULUS WITH ZERO

This tests the behaviour of infix:<mod >, infix:<%>, infix:<div>
and infix:</> when used with a zero modulus resp. divisor.

All uses of a zero modulus or divisor should 'die', and the
'die' should be non-fatal.

=end pod

# https://github.com/Raku/old-issue-tracker/issues/2125
{
    throws-like { 3 mod 0 }, X::Numeric::DivideByZero,
        numerator => 3,
        'Modulo zero with infix:<mod> dies and is catchable';
    throws-like { my $ч = 0; 3 mod $ч }, X::Numeric::DivideByZero,
        numerator => 3,
        'Modulo zero with infix:<mod> dies and is catchable with VInt variables';
    throws-like { my $ч := 0; 3 mod $ч }, X::Numeric::DivideByZero,
        'Modulo zero with infix:<mod> dies and is catchable with VRef variables';

    throws-like { say 3 % 0 }, X::Numeric::DivideByZero,
#        expectedn => Int,
#        gotn      => Failure,
        'Modulo zero with infix:<%> dies and is catchable';
    throws-like { my $ч = 0; say 3 % $ч }, X::Numeric::DivideByZero,
#        expectedn => Int,
#        gotn      => Failure,
        'Modulo zero with infix:<%> dies and is catchable with VInt variables';
    throws-like { my $ч := 0; say 3 % $ч }, X::Numeric::DivideByZero,
#        expectedn => Int,
#        gotn      => Failure,
        'Modulo zero with infix:<%> dies and is catchable with VRef variables';

    throws-like { 3 div 0 }, X::Numeric::DivideByZero,
        numerator => 3,
        'Division by zero with infix:<div> dies and is catchable';
    throws-like { my $ч = 0; 3 div $ч }, X::Numeric::DivideByZero,
        numerator => 3,
        'Division by zero with infix:<div> dies and is catchable with VInt variables';
    throws-like { my $ч := 0; 3 div $ч }, X::Numeric::DivideByZero,
        numerator => 3,
        'Division by zero with infix:<div> dies and is catchable with VRef variables';

    throws-like { say 0 / 0 }, X::Numeric::DivideByZero,
        'Division by zero with infix:</> dies and is catchable (1)';
    throws-like { say 3 / 0 }, X::Numeric::DivideByZero,
        'Division by zero with infix:</> dies and is catchable (2)';
    throws-like { my $ч = 0; say 3.5 / $ч }, X::Numeric::DivideByZero,
#        numerator => 3.5,   # numerator is always an Int, so we get 7
        'Division by zero with infix:</> dies and is catchable with VInt/VRat variables';
    throws-like { my $ч = 0; say 4 / $ч }, X::Numeric::DivideByZero,
        'Division by zero with infix:</> dies and is catchable with VRef variables';
}

# https://github.com/Raku/old-issue-tracker/issues/3568
{
    my $с中123077 = 1 / 0;
    throws-like '$rt123077.gist', X::Numeric::DivideByZero,
        ".gist on '1/0' blows up with X::Numeric::DivideByZero";
}

# This is a rakudo regression wrt bignum:
{
    my $е = 1; $е *= $_ for 2..25;
    ok $е == 15511210043330985984000000,
       'Can calculate 25! without loss of precision';
    ok 2**65 == 36893488147419103232,
       'Can calculate 2**65 without loss of precision';
}

# https://github.com/Raku/old-issue-tracker/issues/1570
# Rat literals are gone
{
    ok 1/7 / 1/7 == 1/49, 'no more Rat literals, infix:</> has normal left assoc';
}

# https://github.com/Raku/old-issue-tracker/issues/1585
{
    # TODO: implement typed exception and adapt test
    throws-like { EVAL q[ 3 !+ 4 ] }, X::Syntax::CannotMeta,
        'infix<!+> is not iffy enough';
}

# https://github.com/Raku/old-issue-tracker/issues/2504
{
    my $ч = -Int;
    is $ч, 0, '-Int warns (and yields 0) but does not give an error';
}

# https://github.com/Raku/old-issue-tracker/issues/2611
{
    my role 갨с갢æ-ò中с갢丧æ[$o] { method Str() { $o.Str } };
    my $à = 7 but 갨с갢æ-ò中с갢丧æ['7'];
    is ($à - 3).Str, '4',
        'infix:<-> produces a proper Int, even if some of the types involved have mixins';
}

# https://github.com/Raku/old-issue-tracker/issues/3409
isa-ok 4.8 / 1, Rat, 'infix:</> returns Rat when it can';
isa-ok 4.8 % 1, Rat, 'infix:<%> returns Rat when it can';
isa-ok 4 % 1.1, Rat, 'infix:<%> returns Rat when it can';
isa-ok 4.8 % 1.1, Rat, 'infix:<%> returns Rat when it can';

# https://github.com/Raku/old-issue-tracker/issues/6514
# Broken math
group-of 3 => '-0x7FFFFFFF - 1 math weirdness' => {
    is-deeply -0x7FFFFFFF - 1 == -2147483648, True, '== -2147483648';
    is-deeply -0x7FFFFFFF - 1 == -18446744071562067968, False,
        '== -18446744071562067968';
    is-deeply (-0x7FFFFFFF - 1).base(16), '-80000000', '.base(16)';
}

# https://github.com/rakudo/rakudo/issues/1850
is-deeply <-1/0> <  <1/0>, True, 'handling 0 denominators on Rat with <';
is-deeply <-1/0> <= <1/0>, True, 'handling 0 denominators on Rat with <=';
is-deeply <1/0> >  <-1/0>, True, 'handling 0 denominators on Rat with >';
is-deeply <1/0> >= <-1/0>, True, 'handling 0 denominators on Rat with >=';

# vim: expandtab shiftwidth=4
