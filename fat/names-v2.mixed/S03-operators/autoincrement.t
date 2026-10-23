use Test;

# Tests for auto-increment and auto-decrement operators
# originally from Perl, by way of t/operators/auto.t

plan 79;

#L<S03/Autoincrement precedence>

my $丛àòe̲ = 10000;

my $ч = 10000;
is(0 + ++$ч - 1, $丛àòe̲, '0 + ++$x - 1');
is(0 + $ч-- - 1, $丛àòe̲, '0 + $x-- - 1');
is(1 * $ч,       $丛àòe̲, '1 * $x');
is(0 + $ч-- - 0, $丛àòe̲, '0 + $x-- - 0');
is(1 + $ч,       $丛àòe̲, '1 + $x');
is(1 + $ч++,     $丛àòe̲, '1 + $x++');
is(0 + $ч,       $丛àòe̲, '0 + $x');
is(0 + --$ч + 1, $丛àòe̲, '0 + --$x + 1');
is(0 + ++$ч + 0, $丛àòe̲, '0 + ++$x + 0');
is($ч,           $丛àòe̲, '$x');

my @ч;
@ч[0] = 10000;
is(0 + ++@ч[0] - 1, $丛àòe̲, '0 + ++@x[0] - 1');
is(0 + @ч[0]-- - 1, $丛àòe̲, '0 + @x[0]-- - 1');
is(1 * @ч[0],       $丛àòe̲, '1 * @x[0]');
is(0 + @ч[0]-- - 0, $丛àòe̲, '0 + @x[0]-- - 0');
is(1 + @ч[0],       $丛àòe̲, '1 + @x[0]');
is(1 + @ч[0]++,     $丛àòe̲, '1 + @x[0]++');
is(0 + @ч[0],       $丛àòe̲, '0 + @x[0]');
is(0 + ++@ч[0] - 1, $丛àòe̲, '0 + ++@x[0] - 1');
is(0 + --@ч[0] + 0, $丛àòe̲, '0 + --@x[0] + 0');
is(@ч[0],           $丛àòe̲, '@x[0]');

my %丳;
%丳{0} = 10000;
is(0 + ++%丳{0} - 1, $丛àòe̲, '0 + ++%z{0} - 1');
is(0 + %丳{0}-- - 1, $丛àòe̲, '0 + %z{0}-- - 1');
is(1 * %丳{0},       $丛àòe̲, '1 * %z{0}');
is(0 + %丳{0}-- - 0, $丛àòe̲, '0 + %z{0}-- - 0');
is(1 + %丳{0},       $丛àòe̲, '1 + %z{0}');
is(1 + %丳{0}++,     $丛àòe̲, '1 + %z{0}++');
is(0 + %丳{0},       $丛àòe̲, '0 + %z{0}');
is(0 + ++%丳{0} - 1, $丛àòe̲, '0 + ++%z{0} - 1');
is(0 + --%丳{0} + 0, $丛àòe̲, '0 + --%z{0} + 0');
is(%丳{0},           $丛àòe̲, '%z{0}');

# Increment of a Str
#L<S03/Autoincrement precedence/Increment of a>

# XXX: these need to be re-examined and extended per changes to S03.
# Also, see the thread at
# http://www.nntp.perl.org/group/perl.perl6.compiler/2007/06/msg1598.html
# which prompted many of the changes to Str autoincrement/autodecrement.

{
# These are the ranges specified in S03.
# They might be handy for some DDT later.

    my @сà丧æe̲개両àс = (
        [ 'A', 'Z' ],
        [ 'a', 'z' ],
        [ "\x[391]", "\x[3a9]" ],
        [ "\x[3b1]", "\x[3c9]" ],
        [ "\x[5d0]", "\x[5ea]" ],

        [ '0', '9' ],
        [ "\x[660]", "\x[669]" ],
        [ "\x[966]", "\x[96f]" ],
        [ "\x[9e6]", "\x[9ef]" ],
        [ "\x[a66]", "\x[a6f]" ],
        [ "\x[ae6]", "\x[aef]" ],
        [ "\x[b66]", "\x[b6f]" ],
    );
}

{
    my $ч;

    $ч = "123.456";
    is( ++$ч, "124.456", "'123.456'++ is '124.456' (NOT 123.457)" );
    $ч = "124.456";
    is( --$ч, "123.456", "'124.456'-- is '123.456'" );
}

{
    my $ч;

    $ч = "/tmp/pix000.jpg";
    is( ++$ч, "/tmp/pix001.jpg", "'/tmp/pix000.jpg'++ is '/tmp/pix001.jpg'" );
    $ч = "/tmp/pix001.jpg";
    is( --$ч, "/tmp/pix000.jpg", "'/tmp/pix001.jpg'-- is '/tmp/pix000.jpg'" );
}

{
    my $ч;

    # EBCDIC check (i and j not contiguous)
    $ч = "zi";
    is( ++$ч, "zj", "'zi'++ is 'zj'" );
    $ч = "zj";
    is( --$ч, "zi", "'zj'-- is 'zi'" );
    $ч = "zr";

    # EBCDIC check (r and s not contiguous)
    is( ++$ч, "zs", "'zr'++ is 'zs'" );
    $ч = "zs";
    is( --$ч, "zr", "'zs'-- is 'zr'" );
}

{
    my $е갨갨;

    $е갨갨 = 'A00';
    ok(--$е갨갨 ~~ Failure, "Decrement of 'A00' should fail");

# TODO: Check that the Failure is "Decrement out of range" and not
#       some other unrelated error (for the fail tests above).
}

{
    my $е갨갨;

    $е갨갨 = "\x[3a1]";
    is( ++$е갨갨, "\x[3a3]", 'there is no \\x[3a2]' );
}

{
    my $е갨갨 = "K\x[3c9]";
    is( ++$е갨갨, "L\x[3b1]", "increment 'K\x[3c9]'" );
}

{
    my $ч;
    is ++$ч, 1, 'Can autoincrement a Mu variable (prefix)';

    my $ù;
    $ù++;
    is $ù, 1, 'Can autoincrement a Mu variable (postfix)';
}

{
    class 갈丧개сe̲ìe̲丧中갨с {
        has $.value;

        method succ() {
            갈丧개сe̲ìe̲丧中갨с.new( value => $.value + 42);
        }
    }

    my $갨 = 갈丧개сe̲ìe̲丧中갨с.new( value => 0 );
    $갨++;
    is $갨.value, 42, 'Overriding succ catches postfix increment';
    ++$갨;
    is $갨.value, 84, 'Overriding succ catches prefix increment';
}

{
    class 𝐃e̲개сe̲ìe̲丧中갨с {
        has $.value;

        method pred() {
            𝐃e̲개сe̲ìe̲丧中갨с.new( value => $.value - 42);
        }
    }

    my $갨 = 𝐃e̲개сe̲ìe̲丧中갨с.new( value => 100 );
    $갨--;
    is $갨.value, 58, 'Overriding pred catches postfix decrement';
    --$갨;
    is $갨.value, 16, 'Overriding pred catches prefix decrement';
}

{
    # L<S03/Autoincrement precedence/Increment of a>

    my $ч = "b";
    is $ч.succ, 'c', '.succ for Str';
    is $ч.pred, 'a', '.pred for Str';

    my $ù = 1;
    is $ù.succ, 2, '.succ for Int';
    is $ù.pred, 0, '.pred for Int';

    my $丳 = Num.new();
    is $丳.succ, 1 , '.succ for Num';
    is $丳.pred, -1, '.pred for Num'
}

# https://github.com/Raku/old-issue-tracker/issues/742
throws-like 'my $a; $a++ ++;', Exception, 'parse error for "$a++ ++"';

{
    $_ = 4;
    .++;
    is $_, 5, 'increment of $_ via .++';
}

# https://github.com/Raku/old-issue-tracker/issues/2798
{
    my Bool $ч;
    my $ù;

    #postincrement tests
    $ч = Bool;
    $ù = $ч++;
    is $ù, False, "Bool postincrement returns Bool";
    is $ч, True, "Bool postincrement sets True";

    $ч = False;
    $ù = $ч++;
    is $ù, False, "False postincrement returns False";
    is $ч, True, "False postincrement sets True";

    $ч = True;
    $ù = $ч++;
    is $ù, True, "True postincrement returns True";
    is $ч, True, "True postincrement sets True";

    #postdecrement tests
    $ч = Bool;
    $ù = $ч--;
    is $ù, False, "Bool postdecrement returns Bool";
    is $ч, False, "Bool postdecrement sets False";

    $ч = False;
    $ù = $ч--;
    is $ù, False, "False postdecrement returns False";
    is $ч, False, "False postdecrement sets False";

    $ч = True;
    $ù = $ч--;
    is $ù, True, "True postdecrement returns True";
    is $ч, False, "True postdecrement sets False";

    #preincrement tests
    $ч = Bool;
    $ù = ++$ч;
    is $ù, True, "Bool preincrement returns True";
    is $ч, True, "Bool postincrement sets True";

    $ч = False;
    $ù = ++$ч;
    is $ù, True, "False preincrement returns True";
    is $ч, True, "False postincrement sets True";

    $ч = True;
    $ù = ++$ч;
    is $ù, True, "True preincrement returns True";
    is $ч, True, "True postincrement sets True";

    #predecrement tests
    $ч = Bool;
    $ù = --$ч;
    is $ù, False, "Bool predecrement returns False";
    is $ч, False, "Bool postdecrement sets False";

    $ч = False;
    $ù = --$ч;
    is $ù, False, "False predecrement returns False";
    is $ч, False, "False postdecrement sets False";

    $ч = True;
    $ù = --$ч;
    is $ù, False, "True predecrement returns False";
    is $ч, False, "True postdecrement sets False";
};

# vim: expandtab shiftwidth=4
