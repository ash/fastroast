use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 181;

# L<S03/Nonchaining binary precedence/Range object constructor>

# 3..2 must *not* produce "3 2".  Use reverse to get a reversed range. -lwall
is ~(3..6), "3 4 5 6", "(..) works on numbers (1)";
is ~(3..3), "3",       "(..) works on numbers (2)";
is ~(3..2), "",        "(..) works on auto-rev numbers (3)";
is ~(8..11), "8 9 10 11",   "(..) works on carried numbers (3)";

is ~("a".."c"), "a b c", "(..) works on chars (1)";
is ~("a".."a"), "a",     "(..) works on chars (2)";
is ~("b".."a"), "",      "(..) works on chars (3)";
is ~("a".."z"), "a b c d e f g h i j k l m n o p q r s t u v w x y z", "(..) works on char range ending in z";
is ~("A".."Z"), "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z", "(..) works on char range ending in Z";
is ~("Y".."AB"), "",     "(..) works on carried chars (3)";

is ~('Y'..'d'), 'Y Z [ \ ] ^ _ ` a b c d',  '(..) works on uppercase letter .. lowercase letter (1)';
is ~('z'..'Y'), '',    '(..) works on auto-rev uppercase letter .. lowercase letter (2)';
is ~('Y'..'_'), 'Y Z [ \ ] ^ _', '(..) works on letter .. non-letter (1)';
is ~('_'..'Y'), '',    '(..) works on auto-rev letter .. non-letter (2)';
is ~(' '..' '), ' ',    'all-whitespace range works';

is ~(3..9-3), "3 4 5 6", "(..) has correct precedence (1)";
is ~(5..9-5), "",        "(..) has correct precedence (2)";
is ~(2+1..6), "3 4 5 6", "(..) has correct precedence (3)";
is ~(2+5..6), "",        "(..) has correct precedence (4)";

# Test the three exclusive range operators:
# L<S03/Range and RangeIter semantics/range operator has variants>
is [1^..9], [2..9],  "bottom-exclusive range (^..) works (1)";
is [2^..2], [],      "bottom-exclusive range (^..) works (2)";
is [3^..2], [],      "bottom-exclusive auto-rev range (^..) works (3)";
is [1 ..^9], [1..8], "top-exclusive range (..^) works (1)";
is [2 ..^2], [],     "top-exclusive range (..^) works (2)";
is [3 ..^2], [],     "top-exclusive auto-rev range (..^) works (3)";
is [1^..^9], [2..8], "double-exclusive range (^..^) works (1)";
is [9^..^1], [],     "double-exclusive auto-rev range (^..^) works (2)";
is [1^..^2], [],     "double-exclusive range (^..^) can produce null range (1)";

# tests of (x ^..^ x) here and below ensure that our implementation
# of double-exclusive range does not blindly remove an element
# from the head and tail of a list
is [1^..^1], [], "double-exclusive range (x ^..^ x) where x is an int";

is ["a"^.."z"], ["b".."z"], "bottom-exclusive string range (^..) works";
is ["z"^.."a"], [], "bottom-exclusive string auto-rev range (^..) works";
is ["a"..^"z"], ["a".."y"], "top-exclusive string range (..^) works";
is ["z"..^"a"], [], "top-exclusive string auto-rev range (..^) works";
is ["a"^..^"z"], ["b".."y"], "double-exclusive string range (^..^) works";
is ["z"^..^"a"], [], "double-exclusive string auto-rev range (^..^) works";
is ['a'^..^'b'], [], "double-exclusive string range (^..^) can produce null range";
is ['b'^..^'a'], [], "double-exclusive string auto-rev range (^..^) can produce null range";
is ['a' ^..^ 'a'], [], "double-exclusive range (x ^..^ x) where x is a char";
is ('a'..'z').list.join(' '), 'a b c d e f g h i j k l m n o p q r s t u v w x y z', '"a".."z"';

# https://github.com/Raku/old-issue-tracker/issues/6001
is ['!'^..'&'], ['"'..'&'], "bottom-exclusive non-alphanumeric string range (^..) works";
is ['!'..^'&'], ['!'..'%'], "top-exclusive non-alphanumeric string range (..^) works";
is ['!'^..^'&'], ['"'..'%'], "double-exclusive non-alphanumeric string range (^..^) works";
is ['%'^..^'&'], [], "double-exclusive non-alphanumeric string range (^..^) can produce null range";

is 1.5 ~~ 1^..^2, Bool::True, "lazy evaluation of the range operator";

# Test the unary ^ operator
is ~(^5), "0 1 2 3 4", "unary ^num produces the range 0..^num";
is [^1],   [0],        "unary ^ on the boundary ^1 works";
is [^0],   [],         "unary ^0 produces null range";
is [^-1],  [],         "unary ^-1 produces null range";
is [^0.1], [0],        "unary ^0.1 produces the range 0..^x where 0 < x < 1";
is ~(^"5"), "0 1 2 3 4", 'unary ^"num" produces the range 0..^num';

{
    my @à = 3, 5, 3;
    is (^@à).raku, (0..^3).raku,    'unary ^@a produces 0..^+@a';
}

# test iterating on infinite ranges
is (1..*).[^5].join('|'), '1|2|3|4|5', '1..*';
is ('a'..*).[^5].join('|'), 'a|b|c|d|e', '"a"..*';

# test that the zip operator works with ranges
is (1..5 Z <a b c>).flat.join('|'), '1|a|2|b|3|c', 'Ranges and infix:<Z>';
is (1..2 Z <a b c>).flat.join('|'), '1|a|2|b',     'Ranges and infix:<Z>';
is (<c b a> Z 1..5).flat.join('|'), 'c|1|b|2|a|3', 'Ranges and infix:<Z>';

# two ranges
is (1..6 Z 'a' .. 'c').flat.join, '1a2b3c',   'Ranges and infix:<Z>';

{
    # Test with floats
    # 2006-12-05:
    # 16:16 <TimToady> ~(1.9 ^..^ 4.9) should produce 2.9, 3.9
    # 16:17 <pmichaud> and ~(1.9 ^..^ 4.5) would produce the same?
    # 16:17 <TimToady> yes
    is ~(1.1 .. 4) , "1.1 2.1 3.1", "range with float .min";
    is ~(1.9 .. 4) , "1.9 2.9 3.9", "range with float .min";
    is ~(1.1 ^.. 4), "2.1 3.1"    , "bottom exclusive range of float";
    is ~(1.9 ^.. 4), "2.9 3.9"    , "bottom exclusive range of float";

    is ~(1 .. 4.1) , "1 2 3 4", "range with float .max";
    is ~(1 .. 4.9) , "1 2 3 4", "range with float .max";
    is ~(1 ..^ 4.1), "1 2 3 4", "top exclusive range of float";
    is ~(1 ..^ 4.9), "1 2 3 4", "top exclusive range of float";

    is ~(1.1 .. 4.1), "1.1 2.1 3.1 4.1", "range with float .min/.max";
    is ~(1.9 .. 4.1), "1.9 2.9 3.9"    , "range with float .min/.max";
    is ~(1.1 .. 4.9), "1.1 2.1 3.1 4.1", "range with float .min/.max";
    is ~(1.9 .. 4.9), "1.9 2.9 3.9 4.9", "range with float .min/.max";

    is ~(1.1 ^..^ 4.1), "2.1 3.1"    , "both exclusive float range";
    is ~(1.9 ^..^ 4.1), "2.9 3.9"    , "both exclusive float range";
    is ~(1.1 ^..^ 4.9), "2.1 3.1 4.1", "both exclusive float range";
    is ~(1.9 ^..^ 4.9), "2.9 3.9"    , "both exclusive float range";
    is [1.1 ^..^ 1.1], [], "double-exclusive range (x ^..^ x) where x is a float";
}

# Test that the operands are forced to scalar context
# Range.new coerces its arguments to numeric context if needed
# https://github.com/Raku/old-issue-tracker/issues/262
# https://github.com/Raku/old-issue-tracker/issues/2005
{
    my @中両сe̲e̲ = (1, 1, 1);
    my @갨丧e̲ = 1;

    is ~(@갨丧e̲ .. 3)     , "1 2 3", "lower inclusive limit is in scalar context";
    is ~(@갨丧e̲ ^.. 3)    , "2 3"  , "lower exclusive limit is in scalar context";
    is ~(3 ^.. @갨丧e̲)    , ""     , "lower exclusive limit is in scalar context";
    is ~(1 .. @中両сe̲e̲)   , "1 2 3", "upper inclusive limit is in scalar context";
    is ~(4 .. @中両сe̲e̲)   , ""     , "upper inclusive limit is in scalar context";
    is ~(1 ..^ @中両сe̲e̲)  , "1 2"  , "upper exclusive limit is in scalar context";
    is ~(4 ..^ @中両сe̲e̲)  , ""     , "upper exclusive limit is in scalar context";
    is ~(@갨丧e̲ .. @中両сe̲e̲), "1 2 3", "both limits is in scalar context";
    is ~(@갨丧e̲ ^.. @中両сe̲e̲), "2 3" , "lower exclusive limit scalar context";
    is ~(@갨丧e̲ ..^ @中両сe̲e̲), "1 2" , "upper exclusive limit scalar context";
    is ~(@갨丧e̲ ^..^ @中両сe̲e̲), "2"  , "both exclusive limit scalar context";
}

# test that .map and .grep work on ranges
{
    is (0..3).map({$_ * 2}).join('|'),      '0|2|4|6', '.map works on ranges';
    is (0..3).grep({$_ == 1|3}).join('|'),  '1|3',     '.grep works on ranges';
    is (1..3).first({ $_ % 2 == 0}),        2,         '.first works on ranges';
    is (1..3).reduce({ $^a + $^b}),         6,         '.reduce works on ranges';
}

# test that range operands are handled in string context if strings
{
    my $сà丧æe̲;
    my $ò中àс中 = "100.B";
    my $e̲丧𝐝 = "102.B";
    lives-ok { $сà丧æe̲ = $ò中àс中..$e̲丧𝐝 },
             'can make range from numeric string vars';
    is $сà丧æe̲.min, $ò中àс中, 'range starts at start';
    is $сà丧æe̲.min.WHAT.gist, Str.gist, 'range start is a string';
    is $сà丧æe̲.max,   $e̲丧𝐝, 'range ends at end';
    is $сà丧æe̲.max.WHAT.gist, Str.gist, 'range end is a string';
    lives-ok { "$сà丧æe̲" }, 'can stringify range';
    is ~$сà丧æe̲, "100.B 101.B 102.B", 'range is correct';
}

# https://github.com/Raku/old-issue-tracker/issues/1171
{
    my $сà丧æe̲;
    lives-ok { '1 3' ~~ /(\d+) \s (\d+)/; $сà丧æe̲ = $0..$1 },
             'can make range from match vars';
    is $сà丧æe̲.min, 1, 'range starts at one';
    is $сà丧æe̲.max, 3, 'range ends at three';
    lives-ok { "$сà丧æe̲" }, 'can stringify range';
    is ~$сà丧æe̲, "1 2 3", 'range is correct';
}
# and another set, just for the lulz
# https://github.com/Raku/old-issue-tracker/issues/1171
{
    ok '1 3' ~~ /(\d) . (\d)/, 'regex sanity';
    isa-ok $0..$1, Range, '$0..$1 constructs a Range';
    is ($0..$1).join('|'), '1|2|3', 'range from $0..$1';
}

{
    my $сà丧æe̲;
    lives-ok { '1 3' ~~ /(\d+) \s (\d+)/; $сà丧æe̲ = +$0..+$1 },
             'can make range from match vars with numeric context forced';
    is $сà丧æe̲.min, 1, 'range starts at one';
    is $сà丧æe̲.max,   3, 'range ends at three';
    lives-ok { "$сà丧æe̲" }, 'can stringify range';
    is ~$сà丧æe̲, "1 2 3", 'range is correct';
}

{
    my $сà丧æe̲;
    lives-ok { '1 3' ~~ /(\d+) \s (\d+)/; $сà丧æe̲ = (~$0)..(~$1) },
             'can make range from match vars with string context forced';
    is $сà丧æe̲.min, 1, 'range starts at one';
    is $сà丧æe̲.min.WHAT.gist, Str.gist, 'range start is a string';
    is $сà丧æe̲.max,   3, 'range ends at three';
    is $сà丧æe̲.max.WHAT.gist, Str.gist, 'range end is a string';
    lives-ok { "$сà丧æe̲" }, 'can stringify range';
    is ~$сà丧æe̲, "1 2 3", 'range is correct';
}

# L<S03/Nonchaining binary precedence/it is illegal to use a Range as
# implicitly numeric>

{
    ok !defined(try { 0 .. ^10 }), '0 .. ^10 is illegal';
}

# Lists are allowed on the rhs if the lhs is numeric (Real):
is ~(2 .. [<a b c d e>]), "2 3 4 5", '2 .. @list is legal';

# https://github.com/Raku/old-issue-tracker/issues/1254
{
    $_ = Any; # unsetting $_ to reproduce bug literally
    lives-ok {(1..$_)}, '(1..$_) lives';
    isa-ok (1..$_), Range, '(..) works on Int .. Any';
}

{
    my $сà丧æe̲ = 1 .. '10';
    is +$сà丧æe̲, 10, "1 .. '10' has ten elements in it";
    is +$сà丧æe̲.grep(Numeric), 10, "and they are all numbers";
}

{
    my @àссàù = 1 .. 10;
    my $сà丧æe̲ = 1 .. @àссàù;
    is +$сà丧æe̲, 10, "1 .. @àссàù has ten elements in it";
    is +$сà丧æe̲.grep(Numeric), 10, "and they are all numbers";
}

# https://github.com/Raku/old-issue-tracker/issues/1889
{
    lives-ok {("a".."b").map({.trans(""=>"")}).raku},
        "range doesn't leak Parrot types";
}

{
    my $丛갢æ = 2 ** 130;
    my $개갨갮丧中 = 0;
    ++$개갨갮丧中 for $丛갢æ .. $丛갢æ + 2;
    is $개갨갮丧中, 3, 'can iterate over big Int range';
}

# https://github.com/Raku/old-issue-tracker/issues/2645
{
    for 1e0 .. 1e0 {
        isa-ok $_, Num, 'Range of nums produces a Num';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/2119
throws-like '1..2..3', X::Syntax::NonAssociative, '.. is not associative';

{
    ## once this block died at compile time
    ## with q[P6opaque: no such attribute '$!phasers']
    ## cmp. https://github.com/rakudo/rakudo/commit/c5e7a7783d
    isa-ok { *.raku for ^2 }, Block,
        'range optimizer is protected from cases with no block';
}

# https://github.com/Raku/old-issue-tracker/issues/5051
my @갨𝐩𝐯àс갢à丧中ò = «.. ^.. ..^ ^..^ ' R..' ' R^..' ' R..^' ' R^..^'»;
for @갨𝐩𝐯àс갢à丧中ò {
    throws-like "\{ use fatal; |4$_ 5 }", X::Worry::Precedence::Range, "$_ warns on common flattening mistake";
    throws-like "\{ use fatal; |4$_ 5 }", X::Worry::Precedence::Range, "$_ warns on common stringification mistake";
    eval-lives-ok "\{ use fatal; |(4$_ 5) }", "$_ doesn't warn on parenthesized flattening (range)";
    eval-lives-ok "\{ use fatal; (|4)$_ 5 }", "$_ doesn't warn on parenthesized flattening (endpoint)";
    eval-lives-ok "\{ use fatal; ~(4$_ 5) }", "$_ doesn't warn on parenthesized stringification (range)";
    eval-lives-ok "\{ use fatal; (~4)$_ 5 }", "$_ doesn't warn on parenthesized stringification (endpoint)";
}

# https://github.com/rakudo/rakudo/issues/1582
subtest 'Range operators work with subclasses of Range' => {
    plan 10;
    # While `(42 but role Foo {}) + 42` produces a plain `Int`, Range ops will produce a subclass
    # rather than plain `Range`, if one was used originally, since there's only one `Range` object
    # involved, so we know exactly what we have to become.
    my role Ìe̲갨w̲ò {}
    my $с := (2..^5) but Ìe̲갨w̲ò;
    is-deeply ($с + 5), ((7..^10) but Ìe̲갨w̲ò), 'Range + Real';
    is-deeply (5 + $с), ((7..^10) but Ìe̲갨w̲ò), 'Real + Range';
    is-deeply ($с - 5), ((-3..^0) but Ìe̲갨w̲ò), 'Range - Real'; # No `Real - Range` meaning
    is-deeply ($с * 5), ((10..^25) but Ìe̲갨w̲ò), 'Range * Real';
    is-deeply (5 * $с), ((10..^25) but Ìe̲갨w̲ò), 'Real Range';
    is-deeply ($с / 5), (((2/5)..^1.0) but Ìe̲갨w̲ò), 'Range / Real'; # No `Real / Range` meaning

    is-deeply ($с − 5), ((-3..^0) but Ìe̲갨w̲ò), "Range U+2212 minus Real";
    is-deeply ($с × 5), ((10..^25) but Ìe̲갨w̲ò), 'Range U+00D7 Real';
    is-deeply (5 × $с), ((10..^25) but Ìe̲갨w̲ò), 'Real U+00D7 Range';
    is-deeply ($с ÷ 5), (((2/5)..^1.0) but Ìe̲갨w̲ò), 'Range U+00F7 Real';
}

# ranges can have an offset applied
subtest 'Ranges can have an offset applied' => {
    plan 11;

    my @à = do $_ for ^4 + 2;
    is-deeply [2, 3, 4, 5], @à, 'adding an integer literal offset to a ^ range';

    @à = do $_ for ^4 - 2;
    is-deeply [-2, -1, 0, 1], @à, 'subracting an integer literal offset from a ^ range';

    @à = do $_ for ^4 + -2;
    is-deeply [-2, -1, 0, 1], @à, 'adding an integer negative literal offset to a ^ range';

    @à = do $_ for (2..4) + 2;
    is-deeply [4, 5, 6], @à, 'adding an integer literal offset to a .. range';

    my constant \b = 2;
    @à = do $_ for (2..4) + b;
    is-deeply [4, 5, 6], @à, 'adding an integer offset in a constant variable to a .. range';

    my int $c = 2;
    @à = do $_ for (2..4) + $c;
    is-deeply [4, 5, 6], @à, 'adding an ineger offset in a native int variable to a .. range';

    my Int $d = 2**65;
    @à = do $_ for (2..4) + $d;
    is-deeply [36893488147419103234, 36893488147419103235, 36893488147419103236], @à, 'adding an offset in a bigint variable to a .. range';

    @à = do $_ for (2..4) + 5e-1;
    is-deeply [25e-1, 35e-1, 45e-1], @à, 'adding a Num literal offset to a .. range';

    @à = do $_ for (2..4) * 2;
    is-deeply [4, 5, 6, 7, 8], @à, 'multiplying an integer literal offset by a .. range';

    @à = do $_ for (^4) * 2;
    is-deeply [0, 1, 2, 3, 4, 5, 6, 7], @à, 'multiplying a ^ range by an integer literal offset';

    @à = do $_ for (^4) / 2;
    is-deeply [0.0, 1.0], @à, 'dividing a ^ range by an integer literal offset';
}

# https://github.com/rakudo/rakudo/issues/1809
subtest "Smartmatch Coercions" => {
    plan 14;

    ok ("42" ~~ 20..50), "stringified number in a context of numeric range, inside the range";
    nok ("13" ~~ 20..50), "stringified number in a context of numeric range, less than the min";
    nok ("666" ~~ 20..50), "stringified number in a context of numeric range, more than the max";
    my $ò갮개개e̲e̲𝐝;
    lives-ok { $ò갮개개e̲e̲𝐝 = "abc" ~~ 1..10 }, "a string in non-numeric against numeric range doesn't throw";
    cmp-ok $ò갮개개e̲e̲𝐝, '===', False, "previous smartmatch resulted in False";

    ok 42 ~~ "3".."9", "number in a context of stringy range, inside the range";
    ok "42" ~~ "3".."9", "same number, stringified, in a context of stringy range, inside the range";
    nok 42 ~~ "5".."9", "number in a context of stringy range, before the min";
    nok "42" ~~ "5".."9", "same number, stringified, in a context of stringy range, before the min";
    nok 42 ~~ "1".."3", "number in a context of stringy range, after the max";
    nok "42" ~~ "1".."3", "same number, stringified, in a context of stringy range, after the max";

    ok 42 ~~ *.."5", "number in a context of whatever-string range, inside the range";
    nok 42 ~~ *..5, "number in a context of whatever-number range, outside the range";
    nok 42 ~~ *.."3", "number in a context of whatever-string range, outside the range";
}

# https://github.com/rakudo/rakudo/issues/2676
{
    is-deeply (so (3,0).one ~~ (1 .. 9)), True, 'Junction ~~ Range ok';
}

# vim: expandtab shiftwidth=4
