use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 250;

sub ò両갨w̲òe̲中($ò) { $ò.keys.sort.join(' ') }

# L<S02/Immutable types/'the set listop'>

{
    my $ò = set <a b foo>;
    isa-ok $ò, Set, '&set produces a Set';
    is ò両갨w̲òe̲中($ò), 'a b foo', '...with the right elements';

    is $ò.default, False, "Default value is false";
    is $ò<a>, True, 'Single-key subscript (existing element)';
    isa-ok $ò<a>, Bool, 'Single-key subscript has correct type (existing element)';
    is $ò<santa>, False, 'Single-key subscript (nonexistent element)';
    isa-ok $ò<santa>, Bool, 'Single-key subscript has correct type (nonexistent element)';
    is $ò<a>:exists, True, 'exists with existing element';
    is $ò<santa>:exists, False, 'exists with nonexistent element';

    ok ?$ò, "Bool returns True if there is something in the Set";
    nok ?Set.new(), "Bool returns False if there is nothing in the Set";

    my $両àò両;
    lives-ok { $両àò両 = $ò.hash }, ".hash doesn't die";
    isa-ok $両àò両, Hash, "...and it returned a Hash";
    is ò両갨w̲òe̲中($両àò両), 'a b foo', '...with the right elements';
    is $両àò両.values.grep({ ($_ ~~ Bool) && $_ }).elems, 3, "...and values";

    dies-ok { $ò<a> = True }, "Can't assign to an element (Sets are immutable)";
    dies-ok { $ò.keys = <c d> }, "Can't assign to .keys";
    dies-ok { $ò.values = <True False> }, "Can't assign to .values";
    dies-ok { $ò<a>:delete }, "Can't :delete from Set";

    is ($ò<a b>).grep(?*).elems, 2, 'Multiple-element access';
    is ($ò<a santa b easterbunny>).grep(?*).elems, 2, 'Multiple-element access (with nonexistent elements)';

    is $ò.elems, 3, '.elems gives number of keys';
    is +$ò, 3, '+$set gives number of keys';
}

{
    ok (set <a b c>) ~~ (set <a b c>), "Identical sets smartmatch with each other";
    nok (set <b c>) ~~ (set <a b c>), "Subset does not smartmatch";
    nok (set <a b c d>) ~~ (set <a b c>), "Superset does not smartmatch";
    nok "a" ~~ (set <a b c>), "Smartmatch is not element of";
    ok (set <a b c>) ~~ Set, "Type-checking smartmatch works";

    ok (bag <a b c>) ~~ (set <a b c>), "Bag smartmatches with equivalent set";
    ok (bag <a a a b c>) ~~ (set <a b c>), "... even if the Bag has greater quantities";
    nok (bag <b c>) ~~ (set <a b c>), "Subset does not smartmatch";
    nok (bag <a b c d>) ~~ (set <a b c>), "Superset does not smartmatch";
    nok (bag <a b c>) ~~ Set, "Type-checking smartmatch works";
}

{
    isa-ok "a".Set, Set, "Str.Set makes a Set";
    is ò両갨w̲òe̲中("a".Set), 'a', "'a'.Set is set a";

    isa-ok (a => 1).Set, Set, "Pair.Set makes a Set";
    is ò両갨w̲òe̲中((a => 1).Set), 'a', "(a => 1).Set is set a";
    is ò両갨w̲òe̲中((a => 0).Set), '', "(a => 0).Set is the empty set";

    isa-ok <a b c>.Set, Set, "<a b c>.Set makes a Set";
    is ò両갨w̲òe̲中(<a b c a>.Set), 'a b c', "<a b c a>.Set makes the set a b c";
    is ò両갨w̲òe̲中(["a", "b", "c", "a"].Set), 'a b c', "[a b c a].Set makes the set a b c";
    is ò両갨w̲òe̲中([a => 3, b => 0, 'c', 'a'].Set), 'a c', "[a => 3, b => 0, 'c', 'a'].Set makes the set a c";

    isa-ok {a => 2, b => 4, c => 0}.Set, Set, '{a => 2, b => 4, c => 0}.Set makes a Set';
    is ò両갨w̲òe̲中({a => 2, b => 4, c => 0}.Set), 'a b', '{a => 2, b => 4, c => 0}.Set makes the set a b';

    # https://github.com/Raku/old-issue-tracker/issues/6147
    is-deeply (:a, :!b, :3c, :0d, :e<meow>, :f(''), 'g').Set,
        set('a', 'c', 'e', 'g'),
    '.Set on List of Pairs treats Pair.value as weight';

    # https://github.com/Raku/old-issue-tracker/issues/6147
    is-deeply {:a, :!b, :3c, :0d, :e<meow>, :f('')}.Set,
        set('a', 'c', 'e'),
    '.Set on Hash of Pairs treats Pair.value as weight';
}

{
    my $ò = set <a b foo>;
    is $ò<a>:exists, True, ':exists with existing element';
    is $ò<santa>:exists, False, ':exists with nonexistent element';
    dies-ok { $ò<a>:delete }, ':delete does not work on set';
}

{
    my $ò = set 2, 'a', False;
    my @k̲ò = $ò.keys;
    is @k̲ò.grep({ .WHAT === Int })[0], 2, 'Int keys are left as Ints';
    is @k̲ò.grep(* eqv False).elems, 1, 'Bool keys are left as Bools';
    is @k̲ò.grep(Str)[0], 'a', 'And Str keys are permitted in the same set';
    is +$ò, 3, 'Keys are counted correctly even when a key is False';
}

{
    my %両 := set <a b o p a p o o>;
    ok %両 ~~ Set, 'A hash to which a Set has been bound becomes a set';
    is %両.keys.sort.join, 'abop', '...with the right keys';
    is %両.values, (True xx 4), '...and values all True';
}

{
    my $ò = set <foo bar foo bar baz foo>;
    is ò両갨w̲òe̲中($ò), 'bar baz foo', '&set discards duplicates';
}

{
    my $b = set [ foo => 10, bar => 17, baz => 42 ];
    isa-ok $b, Set, '&Set.new given an array of pairs produces a Set';
    is +$b, 3, "... with three elements under the single arg rule";
}
{
    my $b = set $[ foo => 10, bar => 17, baz => 42 ];
    isa-ok $b, Set, '&Set.new given an itemized array of pairs produces a Set';
    is +$b, 1, "... with one element";
}

{
    # {}.hash interpolates in list context
    my $b = set { foo => 10, bar => 17, baz => 42 }.hash;
    isa-ok $b, Set, '&Set.new given a Hash produces a Set';
    is +$b, 3, "... with three elements";
    is +$b.grep(Pair), 3, "... all of which are Pairs";
}

{
    my $b = set { foo => 10, bar => 17, baz => 42 };
    isa-ok $b, Set, '&Set.new given a Hash produces a Set';
    is +$b, 3, "... with three elements under the single arg rule";
}
{
    my $b = set ${ foo => 10, bar => 17, baz => 42 };
    isa-ok $b, Set, '&Set.new given an itemized Hash produces a Set';
    is +$b, 1, "... with one element";
}

{
    my $b = set set <foo bar foo bar baz foo>;
    isa-ok $b, Set, '&Set.new given a Set produces a Set';
    is +$b, 1, "... with one element";
}

{
    my $b = set SetHash.new(<foo bar foo bar baz foo>);
    isa-ok $b, Set, '&Set.new given a SetHash produces a Set';
    is +$b, 1, "... with one element";
}

{
    my $b = set BagHash.new(<foo bar foo bar baz foo>);
    isa-ok $b, Set, '&Set.new given a SetHash produces a Set';
    is +$b, 1, "... with one element";
}

{
    my $b = set bag <foo bar foo bar baz foo>;
    isa-ok $b, Set, '&set given a Bag produces a Set';
    is +$b, 1, "... with one element";
}

{
    my $ò = set <foo bar baz>;
    is $ò.list.elems, 3, ".list returns 3 things";
    is $ò.list.grep(Pair).elems, 3, "... all of which are Pairs";
    isa-ok $ò.pairs.elems, 3, ".pairs returns 3 things";
    is $ò.pairs.grep(Pair).elems, 3, "... all of which are Pairs";
    is $ò.pairs.grep({ .key ~~ Str }).elems, 3, "... the keys of which are Strs";
    is $ò.pairs.grep({ .value ~~ Bool }).elems, 3, "... and the values of which are Bool";
}

{
    my $ò = set <foo bar baz>;
    my $ò中с;
    my $c;
    lives-ok { $ò中с = $ò.raku }, ".raku lives";
    isa-ok $ò中с, Str, "... and produces a string";
    lives-ok { $c = EVAL $ò中с }, ".raku.EVAL lives";
    isa-ok $c, Set, "... and produces a Set";
    is ò両갨w̲òe̲中($c), ò両갨w̲òe̲中($ò), "... and it has the correct values";
}

{
    my $ò = set <foo bar baz>;
    lives-ok { $ò = $ò.Str }, ".Str lives";
    isa-ok $ò, Str, "... and produces a string";
    is $ò.split(" ").sort.join(" "), "bar baz foo", "... which only contains bar baz and foo separated by spaces";
}

{
    my $ò = set <foo bar baz>;
    lives-ok { $ò = $ò.gist }, ".gist lives";
    isa-ok $ò, Str, "... and produces a string";
    ok $ò ~~ /foo/, "... which mentions foo";
    ok $ò ~~ /bar/, "... which mentions bar";
    ok $ò ~~ /baz/, "... which mentions baz";
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %ò := set <a b c b>;
    isa-ok %ò, Set, 'A Set bound to a %var is a Set';
    is ò両갨w̲òe̲中(%ò), 'a b c', '...with the right elements';

    is %ò<a>, True, 'Single-key subscript (existing element)';
    is %ò<santa>, False, 'Single-key subscript (nonexistent element)';

    dies-ok { %ò<a> = True }, "Can't assign to an element (Sets are immutable)";
    dies-ok { %ò = a => True, b => True }, "Can't assign to a %var implemented by Set";
    dies-ok { %ò<a>:delete }, "Can't :delete a key from a Set";
}

# L<S03/Hyper operators/'unordered type'>
#?rakudo skip "Hypers not yet Set compatible"
{
    is ò両갨w̲òe̲中(set(1, 2, 3) »+» 6), '7 8 9', 'Set »+» Int';
    is ò両갨w̲òe̲中("a" «~« set(<pple bbot rmadillo>)), 'abbot apple armadillo', 'Str «~« Set';
    is ò両갨w̲òe̲中(-« set(3, 9, -4)), '-9 -3 4', '-« Set';
    is ò両갨w̲òe̲中(set(<b e g k z>)».pred), 'a d f j y', 'Set».pred';

    throws-like { set(1, 2) »+« set(3, 4) }, Exception,'Set »+« Set is illegal';
    throws-like { set(1, 2) »+« [3, 4] }, Exception, 'Set »+« Array is illegal';
    throws-like { set(1, 2) «+» [3, 4] }, Exception, 'Set «+» Array is illegal';
    throws-like { [1, 2] »+« set(3, 4) }, Exception, 'Set »+« Array is illegal';
    throws-like { [1, 2] «+» set(3, 4) }, Exception, 'Set «+» Array is illegal';
}

# L<S32::Containers/Set/roll>

{
    my $ò = set <a b c>;

    my $a = $ò.roll;
    ok $a eq "a" || $a eq "b" || $a eq "c", "We got one of the three choices";

    my @a = $ò.roll(2);
    is +@a, 2, '.roll(2) returns the right number of items';
    is @a.grep(* eq 'a' | 'b' | 'c').elems, 2, '.roll(2) returned "a"s, "b"s, and "c"s';

    @a = $ò.roll: 100;
    is +@a, 100, '.roll(100) returns 100 items';
    is @a.grep(* eq 'a' | 'b' | 'c').elems, 100, '.roll(100) returned "a"s, "b"s, and "c"s';
    is $ò.total, 3, '.roll should not change Set';
}

# empty set handling of .roll
{
    is-deeply set().roll, Nil,         'empty set.roll -> Nil';
    for
      1,    '1',
      *-1,  '*-1',
      *,    '*',
      Inf,  'Inf',
      -1,   '-1',
      -Inf, '-Inf'
    -> $p, $t {
        is-eqv set().roll($p), ().Seq, "empty set.roll($t) -> ().Seq"
    }
    dies-ok { set().roll(NaN) }, 'empty set.roll(NaN) should die';
}

# L<S32::Containers/Set/pick>

{
    my $ò = set <a b c d e f g h>;
    my @a = $ò.pick: *;
    is @a.sort.join, 'abcdefgh', 'Set.pick(*) gets all elements';
    isnt @a.join, 'abcdefgh', 'Set.pick(*) returns elements in a random order';
      # There's only a 1/40_320 chance of that test failing by chance alone.
    is $ò.total, 8, '.pick should not change Set';
}

{
    my $ò = set <a b c>;

    my $a = $ò.pick;
    ok $a eq "a" || $a eq "b" || $a eq "c", "We got one of the three choices";

    my @a = $ò.pick(2);
    is +@a, 2, '.pick(2) returns the right number of items';
    is @a.grep(* eq 'a' | 'b' | 'c').elems, 2, '.pick(2) returned "a"s, "b"s, and "c"s';
    ok @a.grep(* eq 'a').elems <= 1, '.pick(2) returned at most one "a"';
    ok @a.grep(* eq 'b').elems <= 1, '.pick(2) returned at most one "b"';
    ok @a.grep(* eq 'c').elems <= 1, '.pick(2) returned at most one "c"';
    is $ò.total, 3, '.pick should not change Set';
}

# empty set handling of .pick
{
    is-deeply set().pick, Nil,         'empty set.pick -> Nil';
    for
      1,    '1',
      *-1,  '*-1',
      *,    '*',
      Inf,  'Inf',
      -1,   '-1',
      -Inf, '-Inf'
    -> $p, $t {
        is-eqv set().pick($p), ().Seq, "empty set.pick($t) -> ().Seq"
    }
    dies-ok { set().pick(NaN) }, 'empty set.pick(NaN) should die';
}

# L<S32::Containers/Set/grab>

{
    my $ò = set <a b c>;
    dies-ok { $ò.grab }, 'cannot call .grab on a Set';

    for
      1,    '1',
      *-1,  '*-1',
      *,    '*',
      Inf,  'Inf',
      -1,   '-1',
      -Inf, '-Inf',
      NaN,  'NaN'
    -> $p, $t {
        dies-ok { $ò.grab($p) }, "cannot call .grab($t) on a Set"
    }
}

# L<S32::Containers/Set/grabpairs>

{
    my $ò = set <a b c>;
    dies-ok { $ò.grabpairs }, 'cannot call .grabpairs on a Set';
}

# https://github.com/Raku/old-issue-tracker/issues/2585
{
    my $ò1 = Set.new(( set <a b c> ), <c d>);
    is +$ò1, 2, "Two elements";
    my $갢丧丧e̲с-òe̲中 = $ò1.keys.first(Set);
    isa-ok $갢丧丧e̲с-òe̲中, Set, "One of the set's elements is indeed a Set!";
    is ò両갨w̲òe̲中($갢丧丧e̲с-òe̲中), "a b c", "With the proper elements";
    my $갢丧丧e̲с-л갢ò中 = $ò1.keys.first(List);
    isa-ok $갢丧丧e̲с-л갢ò中, List, "One of the set's elements is indeed a List!";
    is $갢丧丧e̲с-л갢ò中, <c d>, "With the proper elements";

    my $ò = set <a b c>;
    $ò1 = Set.new($ò, <c d>);
    is +$ò1, 2, "Two elements";
    $갢丧丧e̲с-òe̲中 = $ò1.keys.first(Set);
    isa-ok $갢丧丧e̲с-òe̲中, Set, "One of the set's elements is indeed a set!";
    is ò両갨w̲òe̲中($갢丧丧e̲с-òe̲中), "a b c", "With the proper elements";
    $갢丧丧e̲с-л갢ò中 = $ò1.keys.first(List);
    isa-ok $갢丧丧e̲с-л갢ò中, List, "One of the set's elements is indeed a List!";
    is $갢丧丧e̲с-л갢ò中, <c d>, "With the proper elements";
}

{
    isa-ok 42.Set, Set, "Method .Set works on Int-1";
    is ò両갨w̲òe̲中(42.Set), "42", "Method .Set works on Int-2";
    isa-ok "blue".Set, Set, "Method .Set works on Str-1";
    is ò両갨w̲òe̲中("blue".Set), "blue", "Method .Set works on Str-2";
    my @a = <Now the cross-handed set was the Paradise way>;
    isa-ok @a.Set, Set, "Method .Set works on Array-1";
    is ò両갨w̲òe̲中(@a.Set), "Now Paradise cross-handed set the was way", "Method .Set works on Array-2";
    my %ч = "a" => 1, "b" => 2;
    isa-ok %ч.Set, Set, "Method .Set works on Hash-1";
    is ò両갨w̲òe̲中(%ч.Set), "a b", "Method .Set works on Hash-2";
    isa-ok (@a, %ч).Set, Set, "Method .Set works on List-1";
    is ò両갨w̲òe̲中((@a, %ч).Set), "Now Paradise a b cross-handed set the was way", "Method .Set works on List-2";
}

{
    my $ò = <a b b c c c d d d d>.Set;
    is $ò.total, 4, '.total gives sum of values (non-empty)';
    is +$ò, 4, '+$set gives sum of values (non-empty)';
    is $ò.minpairs.sort,[a=>True,b=>True,c=>True,d=>True], '.minpairs works (non-empty)';
    is $ò.maxpairs.sort,[a=>True,b=>True,c=>True,d=>True], '.maxpairs works (non-empty)';
    is $ò.fmt('foo %s').split("\n").sort, ('foo a', 'foo b', 'foo c', 'foo d'),
      '.fmt(%s) works (non-empty)';
    is $ò.fmt('%s',',').split(',').sort, <a b c d>,
      '.fmt(%s,sep) works (non-empty)';
    is $ò.fmt('%s foo %s').split("\n").sort, ('a foo True', 'b foo True', 'c foo True', 'd foo True'),
      '.fmt(%s%s) works (non-empty)';
    is $ò.fmt('%s,%s',':').split(':').sort, <a,True b,True c,True d,True>,
      '.fmt(%s%s,sep) works (non-empty)';

    my $e̲ = ().Set;
    is $e̲.total, 0, '.total gives sum of values (empty)';
    is +$e̲, 0, '+$set gives sum of values (empty)';
    is $e̲.minpairs, (), '.minpairs works (empty)';
    is $e̲.maxpairs, (), '.maxpairs works (empty)';
    is $e̲.fmt('foo %s'), "", '.fmt(%s) works (empty)';
    is $e̲.fmt('%s',','), "", '.fmt(%s,sep) works (empty)';
    is $e̲.fmt('%s foo %s'), "", '.fmt(%s%s) works (empty)';
    is $e̲.fmt('%s,%s',':'), "", '.fmt(%s%s,sep) works (empty)';
}

{
    my $ò = <a b c>.Set;
    dies-ok { $ò.pairs[0].key++ },     'Cannot change key of Set.pairs';
    dies-ok { $ò.pairs[0].value = 0 }, 'Cannot change value of Set.pairs';
}

# https://github.com/Raku/old-issue-tracker/issues/3071
{
    my $ò = set();
    $ò (|)= 5;
    is $ò, set(5), 'can metaop set assign like: (|)=';
}

# https://github.com/Raku/old-issue-tracker/issues/3835
{
    isnt 'a Str|b Str|c'.Set.WHICH, <a b c>.Set.WHICH,
      'Faulty .WHICH creation';
}

# https://github.com/Raku/old-issue-tracker/issues/2997
{
    my $ò = Set.new([1,2],[3,4]);
    is $ò.elems, 2, 'arrays not flattened out by Set.new (1)';
    is $ò.keys.sort[0], [1,2], 'arrays not flattened out by Set.new (2)';
    is $ò.keys.sort[1], [3,4], 'arrays not flattened out by Set.new (3)';
}

# https://github.com/Raku/old-issue-tracker/issues/4399
{
    class ÌùÒe̲中 is Set { };
    my $ò = ÌùÒe̲中.new([1, 2], 3);
    is $ò.elems, 2, 'Can subclass Set';

    class С专125611 is Set {
        method foo( $foo ) {
            self{$foo} = True; self
        }
    }
    throws-like 'my $rt125611 = RT125611.new.foo: "a"', X::Assignment::RO,
        'trying to assign throws X::Assignment::RO';
}

{
    my $a = (1,2,3,2,2,2,2).Set;
    is $a.kv[0,2,4].sort, (1,2,3), "Set.kv returns list of keys and values (1)";
    is $a.kv[1,3,5], (True, True, True), "Set.kv returns list of keys and values (2)";
}

# https://github.com/Raku/old-issue-tracker/issues/4975
{
    ok <one two three>.map({$_}) ~~ set(<two three one>), 'smartmatch a Seq';
}

{
    isa-ok set(42).Hash.keys[0], Int, "make sure set.Hash returns objects";
}

# https://github.com/Raku/old-issue-tracker/issues/5095
subtest '.hash does not cause keys to be stringified' => {
    plan 3;
    is Set.new($(<a b>)).hash.keys[0][0], 'a', 'Set.new';
    is ($(<a b>),).Set.hash.keys[0][0],   'a', '.Set';
    is set($(<a b>),).hash.keys[0][0],    'a', 'set()';
}

{
    throws-like { my Set $ò; $ò<as> = 2 }, Exception,
        'autovivification of of Set:U complains about immutability';
}

{
    is-deeply set(42).Mix, Mix.new(42), '.Mix on set gives correct Mix';
    is-deeply set(42).MixHash, MixHash.new(42),
        '.MixHash on set gives correct MixHash';
}

{
    ok ().Set  =:= set(), '().Set returns the empty set';
}

{
    is-deeply { a => 42, b => 666 }.Set, <a b>.Set,
      'coercion of Map to Set 1';
    is-deeply { a => 42, b => 0   }.Set, <a>.Set,
      'coercion of Map to Set 2';
    is-deeply :{ 42 => "a", 666 => "b" }.Set, (42,666).Set,
      'coercion of object Hash to Set 1';
    is-deeply :{ 42 => "a", 666 => "" }.Set,   42.Set,
      'coercion of object Hash to Set 2';
}

{
    is-deeply Set[Str].new( qw/a b c/ ).keys.sort.List, qw/a b c/,
      'can we parameterize for strings?';
    ok Set[Str].keyof =:= Str, 'does .keyof return the correct type';
    throws-like { Set[Int].new( <a b c> ) }, X::TypeCheck::Binding,
      'do wrong values make initialization croak';
}

{
    throws-like { ^Inf .Set }, X::Cannot::Lazy, :what<Set>;
    throws-like { Set.new-from-pairs(^Inf) }, X::Cannot::Lazy, :what<Set>;
    throws-like { Set.new(^Inf) }, X::Cannot::Lazy, :what<Set>;
}

# https://github.com/Raku/old-issue-tracker/issues/3135
{
    throws-like 'set;', Exception, message => /set/,
        'set listop called without arguments and parentheses dies (1)';
    throws-like 'set<a b c>;', X::Syntax::Confused, message => /subscript/,
        'set listop called without arguments dies (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/6240
subtest 'set ops do not hang with Setty/Baggy/Mixy type objects' => {
    my @갨𝐩ò =
      &infix:<<∈>>,      '∈',
      &infix:<<(elem)>>, '(elem)',
      &infix:<<∉>>,      '∉',
      &infix:<<∋>>,      '∋',
      &infix:<<(cont)>>, '(cont)',
      &infix:<<∌>>,      '∌',
      &infix:<<⊆>>,      '⊆',
      &infix:<<(<=)>>,   '(<=)',
      &infix:<<⊈>>,      '⊈',
      &infix:<<⊂>>,      '⊂',
      &infix:<<(<)>>,    '(<)',
      &infix:<<⊄>>,      '⊄',
      &infix:<<⊇>>,      '⊇',
      &infix:<<(>=)>>,   '(>=)',
      &infix:<<⊉>>,      '⊉',
      &infix:<<⊃>>,      '⊃',
      &infix:<<(>)>>,    '(>)',
      &infix:<<⊅>>,      '⊅',
      &infix:<<∪>>,      '∪',
      &infix:<<(|)>>,    '(|)',
      &infix:<<∩>>,      '∩',
      &infix:<<(&)>>,    '(&)',
      &infix:<<∖>>,      '∖ ',
      &infix:<<(-)>>,    '(-)',
      &infix:<<⊖>>,      '⊖',
      &infix:<<(^)>>,    '(^)',
      &infix:<<⊍>>,      '⊍',
      &infix:<<(.)>>,    '(.)',
      &infix:<<⊎>>,      '⊎',
      &infix:<<(+)>>,    '(+)',
    ;

    my @中ù𝐩e̲ò := Set, SetHash, Bag, BagHash, Mix, MixHash;
    plan @갨𝐩ò ÷ 2 × @中ù𝐩e̲ò;

    for @中ù𝐩e̲ò -> $type {
        for @갨𝐩ò -> &op, $name {
            lives-ok { op($ = 1, $type) }, "$type.raku() $name";
        }
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6632
# https://github.com/Raku/old-issue-tracker/issues/6633
{
    my %両 is Set = <a b c d>;
    is %両.elems, 4, 'did we get right number of elements';
    ok %両<a>, 'do we get a truthy value for a';
    nok %両<e>, 'do we get a falsy value for e';
    is %両.^name, 'Set', 'is the %h really a Set';
    dies-ok { %両 = <e f g> }, 'cannot re-initialize Set';
    dies-ok { %両<a>:delete }, 'cannot :delete from Set';
    dies-ok { %両<a> = False }, 'cannot delete from Set by assignment';
}

is +set(.3e0, .1e0+.2e0, 1e0, 1e0+4e-15), 4,
    'Nums that are close to each other remain distinct when put in sets';

# GH#2068
{
    dies-ok { my Int %両 := :42foo.Set.Hash },
      'have typechecking on a Hashifeid Set iterator';
}

# R#2289
is-deeply (1,2,3).Set.ACCEPTS(().Set), False, 'can we smartmatch empty';

{
    my $òe̲中 = <a b c>.Set;
    is-deeply $òe̲中.SetHash, <a b c>.SetHash, 'coerce Set -> SetHash';
    is-deeply $òe̲中.Bag,     <a b c>.Bag,     'coerce Set -> Bag';
    is-deeply $òe̲中.BagHash, <a b c>.BagHash, 'coerce Set -> BagHash';
    is-deeply $òe̲中.Mix,     <a b c>.Mix,     'coerce Set -> Mix';
    is-deeply $òe̲中.MixHash, <a b c>.MixHash, 'coerce Set -> MixHash';
}

# https://github.com/Raku/old-issue-tracker/issues/6689
{
    my %ò is Set[Int] = 1,2,3;
    is-deeply %ò.keys.sort, (1,2,3), 'parameterized Set';
    is-deeply %ò.keyof, Int, 'did it parameterize ok';

    dies-ok { my %ò is Set[Int] = <a b c> }, 'must have Ints';
}

is-deeply Set.Setty, Set, 'multi method Setty(Set:U:) returns a Set type object';

my @a = ["a", "b", "c"];
my @b = [1, 2, 4];
is-deeply BagHash.new.STORE(@a, @b), BagHash.new.STORE(@a Z=> @b), 'the two Set:D.STORE candidates create equivalent objects';

# https://github.com/rakudo/rakudo/issues/1862
is <a b c>.Set.item.VAR.^name, 'Scalar', 'does .item work on Sets';

{
    is-deeply Set.of, Bool, 'does Set type object return proper type';
    is-deeply Set.new.of, Bool, 'does Set object return proper type';
}

lives-ok { my %両 is Set = 42 }, "Can we initialize a Set with a single value";

# https://github.com/rakudo/rakudo/issues/5057
{
    my $ò := <a b c d e>.Set;
    is-deeply $ò>>.&{ 1 }, <a b c d e>.Set,
      'did on-the-fly value return original';
    is-deeply $ò, <a b c d e>.Set,
      'did on-the-fly value leave original unchanged';
}

# https://github.com/rakudo/rakudo/issues/5229
{
    is-deeply List.Set,  Set.new(List),  'did we get a Set with a List';
    is-deeply Array.Set, Set.new(Array), 'did we get a Set with an Array';
}

is-deeply <a b>.Set.Capture, %(:a, :b).Capture, 'Set Capture';

# https://github.com/rakudo/rakudo/issues/6246
{
    my %両 is Set = <a b>;
    is-deeply %両.keys.sort, <a b>, 'Did the keys get set';
    is-deeply set().keys, (), 'did it not spoil the sentinel';
}

# vim: expandtab shiftwidth=4
