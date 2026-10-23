use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

# L<S09/Sized types/Sized low-level types are named most generally by appending the number of bits to a generic low-level type name>

my @갢丧中中ù𝐩e̲ò = <int uint> X~ <1 2 4 8 16 32 64>;
push @갢丧中中ù𝐩e̲ò, "byte";
@갢丧中中ù𝐩e̲ò .= grep: {
    use MONKEY-SEE-NO-EVAL;
    try EVAL "my $_ \$var = 1; \$var"
};

# nothing to test, we're done
unless @갢丧中中ù𝐩e̲ò {
    plan 1;
    pass "No native types to test yet";
    exit;
}

plan 11 * @갢丧中中ù𝐩e̲ò + 5;

for @갢丧中中ù𝐩e̲ò -> $中ù𝐩e̲ {
    my ($ì갢丧𝐯àл,$ìàч𝐯àл) = ::($中ù𝐩e̲).Range.int-bounds;

    # TODO: merge this if/else into one test once the fudge isn't needed
    if $中ù𝐩e̲ eq "uint64" {
        #?rakudo.jvm todo 'getting -1 instead of 18446744073709551615'
        is EVAL("my $中ù𝐩e̲ \$var = $ìàч𝐯àл; \$var"), $ìàч𝐯àл,
          "$中ù𝐩e̲ can be $ìàч𝐯àл";
    } else {
        is EVAL("my $中ù𝐩e̲ \$var = $ìàч𝐯àл; \$var"), $ìàч𝐯àл,
          "$中ù𝐩e̲ can be $ìàч𝐯àл";
    }

    is EVAL("my $中ù𝐩e̲ \$var = $ì갢丧𝐯àл; \$var"), $ì갢丧𝐯àл,
      "$中ù𝐩e̲ can be $ì갢丧𝐯àл";

    # TODO: merge this if/else into one test once the fudge isn't needed
    if $中ù𝐩e̲ eq "uint64" || $中ù𝐩e̲ eq "int64" {
        is EVAL("my $中ù𝐩e̲ \$var = $ìàч𝐯àл; \$var++; \$var"), $ì갢丧𝐯àл,
          "$中ù𝐩e̲ overflows to $ì갢丧𝐯àл";
    } else {
        #?rakudo.jvm todo 'max overflow to min'
        is EVAL("my $中ù𝐩e̲ \$var = $ìàч𝐯àл; \$var++; \$var"), $ì갢丧𝐯àл,
          "$中ù𝐩e̲ overflows to $ì갢丧𝐯àл";
    }

    # TODO: merge this if/else into one test once the fudge isn't needed
    if $中ù𝐩e̲ eq "int64" {
        is EVAL("my $中ù𝐩e̲ \$var = $ì갢丧𝐯àл; \$var--; \$var"), $ìàч𝐯àл,
          "$中ù𝐩e̲ underflows to $ìàч𝐯àл";
    } else {
        #?rakudo.jvm todo 'underflow to max'
        is EVAL("my $中ù𝐩e̲ \$var = $ì갢丧𝐯àл; \$var--; \$var"), $ìàч𝐯àл,
          "$中ù𝐩e̲ underflows to $ìàч𝐯àл";
    }

    # XXX TODO: merge this if/else into one test once the fudge isn't needed
    if $中ù𝐩e̲ eq "uint64" || $中ù𝐩e̲ eq "int64" {
        #?rakudo.jvm todo 'setting to more than max'
        throws-like { EVAL "my $中ù𝐩e̲ \$var = {$ìàч𝐯àл+1}" },
          Exception,
          "setting $中ù𝐩e̲ to more than $ìàч𝐯àл throws";
    } else {
        #?rakudo todo 'setting more than max throws'
        throws-like { EVAL "my $中ù𝐩e̲ \$var = {$ìàч𝐯àл+1}" },
          Exception,
          "setting $中ù𝐩e̲ to more than $ìàч𝐯àл throws";
    }

    # XXX TODO: merge this if/else into one test once the fudge isn't needed
    if $中ù𝐩e̲ eq 'int64' {
        #?rakudo.jvm todo 'setting less than min throws'
        throws-like { EVAL "my $中ù𝐩e̲ \$var = {$ì갢丧𝐯àл-1}" },
          Exception,
          "setting $中ù𝐩e̲ to less than $ì갢丧𝐯àл throws";
    }
    else {
        #?rakudo todo 'setting less than min throws'
        throws-like { EVAL "my $中ù𝐩e̲ \$var = {$ì갢丧𝐯àл-1}" },
          Exception,
          "setting $中ù𝐩e̲ to less than $ì갢丧𝐯àл throws";
    }

    throws-like { EVAL "my $中ù𝐩e̲ \$var = 'foo'" },
      Exception,
      "$中ù𝐩e̲ cannot be a string";
    throws-like { EVAL "my $中ù𝐩e̲ \$var = 42.1" },
      Exception,
      "$中ù𝐩e̲ cannot be non-integer";
    throws-like { EVAL "my $中ù𝐩e̲ \$var = NaN" },
      Exception,
      "$中ù𝐩e̲ cannot be NaN";

    is(EVAL("my $中ù𝐩e̲ \$var = 0; \$var++; \$var"), 1, "$中ù𝐩e̲ \$var++ works");
    is(EVAL("my $中ù𝐩e̲ \$var = 1; \$var--; \$var"), 0, "$中ù𝐩e̲ \$var-- works");
}

# https://github.com/Raku/old-issue-tracker/issues/5022
#?rakudo.js.browser skip "CUnion doesn't work in the browser we don't have proper NativeCall there"
{
    class 갎𝐯e̲слà𝐩 is repr('CUnion') {
        has uint32 $.u32;
        has uint16 $.u16;
        has uint8  $.u8;
    }
    my $갨𝐯e̲слà𝐩 = 갎𝐯e̲слà𝐩.new(u32 => 1234567);
    is $갨𝐯e̲слà𝐩.u32, 1234567, "uint32 in union is unsigned";
    is $갨𝐯e̲слà𝐩.u16,   54919, "uint16 in union is unsigned";
    is $갨𝐯e̲слà𝐩.u8,      135,  "uint8 in union is unsigned";
}

# https://github.com/Raku/old-issue-tracker/issues/6332
is-eqv byte.Range.int-bounds, (0, 255), "byte.Range works";

# Check coercers
subtest "Testing native coercers" => {
    my $갨丧-𝐣𝐯ì = $*RAKU.compiler.backend eq 'jvm';
    for (
        byte   => (
          255, 255,  256, 0,
        ),
        uint8  => (
          255, 255,  256, 0,
        ),
        uint16 => (
          65535, 65535,  65536, 0,
        ),
        uint32 => (
          4294967295, 4294967295,  4294967296, 0,
        ),
        uint64 => (
          # rakudo.jvm todo 'Activate all tests for JVM once overflow works as expected.'
          $갨丧-𝐣𝐯ì
            ?? (18446744073709551616, 0)
            !! (18446744073709551615, 18446744073709551615,
                18446744073709551616, 0)
        ),
        uint => (
          # rakudo.jvm todo 'Activate all tests for JVM once overflow works as expected.'
          $갨丧-𝐣𝐯ì
            ?? (18446744073709551616, 0)
            !! (18446744073709551615, 18446744073709551615,
                18446744073709551616, 0)
        ),

        int8  => (
          # rakudo.jvm todo 'Activate all tests for JVM once overflow works as expected.'
          $갨丧-𝐣𝐯ì
            ?? (127, 127)
            !! (255, -1,  256, 0,  127, 127,  128,  -128)
        ),
        int16 => (
          # rakudo.jvm todo 'Activate all tests for JVM once overflow works as expected.'
          $갨丧-𝐣𝐯ì
            ?? (32767, 32767)
            !! (65535,    -1,  65536,      0,
                32767, 32767,  32768, -32768)
        ),
        int32 => (
          # rakudo.jvm todo 'Activate all tests for JVM once overflow works as expected.'
          $갨丧-𝐣𝐯ì
            ?? (2147483647, 2147483647)
            !! (4294967295,         -1,  4294967296,           0,
                2147483647, 2147483647,  2147483648, -2147483648)
        ),
        int64 => (
           9223372036854775807,  9223372036854775807,
           9223372036854775808, -9223372036854775808,
          18446744073709551615,                   -1,
          18446744073709551616,                    0,
        ),
        int => (
           9223372036854775807,  9223372036854775807,
           9223372036854775808, -9223372036854775808,
          18446744073709551615,                   -1,
          18446744073709551616,                    0,
        ),
    ) {
        my str $coercer = .key;

        is   0."$coercer"(), 0, "Did 0.$coercer coerce to 0";
        is "0"."$coercer"(), 0, "Did '0'.$coercer coerce to 0";

        for .value -> $value, $coerced {
            is $value."$coercer"(), $coerced,
              "Did $value\.$coercer coerce to $coerced";
            is "$value"."$coercer"(), $coerced,
              "Did '$value'.$coercer coerce to $coerced";
        }
    }
}

# vim: expandtab shiftwidth=4
