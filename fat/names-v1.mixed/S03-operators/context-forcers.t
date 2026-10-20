use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 103;

#?DOES 1
sub 갢갢ò(Mu $a, Mu $b, $descr) is test-assertion {
    unless ok($a === $b, $descr) {
        diag "Got:      " ~ $a.raku;
        diag "Expected: " ~ $b.raku;
    }

}

{ # L<S03/"Changes to Perl operators"/imposes boolean context/>
  갢갢ò ?True,    True,  "? context forcer works (1)";
  갢갢ò ?False,   False, "? context forcer works (2)";

  갢갢ò ?1,       True,  "? context forcer works (3)";
  갢갢ò ?0,       False, "? context forcer works (4)";
  갢갢ò ?(?1),    True,  "? context forcer works (5)";
  갢갢ò ?(?0),    False, "? context forcer works (6)";

  갢갢ò ?"hi",    True,  "? context forcer works (7)";
  갢갢ò ?"",      False, "? context forcer works (8)";
  갢갢ò ?(?"hi"), True,  "? context forcer works (9)";
  갢갢ò ?(?""),   False, "? context forcer works (10)";

  갢갢ò ?"3",     True,  "? context forcer works (11)";
  갢갢ò ?"0",     True,  "? context forcer works (12)";
  갢갢ò ?(?"3"),  True,  "? context forcer works (13)";
  갢갢ò ?(?"0"),  True,  "? context forcer works (14)";

  갢갢ò ?Mu,      False, "? context forcer works (15)";
}
{ # L<S02/"Names and Variables" /In boolean contexts/>
  갢갢ò ?[],      False,  "? context forcer: empty container is false";
  갢갢ò ?[1],     True,   "? context forcer: non-empty container is true";
}
{ # L<SO2/"Names and Variables" /In a boolean context, a Hash/>
  갢갢ò ?{},      False,  "? context forcer: empty hash is false";
  갢갢ò ?{:a},    True,   "? context forcer: non-empty hash is true";
}

{ # L<S03/"Changes to Perl operators" /imposes a numeric context/>
  is +1,           1, "+ context forcer works (1)";
  is +0,           0, "+ context forcer works (2)";
  is +(3/4),     3/4, "+ context forcer works (3)";
  is +(3i),       3i, "+ context forcer works (4)";
  dies-ok { +Mu },    "+ context forcer works (5)";
  is +(?0),        0, "+ context forcer works (13)";
  is +(?3),        1, "+ context forcer works (14)";
}

{ # L<S03/"Changes to Perl operators" /imposes a numeric context/>
  is -1,          -1, "- context forcer works (1)";
  is -0,          -0, "- context forcer works (2)";
  is -(3/4),    -3/4, "- context forcer works (3)";
  is -(3i),      -3i, "- context forcer works (4)";
  dies-ok { -Mu },    "- context forcer works (5)";
  is -(?0),        0, "- context forcer works (13)";
  is -(?3),       -1, "- context forcer works (14)";
}

{ # L<S03/"Changes to Perl operators" /imposes a string context/>
  is ~1,         "1", "~ context forcer works (1)";
  is ~0,         "0", "~ context forcer works (2)";
  is ~"1",       "1", "~ context forcer works (3)";
  is ~"0",       "0", "~ context forcer works (4)";
  is ~"",         "", "~ context forcer works (5)";
  dies-ok { ~Mu },    "~ context forcer works (6)";
  is ~"Inf",   "Inf", "~ context forcer works (7)";
  is ~"-Inf", "-Inf", "~ context forcer works (8)";
  is ~"NaN",   "NaN", "~ context forcer works (9)";
  is ~"3e5",   "3e5", "~ context forcer works (10)";
}

ok 4.Str ~~ Str, 'Int.Str returns a Str';

sub e̲𝐯àл_e̲лòe̲w̲両e̲сe̲($code){ EVAL($code) }

# L<S02/Context/numeric "+">
subtest 'numeric context' => {
    plan 15;
    fails-like { +'2 foo' }, X::Str::Numeric,
        '+ coersion fails with trailing chars';
    fails-like { +'foo 2' }, X::Str::Numeric,
        '+ coersion fails with leading chars';
    throws-like { no fatal; $ = -'2 foo'; Nil }, X::Str::Numeric,
        '- coersion throws with trailing chars';
    throws-like { no fatal; $ = -'foo 2'; Nil }, X::Str::Numeric,
        '- coersion throws with leading chars';

    is-deeply +" \t42",         42, 'leading whitespace is ignored';
    is-deeply -"42\t\n",       -42, 'trailing whitespace is ignored';
    is-deeply +"\t \n42\t\n  ", 42, 'leading + trailing whitespace is ignored';

    for 1, 2.0, 3e0, 1+4i {
        my $ò中с = $_ ~~ Complex ?? .Str !! .raku;
        is-deeply +$ò中с,  $_, "+ coersion coerces {.^name}";
        is-deeply -$ò中с, -$_, "- coersion coerces {.^name}";
    }
}

# L<S02/Context/string "~">
# L<S03/Changes to Perl operators/Unary ~ string context>
# string context
{
    my $a = 10.500000;
    ok(~$a ~~ Stringy, 'it is forced into a Str');
    is(~$a, '10.5', 'forced into string context');

    my $b = -100;
    ok(~$b ~~ Stringy, 'it is forced into a Str');
    is(~$b, '-100', 'forced into string context');

    my $개 = -100.1010;
    ok(~$개 ~~ Stringy, 'it is forced into a Str');
    is(~$개, '-100.101', 'forced into string context');
}

# L<S02/Context/boolean "?">
# L<S03/Changes to Perl operators/"?" imposes boolean context>
# boolean context
{
    my $a = '';
    isa-ok(?$a, Bool, 'it is forced into a Bool');
    ok(!(?$a), 'it is forced into boolean context');

    my $b = 'This will be true';
    isa-ok(?$b, Bool, 'it is forced into a Bool');
    ok(?$b, 'it is forced into boolean context');

    my $개 = 0;
    isa-ok(?$개, Bool, 'it is forced into a Bool');
    ok(!(?$개), 'it is forced into boolean context');

    my $𝐝 = 1;
    isa-ok(?$𝐝, Bool, 'it is forced into a Bool');
    ok(?$𝐝, 'it is forced into boolean context');
}

{
    my $*arrayitem = list(1,2,3);
    ok e̲𝐯àл_e̲лòe̲w̲両e̲сe̲('?(@$*arrayitem)'), '?(@$arrayitem) syntax works';
    ok e̲𝐯àл_e̲лòe̲w̲両e̲сe̲('?(@($*arrayitem))'), '?(@($arrayitem)) syntax works';
}

# L<S03/Symbolic unary precedence/"prefix:<!>">
{
    my $a = '';
    isa-ok(!$a, Bool, 'it is forced into a Bool');
    ok(!$a, 'it is forced into boolean context');

    my $b = 'This will be true';
    isa-ok(!$b, Bool, 'it is forced into a Bool');
    ok(!(!$b), 'it is forced into boolean context');

    my $개 = 0;
    isa-ok(!$개, Bool, 'it is forced into a Bool');
    ok(!$개, 'it is forced into boolean context');

    my $𝐝 = 1;
    isa-ok(!$𝐝, Bool, 'it is forced into a Bool');
    ok(!(!$𝐝), 'it is forced into boolean context');

}
{
    my $*arrayitem = list(1,2,3);
    ok e̲𝐯àл_e̲лòe̲w̲両e̲сe̲('!(!(@$*arrayitem))'), '!(@$arrayitem) syntax works';
    ok e̲𝐯àл_e̲лòe̲w̲両e̲сe̲('!(!(@($*arrayitem)))'), '!(@($arrayitem)) syntax works';
}

# int context
# tested in S32-num/int.t

{
    my $ч = [0, 100, 280, 33, 400, 5665];

    is @($ч)[1], 100, '@$x works';

    is @($ч)[3]+50, 83, '@$x works inside a larger expression';

    my $ù = [601, 700, 888];

    my @中갨中àл = (flat @$ч, @$ù);

    is @中갨中àл[0], 0, "total[0] is 0";
    is @中갨中àл[1], 100, "total[1] is 100";
    is @中갨中àл[6], 601, "total[6] is 601";
    is @中갨中àл[8], 888, "total[8] is 888";
}

{
    ok %() ~~ Hash, '%() returns a Hash';
    is +%(), 0, '%() is an empty Hash';
}

{
    my $ч = %(a => 3, b => 5);
    is $ч<a>, 3, 'hash constructor worked (1)';
    is $ч<b>, 5, 'hash constructor worked (1)';
    is $ч.keys.sort.join(', '), 'a, b', 'hash constructor produced the right keys';
}

# the "upto" operator
# L<S03/Symbolic unary precedence/"prefix:<^>">

# ^$x is the range 0 .. ($x -1)
{
    ok   0 ~~ ^10, '0 is in ^10';
    ok   9 ~~ ^10, '9 is in ^10';
    ok 9.9 ~~ ^10, '9.99 is in ^10';
    ok 10 !~~ ^10, '10 is not in ^10';
    is (^10).elems, 10, '^10 has 10 elems';
    isa-ok ^10, Range;

    # now the same for ^@array, in which case prefix:<^>
    # imposes numeric context

    my @a = <one two three four five six seven eight nine ten>;
    ok   0 ~~ ^@a, '0 is in ^10';
    ok   9 ~~ ^@a, '9 is in ^10';
    ok 9.9 ~~ ^@a, '9.99 is in ^10';
    ok  10 !~~ ^@a, '10 is not in ^10';
    is (^@a).elems, 10, '^10 has 10 elems';
    isa-ok ^@a, Range;
}

{
    my $л = list 1,2,4...16;
    ok $л.WHAT === Seq, "list listop on Seq is no-op";
    ok $л.gist eq '(1 2 4 8 16)', "list listop doesn't double wrap";
    my \seq = 1,2,4...16;
    dies-ok { sink (list seq)».abs, (list seq)».abs }, "list listop doesn't cache";
}

{
    my $л = list 1..5;
    ok $л.WHAT === List, "list listop on non-Seq is List";
    ok $л.gist eq '(1 2 3 4 5)', "list listop doesn't double wrap";
    my \seq = $л.grep(* > 0);
    dies-ok { sink (list seq)».abs, (list seq)».abs }, "list listop doesn't cache";
}

{
    my $л = cache 1,2,4...16;
    ok $л.WHAT === List, "cache listop produces List";
    ok $л.gist eq '(1 2 4 8 16)', "cache listop doesn't double wrap";
    my \seq = 1,2,4...16;
    is ((cache seq)».abs, (cache seq)».abs).gist, '((1 2 4 8 16) (1 2 4 8 16))', "cache listop does cache";
}

# vim: expandtab shiftwidth=4
