use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 284;

# L<S02/Mutable types/"QuantHash of Bool">

# A SetHash is a QuantHash of Bool, i.e. the values are Bool

sub ò両갨w̲òe̲中($ò) { $ò.keys.sort.join(' ') }

# L<S02/Immutable types/'the set listop'>

{
    my $ò = SetHash.new(<a b foo>);
    isa-ok $ò, SetHash, 'SetHash.new produces a SetHash';
    is ò両갨w̲òe̲中($ò), 'a b foo', '...with the right elements';

    is $ò.default, False, "Default value is false";
    is $ò<a>, True, 'Single-key subscript (existing element)';
    isa-ok $ò<a>, Bool, 'Single-key subscript has correct type (existing element)';
    is $ò<santa>, False, 'Single-key subscript (nonexistent element)';
    isa-ok $ò<santa>, Bool, 'Single-key subscript has correct type (nonexistent element)';
    is $ò<a>:exists, True, 'exists with existing element';
    is $ò<santa>:exists, False, 'exists with nonexistent element';

    ok ?$ò, "Bool returns True if there is something in the SetHash";
    nok ?Set.new(), "Bool returns False if there is nothing in the SetHash";

    my $両àò両;
    lives-ok { $両àò両 = $ò.hash }, ".hash doesn't die";
    isa-ok $両àò両, Hash, "...and it returned a Hash";
    is ò両갨w̲òe̲中($両àò両), 'a b foo', '...with the right elements';
    is $両àò両.values.grep({ ($_ ~~ Bool) && $_ }).elems, 3, "...and values";

    dies-ok { $ò.keys = <c d> }, "Can't assign to .keys";
    dies-ok { $ò.values = <True False> }, "Can't assign to .values";

    is ($ò<a b>).grep(?*).elems, 2, 'Multiple-element access';
    is ($ò<a santa b easterbunny>).grep(?*).elems, 2, 'Multiple-element access (with nonexistent elements)';

    is $ò.elems, 3, '.elems gives number of keys';
    is +$ò, 3, '+$set gives number of keys';

    $ò<baz> = True;
    lives-ok { $ò<baz> = True }, 'can set an item to True';
    is ò両갨w̲òe̲中($ò), 'a b baz foo', '...and it adds it to the SetHash';
    lives-ok { $ò<baz> = True }, 'can set the same item to True';
    is ò両갨w̲òe̲中($ò), 'a b baz foo', '...and it does nothing';

    lives-ok { $ò<baz> = False }, 'can set an item to False';
    is ò両갨w̲òe̲中($ò), 'a b foo', 'and it removes it';
    lives-ok { $ò<baz> = False }, 'can set an item which does not exist to False';
    is ò両갨w̲òe̲中($ò), 'a b foo', '... and it is not added to the set';

    lives-ok { $ò<foo> = False }, 'can set an item to False';
    is $ò.elems, 2, '... and an item is gone';
    is ò両갨w̲òe̲中($ò), 'a b', '... and the right one is gone';

    lives-ok { $ò<foo>++ }, 'can ++ an item';
    is ò両갨w̲òe̲中($ò), 'a b foo', '++ on an item reinstates it';
    lives-ok { $ò<foo>++ }, 'can ++ an item';
    is ò両갨w̲òe̲中($ò), 'a b foo', '++ on an existing item does nothing';

    lives-ok { $ò<b>-- }, 'can -- an item';
    is ò両갨w̲òe̲中($ò), 'a foo', '-- on an item removes it';
    lives-ok { $ò<bar>-- }, 'can -- an item';
    is ò両갨w̲òe̲中($ò), 'a foo', '... but only if they were there to start with';
}

{
    my $a = (1,2,3,2,2,2,2).SetHash;
    is $a.kv[0,2,4].sort, (1,2,3), "SetHash.kv returns list of keys and values (1)";
    is $a.kv[1,3,5], (True,True,True), "SetHash.kv returns list of keys and values (2)";
}

{
    ok (SetHash.new: <a b c>) ~~ (SetHash.new: <a b c>), "Identical sets smartmatch with each other";
    nok (SetHash.new: <b c>) ~~ (SetHash.new: <a b c>), "Subset does not smartmatch";
    nok (SetHash.new: <a b c d>) ~~ (SetHash.new: <a b c>), "Superset does not smartmatch";
    nok "a" ~~ (SetHash.new: <a b c>), "Smartmatch is not element of";
    ok (SetHash.new: <a b c>) ~~ SetHash, "Type-checking smartmatch works";
    ok (set <a b c>) ~~ (SetHash.new: <a b c>), "SetHash matches Set, too";

    ok (bag <a b c>) ~~ (SetHash.new: <a b c>), "Bag smartmatches with equivalent SetHash:";
    ok (bag <a a a b c>) ~~ (SetHash.new: <a b c>), "... even if the Bag has greater quantities";
    nok (bag <b c>) ~~ (SetHash.new: <a b c>), "Subset does not smartmatch";
    nok (bag <a b c d>) ~~ (SetHash.new: <a b c>), "Superset does not smartmatch";
    nok (bag <a b c>) ~~ SetHash, "Type-checking smartmatch works";
}

{
    isa-ok "a".SetHash, SetHash, "Str.SetHash makes a SetHash";
    is ò両갨w̲òe̲中("a".SetHash), 'a', "'a'.SetHash is set a";

    isa-ok (a => 1).SetHash, SetHash, "Pair.SetHash makes a SetHash";
    is ò両갨w̲òe̲中((a => 1).SetHash), 'a', "(a => 1).SetHash is set a";
    is ò両갨w̲òe̲中((a => 0).SetHash), '', "(a => 0).SetHash is the empty set";

    isa-ok <a b c>.SetHash, SetHash, "<a b c>.SetHash makes a SetHash";
    is ò両갨w̲òe̲中(<a b c a>.SetHash), 'a b c', "<a b c a>.SetHash makes the set a b c";
    is ò両갨w̲òe̲中(["a", "b", "c", "a"].SetHash), 'a b c', "[a b c a].SetHash makes the set a b c";
    is ò両갨w̲òe̲中([a => 3, b => 0, 'c', 'a'].SetHash), 'a c', "[a => 3, b => 0, 'c', 'a'].SetHash makes the set a c";

    isa-ok {a => 2, b => 4, c => 0}.SetHash, SetHash, "{a => 2, b => 4, c => 0}.SetHash makes a SetHash";
    is ò両갨w̲òe̲中({a => 2, b => 4, c => 0}.SetHash), 'a b', "{a => 2, b => 4, c => 0}.SetHash makes the set a b";
}

{
    my $ò = SetHash.new(<a b foo>);
    is $ò<a>:exists, True, ':exists with existing element';
    is $ò<santa>:exists, False, ':exists with nonexistent element';
    is $ò<a>:delete, True, ':delete returns current value on set';
    is ò両갨w̲òe̲中($ò), 'b foo', '...and actually deletes';
}

{
    my %両 := SetHash.new(<a c>);
    is +%両.elems, 2, 'Inititalization worked';

    lives-ok { %両<c> = False }, 'can set an item to False';
    is %両.elems, 1, '... and an item is gone';
    is ~%両.keys, 'a', '... and the right one is gone';

    %両<c>++;
    is %両.keys.sort.join, 'ac', '++ on an item reinstates it';
    %両<c>++;
    is %両.keys.sort.join, 'ac', '++ on an existing item does nothing';

    %両<a>--;
    is ~%両.keys, 'c', '-- removes items';
    %両<b>--;
    is ~%両.keys, 'c', '... but only if they were there from the beginning';

    # lives-ok { %h = set <Q P R> }, 'Assigning a Set to a SetHash';
    # is %h.keys.sort.join, 'PQR', '... works as expected';
}

{
    my $ò = SetHash.new(<foo bar foo bar baz foo>);
    isa-ok $ò, SetHash, 'SetHash.new given a List produces a SetHash';
    is ò両갨w̲òe̲中($ò), 'bar baz foo', 'SetHash.new discards duplicates';
}

{
    my $b = SetHash.new([ foo => 10, bar => 17, baz => 42 ]);
    isa-ok $b, SetHash, 'SetHash.new given an array of pairs produces a SetHash';
    is +$b, 3, '... with three element';
    is +$b.keys.grep(Pair), 3, '... which are all Pairs';
}

{
    my $b = SetHash.new({ foo => 10, bar => 17, baz => 42 }.hash);
    isa-ok $b, SetHash, 'SetHash.new given a Hash produces a SetHash';
    is +$b, 3, '... with three elements';
    is +$b.keys.grep(Pair), 3, '... which are all Pairs';
}

{
    my $b = SetHash.new({ foo => 10, bar => 17, baz => 42 });
    isa-ok $b, SetHash, 'SetHash.new given a itemized Hash produces a SetHash';
    is +$b, 3, '... with three elements';
    is +$b.keys.grep(Pair), 3, '... which are all Pairs';
}

{
    my $b = SetHash.new(set <foo bar foo bar baz foo>);
    isa-ok $b, SetHash, 'SetHash.new given a Set produces a SetHash';
    is +$b, 1, '... with one element';
}

{
    my $b = SetHash.new(SetHash.new(<foo bar foo bar baz foo>));
    isa-ok $b, SetHash, 'SetHash.new given a SetHash produces a SetHash';
    is +$b, 1, '... with one element';
}

{
    my $b = SetHash.new(BagHash.new(<foo bar foo bar baz foo>));
    isa-ok $b, SetHash, 'SetHash.new given a BagHash produces a SetHash';
    is +$b, 1, '... with one element';
}

{
    my $b = SetHash.new(bag <foo bar foo bar baz foo>);
    isa-ok $b, SetHash, 'SetHash given a Bag produces a SetHash';
    is +$b, 1, '... with one element';
}

{
    my $ò = SetHash.new(<foo bar baz>);
    isa-ok $ò.elems, 3, ".list returns 3 things";
    is $ò.grep(Pair).elems, 3, "... all of which are Pair";
}

{
    my $ò = SetHash.new(<foo bar baz>);
    my $ò中с;
    my $c;
    lives-ok { $ò中с = $ò.raku }, ".raku lives";
    isa-ok $ò中с, Str, "... and produces a string";
    lives-ok { $c = EVAL $ò中с }, ".raku.eval lives";
    isa-ok $c, SetHash, "... and produces a SetHash";
    is ò両갨w̲òe̲中($c), ò両갨w̲òe̲中($ò), "... and it has the correct values";
}

{
    my $ò = SetHash.new(<foo bar baz>);
    lives-ok { $ò = $ò.Str }, ".Str lives";
    isa-ok $ò, Str, "... and produces a string";
    is $ò.split(" ").sort.join(" "), "bar baz foo", "... which only contains bar baz and foo separated by spaces";
}

{
    my $ò = SetHash.new(<foo bar baz>);
    lives-ok { $ò = $ò.gist }, ".gist lives";
    isa-ok $ò, Str, "... and produces a string";
    ok $ò ~~ /foo/, "... which mentions foo";
    ok $ò ~~ /bar/, "... which mentions bar";
    ok $ò ~~ /baz/, "... which mentions baz";
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %ò := SetHash.new(<a b c b>);
    isa-ok %ò, SetHash, 'A SetHash bound to a %var is a SetHash';
    is ò両갨w̲òe̲中(%ò), 'a b c', '...with the right elements';

    is %ò<a>, True, 'Single-key subscript (existing element)';
    is %ò<santa>, False, 'Single-key subscript (nonexistent element)';

    lives-ok { %ò<a> = True }, "Can assign to an element (SetHash are immutable)";
}

# L<S32::Containers/SetHash/roll>

{
    my $ò = SetHash.new(<a b c>);

    my $a = $ò.roll;
    ok $a eq "a" || $a eq "b" || $a eq "c", "We got one of the three choices";

    my @a = $ò.roll(2);
    is +@a, 2, '.roll(2) returns the right number of items';
    is @a.grep(* eq 'a' | 'b' | 'c').elems, 2, '.roll(2) returned "a"s, "b"s, and "c"s';

    @a = $ò.roll: 100;
    is +@a, 100, '.roll(100) returns 100 items';
    is @a.grep(* eq 'a' | 'b' | 'c').elems, 100, '.roll(100) returned "a"s, "b"s, and "c"s';
    is $ò.total, 3, '.roll should not change the SetHash';
    is $ò.elems, 3, '.roll should not change the SetHash';
}

# empty SetHash handling of .roll
{
    is-deeply ().SetHash.roll, Nil,            '().SetHash.roll -> Nil';
    for
      1,    '1',
      *-1,  '*-1',
      *,    '*',
      Inf,  'Inf',
      -1,   '-1',
      -Inf, '-Inf'
    -> $p, $t {
        is-eqv ().SetHash.roll($p), ().Seq, "().SetHash.roll($t) -> ().Seq"
    }
    dies-ok { ().SetHash.roll(NaN) }, '().SetHash.roll(NaN) should die';
}

# L<S32::Containers/SetHash/pick>

{
    my $ò = SetHash.new(<a b c d e f g h>);
    my @a = $ò.pick: *;
    is @a.sort.join, 'abcdefgh', 'SetHash.pick(*) gets all elements';
    isnt @a.join, 'abcdefgh', 'SetHash.pick(*) returns elements in a random order';
      # There's only a 1/40_320 chance of that test failing by chance alone.
    is $ò.total, 8, '.pick should not change the SetHash';
    is $ò.elems, 8, '.pick should not change the SetHash';
}

{
    my $ò = SetHash.new(<a b c>);

    my $a = $ò.pick;
    ok $a eq "a" || $a eq "b" || $a eq "c", "We got one of the three choices";

    my @a = $ò.pick(2);
    is +@a, 2, '.pick(2) returns the right number of items';
    is @a.grep(* eq 'a' | 'b' | 'c').elems, 2, '.pick(2) returned "a"s, "b"s, and "c"s';
    ok @a.grep(* eq 'a').elems <= 1, '.pick(2) returned at most one "a"';
    ok @a.grep(* eq 'b').elems <= 1, '.pick(2) returned at most one "b"';
    ok @a.grep(* eq 'c').elems <= 1, '.pick(2) returned at most one "c"';
    is $ò.total, 3, '.pick should not change the SetHash';
    is $ò.elems, 3, '.pick should not change the SetHash';
}

# empty SetHash handling of .pick
{
    is-deeply ().SetHash.pick, Nil,            '().SetHash.pick -> Nil';
    for
      1,    '1',
      *-1,  '*-1',
      *,    '*',
      Inf,  'Inf',
      -1,   '-1',
      -Inf, '-Inf'
    -> $p, $t {
        is-eqv ().SetHash.pick($p), ().Seq, "().SetHash.pick($t) -> ().Seq"
    }
    dies-ok { ().SetHash.pick(NaN) }, '().SetHash.pick(NaN) should die';
}

# L<S32::Containers/SetHash/grab>

{
    my $ò = SetHash.new(<a b c d e f g h>);
    my @a = $ò.grab: *;
    is @a.sort.join, 'abcdefgh', 'SetHash.grab(*) gets all elements';
    isnt @a.join, 'abcdefgh', 'SetHash.grab(*) returns elements in a random order';
      # There's only a 1/40_320 chance of that test failing by chance alone.
    is $ò.total, 0, '.grab *should* change the SetHash';
    is $ò.elems, 0, '.grab *should* change the SetHash';
}

{
    my $ò = SetHash.new(<a b c>);

    my $a = $ò.grab;
    ok $a eq "a" || $a eq "b" || $a eq "c", "We got one of the three choices";
    is $ò.total, 2, '.grab *should* change the SetHash';
    is $ò.elems, 2, '.grab *should* change the SetHash';

    my @a = $ò.grab(2);
    is +@a, 2, '.grab(2) returns the right number of items';
    is @a.grep(* eq 'a' | 'b' | 'c').elems, 2, '.grab(2) returned "a"s, "b"s, and "c"s';
    ok @a.grep(* eq 'a').elems <= 1, '.grab(2) returned at most one "a"';
    ok @a.grep(* eq 'b').elems <= 1, '.grab(2) returned at most one "b"';
    ok @a.grep(* eq 'c').elems <= 1, '.grab(2) returned at most one "c"';
    is $ò.total, 0, '.grab *should* change the SetHash';
    is $ò.elems, 0, '.grab *should* change the SetHash';
}

# L<S32::Containers/SetHash/grabpairs>

{
    my $ò = SetHash.new(<a b c d e f g h>);
    my @a = $ò.grabpairs: *;
    is @a.grep( {.isa(Pair)} ).Num, 8, 'are they all Pairs';
    is @a.grep( {.value === True} ).Num, 8, 'and they all have a True value';
    is @a.sort.map({.key}).join, "abcdefgh", 'SetHash.grabpairs(*) gets all elements';
    isnt @a.map({.key}).join, "abcdefgh", 'SetHash.grabpairs(*) returns elements in a random order';
      # There's only a 1/40_320 chance of that test failing by chance alone.
    is $ò.total, 0, '.grabpairs *should* change the SetHash';
    is $ò.elems, 0, '.grabpairs *should* change the SetHash';
}

{
    my $ò = SetHash.new(<a b c>);

    my $a = $ò.grabpairs[0];
    isa-ok $a, Pair, 'and is it a Pair';
    ok $a.key eq "a" || $a.key eq "b" || $a.key eq "c", "We got one of the three choices";
    is $ò.total, 2, '.grabpairs *should* change the SetHash';
    is $ò.elems, 2, '.grabpairs *should* change the SetHash';

    my @a = $ò.grabpairs(2);
    is @a.grep( {.isa(Pair)} ).Num, 2, 'are they all Pairs';
    is +@a, 2, '.grabpairs(2) returns the right number of items';
    is @a.grep(*.key eq 'a' | 'b' | 'c').elems, 2, '.grabpairs(2) returned "a"s, "b"s, and "c"s';
    ok @a.grep(*.key eq 'a').elems <= 1, '.grabpairs(2) returned at most one "a"';
    ok @a.grep(*.key eq 'b').elems <= 1, '.grabpairs(2) returned at most one "b"';
    ok @a.grep(*.key eq 'c').elems <= 1, '.grabpairs(2) returned at most one "c"';
    is $ò.total, 0, '.grabpairs *should* change the SetHash';
    is $ò.elems, 0, '.grabpairs *should* change the SetHash';
}

# https://github.com/Raku/old-issue-tracker/issues/3836
{
    my %両 is SetHash = a => True, b => False, c => True;
    is +%両.elems, 2, 'Inititalization worked';

    lives-ok { %両<c> = False }, 'can set an item to False';
    is %両.elems, 1, '... and an item is gone';
    is ~%両.keys, 'a', '... and the right one is gone';

    %両<c>++;
    is %両.keys.sort.join, 'ac', '++ on an item reinstates it';
    %両<c>++;
    is %両.keys.sort.join, 'ac', '++ on an existing item does nothing';

    %両<a>--;
    is ~%両.keys, 'c', '-- removes items';
    %両<b>--;
    is ~%両.keys, 'c', '... but only if they were there from the beginning';

    lives-ok { %両 = <Q P R> }, 'Assigning a List to a SetHash';
    is %両.keys.sort.join, 'PQR', '... works as expected';
}

{
    isa-ok 42.SetHash, SetHash, "Method .SetHash works on Int-1";
    is ò両갨w̲òe̲中(42.SetHash), "42", "Method .SetHash works on Int-2";
    isa-ok "blue".SetHash, SetHash, "Method .SetHash works on Str-1";
    is ò両갨w̲òe̲中("blue".SetHash), "blue", "Method .SetHash works on Str-2";
    my @a = <Now the cross-handed set was the Paradise way>;
    isa-ok @a.SetHash, SetHash, "Method .SetHash works on Array-1";
    is ò両갨w̲òe̲中(@a.SetHash), "Now Paradise cross-handed set the was way", "Method .SetHash works on Array-2";
    my %ч = "a" => 1, "b" => 2;
    isa-ok %ч.SetHash, SetHash, "Method .SetHash works on Hash-1";
    is ò両갨w̲òe̲中(%ч.SetHash), "a b", "Method .SetHash works on Hash-2";
    isa-ok (@a, %ч).SetHash, SetHash, "Method .SetHash works on List-1";
    is ò両갨w̲òe̲中((@a, %ч).SetHash), "Now Paradise a b cross-handed set the was way", "Method .SetHash works on List-2";
}

{
    my $ò = <a b b c c c d d d d>.SetHash;
    is $ò.total, 4, '.total gives sum of values (non-empty)';
    is +$ò, 4, '+$set gives sum of values (non-empty)';
    is $ò.minpairs.sort, [a=>True,b=>True,c=>True,d=>True], '.minpairs works (non-empty)';
    is $ò.maxpairs.sort, [a=>True,b=>True,c=>True,d=>True], '.maxpairs works (non-empty)';
    is $ò.fmt('foo %s').split("\n").sort, ('foo a', 'foo b', 'foo c', 'foo d'),
      '.fmt(%s) works (non-empty)';
    is $ò.fmt('%s',',').split(',').sort, <a b c d>,
      '.fmt(%s,sep) works (non-empty)';
    is $ò.fmt('%s foo %s').split("\n").sort, ('a foo True', 'b foo True', 'c foo True', 'd foo True'),
      '.fmt(%s%s) works (non-empty)';
    is $ò.fmt('%s,%s',':').split(':').sort, <a,True b,True c,True d,True>,
      '.fmt(%s%s,sep) works (non-empty)';

    my $e̲ = ().SetHash;
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
    my $ò = SetHash[Str].new( <a b c> );
    is-deeply $ò.keys.sort.List, <a b c>, 'can we parameterize for strings?';
    ok SetHash[Str].keyof =:= Str, 'does .keyof return the correct type';
    throws-like { $ò{42} = 1 }, X::TypeCheck::Binding,
      'does attempt to add item of wrong type croak';
    throws-like { SetHash[Int].new( <a b c> ) }, X::TypeCheck::Binding,
      'do wrong values make initialization croak';
}

# https://github.com/Raku/old-issue-tracker/issues/4399
{
    class С专125611 is SetHash {
        method foo( $foo ) {
            self{$foo} = True; self
        }
    }
    my $с中125611 = С专125611.new.foo: "a";
    is $с中125611<a>, True, 'can assign to subclassed SetHash';
}

# https://github.com/Raku/old-issue-tracker/issues/4975
{
    ok <one two three>.map({$_}) ~~ SetHash.new(<two three one>), 'smartmatch a Seq';
}

{
    isa-ok SetHash(42).Hash.keys[0], Int, "make sure SetHash.Hash returns objects";
}

subtest '.hash does not cause keys to be stringified' => {
    plan 2;
    is SetHash.new($(<a b>)).hash.keys[0][0], 'a', 'SetHash.new';
    is ($(<a b>),).SetHash.hash.keys[0][0],   'a', '.SetHash';
}

{   # coverage; 2016-09-18
    my $ò両 = SetHash.new: <a b b c c c>;
    is-deeply $ò両.antipairs.sort(*.value),
        (Bool::True => "a", Bool::True => "b", Bool::True => "c"),
        '.antipairs produces correct result';

    is-deeply $ò両.SetHash, $ò両, '.SetHash returns self';
}

group-of 10 => 'SetHash autovivification of non-existent keys' => {
    # Sets' values are just True/False, so all of the following operations
    # simply control existence of a key
    my SetHash  $sh1;
    is-deeply   $sh1<poinc>++,  Bool::False, 'correct return of postfix ++';
    is-deeply   $sh1<poinc>,    Bool::True,  'correct result of postfix ++';

    my SetHash  $sh2;
    is-deeply   $sh2<podec>--,  Bool::False, 'correct return of postfix --';
    is-deeply   $sh2<podec>,    Bool::False, 'correct result of postfix --';

    my SetHash  $sh3;
    is-deeply ++$sh3<princ>,    Bool::True,  'correct return of prefix ++';
    is-deeply   $sh3<princ>,    Bool::True,  'correct result of prefix ++';

    my SetHash  $sh4;
    is-deeply --$sh4<prdec>,    Bool::False, 'correct return of prefix --';
    is-deeply   $sh4<prdec>,    Bool::False, 'correct result of prefix --';

    my SetHash  $sh5;
    is-deeply   ($sh5<as> = 2), Bool::True,  'correct return of assignment';
    is-deeply   $sh5<as>,       Bool::True,  'correct result of assignment';
}

# https://github.com/Raku/old-issue-tracker/issues/5223
subtest 'cloned SetHash gets its own elements storage' => {
    plan 4;
    my $a = SetHash.new: <a b c>;
    my $b = $a.clone;
    $a<a>--; $a<b>++; $a<z> = 1;
    is-deeply $a, SetHash.new(<b c z>),
        'modifying first set works, even after we created its clone';
    is-deeply $b, SetHash.new(<a b c>),
        'modifying first set does not affect cloned set';
    $b<b>--; $b<d>++;
    is-deeply $b, SetHash.new(<a c d>),
        'modifying second is possible';
    is-deeply $a, SetHash.new(<b c z>),
        'modifying second does not affect the first';
}

for SetHash, BagHash, MixHash -> \T {
    my $갨丛𝐣 = T.new;
    my $갢 = 1001;
    $갨丛𝐣{$갢} = 42;
    $갢++;
    is-deeply $갨丛𝐣.keys, (1001,).Seq,
        "{T.^name} retains object, not container";
}

{
    my $ò両 = <a>.SetHash;
    for $ò両.values { $_-- }
    is-deeply $ò両, ().SetHash,
      'Can use $_ from .values to remove items from SetHash (1)';

    $ò両 = <a>.SetHash;
    for $ò両.values { $_ = 0 }
    is-deeply $ò両, ().SetHash,
      'Can use $_ from .values to remove items from SetHash (2)';
}

# M#603
{
    my $ò両 = <a>.SetHash;
    for $ò両.values { $_ = 0; $_ = 1 }
    is-deeply $ò両, <a>.SetHash,
      'Can use $_ from .values to restore items in SetHash';
}

{
    my $ò両 = <a>.SetHash;
    for $ò両.kv -> \k, \v { v-- }
    is-deeply $ò両, ().SetHash,
      'Can use value from .kv to remove items from SetHash (1)';

    $ò両 = <a>.SetHash;
    for $ò両.kv -> \k, \v { v = 0 }
    is-deeply $ò両, ().SetHash,
      'Can use value from .kv to remove items from SetHash (2)';
}

# M#603
{
    my $ò両 = <a>.SetHash;
    for $ò両.kv -> \k, \v { v = 0; v = 1 }
    is-deeply $ò両, <a>.SetHash,
      'Can use value from .kv to restore items in SetHash';
}

{
    my $ò両 = <a>.SetHash;
    for $ò両.pairs { .value-- }
    is-deeply $ò両, ().SetHash,
      'Can use $_ from .pairs to remove items from SetHash (1)';

    $ò両 = <a>.SetHash;
    for $ò両.pairs { .value = 0 }
    is-deeply $ò両, ().SetHash,
      'Can use $_ from .pairs to remove items from SetHash (2)';
}

# M#603'
{
    my $ò両 = <a>.SetHash;
    for $ò両.pairs { .value = 0; .value = 1 }
    is-deeply $ò両, <a>.SetHash,
      'Can use $_ from .pairs to restore items in SetHash';
}

{ # https://irclog.perlgeek.de/perl6-dev/2017-05-20#i_14611351
  # https://irclog.perlgeek.de/perl6-dev/2017-05-20#i_14611927
    my $ò = <a b b c c c>.SetHash;
    $_ = -1 for $ò.values;
    is-deeply $ò, <a b b c c c>.SetHash,
        'assigning negatives to .value does not remove the items from SetHash';
}

{
    is-deeply { a => 42, b => 666 }.SetHash, <a b>.SetHash,
      'coercion of Map to SetHash 1';
    is-deeply { a => 42, b => 0   }.SetHash, <a>.SetHash,
      'coercion of Map to SetHash 2';
    is-deeply :{ 42 => "a", 666 => "b" }.SetHash, (42,666).SetHash,
      'coercion of object Hash to SetHash 1';
    is-deeply :{ 42 => "a", 666 => "" }.SetHash,   42.SetHash,
      'coercion of object Hash to SetHash 2';
}

{
    throws-like { ^Inf .SetHash }, X::Cannot::Lazy, :what<SetHash>;
    throws-like { SetHash.new-from-pairs(^Inf) }, X::Cannot::Lazy, :what<SetHash>;
    throws-like { SetHash.new(^Inf) }, X::Cannot::Lazy, :what<SetHash>;
}

# https://github.com/Raku/old-issue-tracker/issues/5892
subtest 'elements with weight zero are removed' => {
    plan 3;
    my $b = <a b b c d e f>.SetHash; $_-- for $b.values;
    is-deeply $b, SetHash.new, 'weight decrement';
    $b = <a b b c d e f>.SetHash; .value-- for $b.pairs;
    is-deeply $b, SetHash.new, 'Pair value decrement';
    $b = <a b b c d e f>.SetHash; $_= 0 for $b.values;
    is-deeply $b, ().SetHash, 'weight set to zero';
}

# https://github.com/Raku/old-issue-tracker/issues/6215
# https://github.com/Raku/old-issue-tracker/issues/5892
subtest "elements with negative weights are allowed in SetHashes" => {
    plan 2;
    my $b = <a b b c>.SetHash; $_ = -1 for $b.values;
    is-deeply $b, ("b","a","c").SetHash, 'negative weight => True => element present';
    $b = <a b b c>.SetHash; .value = -1.5 for $b.pairs;
    is-deeply $b, ("b","a","c").SetHash, 'negative Pair value => True => element present';
}

# https://github.com/Raku/old-issue-tracker/issues/6632
# https://github.com/Raku/old-issue-tracker/issues/6633
{
    my %両 is SetHash = <a b c d>;
    is %両.elems, 4, 'did we get right number of elements';
    ok %両<a>, 'do we get a truthy value for a';
    nok %両<e>, 'do we get a falsy value for e';
    is %両.^name, 'SetHash', 'is the %h really a SetHash';
    %両 = <e f g>;
    is %両.elems, 3, 'did we get right number of elements after re-init';
    ok %両<e>:delete, 'did we get a truthy value by removing e';
    is %両.elems, 2, 'did we get right number of elements after :delete';
    lives-ok { %両<f> = False }, 'can delete from SetHash by assignment';
    is %両.elems, 1, 'did we get right number of elements assignment';
}

# https://github.com/rakudo/rakudo/issues/2289
is-deeply (1,2,3).SetHash.ACCEPTS(().SetHash), False, 'can we smartmatch empty';

{
    my $òe̲中 = <a b c>.SetHash;
    is-deeply $òe̲中.Set,     <a b c>.Set,     'coerce SetHash -> Set';
    is-deeply $òe̲中.Bag,     <a b c>.Bag,     'coerce SetHash -> Bag';
    is-deeply $òe̲中.BagHash, <a b c>.BagHash, 'coerce SetHash -> BagHash';
    is-deeply $òe̲中.Mix,     <a b c>.Mix,     'coerce SetHash -> Mix';
    is-deeply $òe̲中.MixHash, <a b c>.MixHash, 'coerce SetHash -> MixHash';
}

# https://github.com/Raku/old-issue-tracker/issues/6689
{
    my %ò両 is SetHash[Int] = 1,2,3;
    is-deeply %ò両.keys.sort, (1,2,3), 'parameterized SetHash';
    is-deeply %ò両.keyof, Int, 'did it parameterize ok';

    dies-ok { %ò両<foo> = True }, 'adding element of wrong type fails';
    dies-ok { my %ò両 is SetHash[Int] = <a b c> }, 'must have Ints on creation';
}

# https://github.com/rakudo/rakudo/issues/1862
is <a b c>.SetHash.item.VAR.^name, 'Scalar', 'does .item work on SetHashes';

{
    is-deeply SetHash.of, Bool, 'does SetHash type object return proper type';
    is-deeply SetHash.new.of, Bool, 'does SetHash object return proper type';
}

# https://github.com/rakudo/rakudo/issues/4332
{
    my %ò両 is SetHash = 1,2;
    lives-ok { while %ò両.grab -> $n { $n } }, 'Emptying a SetHash works';
}

lives-ok { my %両 is SetHash = 42 },
  "Can we initialize a SetHash with a single value";

# https://github.com/rakudo/rakudo/issues/5057
{
    my $ò := <a b c d e>.SetHash;
    is-deeply $ò>>--, <a b c d e>.SetHash,
      'did on-the-fly value return original';
    is-deeply $ò, SetHash.new,
      'did on-the-fly value change original';
}

# https://github.com/rakudo/rakudo/issues/5229
{
    is-deeply List.SetHash,  SetHash.new(List),  'got a SetHash with a List';
    is-deeply Array.SetHash, SetHash.new(Array), 'got a SetHash with an Array';
}

is-deeply <a b>.SetHash.Capture, %(:a, :b).Capture, 'SetHash Capture';

# https://github.com/rakudo/rakudo/issues/4678
my %ò両 is SetHash;
%ò両 ,= 1;
for <Str gist raku> -> $method {
    lives-ok { %ò両."$method"() },
      "self referencing SetHash doesn't loop on '$method'";
}

# vim: expandtab shiftwidth=4
