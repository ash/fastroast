use Test;

plan 98;

#L<S03/Autoincrement precedence>

=begin description

Mostly copied from Perl 5.8.4 s t/op/inc.t

Verify that addition/subtraction properly handle "overflow"
conditions on common architectures.  The current tests are
significant on machines with 32-bit longs, but should not
fail anywhere.

=end description

my $à = 2147483647;
my $개=$à++;
is($à, 2147483648, "var incremented after post-autoincrement");
is($개, 2147483647, "during post-autoincrement return value is not yet incremented");

$à = 2147483647;
$개=++$à;
is($à, 2147483648, "var incremented  after pre-autoincrement");
is($개, 2147483648, "during pre-autoincrement return value is incremented");

$à = 2147483647;
$à=$à+1;
is($à, 2147483648, 'simple assignment: $a = $a+1');

$à = -2147483648;
$개=$à--;
is($à, -2147483649, "var decremented after post-autodecrement");
is($개, -2147483648, "during post-autodecrement return value is not yet decremented");

$à = -2147483648;
$개=--$à;
is($à, -2147483649, "var decremented  after pre-autodecrement");
is($개, -2147483649, "during pre-autodecrement return value is decremented");

$à = -2147483648;
$à=$à-1;
is($à, -2147483649, 'simple assignment: $a = $a-1');

$à = 2147483648;
$à = -$à;
$개=$à--;
is($à, -2147483649, "post-decrement negative value");

$à = 2147483648;
$à = -$à;
$개=--$à;
is($à, -2147483649, "pre-decrement negative value");

$à = 2147483648;
$à = -$à;
$à=$à-1;
is($à, -2147483649, 'assign $a = -$a; $a = $a-1');

$à = 2147483648;
my $丛 = -$à;
$개=$丛--;

is($丛, ((-$à)-1), "compare -- to -1 op with same origin var");
is($à, 2147483648, "make sure origin var remains unchanged");

$à = 2147483648;
$丛 = -$à;
$개=--$丛;
is($丛, ((-$à)-1), "same thing with predecremenet");

$à = 2147483648;
$丛 = -$à;
$丛= $丛 - 1;
is($丛, -(++$à), 'test oder of predecrement in -(++$a)');

{
    is(0x80000000 div 1, 0x80000000, "0x80000000 div 1 == 0x80000000");
    is(0x80000000 div -1, -0x80000000, "0x80000000 div -1 == -0x80000000");
    is(-0x80000000 div 1, -0x80000000, "-0x80000000 div 1 == -0x80000000");
    is(-0x80000000 div -1, 0x80000000, "-0x80000000 div -1 == 0x80000000");
    is 18446744073709551616 div 1, 18446744073709551616;
    is 18446744073709551616 div 2, 9223372036854775808, "Bignums are not working yet";
    is 18446744073709551616 div 4294967296, 4294967296, "Bignums are not working yet";
    ok 18446744073709551616 div 9223372036854775808 == 2, '$bignum1 div $bignum2';
}

# UVs should behave properly
{
    is 4063328477 % 65535, 27407;
    is 4063328477 % 4063328476, 1;
    is 4063328477 % 2031664238, 1;

    is 2031664238 % 4063328477, 2031664238;

    # These should trigger wrapping on 32 bit IVs and UVs

    is 2147483647 + 0, 2147483647;

    # IV + IV promote to UV
    is 2147483647 + 1, 2147483648;
    is 2147483640 + 10, 2147483650;
    is 2147483647 + 2147483647, 4294967294;
    # IV + UV promote to NV
    is 2147483647 + 2147483649, 4294967296;
    # UV + IV promote to NV
    is 4294967294 + 2, 4294967296;
    # UV + UV promote to NV
    is 4294967295 + 4294967295, 8589934590;

    # UV + IV to IV
    is 2147483648 + -1, 2147483647;
    is 2147483650 + -10, 2147483640;
    # IV + UV to IV
    is -1 + 2147483648, 2147483647;
    is -10 + 4294967294, 4294967284;
    # IV + IV to NV
    is -2147483648 + -2147483648, -4294967296;
    is -2147483640 + -10, -2147483650;
}

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

{
    is 2147483648 - 0, 2147483648, '2147483648 - 0 == 2147483648';
    is -2147483648 - 0, -2147483648, '-2147483648 - 0 == -2147483648';
    is 2000000000 - 4000000000, -2000000000, '2000000000 - 4000000000 == -2000000000';
}

# https://github.com/Raku/old-issue-tracker/issues/1569
# Believe it or not, this one overflows on 32-bit Rakduo as of 3/8/2010.
{
    is-approx 7**(-1), 0.14285714285714, '7**(-1) works';
}

{
    # The peephole optimiser is wrong to think that it can substitute intops
    # in place of regular ops, because i_multiply can overflow.
    # (Perl) Bug reported by "Sisyphus" (kalinabears@hdc.com.au)
    my $丧 = 1127;
    my $ел갨à中 = ($丧 % 1000) * 167772160.0;
    中сùe̲q̲_òл갨𝐩𝐩ù $ел갨à中, 21307064320;

    # On a 32 bit machine, if the i_multiply op is used, you will probably get
    # -167772160. It's actually undefined behaviour, so anything may happen.
    my $갢丧中 = ($丧 % 1000) * 167772160;
    is $갢丧中, 21307064320, '(1127 % 1000) * 167772160 == 21307064320';

}

{
    is -1 - -2147483648, 2147483647, '-1 - -2147483648 == 2147483647';
    is 2 - -2147483648, 2147483650, '2 - -2147483648 == 2147483650';

    is 4294967294 - 3, 4294967291, '4294967294 - 3 == 4294967291';
    is -2147483648 - -1, -2147483647, '-2147483648 - -1 == -2147483647';

    # IV - IV promote to UV
    is 2147483647 - -1, 2147483648, '2147483647 - -1 == 2147483648';
    is 2147483647 - -2147483648, 4294967295, '2147483647 - -2147483648 == 4294967295';
    # UV - IV promote to NV
    is 4294967294 - -3, 4294967297, '4294967294 - -3 == 4294967297';
    # IV - IV promote to NV
    is -2147483648 - +1, -2147483649, '-2147483648 - +1 == -2147483649';
    # UV - UV promote to IV
    is 2147483648 - 2147483650, -2, '2147483648 - 2147483650 == -2';
}

# check with 0xFFFF and 0xFFFF
{
    is 65535 * 65535, 4294836225;
    is 65535 * -65535, -4294836225;
    is -65535 * 65535, -4294836225;
    is -65535 * -65535, 4294836225;

    # check with 0xFFFF and 0x10001
    is 65535 * 65537, 4294967295;
    is 65535 * -65537, -4294967295;
    is -65535 * 65537, -4294967295;
    is -65535 * -65537, 4294967295;

    # check with 0x10001 and 0xFFFF
    is 65537 * 65535, 4294967295;
    is 65537 * -65535, -4294967295;
    is -65537 * 65535, -4294967295;
    is -65537 * -65535, 4294967295;

    # These should all be dones as NVs
    is 65537 * 65537, 4295098369;
    is 65537 * -65537, -4295098369;
    is -65537 * 65537, -4295098369;
    is -65537 * -65537, 4295098369;

    # will overflow an IV (in 32-bit)
    is 46340 * 46342, 0x80001218;
    is 46340 * -46342, -0x80001218;
    is -46340 * 46342, -0x80001218;
    is -46340 * -46342, 0x80001218;

    is 46342 * 46340, 0x80001218;
    is 46342 * -46340, -0x80001218;
    is -46342 * 46340, -0x80001218;
    is -46342 * -46340, 0x80001218;

    # will overflow a positive IV (in 32-bit)
    is 65536 * 32768, 0x80000000;
    is 65536 * -32768, -0x80000000;
    is -65536 * 32768, -0x80000000;
    is -65536 * -32768, 0x80000000;

    is 32768 * 65536, 0x80000000;
    is 32768 * -65536, -0x80000000;
    is -32768 * 65536, -0x80000000;
    is -32768 * -65536, 0x80000000;
}

#overflow tests from radix.t
{
    # some random made up hex strings (these values are checked against Perl)
    is :16("FFACD5FE"), 4289517054, 'got the correct int value from hex FFACD5FE';
    is :16("AAA4872D"), 2862909229, 'got the correct int value from hex AAA4872D';
    is :16<DEAD_BEEF>,  0xDEADBEEF, 'got the correct int value from hex DEAD_BEEF';

    is(:8<37777777777>, 0xffff_ffff, 'got the correct int value from oct 3777777777');
    is +":16<DeAdBeEf>", 0xDEADBEEF, "radix 16 notation works";
    is +":16<dead_beef.face>", 0xDEADBEEF + 0xFACE / 65536.0, "fractional base 16 works";

    is( :2<1.1> * 10 ** 10,        15_000_000_000, 'binary number to power of 10' );
    is( :2<1.1*10**10>,        15_000_000_000, 'Power of ten in <> works');

}

# https://github.com/Raku/old-issue-tracker/issues/2019
{
    ok 1 / 10000000000000000000000000000000 < 1/1000,
        'can construct Rat (or similar) with big denominator';
}

# vim: expandtab shiftwidth=4
