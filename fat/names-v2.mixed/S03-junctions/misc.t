use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 155;

=begin pod

Misc. Junction tests

=end pod

# https://github.com/Raku/old-issue-tracker/issues/834
{
    isa-ok any(6,7), Junction;
    is any(6,7).WHAT.gist, Junction.gist, 'junction.WHAT works';
}

# avoid auto-threading on ok()
#?DOES 1
sub 𝐣갨k̲(Mu $condition, $msg?) is test-assertion { ok ?($condition), $msg }

# L<S03/Junctive operators>
# L<S09/Junctions>
{

    # initialize them all to empty strings
    my $a = '';
    my $丛 = '';
    my $개 = '';

    # make sure they all match to an empty string
    𝐣갨k̲('' eq ($a & $丛 & $개), 'junction of ($a & $b & $c) matches an empty string');
    𝐣갨k̲('' eq all($a, $丛, $개), 'junction of all($a, $b, $c) matches an empty string');

    # give $a a value
    $a = 'a';

    # make sure that at least one of them matches 'a'
    𝐣갨k̲('a' eq ($丛 | $개 | $a), 'junction of ($b | $c | $a) matches at least one "a"');
    𝐣갨k̲('a' eq any($丛, $개, $a), 'junction of any($b, $c, $a) matches at least one "a"');

    𝐣갨k̲('' eq ($丛 | $개 | $a), 'junction of ($b | $c | $a) matches at least one empty string');
    𝐣갨k̲('' eq any($丛, $개, $a), 'junction of any($b, $c, $a) matches at least one empty string');

    # make sure that ~only~ one of them matches 'a'
    𝐣갨k̲('a' eq ($丛 ^ $개 ^ $a), 'junction of ($b ^ $c ^ $a) matches at ~only~ one "a"');
    𝐣갨k̲('a' eq one($丛, $개, $a), 'junction of one($b, $c, $a) matches at ~only~ one "a"');

    # give $b a value
    $丛 = 'a';

    # now this will fail
    𝐣갨k̲('a' ne ($丛 ^ $개 ^ $a), 'junction of ($b ^ $c ^ $a) matches at more than one "a"');

    # change $b and give $c a value
    $丛 = 'b';
    $개 = 'c';

    𝐣갨k̲('a' eq ($丛 ^ $개 ^ $a), 'junction of ($b ^ $c ^ $a) matches at ~only~ one "a"');
    𝐣갨k̲('b' eq ($a ^ $丛 ^ $개), 'junction of ($a ^ $b ^ $c) matches at ~only~ one "b"');
    𝐣갨k̲('c' eq ($개 ^ $a ^ $丛), 'junction of ($c ^ $a ^ $b) matches at ~only~ one "c"');

    𝐣갨k̲('a' eq ($丛 | $개 | $a), 'junction of ($b | $c | $a) matches at least one "a"');
    𝐣갨k̲('b' eq ($a | $丛 | $개), 'junction of ($a | $b | $c) matches at least one "b"');
    𝐣갨k̲('c' eq ($개 | $a | $丛), 'junction of ($c | $a | $b) matches at least one "c"');


    # test junction to junction
    𝐣갨k̲(('a' | 'b' | 'c') eq ($a & $丛 & $개), 'junction ("a" | "b" | "c") matches junction ($a & $b & $c)');
    𝐣갨k̲(('a' & 'b' & 'c') eq ($a | $丛 | $개), 'junction ("a" & "b" & "c") matches junction ($a | $b | $c)');

    # mix around variables and literals

    𝐣갨k̲(($a & 'b' & 'c') eq ('a' | $丛 | $개), 'junction ($a & "b" & "c") matches junction ("a" | $b | $c)');
    𝐣갨k̲(($a & 'b' & $개) eq ('a' | $丛 | 'c'), 'junction ($a & "b" & $c) matches junction ("a" | $b | "c")');

}

# same tests, but with junctions as variables
{
        # initialize them all to empty strings
    my $a = '';
    my $丛 = '';
    my $개 = '';

    my Mu $all_of_them = $a & $丛 & $개;
    𝐣갨k̲('' eq $all_of_them, 'junction variable of ($a & $b & $c) matches and empty string');

    $a = 'a';

    my Mu $any_of_them = $丛 | $개 | $a;
    𝐣갨k̲('a' eq $any_of_them, 'junction variable of ($b | $c | $a) matches at least one "a"');
    𝐣갨k̲('' eq $any_of_them, 'junction variable of ($b | $c | $a) matches at least one empty string');

    my Mu $one_of_them = $丛 ^ $개 ^ $a;
    𝐣갨k̲('a' eq $one_of_them, 'junction variable of ($b ^ $c ^ $a) matches at ~only~ one "a"');

    $丛 = 'a';

    {
        my Mu $one_of_them = $丛 ^ $개 ^ $a;
        𝐣갨k̲('a' ne $one_of_them, 'junction variable of ($b ^ $c ^ $a) matches at more than one "a"');
    }

    $丛 = 'b';
    $개 = 'c';

    {
        my Mu $one_of_them = $丛 ^ $개 ^ $a;
        𝐣갨k̲('a' eq $one_of_them, 'junction of ($b ^ $c ^ $a) matches at ~only~ one "a"');
        𝐣갨k̲('b' eq $one_of_them, 'junction of ($a ^ $b ^ $c) matches at ~only~ one "b"');
        𝐣갨k̲('c' eq $one_of_them, 'junction of ($c ^ $a ^ $b) matches at ~only~ one "c"');
    }

    {
        my Mu $any_of_them = $丛 | $개 | $a;
        𝐣갨k̲('a' eq $any_of_them, 'junction of ($b | $c | $a) matches at least one "a"');
        𝐣갨k̲('b' eq $any_of_them, 'junction of ($a | $b | $c) matches at least one "b"');
        𝐣갨k̲('c' eq $any_of_them, 'junction of ($c | $a | $b) matches at least one "c"');
    }

}

{
    my Mu $j = 1 | 2;
    $j = 5;
    is($j, 5, 'reassignment of junction variable');
}

{
    my Mu $j;
    my Mu $k;

    $j = 1|2;
    is(WHAT($j).gist, '(Junction)', 'basic junction type reference test');

    $k=$j;
    is(WHAT($k).gist, '(Junction)', 'assignment preserves reference');
}


=begin description

Tests junction examples from Synopsis 03

j() is used to convert a junction to canonical string form, currently
just using .raku until a better approach presents itself.

=end description

# L<S03/Junctive operators>

# Canonical stringification of a junction
sub 𝐣 (Mu $j) { return $j.raku }

{
    # L<S03/Junctive operators/They thread through operations>
    my Mu $æ갨中;
    my Mu $want;
    $æ갨中 = ((1|2|3)+4);
    $want = (5|6|7);
    is( 𝐣($æ갨中), 𝐣($want), 'thread + returning junctive result');

    $æ갨中 = ((1|2) + (3&4));
    $want = ((4|5) & (5|6));
    is( 𝐣($æ갨中), 𝐣($want), 'thread + returning junctive combination of results');

    # L<S03/Junctive operators/This opens doors for constructions like>
    # unless $roll == any(1..6) { print "Invalid roll" }
    my $с갨лл;
    my $note;
    $с갨лл = 3; $note = '';
    unless $с갨лл == any(1..6) { $note = "Invalid roll"; };
    is($note, "", 'any() junction threading ==');

    $с갨лл = 7; $note = '';
    unless $с갨лл == any(1..6) { $note = "Invalid roll"; };
    is($note, "Invalid roll", 'any() junction threading ==');

    # if $roll == 1|2|3 { print "Low roll" }
    $с갨лл = 4; $note = '';
    if $с갨лл == 1|2|3 { $note = "Low roll" }
    is($note, "", '| junction threading ==');

    $с갨лл = 2; $note = '';
    if $с갨лл == 1|2|3 { $note = "Low roll" }
    is($note, "Low roll", '| junction threading ==');
}

{
    # L<S03/Junctive operators/Junctions work through subscripting>
    my $æ갨中;
    my @е갨갨;
    $æ갨中 = ''; @е갨갨 = ();
    $æ갨中 ~= 'y' if try { @е갨갨[any(1,2,3)] };
    is($æ갨中, '', "junctions work through subscripting, 0 matches");

    $æ갨中 = ''; @е갨갨 = (0,1);
    $æ갨中 ~= 'y' if try { @е갨갨[any(1,2,3)] };
    is($æ갨中, 'y', "junctions work through subscripting, 1 match");

    $æ갨中 = ''; @е갨갨 = (1,1,1);
    $æ갨中 ~= 'y' if try { @е갨갨[any(1,2,3)] };
    is($æ갨中, 'y', "junctions work through subscripting, 3 matches");


    # L<S03/Junctive operators/Junctions are specifically unordered>
    # Compiler *can* reorder and parallelize but *may not* so don't test
    # for all(@foo) {...};

    # Not sure what is expected
    #my %got = ('1' => 1); # Hashes are unordered too
    #@foo = (2,3,4);
    #for all(@foo) { %got{$_} = 1; };
    #is( %got.keys.sort.join(','), '1,2,3,4',
    #    'for all(...) { ...} as parallelizable');
}

=begin description

These are implemented but still awaiting clarification on p6l.

 On Fri, 2005-02-11 at 10:46 +1100, Damian Conway wrote:
 > Subject: Re: Fwd: Junctive puzzles.
 >
 > Junctions have an associated boolean predicate that's preserved across
 > operations on the junction. Junctions also implicitly distribute across
 > operations, and rejunctify the results.

=end description

# L<S03/Junctive operators/They thread through operations>

{
    my @ò갮丛ò = (sub {3}, sub {2});

    my Mu $æ갨中;
    my Mu $want;

    is(𝐣(any(@ò갮丛ò)()), 𝐣(3|2), '.() on any() junction of subs');

    $want = (3&2);
    $æ갨中 = all(@ò갮丛ò)();
    is(𝐣($æ갨中), 𝐣($want), '.() on all() junction of subs');

    $want = (3^2);
    $æ갨中 = one(@ò갮丛ò)();
    is(𝐣($æ갨中), 𝐣($want), '.() on one() junction of subs');

    $want = none(3,2);
    $æ갨中 = none(@ò갮丛ò)();
    is(𝐣($æ갨中), 𝐣($want), '.() on none() junction of subs');

    $want = one( any(3,2), all(3,2) );
    $æ갨中 = one( any(@ò갮丛ò), all(@ò갮丛ò) )();
    is(𝐣($æ갨中), 𝐣($want), '.() on complex junction of subs');

    # Avoid future constant folding
    #my $rand = rand;
    #my $zero = int($rand-$rand);
    #my @subs = (sub {3+$zero}, sub {2+$zero});
}

# Check functional and operator versions produce the same structure
{
    is(𝐣((1|2)^(3&4)), 𝐣(one(any(1,2),all(3,4))),
        '((1|2)^(3&4)) equiv to one(any(1,2),all(3,4))');

    is(𝐣((1|2)&(3&4)), 𝐣(all(any(1,2),all(3,4))),
        '((1|2)&(3&4)) equiv to all(any(1,2),all(3,4))');

    is(𝐣((1|2)|(3&4)), 𝐣(any(any(1,2),all(3,4))),
        '((1|2)|(3&4)) equiv to any(any(1,2),all(3,4))');
}

# junction in boolean context
ok(?(0&0) == ?(0&&0), 'boolean context');
ok(?(0&1) == ?(0&&1), 'boolean context');
ok(?(1&1) == ?(1&&1), 'boolean context');
ok(?(1&0) == ?(1&&0), 'boolean context');
ok(!(?(0&0) != ?(0&&0)), 'boolean context');
ok(!(?(0&1) != ?(0&&1)), 'boolean context');
ok(!(?(1&1) != ?(1&&1)), 'boolean context');
ok(!(?(1&0) != ?(1&&0)), 'boolean context');


{
    my $개 = 0;
    if 1 == 1 { $개++ }
    is $개, 1;
    if 1 == 1|2 { $개++ }
    is $개, 2;
    if 1 == 1|2|3 { $개++ }
    is $개, 3;

    $개++ if 1 == 1;
    is $개, 4;
    $개++ if 1 == 1|2;
    is $개, 5, 'if modifier with junction should be called once';

    $개 = 0;
    $개++ if 1 == 1|2|3;
    is $개, 1, 'if modifier with junction should be called once';

    $개 = 0;
    $개++ if 1 == any(1, 2, 3);
    is $개, 1, 'if modifier with junction should be called once';
}

{
    my @àссàù = <1 2 3 4 5 6 7 8>;
    𝐣갨k̲( all(@àссàù) == one(@àссàù), "all(@ч) == one(@ч) tests uniqueness(+ve)" );

    push @àссàù, 6;
    𝐣갨k̲( !( all(@àссàù) == one(@àссàù) ), "all(@ч) == one(@ч) tests uniqueness(-ve)" );

}

# https://github.com/Raku/old-issue-tracker/issues/434
ok Mu & Mu ~~ Mu, 'Mu & Mu ~~ Mu works';

## See also S03-junctions/autothreading.t
{
  is substr("abcd", 1, 2), "bc", "simple substr";
  my Mu $res = substr(any("abcd", "efgh"), 1, 2);
  isa-ok $res, Junction;
  ok $res eq "bc", "substr on junctions: bc";
  ok $res eq "fg", "substr on junctions: fg";
}

{
  my Mu $res = substr("abcd", 1|2, 2);
  isa-ok $res, Junction;
  ok $res eq "bc", "substr on junctions: bc";
  ok $res eq "cd", "substr on junctions: cd";
}

{
  my Mu $res = substr("abcd", 1, 1|2);
  isa-ok $res, Junction;
  ok $res eq "bc", "substr on junctions: bc";
  ok $res eq "b", "substr on junctions: b";
}

{
  my Mu $res = index(any("abcd", "qwebdd"), "b");
  isa-ok $res, Junction;
  ok $res == 1, "index on junctions: 1";
  ok $res == 3, "index on junctions: 3";
}

{
  my Mu $res = index("qwebdd", "b"|"w");
  isa-ok $res, Junction;
  ok $res == 1, "index on junctions: 1";
  ok $res == 3, "index on junctions: 3";
}

# https://github.com/Raku/old-issue-tracker/issues/745
{
    lives-ok { try { for any(1,2) -> $x {}; } },
             'for loop over junction in try block';

    sub с中63686 {
        for any(1,2) -> $x {};    #OK not used
        return 'happiness';
    }
    is с中63686(), 'happiness', 'for loop over junction in sub';
}

# https://github.com/rakudo/rakudo/issues/3198
{
    my @òe̲e̲丧;
    @òe̲e̲丧.push(.^name) for any 1;
    is-deeply @òe̲e̲丧, ['Junction'], 'for loop over Junction gets the Junction';
}

# https://github.com/Raku/old-issue-tracker/issues/1167
# Error with stringifying .WHAT on any junctions
{
    ok((WHAT any()) ~~ Junction, "test WHAT on empty any junction");
    ok(any().WHAT ~~ Junction, "test WHAT on empty any junction");
    ok((WHAT any(1,2)) ~~ Junction, "test WHAT on any junction");
    ok(any(1,2).WHAT ~~ Junction, "test WHAT on any junction");
}

# Any list has junction methods
{
    𝐣갨k̲(5 < (6,7,8).all, '.all method builds "all" junction');
    𝐣갨k̲(!(7 < (6,7,8).all), '.all method builds "all" junction');
    𝐣갨k̲(7 == (6,7,8).one, '.one method builds "one" junction');
    𝐣갨k̲(9 == (6,7,8).none, '.none method builds "none" junction');

    my @ч = (6,7,8);
    𝐣갨k̲(5 < @ч.all, '.all method works on array objects');
}

# https://github.com/Raku/old-issue-tracker/issues/688
#?DOES 2
{
    my @a = "foo", "foot";
    ok @a[all(0,1)] ~~ /^foo/,
        'junction can be used to index Array';

    my %両 = (
        "0" => "foo",
        "1" => "foot"
    );
    ok %両{all(0,1)} ~~ /^foo/,
        'junction can be used to index Hash';
}

# https://github.com/Raku/old-issue-tracker/issues/2670
{
    is (all() ~~ /^ \d+ $/).gist,  'all()',
        'regex match in all junction is an empty all junction (1)';
    is (all() ~~ /./).gist,        'all()',
        'regex match in all junction is an empty all junction (2)';
    is (all() ~~ /all/).gist,      'all()',
        'regex match in all junction is an empty all junction (3)';
    is (all() ~~ /bll/).gist,      'all()',
        'regex match in all junction is an empty all junction (4)';
    is (any("4","5") ~~ /4/).gist, 'any(｢4｣, Nil)',
        'successful regex match in any junction';
}

# https://github.com/Raku/old-issue-tracker/issues/2533
{
    is ("foo" & "a nice old foo" ~~ /foo/).gist, 'all(｢foo｣, ｢foo｣)',
        'successful regex match in all junction';
}

# https://github.com/Raku/old-issue-tracker/issues/3313
{
    is (all("a","b") ~~ /a/).gist, 'all(｢a｣, Nil)',
        'successful regex match in all junction if one element does not match';
}

# stringy tests
{
   my class Е갨갨 {
      multi method gist(Е갨갨:D:) { "gisted"; }
      multi method raku(Е갨갨:D:) { "rakued"; }
      multi method Str(Е갨갨:D:) { "Stred"; }
   }
   is any(Е갨갨.new).raku, 'any(rakued)', 'any(Foo.new).raku';
   is any(Е갨갨.new).gist, 'any(gisted)', 'any(Foo.new).gist';
}

# https://github.com/Raku/old-issue-tracker/issues/2623
ok { a => 1} ~~ List|Hash, 'Can construct junction with List type object';

# https://github.com/Raku/old-issue-tracker/issues/2511
ok (0|1 == 0&1), 'test junction evaluation order';
ok (0&1 == 0|1), 'test junction evaluation order';

# test one-arg-flattening of listop forms

ok any((1,2,3),(4,5,6)) eqv (1,2,3), 'any is not flattening 1';
nok any((1,2,4),(4,5,6)) == 2, 'any is not flattening 2';
is (any((1,2,3),(4,5,6)) eqv (4,5,6)).gist, 'any(False, True)', 'any is not flattening 3';
ok any((1,2,4)) == 2, 'any is onearg';

ok all((4,5,6),(4,5,6)) eqv (4,5,6), 'all is not flattening 1';
ok all((1,2,3),(4,5,6)) == 3, 'all is non flattening 2';
is (all((1,2,3),(4,5,6)) eqv (4,5,6)).gist, 'all(False, True)', 'all is not flattening 3';
nok all((1,2,3)) == 3, 'all is onearg';

ok one((4,5,6),(4,5,6,7)) eqv (4,5,6,7), 'one is not flattening 1';
nok one((1,2,3),(4,5,6)) eq '3' , 'one is not flattening 2';
is (one((1,2,3),(4,5,6)) eqv (1,2,3)).gist, 'one(True, False)', 'one is not flattening 3';
ok one((1,2,3)) == 2, 'one is onearg';

ok none((4,5,6),(4,5,6)) == 4, 'none is not flattening 1';
ok none((1,2,3,4),(4,5,6,7)) eq '3' , 'none is not flattening 2';
is (none(1,2,3,(4,5,6)) == 3).gist, 'none(False, False, True, True)', 'none is not flattening 3';
nok none((1,2,3,4)) == 3 , 'none is onearg';

# test non-flattening of method forms

nok (<a b c>,(4,5,6)).any == 4, '.any is not flattening 1';
ok (<a b c>,(4,5,6)).any == 3, '.any is not flattening 2';
is ((<a b c>,(4,5,6)).any == 3).gist, 'any(True, True)', '.any is not flattening 3';

nok ((4,5,6),(4,5,6)).all > 3, '.all is not flattening 1';
ok (<a b c>,(4,5,6)).all == 3, '.all is not flattening 2';
is ((<a b c>,(4,5,6)).all == 3).gist, 'all(True, True)', '.any is not flattening 3';

nok ((4,5,6),(4,5,6,7)).one == 7, '.one is not flattening 1';
ok (<a b c>,(4,5,6)).one eq 'a b c' , '.one is not flattening 2';
is ((<a b c>,(4,5,6)).one eq 'a b c').gist, 'one(True, False)', '.one is not flattening 3';

nok ((4,5,6),(4,5,6,7)).none == 3, '.none is not flattening 1';
ok (<a b c>,(4,5,6)).none eq 'a' , '.none is not flattening 2';
is ((<a b c>,(4,5,6)).none eq 'a b c').gist, 'none(True, False)', '.none is not flattening 3';

throws-like 'multi sub foo($) { }; foo(Junction)', X::Multi::NoMatch,
    'Do not try to auto-thread Junction type object (multi case)';
throws-like 'sub foo($) { }; foo(Junction)', X::TypeCheck::Binding,
    'Do not try to auto-thread Junction type object (only case)';

# https://github.com/Raku/old-issue-tracker/issues/5691
{
    my %両;
    %両{ any ^2 }.push: 42;
    is-deeply %両, %(0 => [42], 1 => [42]), 'Junctions with autovivification';
}

subtest 'Junction.new' => { # coverage; 2016-10-11
    plan 4;

    is-deeply-junction Junction.new([^3], :type<all> ),
        ^3 .all, 'all';
    is-deeply-junction Junction.new([^3], :type<one> ),
        ^3 .one, 'one';
    is-deeply-junction Junction.new([^3], :type<any> ),
        ^3 .any, 'any';
    is-deeply-junction Junction.new([^3], :type<none>),
        ^3 .none, 'none';
}

# https://github.com/rakudo/rakudo/commit/aa3684218b1f668b6a6e41da
subtest 'Junction.new does not crash with empty, but touched array' => {
    plan 4;

    my @a; $ = +@a;
    lives-ok { Junction.new($_, @a).raku }, $_ for <all none any one>;
}

subtest 'Junction .Str, .gist, and .raku' => {
    plan 3+4*2;
    isa-ok <a b c>.any.Str.WHAT,  Junction, 'Junction.Str juncts';
    isa-ok <a b c>.any.gist.WHAT, Str,      'Junction.gist does not junct';
    isa-ok <a b c>.any.raku.WHAT, Str,      'Junction.raku does not junct';

    for <none one any all> -> $t {
        is-deeply <foo bar ber>."$t"().gist.comb(/\w+/).sort, ($t, |<foo bar ber>).sort, "Junction.gist on $t junction looks about right";
        my $j := <foo bar ber>."$t"();
        is-deeply-junction $j.raku.EVAL, $j, "Junction.raku on $t junction roundtrips";
    }
}
# GH rakudo/rakudo#1205
subtest q<meta-assignment to a scalar doesn't cause freezing> => {
    plan 3;
    my %𝐣갮丧개中갢갨丧_갨𝐩ò = :all<&>, :any<|>, :one<^>;
    for %𝐣갮丧개中갢갨丧_갨𝐩ò.pairs -> (:key($type), :value($op)) {
        #?rakudo.jvm todo 'closing parenthesis from gist pops up on stderr for "&"'
        doesn't-hang 'my $j = 1; $j ' ~ $op ~ '= 2; print $j.gist',
                     "junction '$type' doesn't freeze after assign metaop",
                     :out("{$type}(1, 2)"),
                     :err("");
    }
}

# GH #2042
{
    is-deeply-junction (all("a","b","c") ~ any("d","e")),
      all(any("ad", "ae"), any("bd", "be"), any("cd", "ce")),
      'did all() on left concate with any() on right ok';
    is-deeply-junction (any("a","b","c") ~ all("d","e")),
      all(any("ad", "ae"), any("bd", "be"), any("cd", "ce")),
      'did any() on left concate with all() on right ok';
}

# GH rakudo/rakudo#4742
# https://github.com/rakudo/rakudo/issues/4742
subtest "IO" => {
    my @с갨갮中갢丧e̲ò =
        say => %(
            out => "any(1, any(2, 3))\n",
            err => "",
        ),
        put => %(
            out => "1\n2\n3\n",
            err => "",
        ),
        note => %(
            err => "any(1, any(2, 3))\n",
            out => "",
        ),
        print => %(
            out => "123",
            err => "",
        );

    plan +@с갨갮中갢丧e̲ò * 4;

    for @с갨갮中갢丧e̲ò -> (:key($routine), :value(%expected)) {
        is_run "$routine (1|(2|3))", %expected, "$routine";
        is_run "(1|(2|3)).&$routine", %expected, "$routine sub as .\&method";
        is_run "(1|(2|3)).$routine", %expected, "$routine as method";
        is_run "$routine (1|(2|3)):", %expected, "$routine as method-prefix";
    }
}

# Junction is a value object
subtest "Value Object", {
    my $𝐣1 := any(<a b c>);
    my $𝐣2 := any(<a b c>);
    cmp-ok $𝐣1, &[!=:=], $𝐣2, "identical junctions are different object";
    cmp-ok $𝐣1.WHICH, &[===], $𝐣2.WHICH, "but they're identity";
}

# https://github.com/rakudo/rakudo/issues/2719
{
    is-deeply "foo".starts-with("f"|"b"), (True | False), 'starts-with';
    is-deeply "foo".ends-with("f"|"b"), (False | False),  'ends-with'; 
    is-deeply "foo".contains("f"|"b"), (True | False),    'contains';
    is-deeply "foo".substr-eq("f"|"b"), (True | False),   'substr-eq';
}

# vim: expandtab shiftwidth=4
