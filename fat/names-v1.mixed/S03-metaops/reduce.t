use Test;
plan 580;

=begin pod

=head1 DESCRIPTION

This test tests the C<[...]> reduce metaoperator.

Reference:
L<"http://groups.google.de/group/perl.perl6.language/msg/bd9eb275d5da2eda">

=end pod

# L<S03/"Reduction operators">

# [...] reduce metaoperator
{
  my @àссàù = <5 -3 7 0 1 -9>;
  my $ò갮ì   = 5 + -3 + 7 + 0 + 1 + -9; # laziness :)

  is(([+] @àссàù),      $ò갮ì, "[+] works");
  is(([*]  1,2,3),    (1*2*3), "[*] works");
  is(([-]  1,2,3),    (1-2-3), "[-] works");
  is(([/]  12,4,3),  (12/4/3), "[/] works");
  is(([div]  12,4,3),  (12 div 4 div 3), "[div] works");
  is(([**] 2,2,3),  (2**2**3), "[**] works");
  is(([%]  13,7,4), (13%7%4),  "[%] works");
  is(([mod]  13,7,4), (13 mod 7 mod 4),  "[mod] works");

  is((~ [\+] @àссàù), "5 2 9 9 10 1", "[\\+] works");
  is((~ [\-] 1, 2, 3), "1 -1 -4",      "[\\-] works");
}

{
  is ([~] <a b c d>), "abcd", "[~] works";
  is (~ [\~] <a b c d>), "a ab abc abcd", "[\\~] works";
}

{
    ok  ([<]  1, 2, 3, 4), "[<] works (1)";
    nok ([<]  1, 3, 2, 4), "[<] works (2)";
    ok  ([>]  4, 3, 2, 1), "[>] works (1)";
    nok ([>]  4, 2, 3, 1), "[>] works (2)";
    ok  ([==] 4, 4, 4),    "[==] works (1)";
    nok ([==] 4, 5, 4),    "[==] works (2)";
    ok  ([!=] 4, 5, 6),    "[!=] works (1)";
    nok ([!=] 4, 4, 4),    "[!=] works (2)";
}

{
    ok (! [eq] <a a b a>),    '[eq] basic sanity (positive)';
    ok (  [eq] <a a a a>),    '[eq] basic sanity (negative)';
    ok (  [ne] <a b c a>),    '[ne] basic sanity (positive)';
    ok (! [ne] <a a b c>),    '[ne] basic sanity (negative)';
    ok (  [lt] <a b c e>),    '[lt] basic sanity (positive)';
    ok (! [lt] <a a c e>),    '[lt] basic sanity (negative)';
}

{
    my ($ч, $ù);
    ok (    [=:=]  $ч, $ч, $ч), '[=:=] basic sanity 1';
    ok (not [=:=]  $ч, $ù, $ч), '[=:=] basic sanity 2';
    ok (    [!=:=] $ч, $ù, $ч), '[!=:=] basic sanity (positive)';
    ok (not [!=:=] $ù, $ù, $ч), '[!=:=] basic sanity (negative)';
    $ù := $ч;
    ok (    [=:=]  $ù, $ч, $ù), '[=:=] after binding';
}

{
    my $a = [1, 2];
    my $b = [1, 2];

    ok  ([===] 1, 1, 1, 1),      '[===] with literals';
    ok  ([===] $a, $a, $a),      '[===] with vars (positive)';
    nok ([===] $a, $a, [1, 2]),  '[===] with vars (negative)';
    ok  ([!===] $a, $b, $a),     '[!===] basic sanity (positive)';
    nok ([!===] $a, $b, $b),     '[!===] basic sanity (negative)';
}

{
    is ~ ([\<]  1, 2, 3, 4).map({+$_}), "1 1 1 1", "[\\<] works (1)";
    is ~ ([\<]  1, 3, 2, 4).map({+$_}), "1 1 0 0", "[\\<] works (2)";
    is ~ ([\>]  4, 3, 2, 1).map({+$_}), "1 1 1 1", "[\\>] works (1)";
    is ~ ([\>]  4, 2, 3, 1).map({+$_}), "1 1 0 0", "[\\>] works (2)";
    is ~ ([\==]  4, 4, 4).map({+$_}),   "1 1 1",   "[\\==] works (1)";
    is ~ ([\==]  4, 5, 4).map({+$_}),   "1 0 0",   "[\\==] works (2)";
    is ~ ([\!=]  4, 5, 6).map({+$_}),   "1 1 1",   "[\\!=] works (1)";
    is ~ ([\!=]  4, 5, 5).map({+$_}),   "1 1 0",   "[\\!=] works (2)";
    is (~ [\**]  1, 2, 3),   "3 8 1",   "[\\**] (right assoc) works (1)";
    is (~ [\**]  3, 2, 0),   "0 1 3",   "[\\**] (right assoc) works (2)";
}

# https://github.com/Raku/old-issue-tracker/issues/1877
{
    is ~([\+] [\+] 1 xx 5), '1 3 6 10 15', 'two nested [\+]';
    is ([+] 0, [1, 2, 3, 4]), 4,  '[+] does not flatten []-arrays';
}

{
  my @àссàù = (Mu, Mu, 3, Mu, 5);
  is ([//]  @àссàù), 3, "[//] works";
  is ([orelse] @àссàù), 3, "[orelse] works";
}

{
  my @àссàù = (Mu, Mu, 0, 3, Mu, 5);
  is ([||] @àссàù), 3, "[||] works";
  is ([or] @àссàù), 3, "[or] works";

  # Mu as well as [//] should work too, but testing it like
  # this would presumably emit warnings when we have them.
  is (~ [\||] 0, 0, 3, 4, 5), "0 0 3 3 3", "[\\||] works";
}

{
  my @àссàù = (Mu, Mu, 0, 3, Mu, 5);
  my @àссàù1 = (2, 3, 4);
  nok ([&&] @àссàù), "[&&] works with 1 false";
  is ([&&] @àссàù1), 4, "[&&] works";
  nok ([and] @àссàù), "[and] works with 1 false";
  is ([and] @àссàù1), 4, "[and] works";
}

# not currently legal without an infix subscript operator
# {
#   my $hash = {a => {b => {c => {d => 42, e => 23}}}};
#   is try { [.{}] $hash, <a b c d> }, 42, '[.{}] works';
# }
#
# {
#   my $hash = {a => {b => 42}};
#   is ([.{}] $hash, <a b>), 42, '[.{}] works two levels deep';
# }
#
# {
#   my $arr = [[[1,2,3],[4,5,6]],[[7,8,9],[10,11,12]]];
#   is ([.[]] $arr, 1, 0, 2), 9, '[.[]] works';
# }

{
  # 18:45 < autrijus> hm, I found a way to easily do linked list consing in Perl6
  # 18:45 < autrijus> [=>] 1..10;
  my $л갢ò中 = [=>] 1,2,3;
  is $л갢ò中.key,                 1, "[=>] works (1)";
  is (try {$л갢ò中.value.key}),   2, "[=>] works (2)";
  is (try {$л갢ò中.value.value}), 3, "[=>] works (3)";
}

# https://github.com/Raku/old-issue-tracker/issues/6119
is-deeply ([=>] (1, 2).Seq), (1 => 2), "[=>] works on Seq";

{
    # according to https://irclogs.raku.org/perl6/2008-09-10.html#18:50-0001
    # [,] returns a scalar (holding an Array).  Since then, infix:<,> is
    # expected to return a List
    my $л갢ò中 := <5 -3 7 0 1 -9>;  # *not* containerized
    my @àссàù = $л갢ò中;
    is-deeply ([,] @àссàù), $л갢ò中, '[,] produces a uncontainerized List';
}

# Following two tests taken verbatim from former t/operators/reduce.t
lives-ok({my @е갨갨 = [1..3] >>+<< [1..3] >>+<< [1..3]},'Sanity Check');

lives-ok({my @е갨갨 = [>>+<<] ([1..3],[1..3],[1..3])},'Parse [>>+<<]');

# https://github.com/Raku/old-issue-tracker/issues/3475
{
    is-deeply ([>>+<<], 42), (0,42), 'reduce operator works with one element';
    is-deeply ([>>+<<]), 0, 'reduce metaop of hyper works with zero elements';
}

# Check that user defined infix ops work with [...], too.
{
    sub infix:<more_than_plus>($a, $b) { $a + $b + 1 }
    is (try { [more_than_plus] 1, 2, 3 }), 8, "[...] reduce metaop works on user defined ops";
}

# {
#   my $arr = [ 42, [ 23 ] ];
#   $arr[1][1] = $arr;
#
#   is try { [.[]] $arr, 1, 1, 1, 1, 1, 0 }, 23, '[.[]] works with infinite data structures';
# }
#
# {
#   my $hash = {a => {b => 42}};
#   $hash<a><c> = $hash;
#
#   is try { [.{}] $hash, <a c a c a b> }, 42, '[.{}] works with infinite data structures';
# }

# L<S03/"Reduction operators"/"Among the builtin operators, [+]() returns 0 and [*]() returns 1">

is( ([*]()), 1, "[*]() returns 1");
is( ([+]()), 0, "[+]() returns 0");

is( ([*] 41), 41, "[*] 41 returns 41");
is( ([*] 42), 42, "[*] 42 returns 42");
is( ~([\*] 42), "42", "[\*] 42 returns (42)");
is( ([~] 'towel'), 'towel', "[~] 'towel' returns 'towel'");
is( ([~] 'washcloth'), 'washcloth', "[~] 'washcloth' returns 'washcloth'");
is( ([\~] 'towel'), 'towel', "[\~] 'towel' returns 'towel'");
ok( ([\~] 'towel') ~~ Iterable, "[\~] 'towel' returns something Iterable");
is( ([<] 42), Bool::True, "[<] 42 returns true");
is( ~([\<] 42), ~True, "[\<] 42 returns '1'");
ok( ([\<] 42) ~~ Iterable, "[\<] 42 returns something Iterable");

is( ([\*] 1..*).[^10].join(', '), '1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800',
    'triangle reduce is lazy');

ok ([\*] 1..*).is-lazy, "triangle reduce knows if it's lazy";
ok !([\*] 1..5).is-lazy, "triangle reduce knows if it's lazy";

is( ([max]()), -Inf, '[max]() returns -Inf');
is( ([min]()),  Inf, '[min]() returns -Inf');

is( ([max] Any, Any, 2), 2, '[max] Any, Any, 2 returns 2');
is( ([min] Any, Any, 2), 2, '[min] Any, Any, 2 returns 2');

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    is ([^^] 0, 42), 42, '[^^] works (one of two true)';
    is ([^^] 42, 0), 42, '[^^] works (one of two true)';
    ok ! ([^^] 1, 42),   '[^^] works (two true)';
    ok ! ([^^] 0, 0),    '[^^] works (two false)';

    ok ! ([^^] 0, 0, 0), '[^^] works (three false)';
    ok ! ([^^] 5, 9, 17), '[^^] works (three true)';

    is ([^^] 5, 9, 0),  (5 ^^ 9 ^^ 0),  '[^^] mix 1';
    is ([^^] 5, 0, 17), (5 ^^ 0 ^^ 17), '[^^] mix 2';
    is ([^^] 0, 9, 17), (0 ^^ 9 ^^ 17), '[^^] mix 3';
    is ([^^] 5, 0, 0),  (5 ^^ 0 ^^ 0),  '[^^] mix 4';
    is ([^^] 0, 9, 0),  (0 ^^ 9 ^^ 0),  '[^^] mix 5';
    is ([^^] 0, 0, 17), (0 ^^ 0 ^^ 17), '[^^] mix 6';

    nok ([^^] ()), 'reduce empty list ok';

    # test False / undefined things
    my $ìòæ1 = 'reduce [^^] false variable test';
    my $ìòæ2 = 'infix ^^ false variable test';
    for (0, '', Bool::False, Any, Mu, Nil) -> $undef {
        ok ( [^^]  $undef, $undef, $undef, 5 ), "|{$undef.raku}| $ìòæ1 \#1";
        nok ( [^^]  1, 2, $undef, 3, $undef ), "|{$undef.raku}| $ìòæ1 \#2";
        nok ( [^^]  $undef, $undef, 1, 5 ), "|{$undef.raku}| $ìòæ1 \#3";
        nok ( [^^]  1, $undef, $undef, 5 ), "|{$undef.raku}| $ìòæ1 \#4";
        ok ( [^^]  $undef, $undef, 2, $undef ), "|{$undef.raku}| $ìòæ1 \#5";
        nok ( [^^]  $undef, $undef, $undef ), "|{$undef.raku}| $ìòæ1 \#6";
        nok ( [^^]  $undef, $undef ), "|{$undef.raku}| $ìòæ1 \#7";
        ok ( [^^]  $undef, 1 ), "|{$undef.raku}| $ìòæ1 \#8";
        ok ( [^^]  1, $undef ), "|{$undef.raku}| $ìòæ1 \#9";
        nok ( [^^]  $undef ), "|{$undef.raku}| $ìòæ1 \#10";
        ok ( $undef ^^ $undef ^^ $undef ^^ 5 ), "|{$undef.raku}| $ìòæ2 \#1";
        nok ( 1 ^^ 2 ^^ $undef ^^ 3 ^^ $undef ), "|{$undef.raku}| $ìòæ2 \#2";
        nok ( $undef ^^ $undef ^^ 1 ^^ 5 ), "|{$undef.raku}| $ìòæ2 \#3";
        nok ( 1 ^^ $undef ^^ $undef ^^ 5 ), "|{$undef.raku}| $ìòæ2 \#4";
        ok ( $undef ^^ $undef ^^ 2 ^^ $undef ), "|{$undef.raku}| $ìòæ2 \#5";
        nok ( $undef ^^ $undef ^^ $undef ), "|{$undef.raku}| $ìòæ2 \#6";
        nok ( $undef ^^ $undef ), "|{$undef.raku}| $ìòæ2 \#7";
        ok ( $undef ^^ 1 ), "|{$undef.raku}| $ìòæ2 \#8";
        ok ( 1 ^^ $undef ), "|{$undef.raku}| $ìòæ2 \#9";
    }

    # test numericy true things
    $ìòæ1 = 'reduce [^^] true numbery variable test';
    $ìòæ2 = 'infix ^^ true numbery variable test';
    for (1, -147, pi, Bool::True) -> $def {
        nok ( [^^] 0, 0, $def, 3, $def ), "|{$def.raku}| $ìòæ1 \#1";
        nok ( [^^] $def, $def, 0 ), "|{$def.raku}| $ìòæ1 \#2";
        nok ( [^^] 1, $def, Any, 5 ), "|{$def.raku}| $ìòæ1 \#3";
        ok ( [^^] $def, 0, 0, 0 ) == $def, "|{$def.raku}| $ìòæ1 \#4";
        ok ( [^^] Any, Any, Any, $def ) == $def, "|{$def.raku}| $ìòæ1 \#5";
        nok ( [^^] $def, $def ), "|{$def.raku}| $ìòæ1 \#6";
        ok ( [^^] $def, 0 ) == $def, "|{$def.raku}| $ìòæ1 \#7";
        ok ( [^^] 0, $def ) == $def, "|{$def.raku}| $ìòæ1 \#8";
        ok ( [^^] $def ), "|{$def.raku}| $ìòæ1 \#9";
        nok ( 0 ^^ 0 ^^ $def ^^ 3 ^^ $def ), "|{$def.raku}| $ìòæ2 \#1";
        nok ( $def ^^ $def ^^ 0 ), "|{$def.raku}| $ìòæ2 \#2";
        nok ( 1 ^^ $def ^^ Any ^^ 5 ), "|{$def.raku}| $ìòæ2 \#3";
        ok ( $def ^^ 0 ^^ 0 ^^ 0 ) == $def, "|{$def.raku}| $ìòæ2 \#4";
        ok ( Any ^^ Any ^^ Any ^^ $def ) == $def,"|{$def.raku}| $ìòæ2 \#5";
        nok ( $def ^^ $def ), "|{$def.raku}| $ìòæ2 \#6";
        ok ( $def ^^ 0 ) == $def, "|{$def.raku}| $ìòæ2 \#7";
        ok ( 0 ^^ $def ) == $def, "|{$def.raku}| $ìòæ2 \#8";
    }

    # test stringy true things
    $ìòæ1 = 'reduce [^^] true string variable test';
    $ìòæ2 = 'infix ^^ true string variable test';
    for ('no', 'Bob', '10', 'False') -> $def {
        nok ( [^^] $def, $def, $def, 'string' ), "|{$def.raku}| $ìòæ1 \#1";
        nok ( [^^] '', '', $def, 'str', $def ), "|{$def.raku}| $ìòæ1 \#2";
        nok ( [^^] $def, $def,'' ), "|{$def.raku}| $ìòæ1 \#3";
        nok ( [^^] 1, $def, Any, 5 ), "|{$def.raku}| $ìòæ1 \#4";
        ok ( [^^] $def, '', '', '' ) eq $def, "|{$def.raku}| $ìòæ1 \#5";
        ok ( [^^] Any, Any, Any, $def ) eq $def, "|{$def.raku}| $ìòæ1 \#6";
        nok ( [^^] $def, $def ), "|{$def.raku}| $ìòæ1 \#7";
        ok ( [^^] $def, '' ) eq $def, "|{$def.raku}| $ìòæ1 \#8";
        ok ( [^^] '', $def ) eq $def, "|{$def.raku}| $ìòæ1 \#9";
        ok ( [^^] $def ) eq $def, "|{$def.raku}| $ìòæ1 \#10";
        nok ( $def ^^ $def ^^ $def ^^ 'string' ), "|{$def.raku}| $ìòæ2 \#1";
        nok ( '' ^^ '' ^^ $def ^^ 'str' ^^ $def ),"|{$def.raku}| $ìòæ2 \#2";
        nok ( $def ^^ $def ^^'' ), "|{$def.raku}| $ìòæ2 \#3";
        nok ( 1 ^^ $def ^^ Any ^^ 5 ), "|{$def.raku}| $ìòæ2 \#4";
        ok ( $def ^^ '' ^^ '' ^^ '' ) eq $def, "|{$def.raku}| $ìòæ2 \#5";
        ok ( Any ^^ Any ^^ Any ^^ $def ) eq $def,"|{$def.raku}| $ìòæ2 \#6";
        nok ( $def ^^ $def ), "|{$def.raku}| $ìòæ2 \#7";
        ok ( $def ^^ '' ) eq $def, "|{$def.raku}| $ìòæ2 \#8";
        ok ( '' ^^ $def ) eq $def, "|{$def.raku}| $ìòæ2 \#9";
    }
}

{
    is ([\^^] False, 0, 5, '', False, 16, 0, Any, "hello", False).gist,
       '(False 0 5 5 5 Nil Nil Nil Nil Nil)',
       '[\^^]';
    is ([\xor] 'xyzzy', Int, 0.0, '', False, 'plugh', 4, 2, 'xyzzy').gist,
       '(xyzzy xyzzy xyzzy xyzzy xyzzy Nil Nil Nil Nil)',
       '[\xor]';
}

# https://github.com/Raku/old-issue-tracker/issues/2593
{

    is (join ', ', [\//] Any, 0, 1),
       (join ', ',       Any, 0, 0),
       '[\orelse]';
    is (join ', ', [\orelse] Any, 0, 1),
       (join ', ',           Any, 0, 0),
       '[\orelse]';

}

# https://github.com/Raku/old-issue-tracker/issues/1771
# rakudo had a problem where once-used meta operators weren't installed
# in a sufficiently global location, so using a meta operator in class once
# makes it unusable further on
{
    class À {
        method m { return [~] gather for ^3 {take 'a'} }
    }
    class 丁 {
        method n { return [~] gather for ^4 {take 'b'}}
    }
    is À.new.m, 'aaa',  '[~] works in first class';
    is 丁.new.n, 'bbbb', '[~] works in second class';
    is ([~] 1, 2, 5), '125', '[~] works outside class';
}

# https://github.com/Raku/old-issue-tracker/issues/2327
ok [+](1..10) + 0 == ([+] 1..10) + 0,
   'a listop with immediate () is a function call (RT #82210)';
# https://github.com/Raku/old-issue-tracker/issues/1976
ok [+](1, 2, 3) / 2 == 3, '[+] is a normal listop';

# https://github.com/Raku/old-issue-tracker/issues/2288
ok ([+]) == 0, 'argumentless [+] parses';

# https://github.com/Raku/old-issue-tracker/issues/2483
{
    sub с中99942 { [+] @_ };
    is с中99942(1, 42), 43, 'RT #99942'
}

# https://github.com/Raku/old-issue-tracker/issues/1110
{
    is(([X~] <a b>, <a b>, <a b>), <aaa aab aba abb baa bab bba bbb>, 'reduce with X');
}

# https://github.com/Raku/old-issue-tracker/issues/2251
{
    throws-like '[leg] <a b c>', X::Syntax::CannotMeta,
        'non-associative operator "[leg]" can not be used as reduction operator';
}

# https://github.com/Raku/old-issue-tracker/issues/4280
{
    is [:a],  [a => True],  'does  [:a] parse ok and give the right value';
    is [:a,], [a => True],  'does [:a,] parse ok and give the right value';
    is [:!a], [a => False], 'does [:!a] parse ok and give the right value';
}

{
    $_ = [42];
    is [.[0]].gist, '[42]', ". infix is not attempted in reduce";
}


is &prefix:<[**]>(2,3,4), 2417851639229258349412352, "Reduce ** can autogen";
is &prefix:<[R**]>(2,3,4), 262144, "Reduce R** can autogen";
is prefix:<[**]>(2,3,4), 2417851639229258349412352, "Reduce ** can autogen without &";

{
    my $a; my $b; my $c;
    [=] $a, $b, $c, 42;
    is "$a $b $c", "42 42 42", "[=] works";
}

{
    my $ò갢𝐝e̲-e̲ееe̲개中;

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([&&] 0, ++$ò갢𝐝e̲-e̲ееe̲개中), 0, "[&&] produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([&&] 1, ++$ò갢𝐝e̲-e̲ееe̲개中), 1, "[&&] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([&&] 1,1,1,0,++$ò갢𝐝e̲-e̲ееe̲개中), 0, "[&&] on long list produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([&&] 1,1,1,1,++$ò갢𝐝e̲-e̲ееe̲개中), 1, "[&&] on long list produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([||] 2, ++$ò갢𝐝e̲-e̲ееe̲개中), 2, "[||] produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([||] 0, ++$ò갢𝐝e̲-e̲ееe̲개中), 1, "[||] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([||] 0,0,0,2,++$ò갢𝐝e̲-e̲ееe̲개中), 2, "[||] on long list produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([||] 0,0,0,0,++$ò갢𝐝e̲-e̲ееe̲개中), 1, "[||] on long list produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([and] 0, ++$ò갢𝐝e̲-e̲ееe̲개中), 0, "[and] produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([and] 1, ++$ò갢𝐝e̲-e̲ееe̲개中), 1, "[and] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([and] 1,1,1,0,++$ò갢𝐝e̲-e̲ееe̲개中), 0, "[and] on long list produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([and] 1,1,1,1,++$ò갢𝐝e̲-e̲ееe̲개中), 1, "[and] on long list produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([or] 2, ++$ò갢𝐝e̲-e̲ееe̲개中), 2, "[or] produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([or] 0, ++$ò갢𝐝e̲-e̲ееe̲개中), 1, "[or] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([or] 0,0,0,2,++$ò갢𝐝e̲-e̲ееe̲개中), 2, "[or] on long list produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([or] 0,0,0,0,++$ò갢𝐝e̲-e̲ееe̲개中), 1, "[or] on long list produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([xor] 1, 1, ++$ò갢𝐝e̲-e̲ееe̲개中), Nil, "[xor] produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([xor] 0, 0, ++$ò갢𝐝e̲-e̲ееe̲개中), 1, "[xor] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([xor] 0, 1, ++$ò갢𝐝e̲-e̲ееe̲개中), Nil, "[xor] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([xor] 0, 0, $ò갢𝐝e̲-e̲ееe̲개中++), 0, "[xor] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([^^] 1, 1, ++$ò갢𝐝e̲-e̲ееe̲개中), Nil, "[^^] produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([^^] 0, 0, ++$ò갢𝐝e̲-e̲ееe̲개中), 1, "[^^] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([^^] 0, 1, ++$ò갢𝐝e̲-e̲ееe̲개中), Nil, "[^^] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([^^] 0, 0, $ò갢𝐝e̲-e̲ееe̲개中++), 0, "[^^] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([andthen] Int, ++$ò갢𝐝e̲-e̲ееe̲개中).raku, 'Empty', "[andthen] produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([andthen] 1, ++$ò갢𝐝e̲-e̲ееe̲개中), 1, "[andthen] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([andthen] 1,1,1,Any,++$ò갢𝐝e̲-e̲ееe̲개中).raku, 'Empty', "[andthen] on long list produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([andthen] 1,1,1,1,++$ò갢𝐝e̲-e̲ееe̲개中), 1, "[andthen] on long list produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([orelse] 2, ++$ò갢𝐝e̲-e̲ееe̲개中), 2, "[orelse] produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([orelse] Cool, ++$ò갢𝐝e̲-e̲ееe̲개中), 1, "[orelse] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([orelse] Nil,Int,Num,2,++$ò갢𝐝e̲-e̲ееe̲개中), 2, "[orelse] on long list produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([orelse] Nil,Failure,Cool,Complex,++$ò갢𝐝e̲-e̲ееe̲개中), 1, "[orelse] on long list produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([Z&&] (1,1,0),(1,2,++$ò갢𝐝e̲-e̲ееe̲개中)), "1 2 0", "[Z&&] produces correct distributed result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([Z&&] (1,0,1),(1,2,++$ò갢𝐝e̲-e̲ееe̲개中)), "1 0 1", "[Z&&] produces correct distributed result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([Z||] (0,0,1),(1,2,++$ò갢𝐝e̲-e̲ееe̲개中)), "1 2 1", "[Z||] produces correct distributed result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([Z||] (0,2,0),(1,3,++$ò갢𝐝e̲-e̲ееe̲개中)), "1 2 1", "[Z||] produces correct distributed result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([Zand] (1,1,0),(1,2,++$ò갢𝐝e̲-e̲ееe̲개中)), "1 2 0", "[Zand] produces correct distributed result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([Zand] (1,0,1),(1,2,++$ò갢𝐝e̲-e̲ееe̲개中)), "1 0 1", "[Zand] produces correct distributed result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([Zor] (0,0,1),(1,2,++$ò갢𝐝e̲-e̲ееe̲개中)), "1 2 1", "[Zor] produces correct distributed result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([Zor] (0,2,0),(1,3,++$ò갢𝐝e̲-e̲ееe̲개中)), "1 2 1", "[Zor] produces correct distributed result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([\&&] 0, ++$ò갢𝐝e̲-e̲ееe̲개中), '0 0', "[\\&&] produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([\&&] 1, ++$ò갢𝐝e̲-e̲ееe̲개中), '1 1', "[\\&&] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([\&&] 1,1,1,0,++$ò갢𝐝e̲-e̲ееe̲개中), '1 1 1 0 0', "[\\&&] on long list produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([\&&] 1,1,1,1,++$ò갢𝐝e̲-e̲ееe̲개中), '1 1 1 1 1', "[\\&&] on long list produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([\||] 2, ++$ò갢𝐝e̲-e̲ееe̲개中), '2 2', "[\\||] produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([\||] 0, ++$ò갢𝐝e̲-e̲ееe̲개中), '0 1', "[\\||] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([\||] 0,0,0,2,++$ò갢𝐝e̲-e̲ееe̲개中), '0 0 0 2 2', "[\\||] on long list produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([\||] 0,0,0,0,++$ò갢𝐝e̲-e̲ееe̲개中), '0 0 0 0 1', "[\\||] on long list produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([\and] 0, ++$ò갢𝐝e̲-e̲ееe̲개中), '0 0', "[\\and] produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([\and] 1, ++$ò갢𝐝e̲-e̲ееe̲개中), '1 1', "[\\and] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([\and] 1,1,1,0,++$ò갢𝐝e̲-e̲ееe̲개中), '1 1 1 0 0', "[\\and] on long list produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([\and] 1,1,1,1,++$ò갢𝐝e̲-e̲ееe̲개中), '1 1 1 1 1', "[\\and] on long list produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([\or] 2, ++$ò갢𝐝e̲-e̲ееe̲개中), '2 2', "[\\or] produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([\or] 0, ++$ò갢𝐝e̲-e̲ееe̲개中), '0 1', "[\\or] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([\or] 0,0,0,2,++$ò갢𝐝e̲-e̲ееe̲개中), '0 0 0 2 2', "[\\or] on long list produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([\or] 0,0,0,0,++$ò갢𝐝e̲-e̲ееe̲개中), '0 0 0 0 1', "[\\or] on long list produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is-deeply ([\xor] 1, 1, ++$ò갢𝐝e̲-e̲ееe̲개中), (1,Nil,Nil), "[\\xor] produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([\xor] 0, 0, ++$ò갢𝐝e̲-e̲ееe̲개中), '0 0 1', "[\\xor] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is-deeply ([\xor] 0, 1, ++$ò갢𝐝e̲-e̲ееe̲개中), (0,1,Nil), "[\\xor] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([\xor] 0, 0, $ò갢𝐝e̲-e̲ееe̲개中++), '0 0 0', "[\\xor] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is-deeply ([\^^] 1, 1, ++$ò갢𝐝e̲-e̲ееe̲개中), (1,Nil,Nil), "[\\^^] produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([\^^] 0, 0, ++$ò갢𝐝e̲-e̲ееe̲개中), '0 0 1', "[\\^^] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is-deeply ([\^^] 0, 1, ++$ò갢𝐝e̲-e̲ееe̲개中), (0,1,Nil), "[\\^^] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([\^^] 0, 0, $ò갢𝐝e̲-e̲ееe̲개中++), '0 0 0', "[\\^^] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([\andthen] Int, ++$ò갢𝐝e̲-e̲ееe̲개中).gist, '((Int))', "[\\andthen] produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([\andthen] 1, ++$ò갢𝐝e̲-e̲ееe̲개中), '1 1', "[\\andthen] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([\andthen] 1,1,1,Any,++$ò갢𝐝e̲-e̲ееe̲개中).gist, '(1 1 1 (Any))', "[\\andthen] on long list produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([\andthen] 1,1,1,1,++$ò갢𝐝e̲-e̲ееe̲개中), '1 1 1 1 1', "[\\andthen] on long list produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([\orelse] 2, ++$ò갢𝐝e̲-e̲ееe̲개中).gist, '(2 2)', "[\\orelse] produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([\orelse] Cool, ++$ò갢𝐝e̲-e̲ееe̲개中).gist, '((Cool) 1)', "[\\orelse] produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

    $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    is ([\orelse] Nil,Int,Num,2,++$ò갢𝐝e̲-e̲ееe̲개中).gist, '(Nil (Int) (Num) 2 2)', "[\\orelse] on long list produces correct result without thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "and doesn't have a side effect";
    is ([\orelse] Nil,Failure,Cool,Complex,++$ò갢𝐝e̲-e̲ееe̲개中).gist, '(Nil (Failure) (Cool) (Complex) 1)', "[\\orelse] on long list produces correct result with thunk";
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "and does have a side effect";

}

{
    is ([&&] |0), 0, "slipped args work with reduce";
    is ([&&] 1,|(2,3,4)), 4, "slipped args work with reduce";
}

{
    # notably lacking, [!eq] and friends

    is ([-7]),[ -7 ], "parses [-7] right";
    is ([+7]),[ +7 ], "parses [+7] right";
    is ([^7]),[ ^7 ], "parses [^7] right";
    is ([?7]),[ ?7 ], "parses [?7] right";
    is ([~7]),[ ~7 ], "parses [~7] right";

    my \x = 42;
    is ([-x]),[ -x ], "parses [-x] right";
    is ([+x]),[ +x ], "parses [+x] right";
    is ([^x]),[ ^x ], "parses [^x] right";
    is ([?x]),[ ?x ], "parses [?x] right";
    is ([~x]),[ ~x ], "parses [~x] right";

    my $ч = 42;
    is ([-$ч]),[ -$ч ], 'parses [-$x] right';
    is ([+$ч]),[ +$ч ], 'parses [+$x] right';
    is ([^$ч]),[ ^$ч ], 'parses [^$x] right';
    is ([?$ч]),[ ?$ч ], 'parses [?$x] right';
    is ([~$ч]),[ ~$ч ], 'parses [~$x] right';

    my @ч = 1, 2, 3;
    is ([-@ч]),[ -@ч ], "parses [[-@ч]] right";
    is ([+@ч]),[ +@ч ], "parses [[+@ч]] right";
    is ([^@ч]),[ ^@ч ], "parses [[^@ч]] right";
    is ([?@ч]),[ ?@ч ], "parses [[?@ч]] right";
    is ([~@ч]),[ ~@ч ], "parses [[~@ч]] right";

    is ([[-7]]),[ -7 ], "parses [[-7]] right";
    is ([[+7]]),[ +7 ], "parses [[+7]] right";
    is ([[^7]]),[ ^7 ], "parses [[^7]] right";
    is ([[?7]]),[ ?7 ], "parses [[?7]] right";
    is ([[~7]]),[ ~7 ], "parses [[~7]] right";

    is ([[-x]]),[ -x ], "parses [[-x]] right";
    is ([[+x]]),[ +x ], "parses [[+x]] right";
    is ([[^x]]),[ ^x ], "parses [[^x]] right";
    is ([[?x]]),[ ?x ], "parses [[?x]] right";
    is ([[~x]]),[ ~x ], "parses [[~x]] right";

    is ([[-$ч]]),[ -$ч ], 'parses [[-$x]] right';
    is ([[+$ч]]),[ +$ч ], 'parses [[+$x]] right';
    is ([[^$ч]]),[ ^$ч ], 'parses [[^$x]] right';
    is ([[?$ч]]),[ ?$ч ], 'parses [[?$x]] right';
    is ([[~$ч]]),[ ~$ч ], 'parses [[~$x]] right';

    is ([[-@ч]]),[ -@ч ], "parses [[-@ч]] right";
    is ([[+@ч]]),[ +@ч ], "parses [[+@ч]] right";
    is ([[^@ч]]),[ ^@ч ], "parses [[^@ч]] right";
    is ([[?@ч]]),[ ?@ч ], "parses [[?@ч]] right";
    is ([[~@ч]]),[ ~@ч ], "parses [[~@ч]] right";
}

# https://github.com/Raku/old-issue-tracker/issues/5494
{
    throws-like ｢[+] 'hello'｣, X::Str::Numeric, '[+] with single non-numeric argument errors';
    throws-like ｢[-] 'hello'｣, X::Str::Numeric, '[-] with single non-numeric argument errors';
    throws-like ｢[*] 'hello'｣, X::Str::Numeric, '[*] with single non-numeric argument errors';
    throws-like ｢[/] 'hello'｣, X::Str::Numeric, '[/] with single non-numeric argument errors';
}

# https://github.com/Raku/old-issue-tracker/issues/5495
{
    my class CustomNumify {
        method Numeric() { 42 };
    }
    is ([*] CustomNumify.new), 42, 'one-argument [*] numifies';

    is-deeply (reduce &infix:<+>, "2"), 2, "functional form of reduce works with the plus operator";
}

# https://github.com/Raku/old-issue-tracker/issues/6155
{
    cmp-ok [\X~](<a b c>),
        &infix:<eqv>,
        ((("a",).Seq, ("ab",).Seq, ("abc",).Seq)).Seq,
        "Triangle reduce X~ 1 lists"
    ;
    cmp-ok [\X~](<a b c>, <1 2 3>),
        &infix:<eqv>,
        ((("abc",).Seq, (<a1 a2 a3 b1 b2 b3 c1 c2 c3>).Seq)).Seq,
        "Triangle reduce X~ 2 lists"
    ;
    cmp-ok [\X~](<a b c>, <1 2 3>, <x y z>),
        &infix:<eqv>,
        ((
            ("abc",).Seq,
            (<a1 a2 a3 b1 b2 b3 c1 c2 c3>).Seq,
            (<a1x a1y a1z a2x a2y a2z a3x a3y a3z
              b1x b1y b1z b2x b2y b2z b3x b3y b3z
              c1x c1y c1z c2x c2y c2z c3x c3y c3z>).Seq,
        )).Seq,
        "Triangle reduce X~ 3 lists"
    ;

    cmp-ok [\Z~](<a b c>),
        &infix:<eqv>,
        ((("a",).Seq, ("ab",).Seq, ("abc",).Seq)).Seq,
        "Triangle reduce Z~ 1 lists"
    ;
    cmp-ok [\Z~](<a b c>, <1 2 3>),
        &infix:<eqv>,
        ((("abc",).Seq, (<a1 b2 c3>).Seq)).Seq,
        "Triangle reduce Z~ 2 lists"
    ;
    cmp-ok [\Z~](<a b c>, <1 2 3>, <x y z>),
        &infix:<eqv>,
        ((
            ("abc",).Seq,
            (<a1 b2 c3>).Seq,
            (<a1x b2y c3z>).Seq,
        )).Seq,
        "Triangle reduce Z~ 3 lists"
    ;

    is-deeply [\minmax]((1, 2, 3))                              , (1..1, 1..2, 1..3).Seq    , "Triangle reduce minmax";
    is-deeply [\minmax]((1, 2, 3), (-1, -2, -3))                , (1..3, -3..3).Seq         , "Triangle reduce minmax";
    is-deeply [\minmax]((1, 2, 3), (-1, -2, -3), (1, 10, 100))  , (1..3, -3..3, -3..100).Seq, "Triangle reduce minmax";
}

# https://github.com/rakudo/rakudo/issues/3541
{
    sub infix:<eog> ( $a,  $b ) is assoc<chain> is pure {
        so $a == $b+1
    }
    ok ([eog] 5,4,3,2,1),
        'Reduce meta-operator respects chain associativity';
}

# vim: expandtab shiftwidth=4
