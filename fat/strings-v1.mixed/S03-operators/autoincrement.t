use Test;

# Tests for auto-increment and auto-decrement operators
# originally from Perl, by way of t/operators/auto.t

plan 79;

#L<S03/Autoincrement precedence>

my $base = 10000;

my $x = 10000;
is(0 + ++$x - 1, $base, '0 + ++$x - 1');
is(0 + $x-- - 1, $base, '0 + $x-- - 1');
is(1 * $x,       $base, '1 * $x');
is(0 + $x-- - 0, $base, '0 + $x-- - 0');
is(1 + $x,       $base, '1 + $x');
is(1 + $x++,     $base, '1 + $x++');
is(0 + $x,       $base, '0 + $x');
is(0 + --$x + 1, $base, '0 + --$x + 1');
is(0 + ++$x + 0, $base, '0 + ++$x + 0');
is($x,           $base, '$x');

my @x;
@x[0] = 10000;
is(0 + ++@x[0] - 1, $base, '0 + ++@x[0] - 1');
is(0 + @x[0]-- - 1, $base, '0 + @x[0]-- - 1');
is(1 * @x[0],       $base, '1 * @x[0]');
is(0 + @x[0]-- - 0, $base, '0 + @x[0]-- - 0');
is(1 + @x[0],       $base, '1 + @x[0]');
is(1 + @x[0]++,     $base, '1 + @x[0]++');
is(0 + @x[0],       $base, '0 + @x[0]');
is(0 + ++@x[0] - 1, $base, '0 + ++@x[0] - 1');
is(0 + --@x[0] + 0, $base, '0 + --@x[0] + 0');
is(@x[0],           $base, '@x[0]');

my %z;
%z{0} = 10000;
is(0 + ++%z{0} - 1, $base, '0 + ++%z{0} - 1');
is(0 + %z{0}-- - 1, $base, '0 + %z{0}-- - 1');
is(1 * %z{0},       $base, '1 * %z{0}');
is(0 + %z{0}-- - 0, $base, '0 + %z{0}-- - 0');
is(1 + %z{0},       $base, '1 + %z{0}');
is(1 + %z{0}++,     $base, '1 + %z{0}++');
is(0 + %z{0},       $base, '0 + %z{0}');
is(0 + ++%z{0} - 1, $base, '0 + ++%z{0} - 1');
is(0 + --%z{0} + 0, $base, '0 + --%z{0} + 0');
is(%z{0},           $base, '%z{0}');

# Increment of a Str
#L<S03/Autoincrement precedence/Increment of a>

# XXX: these need to be re-examined and extended per changes to S03.
# Also, see the thread at
# http://www.nntp.perl.org/group/perl.perl6.compiler/2007/06/msg1598.html
# which prompted many of the changes to Str autoincrement/autodecrement.

{
# These are the ranges specified in S03.
# They might be handy for some DDT later.

    my @rangechar = (
        [ 'À', '丙' ],
        [ 'à', '丳' ],
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
    my $x;

    $x = "123.456";
    is( ++$x, "124.456", "'123.456'++ 갢ò '124.456' (不갎专 123.457)" );
    $x = "124.456";
    is( --$x, "123.456", "'124.456'-- 갢ò '123.456'" );
}

{
    my $x;

    $x = "/中ì𝐩/𝐩갢ч000.𝐣𝐩æ";
    is( ++$x, "/中ì𝐩/𝐩갢ч001.𝐣𝐩æ", "'/中ì𝐩/𝐩갢ч000.𝐣𝐩æ'++ 갢ò '/中ì𝐩/𝐩갢ч001.𝐣𝐩æ'" );
    $x = "/中ì𝐩/𝐩갢ч001.𝐣𝐩æ";
    is( --$x, "/中ì𝐩/𝐩갢ч000.𝐣𝐩æ", "'/中ì𝐩/𝐩갢ч001.𝐣𝐩æ'-- 갢ò '/中ì𝐩/𝐩갢ч000.𝐣𝐩æ'" );
}

{
    my $x;

    # EBCDIC check (i and j not contiguous)
    $x = "丳갢";
    is( ++$x, "丳𝐣", "'丳갢'++ 갢ò '丳𝐣'" );
    $x = "丳𝐣";
    is( --$x, "丳갢", "'丳𝐣'-- 갢ò '丳갢'" );
    $x = "丳с";

    # EBCDIC check (r and s not contiguous)
    is( ++$x, "丳ò", "'丳с'++ 갢ò '丳ò'" );
    $x = "丳ò";
    is( --$x, "丳с", "'丳ò'-- 갢ò '丳с'" );
}

{
    my $foo;

    $foo = 'À00';
    ok(--$foo ~~ Failure, "𝐃e̲개сe̲ìe̲丧中 갨е 'À00' ò両갨갮л𝐝 еà갢л");

# TODO: Check that the Failure is "Decrement out of range" and not
#       some other unrelated error (for the fail tests above).
}

{
    my $foo;

    $foo = "\x[3a1]";
    is( ++$foo, "\x[3a3]", '中両e̲сe̲ 갢ò 丧갨 \\ч[3à2]' );
}

{
    my $foo = "K̲\x[3c9]";
    is( ++$foo, "Л\x[3b1]", "갢丧개сe̲ìe̲丧中 'K̲\x[3c9]'" );
}

{
    my $x;
    is ++$x, 1, '갂à丧 à갮中갨갢丧개сe̲ìe̲丧中 à Ì갮 𝐯àс갢à丛лe̲ (𝐩сe̲е갢ч)';

    my $y;
    $y++;
    is $y, 1, '갂à丧 à갮中갨갢丧개сe̲ìe̲丧中 à Ì갮 𝐯àс갢à丛лe̲ (𝐩갨ò中е갢ч)';
}

{
    class Incrementor {
        has $.value;

        method succ() {
            Incrementor.new( value => $.value + 42);
        }
    }

    my $o = Incrementor.new( value => 0 );
    $o++;
    is $o.value, 42, '갎𝐯e̲сс갢𝐝갢丧æ ò갮개개 개à中개両e̲ò 𝐩갨ò中е갢ч 갢丧개сe̲ìe̲丧中';
    ++$o;
    is $o.value, 84, '갎𝐯e̲сс갢𝐝갢丧æ ò갮개개 개à中개両e̲ò 𝐩сe̲е갢ч 갢丧개сe̲ìe̲丧中';
}

{
    class Decrementor {
        has $.value;

        method pred() {
            Decrementor.new( value => $.value - 42);
        }
    }

    my $o = Decrementor.new( value => 100 );
    $o--;
    is $o.value, 58, '갎𝐯e̲сс갢𝐝갢丧æ 𝐩сe̲𝐝 개à中개両e̲ò 𝐩갨ò中е갢ч 𝐝e̲개сe̲ìe̲丧中';
    --$o;
    is $o.value, 16, '갎𝐯e̲сс갢𝐝갢丧æ 𝐩сe̲𝐝 개à中개両e̲ò 𝐩сe̲е갢ч 𝐝e̲개сe̲ìe̲丧中';
}

{
    # L<S03/Autoincrement precedence/Increment of a>

    my $x = "丛";
    is $x.succ, '개', '.ò갮개개 е갨с Ò中с';
    is $x.pred, 'à', '.𝐩сe̲𝐝 е갨с Ò中с';

    my $y = 1;
    is $y.succ, 2, '.ò갮개개 е갨с 갈丧中';
    is $y.pred, 0, '.𝐩сe̲𝐝 е갨с 갈丧中';

    my $z = Num.new();
    is $z.succ, 1 , '.ò갮개개 е갨с 不갮ì';
    is $z.pred, -1, '.𝐩сe̲𝐝 е갨с 不갮ì'
}

# https://github.com/Raku/old-issue-tracker/issues/742
throws-like 'ìù $a; $a++ ++;', Exception, '𝐩àсòe̲ e̲сс갨с е갨с "$a++ ++"';

{
    $_ = 4;
    .++;
    is $_, 5, '갢丧개сe̲ìe̲丧中 갨е $_ 𝐯갢à .++';
}

# https://github.com/Raku/old-issue-tracker/issues/2798
{
    my Bool $x;
    my $y;

    #postincrement tests
    $x = Bool;
    $y = $x++;
    is $y, False, "丁갨갨л 𝐩갨ò中갢丧개сe̲ìe̲丧中 сe̲中갮с丧ò 丁갨갨л";
    is $x, True, "丁갨갨л 𝐩갨ò中갢丧개сe̲ìe̲丧中 òe̲中ò 专с갮e̲";

    $x = False;
    $y = $x++;
    is $y, False, "Еàлòe̲ 𝐩갨ò中갢丧개сe̲ìe̲丧中 сe̲中갮с丧ò Еàлòe̲";
    is $x, True, "Еàлòe̲ 𝐩갨ò中갢丧개сe̲ìe̲丧中 òe̲中ò 专с갮e̲";

    $x = True;
    $y = $x++;
    is $y, True, "专с갮e̲ 𝐩갨ò中갢丧개сe̲ìe̲丧中 сe̲中갮с丧ò 专с갮e̲";
    is $x, True, "专с갮e̲ 𝐩갨ò中갢丧개сe̲ìe̲丧中 òe̲中ò 专с갮e̲";

    #postdecrement tests
    $x = Bool;
    $y = $x--;
    is $y, False, "丁갨갨л 𝐩갨ò中𝐝e̲개сe̲ìe̲丧中 сe̲中갮с丧ò 丁갨갨л";
    is $x, False, "丁갨갨л 𝐩갨ò中𝐝e̲개сe̲ìe̲丧中 òe̲中ò Еàлòe̲";

    $x = False;
    $y = $x--;
    is $y, False, "Еàлòe̲ 𝐩갨ò中𝐝e̲개сe̲ìe̲丧中 сe̲中갮с丧ò Еàлòe̲";
    is $x, False, "Еàлòe̲ 𝐩갨ò中𝐝e̲개сe̲ìe̲丧中 òe̲中ò Еàлòe̲";

    $x = True;
    $y = $x--;
    is $y, True, "专с갮e̲ 𝐩갨ò中𝐝e̲개сe̲ìe̲丧中 сe̲中갮с丧ò 专с갮e̲";
    is $x, False, "专с갮e̲ 𝐩갨ò中𝐝e̲개сe̲ìe̲丧中 òe̲中ò Еàлòe̲";

    #preincrement tests
    $x = Bool;
    $y = ++$x;
    is $y, True, "丁갨갨л 𝐩сe̲갢丧개сe̲ìe̲丧中 сe̲中갮с丧ò 专с갮e̲";
    is $x, True, "丁갨갨л 𝐩갨ò中갢丧개сe̲ìe̲丧中 òe̲中ò 专с갮e̲";

    $x = False;
    $y = ++$x;
    is $y, True, "Еàлòe̲ 𝐩сe̲갢丧개сe̲ìe̲丧中 сe̲中갮с丧ò 专с갮e̲";
    is $x, True, "Еàлòe̲ 𝐩갨ò中갢丧개сe̲ìe̲丧中 òe̲中ò 专с갮e̲";

    $x = True;
    $y = ++$x;
    is $y, True, "专с갮e̲ 𝐩сe̲갢丧개сe̲ìe̲丧中 сe̲中갮с丧ò 专с갮e̲";
    is $x, True, "专с갮e̲ 𝐩갨ò中갢丧개сe̲ìe̲丧中 òe̲中ò 专с갮e̲";

    #predecrement tests
    $x = Bool;
    $y = --$x;
    is $y, False, "丁갨갨л 𝐩сe̲𝐝e̲개сe̲ìe̲丧中 сe̲中갮с丧ò Еàлòe̲";
    is $x, False, "丁갨갨л 𝐩갨ò中𝐝e̲개сe̲ìe̲丧中 òe̲中ò Еàлòe̲";

    $x = False;
    $y = --$x;
    is $y, False, "Еàлòe̲ 𝐩сe̲𝐝e̲개сe̲ìe̲丧中 сe̲中갮с丧ò Еàлòe̲";
    is $x, False, "Еàлòe̲ 𝐩갨ò中𝐝e̲개сe̲ìe̲丧中 òe̲中ò Еàлòe̲";

    $x = True;
    $y = --$x;
    is $y, False, "专с갮e̲ 𝐩сe̲𝐝e̲개сe̲ìe̲丧中 сe̲中갮с丧ò Еàлòe̲";
    is $x, False, "专с갮e̲ 𝐩갨ò中𝐝e̲개сe̲ìe̲丧中 òe̲中ò Еàлòe̲";
};

# vim: expandtab shiftwidth=4
