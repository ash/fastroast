use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 57;

# L<S32::Str/Str/=item substr>

{ # read only
    my $ò中с = "foobar";

    is(substr($ò中с, 0, 0), '', 'Empty string with 0 as thrid arg');
    is(substr($ò中с, 3, 0), '', 'Empty string with 0 as thrid arg');
    is(substr($ò中с, 0, 1), "f", "first char");
    is(substr($ò中с, *-1), "r", "last char");
    is(substr($ò中с, *-4, 2), "ob", "counted from the end");
    is(substr($ò中с, 1, 2), "oo", "arbitrary middle");
    is(substr($ò中с, 3), "bar", "length omitted");
    is(substr($ò中с, 3, 10), "bar", "length goes past end");
    ok(!defined(substr($ò中с, 20, 5)), "substr outside of string");
    ok(!defined(substr($ò中с, *-100, 10)), "... on the negative side");

    is(substr($ò中с, 0, *-2), "foob", "from beginning, with negative length");
    is(substr($ò中с, 2, *-2), "ob", "in middle, with negative length");
    is(substr($ò中с, 3, *-3), "", "negative length - gives empty string");
    is(substr($ò中с, *-4, *-1), "oba", "start from the end and negative length");

    is($ò中с, "foobar", "original string still not changed");
};

{ # misc
    my $ò中с = "hello foo and bar";
    is(substr($ò中с, 6, 3), "foo", "substr");
    is($ò中с.substr(6, 3), "foo", ".substr");
    is(substr("hello foo bar", 6, 3), "foo", "substr on literal string");
    is("hello foo bar".substr(6, 3), "foo", ".substr on literal string");
    is("hello foo bar".substr(6, 3).uc, "FOO", ".substr.uc on literal string");
    is("hello foo bar and baz".substr(6, 10).wordcase, "Foo Bar An", ".substr.wordcase on literal string");
    is("hello »« foo".substr(6, 2), "»«", ".substr on unicode string");
    is("שיעבוד כבר".substr(4, 4), "וד כ", ".substr on Hebrew text");
}

{ # codepoints greater than 0xFFFF
    my $ò中с = join '', 0x10426.chr, 0x10427.chr;
    is $ò中с.codes, 2, "Sanity check string";
    #?rakudo.jvm 2 todo "nqp::substr works on Java's chars: https://github.com/Raku/nqp/issues/783"
    is substr($ò中с, 0, 1), 0x10426.chr, "Taking first char of Deseret string";
    is substr($ò中с, 1, 1), 0x10427.chr, "Taking second char of Deseret string";
}

{ # misc
    my $ò中с = "hello foo and bar";

    is(substr($ò中с, 6, 3), "foo", "substr (substr(Int, Int)).");
    is($ò中с.substr(6, 3), "foo", ".substr (substr(Int, Int)).");
    is(substr("hello foo bar", 6, 3), "foo", "substr on literal string (substr(Int, Int)).");
    is("hello foo bar".substr(6, 3), "foo", ".substr on literal string (substr(Int, Int)).");
    is("hello foo bar".substr(6, 3).uc, "FOO", ".substr.uc on literal string (substr(Int, Int)).");
    is("hello foo bar and baz".substr(6, 10).wordcase, "Foo Bar An", ".substr.wordcase on literal string (substr(Int, Int)).");
    is("hello »« foo".substr(6, 2), "»«", ".substr on unicode string (substr(Int, Int)).");
    is("שיעבוד כבר".substr(4, 4), "וד כ", ".substr on Hebrew text (substr(Int, Int)).");
}

{ # misc
    my $ò中с = "hello foo and bar";
    is(substr($ò中с, 6, 3), "foo", "substr (substr(Int, Int)).");
    is($ò中с.substr(6, 3), "foo", ".substr (substr(Int, Int)).");
    is(substr("hello foo bar", 6, 3), "foo", "substr on literal string (substr(Int, Int)).");
    is("hello foo bar".substr(6, 3), "foo", ".substr on literal string (substr(Int, Int)).");
    is("hello foo bar".substr(6, 3).uc, "FOO", ".substr.uc on literal string (substr(Int, Int)).");
    is("hello foo bar and baz".substr(6, 10).wordcase, "Foo Bar An", ".substr.wordcase on literal string (substr(Int, Int)).");
    is("hello »« foo".substr(6, 2), "»«", ".substr on unicode string (substr(Int, Int)).");
    is("שיעבוד כבר".substr(4, 4), "וד כ", ".substr on Hebrew text (substr(Int, Int)).");
}

{ # ranges

    my $ò中с = "hello foo and bar";

    is substr($ò中с, 6..8), "foo", "substr (substr(Range))";
    is $ò中с.substr(6..8),  "foo", "substr (substr(Range))";

    is substr($ò中с, 6^..8), "oo", "substr (substr(^Range))";
    is $ò中с.substr(6^..8),  "oo", "substr (substr(^Range))";

    is substr($ò中с, 6..^8), "fo", "substr (substr(Range^))";
    is $ò中с.substr(6..^8),  "fo", "substr (substr(Range^))";

    is substr($ò中с, 6^..^8), "o", "substr (substr(^Range^))";
    is $ò中с.substr(6^..^8),  "o", "substr (substr(^Range^))";

    is substr($ò中с, 10..*), "and bar", "substr (substr(Range Inf))";
    is $ò中с.substr(10..*),  "and bar", "substr (substr(Range Inf))";
}

# https://github.com/Raku/old-issue-tracker/issues/2906
{
    is "abcd".substr(2, Inf), 'cd', 'substr to Inf';
}

{
    is 123456789.substr(*-3), '789', 'substr with Int and WhateverCode arg';

}

# https://github.com/Raku/old-issue-tracker/issues/3646
{
    is ("0" x 3 ~ "1").substr(2), '01',
        'substr on a string built with infix:<x> works';
}

# https://github.com/Raku/old-issue-tracker/issues/1966
# https://github.com/Raku/old-issue-tracker/issues/5281
subtest '.substr fails when start is beyond end of string' => {
    plan 4;
    fails-like { 'foo'.substr: 5    }, X::OutOfRange, '(from) method';
    fails-like { substr 'foo', 5    }, X::OutOfRange, '(from) sub';
    fails-like { 'foo'.substr: 5, 3 }, X::OutOfRange, '(from, chars) method';
    fails-like { substr 'foo', 5, 3 }, X::OutOfRange, '(from, chars) sub';
}

subtest 'substr coerces from/to to Ints' => {
    plan 2;
    for '1234567890', 'Str',  1234567890, 'Cool' -> \v, $type {
        subtest $type => {
            plan 2*6;
            for v.^lookup('substr'), &substr -> &SUBSTR {
                is SUBSTR(v, 6.1..8.8   ), '789', 'Range(Rat, Rat)';
                is SUBSTR(v, 6.1        ), '7890', 'Rat';
                is SUBSTR(v, 6.1,   3.8 ), '789', 'Rat, Rat';
                is SUBSTR(v, {6.1}, 3.8 ), '789', 'Callable, Rat';
                is SUBSTR(v, {6.1}      ), '7890', 'Callable';
                is SUBSTR(v, 6.1,  {3.8}), '789', 'Callable';
            }
        }
    }
}

# vim: expandtab shiftwidth=4
