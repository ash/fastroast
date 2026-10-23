use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 246;

sub ò両갨w̲k̲𝐯($x) {
    $x.keys.sort.map({ $^k ~ ':' ~ $x{$k} }).join(' ')
}

# L<S02/Immutable types/'the mix listop'>

{
    my $ì = mix <a foo a a a a b foo>;
    isa-ok $ì, Mix, '&mix produces a Mix';
    is ò両갨w̲k̲𝐯($ì), 'a:5 b:1 foo:2', '...with the right elements';

    is $ì.default, 0, "Defaults to 0";
    is $ì<a>, 5, 'Single-key subscript (existing element)';
    isa-ok $ì<a>, Int, 'Single-key subscript yields an Int';
    is $ì<santa>, 0, 'Single-key subscript (nonexistent element)';
    isa-ok $ì<santa>, Int, 'Single-key subscript yields an Int (nonexistent element)';
    ok $ì<a>:exists, 'exists with existing element';
    nok $ì<santa>:exists, 'exists with nonexistent element';

    is $ì.values.elems, 3, "Values returns the correct number of values";
    is ([+] $ì.values), 8, "Values returns the correct sum";
    ok ?$ì, "Bool returns True if there is something in the Mix";
    nok ?Mix.new(), "Bool returns False if there is nothing in the Mix";

    my $両àò両;
    lives-ok { $両àò両 = $ì.hash }, ".hash doesn't die";
    isa-ok $両àò両, Hash, "...and it returned a Hash";
    is ò両갨w̲k̲𝐯($両àò両), 'a:5 b:1 foo:2', '...with the right elements';

    throws-like { $ì<a> = 5 },
      X::Assignment::RO,
      "Can't assign to an element (Mixs are immutable)";
    throws-like { $ì<a>++ },
      Exception,
      "Can't increment an element (Mixs are immutable)";
    throws-like { $ì.keys = <c d> },
      X::Assignment::RO,
      "Can't assign to .keys";
    throws-like { $ì.values = 3, 4 },
      X::Assignment::RO,
      "Can't assign to .values";
    throws-like { $ì<a>:delete },
      X::Assignment::RO,
      "Can't :delete from Mix";

    is ~$ì<a b>, "5 1", 'Multiple-element access';
    is ~$ì<a santa b easterbunny>, "5 0 1 0", 'Multiple-element access (with nonexistent elements)';

    is $ì.total, 8, '.total gives sum of values';
    is +$ì, 8, '+$mix gives sum of values';
}

{
    ok (mix <a b c>) ~~ (mix <a b c>), "Identical mixs smartmatch with each other";
    ok (mix <a b c c>) ~~ (mix <a b c c>), "Identical mixs smartmatch with each other";
    nok (mix <b c>) ~~ (mix <a b c>), "Subset does not smartmatch";
    nok (mix <a b c>) ~~ (mix <a b c c>), "Subset (only quantity different) does not smartmatch";
    nok (mix <a b c d>) ~~ (mix <a b c>), "Superset does not smartmatch";
    nok (mix <a b c c c>) ~~ (mix <a b c c>), "Superset (only quantity different) does not smartmatch";
    nok "a" ~~ (mix <a b c>), "Smartmatch is not element of";
    ok (mix <a b c>) ~~ Mix, "Type-checking smartmatch works";

    ok (set <a b c>) ~~ (mix <a b c>), "Set smartmatches with equivalent mix";
    nok (set <a b c>) ~~ (mix <a a a b b c>), "... but not if the Mix has greater quantities";
    nok (set <a b c>) ~~ Mix, "Type-checking smartmatch works";
}

{
    isa-ok "a".Mix, Mix, "Str.Mix makes a Mix";
    is ò両갨w̲k̲𝐯("a".Mix), 'a:1', "'a'.Mix is mix a";

    isa-ok (a => 100000).Mix, Mix, "Pair.Mix makes a Mix";
    is ò両갨w̲k̲𝐯((a => 100000).Mix), 'a:100000', "(a => 100000).Mix is mix a:100000";
    is ò両갨w̲k̲𝐯((a => 0).Mix), '', "(a => 0).Mix is the empty mix";

    isa-ok <a b c>.Mix, Mix, "<a b c>.Mix makes a Mix";
    is ò両갨w̲k̲𝐯(<a b c a>.Mix), 'a:2 b:1 c:1', "<a b c a>.Mix makes the mix a:2 b:1 c:1";
    is ò両갨w̲k̲𝐯(["a", "b", "c", "a"].Mix), 'a:2 b:1 c:1', "[a b c a].Mix makes the mix a:2 b:1 c:1";
    is ò両갨w̲k̲𝐯([a => 3, b => 0, 'c', 'a'].Mix), 'a:4 c:1', "[a => 3, b => 0, 'c', 'a'].Mix makes the mix a:4 c:1";

    isa-ok {a => 2, b => 4, c => 0}.Mix, Mix, "{a => 2, b => 4, c => 0}.Mix makes a Mix";
    is ò両갨w̲k̲𝐯({a => 2, b => 4, c => 0}.Mix), 'a:2 b:4', "{a => 2, b => 4, c => 0}.Mix makes the mix a:2 b:4";
}

{
    my $ì = mix <a a b foo>;
    is $ì<a>:exists, True, ':exists with existing element';
    is $ì<santa>:exists, False, ':exists with nonexistent element';
    throws-like { $ì<a>:delete },
      X::Assignment::RO,
      ':delete does not work on mix';
}

{
    my $ì = mix 'a', False, 2, 'a', False, False;
    my @k̲ò = $ì.keys;
    is @k̲ò.grep({ .WHAT === Int })[0], 2, 'Int keys are left as Ints';
    is @k̲ò.grep(* eqv False).elems, 1, 'Bool keys are left as Bools';
    is @k̲ò.grep(Str)[0], 'a', 'And Str keys are permitted in the same set';
    is $ì{2, 'a', False}.join(' '), '1 2 3', 'All keys have the right values';
}

{
    my %ò = mix <a b o p a p o o>;
    is-deeply %ò, { :2a, :1b, :2p, :3o }, 'flattens under single arg rule';
    my %ì = mix <a b o p>,< a p o o>;
    is-deeply %ì, { :2a, :1b, :2p, :3o }, 'also flattens';
}
{
    my %両 := mix <a b o p a p o o>;
    ok %両 ~~ Mix, 'A hash to which a Mix has been bound becomes a Mix';
    is ò両갨w̲k̲𝐯(%両), 'a:2 b:1 o:3 p:2', '...with the right elements';
}

{
    my $ì = mix <a b o p a p o o>;
    isa-ok $ì, Mix, '&Mix.new given an array of strings produces a Mix';
    is ò両갨w̲k̲𝐯($ì), 'a:2 b:1 o:3 p:2', '...with the right elements';
}

{
    my $ì = mix [ foo => 10, bar => 17, baz => 42, santa => 0 ];
    isa-ok $ì, Mix, '&Mix.new given an array of pairs produces a Mix';
    is +$ì, 4, "... with four elements under the single arg rule";
}
{
    my $ì = mix $[ foo => 10, bar => 17, baz => 42, santa => 0 ];
    isa-ok $ì, Mix, '&Mix.new given an itemized array of pairs produces a Mix';
    is +$ì, 1, "... with one element";
}

{
    # {}.hash interpolates in list context
    my $ì = mix { foo => 10, bar => 17, baz => 42, santa => 0 }.hash;
    isa-ok $ì, Mix, '&Mix.new given a Hash produces a Mix';
    is +$ì, 4, "... with four elements";
    is +$ì.grep(Pair), 4, "... which are all Pairs";
}

{
    my $ì = mix { foo => 10, bar => 17, baz => 42, santa => 0 };
    isa-ok $ì, Mix, '&Mix.new given a Hash produces a Mix';
    is +$ì, 4, "... with four elements under the single arg rule";
}
{
    my $ì = mix ${ foo => 10, bar => 17, baz => 42, santa => 0 };
    isa-ok $ì, Mix, '&Mix.new given an itemized Hash produces a Mix';
    is +$ì, 1, "... with one element";
}

{
    my $ì = mix set <foo bar foo bar baz foo>;
    isa-ok $ì, Mix, '&Mix.new given a Set produces a Mix';
    is +$ì, 1, "... with one element";
}

{
    my $ì = mix SetHash.new(<foo bar foo bar baz foo>);
    isa-ok $ì, Mix, '&Mix.new given a SetHash produces a Mix';
    is +$ì, 1, "... with one element";
}

{
    my $ì = mix MixHash.new(<foo bar foo bar baz foo>);
    isa-ok $ì, Mix, '&Mix.new given a MixHash produces a Mix';
    is +$ì, 1, "... with one element";
}

{
    my $ì = mix set <foo bar foo bar baz foo>;
    isa-ok $ì, Mix, '&mix given a Set produces a Mix';
    is +$ì, 1, "... with one element";
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %ì := mix <a b c b>;
    isa-ok %ì, Mix, 'A Mix bound to a %var is a Mix';
    is ò両갨w̲k̲𝐯(%ì), 'a:1 b:2 c:1', '...with the right elements';

    is %ì<b>, 2, 'Single-key subscript (existing element)';
    is %ì<santa>, 0, 'Single-key subscript (nonexistent element)';

    throws-like { %ì<a> = 1 },
      X::Assignment::RO,
      "Can't assign to an element (Mixs are immutable)";
    throws-like { %ì = mix <a b> },
      X::Assignment::RO,
      "Can't assign to a %var implemented by Mix";
    throws-like { %ì<a>:delete },
      X::Assignment::RO,
      "Can't :delete from a Mix";
}

{
    my $ì = { foo => 10.1, bar => 1.2, baz => 2.3}.Mix;
    is $ì.total, 13.6, 'is the total calculated correctly';

    # .list is just the keys, as per TimToady:
    # http://irclog.perlgeek.de/perl6/2012-02-07#i_5112706
    isa-ok $ì.list.elems, 3, ".list returns 3 things";
    is $ì.list.grep(Pair).elems, 3, "... all of which are Pairs";

    isa-ok $ì.pairs.elems, 3, ".pairs returns 3 things";
    is $ì.pairs.grep(Pair).elems, 3, "... all of which are Pairs";
    is $ì.pairs.grep({ .key ~~ Str }).elems, 3, "... the keys of which are Strs";
    is $ì.pairs.grep({ .value ~~ Real }).elems, 3, "... and the values of which are Reals";
}

{
    my $ì = { foo => 10000000000.1, bar => 17.2, baz => 42.3 }.Mix;
    is $ì.total, 10000000059.6, 'is the total calculated correctly';
    my $ò;
    my $c;
    lives-ok { $ò = $ì.raku }, ".raku lives";
    isa-ok $ò, Str, "... and produces a string";
    ok $ò.chars < 1000, "... of reasonable length";
    lives-ok { $c = EVAL $ò }, ".raku.EVAL lives";
    isa-ok $c, Mix, "... and produces a Mix";
    is ò両갨w̲k̲𝐯($c), ò両갨w̲k̲𝐯($ì), "... and it has the correct values";
}

{
    my $ì = { foo => 3.1, bar => -2.2, baz => 1 }.Mix;
    is $ì.total, 1.9, 'is the total calculated correctly';
    my $ò;
    lives-ok { $ò = $ì.Str }, ".Str lives";
    isa-ok $ò, Str, "... and produces a string";
    is $ò.split(" ").sort.join(" "), "bar(-2.2) baz foo(3.1)", "... which only contains bar baz and foo with the proper counts and separated by spaces";
}

{
    my $ì = { foo => 10000000000, bar => 17, baz => 42 }.Mix;
    my $ò;
    lives-ok { $ò = $ì.gist }, ".gist lives";
    isa-ok $ò, Str, "... and produces a string";
    ok $ò.chars < 1000, "... of reasonable length";
    ok $ò ~~ /foo/, "... which mentions foo";
    ok $ò ~~ /bar/, "... which mentions bar";
    ok $ò ~~ /baz/, "... which mentions baz";
}

# L<S02/Names and Variables/'C<%x> may be bound to'>

{
    my %b := mix "a", "b", "c", "b";
    isa-ok %b, Mix, 'A Mix bound to a %var is a Mix';
    is ò両갨w̲k̲𝐯(%b), 'a:1 b:2 c:1', '...with the right elements';

    is %b<b>, 2, 'Single-key subscript (existing element)';
    is %b<santa>, 0, 'Single-key subscript (nonexistent element)';
}

# L<S32::Containers/Mix/roll>

{
    my $ì = Mix.new("a", "b", "b");

    my $a = $ì.roll;
    ok $a eq "a" || $a eq "b", "We got one of the two choices";

    isa-ok $ì.roll, Str, ".roll with no arguments returns a key of the Mix";
    ok $ì.roll(0) ~~ Iterable, ".roll(0) gives you an Iterable";
    ok $ì.roll(1) ~~ Iterable, ".roll(1) gives you an Iterable";
    ok $ì.roll(2) ~~ Iterable, ".roll(2) gives you an Iterable";
    is +$ì.roll(0), 0, ".roll(0) returns 0 results";
    is +$ì.roll(1), 1, ".roll(1) returns 1 result";

    my @a = $ì.roll(2);
    is +@a, 2, '.roll(2) returns the right number of items';
    is @a.grep(* eq 'a').elems + @a.grep(* eq 'b').elems, 2, '.roll(2) returned "a"s and "b"s';

    @a = $ì.roll: 100000;
    is +@a, 100000, '.roll(100000) returns 100000 items';
    ok 2 < @a.grep(* eq 'a') < 75000, '.roll(100000) (1)';
    ok @a.grep(* eq 'a') + 2 < @a.grep(* eq 'b'), '.roll(100000) (2)';

    @a = $ì.roll(*)[^100000];
    ok 2 < @a.grep(* eq 'a') < 75000, '.roll(*)[^100000] (1)';
    ok @a.grep(* eq 'a') + 2 < @a.grep(* eq 'b'), '.roll(*)[^100000] (2)';

    is $ì.total, 3, '.roll should not change Mix';
}

{
    my $ì = {b => 1, a => 100000000000, c => -100000000000}.Mix;

    my $a = $ì.roll;
    ok $a eq "a" || $a eq "b", "We got one of the two choices (and this was pretty quick, we hope!)";

    my @a = $ì.roll: 100000;
    is +@a, 100000, '.roll(100000) returns 100000 items';
    diag "Found {+@a.grep(* eq 'a')} a's"
      if !ok @a.grep(* eq 'a') > 97000, '.roll(100000) (1)';
    diag "Found {+@a.grep(* eq 'b')} b's"
      if !ok @a.grep(* eq 'b') < 3000, '.roll(100000) (2)';
    is $ì.total, 1, '.roll should not change Mix';
}

# L<S32::Containers/Mix/pick>

{
    my $ì = Mix.new("a", "b", "b");
    throws-like { $ì.pick },
      Exception,
      '.pick does not work on Mix';
}

# L<S32::Containers/Mix/grab>

{
    my $ì = mix <a b b c c c>;
    throws-like { $ì.grab },
      X::Immutable,
      'cannot call .grab on a Mix';
}

# L<S32::Containers/Mix/grabpairs>

{
    my $ì = mix <a b b c c c>;
    throws-like { $ì.grabpairs },
      X::Immutable,
      'cannot call .grabpairs on a Mix';
}

{
    my $ì1 = Mix.new(( mix <a b c> ), <c c c d d d d>);
    is +$ì1, 2, "Two elements";
    my $갢丧丧e̲с-ì갢ч = $ì1.keys.first(Mix);
    isa-ok $갢丧丧e̲с-ì갢ч, Mix, "One of the mix's elements is indeed a Mix!";
    is ò両갨w̲k̲𝐯($갢丧丧e̲с-ì갢ч), "a:1 b:1 c:1", "With the proper elements";
    my $갢丧丧e̲с-л갢ò中 = $ì1.keys.first(List);
    isa-ok $갢丧丧e̲с-л갢ò中, List, "One of the mix's elements is indeed a List!";
    is $갢丧丧e̲с-л갢ò中, <c c c d d d d>, "With the proper elements";

    my $ì = mix <a b c>;
    $ì1 = Mix.new($ì, <c d>);
    is +$ì1, 2, "Two elements";
    $갢丧丧e̲с-ì갢ч = $ì1.keys.first(Mix);
    isa-ok $갢丧丧e̲с-ì갢ч, Mix, "One of the mix's elements is indeed a mix!";
    is ò両갨w̲k̲𝐯($갢丧丧e̲с-ì갢ч), "a:1 b:1 c:1", "With the proper elements";
    $갢丧丧e̲с-л갢ò中 = $ì1.keys.first(List);
    isa-ok $갢丧丧e̲с-л갢ò中, List, "One of the mix's elements is indeed a List!";
    is $갢丧丧e̲с-л갢ò中, <c d>, "With the proper elements";
}

{
    isa-ok 42.Mix, Mix, "Method .Mix works on Int-1";
    is ò両갨w̲k̲𝐯(42.Mix), "42:1", "Method .Mix works on Int-2";
    isa-ok "blue".Mix, Mix, "Method .Mix works on Str-1";
    is ò両갨w̲k̲𝐯("blue".Mix), "blue:1", "Method .Mix works on Str-2";
    my @a = <Now the cross-handed set was the Paradise way>;
    isa-ok @a.Mix, Mix, "Method .Mix works on Array-1";
    is ò両갨w̲k̲𝐯(@a.Mix), "Now:1 Paradise:1 cross-handed:1 set:1 the:2 was:1 way:1", "Method .Mix works on Array-2";
    my %ч = "a" => 1, "b" => 2;
    isa-ok %ч.Mix, Mix, "Method .Mix works on Hash-1";
    is ò両갨w̲k̲𝐯(%ч.Mix), "a:1 b:2", "Method .Mix works on Hash-2";
    isa-ok (@a, %ч).Mix, Mix, "Method .Mix works on List-1";
    is ò両갨w̲k̲𝐯((@a, %ч).Mix), "Now:1 Paradise:1 a:1 b:2 cross-handed:1 set:1 the:2 was:1 way:1",
       "Method .Mix works on List-2";
}

{
    my $ì1 = (a => 1.1, b => 2.2, c => 3.3, d => 4.4).Mix;
    is $ì1.total, 11, '.total gives sum of values (non-empty) 11';
    is +$ì1, 11, '+$set gives sum of values (non-empty) 11';
    is $ì1.minpairs, [a=>1.1], '.minpairs works (non-empty) 11';
    is $ì1.maxpairs, [d=>4.4], '.maxpairs works (non-empty) 11';
    is $ì1.fmt('foo %s').split("\n").sort, ('foo a', 'foo b', 'foo c', 'foo d'),
      '.fmt(%s) works (non-empty 11)';
    is $ì1.fmt('%s',',').split(',').sort, <a b c d>,
      '.fmt(%s,sep) works (non-empty 11)';
    is $ì1.fmt('%s foo %s').split("\n").sort, ('a foo 1.1', 'b foo 2.2', 'c foo 3.3', 'd foo 4.4'),
      '.fmt(%s%s) works (non-empty 11)';
    is $ì1.fmt('%s,%s',':').split(':').sort, <a,1.1 b,2.2 c,3.3 d,4.4>,
      '.fmt(%s%s,sep) works (non-empty 11)';

    my $ì2 = (a => 1.1, b => 1.1, c => 3.3, d => 3.3).Mix;
    is $ì2.total, 8.8, '.total gives sum of values (non-empty) 8.8';
    is +$ì2, 8.8, '+$set gives sum of values (non-empty) 8.8';
    is $ì2.minpairs.sort, [a=>1.1,b=>1.1], '.minpairs works (non-empty) 8.8';
    is $ì2.maxpairs.sort, [c=>3.3,d=>3.3], '.maxpairs works (non-empty) 8.8';

    my $ì3 = (a => 1.1, b => 1.1, c => 1.1, d => 1.1).Mix;
    is $ì3.total, 4.4, '.total gives sum of values (non-empty) 4.4';
    is +$ì3, 4.4, '+$set gives sum of values (non-empty) 4.4';
    is $ì3.minpairs.sort,[a=>1.1,b=>1.1,c=>1.1,d=>1.1], '.minpairs works (non-empty) 4.4';
    is $ì3.maxpairs.sort,[a=>1.1,b=>1.1,c=>1.1,d=>1.1], '.maxpairs works (non-empty) 4.4';

    my $e̲ = ().Mix;
    is $e̲.total, 0, '.total gives sum of values (empty)';
    is +$e̲, 0, '+$mix gives sum of values (empty)';
    is $e̲.minpairs, (), '.minpairs works (empty)';
    is $e̲.maxpairs, (), '.maxpairs works (empty)';
    is $e̲.fmt('foo %s'), "", '.fmt(%s) works (empty)';
    is $e̲.fmt('%s',','), "", '.fmt(%s,sep) works (empty)';
    is $e̲.fmt('%s foo %s'), "", '.fmt(%s%s) works (empty)';
    is $e̲.fmt('%s,%s',':'), "", '.fmt(%s%s,sep) works (empty)';
}

{
    is-deeply Mix[Str].new( <a b c> ).keys.sort.List, <a b c>,
      'can we parameterize for strings?';
    ok Mix[Str].keyof =:= Str, 'does .keyof return the correct type';
    throws-like { Mix[Int].new( <a b c> ) }, X::TypeCheck::Binding,
      'do wrong values make initialization croak';
}

# https://github.com/Raku/old-issue-tracker/issues/3805
isnt
  '91D95D6EDD0F0C61D02A2989781C5AEB10832C94'.Mix.WHICH,
  <a b c>.Mix.WHICH,
  'Faulty .WHICH creation';

{
    my $ì = <a>.Mix;
    throws-like { $ì<a> = 42.1 },
      X::Assignment::RO,
      'Make sure we cannot assign on a key';

    throws-like { $_ = 666.1 for $ì.values },
      Exception,  # X::Assignment::RO  ???
      'Make sure we cannot assign on a .values alias';

    throws-like { .value = 999.1 for $ì.pairs },
      X::Assignment::RO,
      'Make sure we cannot assign on a .pairs alias';

    throws-like { for $ì.kv -> \k, \v { v = 22.1 } },
      X::Assignment::RO,
      'Make sure we cannot assign on a .kv alias';
}

{
    my $ì = (a=>1.1, b=>2.2, c=>3.3, d=> 4.4).Mix;
    my @à1;
    for $ì.values -> \v { @à1.push(v) }
    is @à1.sort, (1.1,2.2,3.3,4.4), 'did we see all values';
    my @à2;
    for $ì.keys -> \v { @à2.push(v) }
    is @à2.sort, <a b c d>, 'did we see all keys';
    my %両1;
    for $ì.pairs -> \p { %両1{p.key} = p.value }
    is %両1.sort, (a=>1.1, b=>2.2, c=>3.3, d=>4.4), 'did we see all the pairs';
    my %両2;
    for $ì.kv -> \k, \v { %両2{k} = v }
    is %両2.sort, (a=>1.1, b=>2.2, c=>3.3, d=>4.4), 'did we see all the kv';
    my %両3;
    for $ì.antipairs -> \p { %両3{p.value} = p.key }
    is %両3.sort, (a=>1.1, b=>2.2, c=>3.3, d=>4.4), 'did we see all the antipairs';
}

# https://github.com/Raku/old-issue-tracker/issues/5513
subtest '.hash does not cause keys to be stringified' => {
    plan 3;
    is Mix.new($(<a b>)).hash.keys[0][0], 'a', 'Mix.new';
    is ($(<a b>),).Mix.hash.keys[0][0],   'a', '.Mix';
    is mix($(<a b>)).hash.keys[0][0],     'a', 'mix()';
}

{ # coverage; 2016-10-13
    my $ì = Mix.new-from-pairs: 'sugar' => .2, 'flour' => 2.7,
        'sugar' => 1.1, 'cyanide' => 0;

    is-deeply $ì.Bag, Bag.new(<sugar flour flour>), '.Bag coercer';
    is-deeply $ì.BagHash, BagHash.new(<sugar flour flour>),
        '.BagHash coercer';

    my $개갨𝐝e̲ = ｢my $m = Mix.new-from-pairs('a' => -20, 'b' => 1.5);｣
        ~ ｢my $a = $m.Bag; my $b = $m.BagHash｣;
    is_run $개갨𝐝e̲, { :err(''), :out(""), :0status },
        'negative Mix weights removed from Bag coercion without warnings';
}

{
    throws-like { my Mix $ì; $ì<as> = 2 }, Exception,
        'autovivification of of Mix:U complains about immutability';
}

{ # https://irclog.perlgeek.de/perl6-dev/2016-11-07#i_13528982
    my $a = (:a(-10), :b(-30)                 ).Mix;
    my $b = (         :b(-20), :c(-10), :d(10)).Mix;
    my $с = (:a(-10), :b(-20), :c(-10), :d(10)).Mix;
    is-deeply $a  ∪  $b, $с, 'negative weights remain with  ∪  operator';
    is-deeply $a (|) $b, $с, 'negative weights remain with (|) operator';
}

{
    ok ().Mix  =:= mix(), '().Mix returns the empty mix';
}

{
    throws-like { ^Inf .Mix }, X::Cannot::Lazy, :what<Mix>;
    throws-like { Mix.new-from-pairs(^Inf) }, X::Cannot::Lazy, :what<Mix>;
    throws-like { Mix.new(^Inf) }, X::Cannot::Lazy, :what<Mix>;

    for a=>"a", a=>Inf, a=>-Inf, a=>NaN, a=>3i -> $pair {
      my \ex := $pair.value ~~ Complex
          ?? X::Numeric::Real !! $pair.value eq 'a'
          ?? X::Str::Numeric  !! X::OutOfRange;
      throws-like { $pair.Mix }, ex,
        "($pair.raku()).Mix throws";
      throws-like { Mix.new-from-pairs($pair) }, ex,
        "Mix.new-from-pairs( ($pair.raku()) ) throws";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6343
{
    is-deeply (a => -1, a => 1).Mix,      mix(),
      'final value 0 disappears in Mix for empty mix';
    is-deeply (a => -1, a => 1, "b").Mix, Mix.new("b"),
      'final value 0 disappears in Mix';
}

# https://github.com/Raku/old-issue-tracker/issues/6430
{
    is-deeply (a => ½).Mix    .roll, 'a', 'Mix.roll with fractional weights';
    is-deeply (a => ½).MixHash.roll, 'a', 'MixHash.roll with fractional weights';
}

# https://github.com/Raku/old-issue-tracker/issues/6632
# https://github.com/Raku/old-issue-tracker/issues/6633
{
    my %両 is Mix = <a b b c c c d d d d>;
    is %両.elems, 4, 'did we get right number of elements';
    is %両<a>, 1, 'do we get 1 for a';
    is %両<e>, 0, 'do we get 0 for e';
    is %両.^name, 'Mix', 'is the %h really a Mix';
    dies-ok { %両 = <e f g> }, 'cannot re-initialize Mix';
    dies-ok { %両<a>:delete }, 'cannot :delete from Mix';
    dies-ok { %両<a> = False }, 'cannot delete from Mix by assignment';
}

# https://github.com/rakudo/rakudo/issues/2289
is-deeply (1,2,3).Mix.ACCEPTS(().Mix), False, 'can we smartmatch empty';

{
    my $ì갢ч = <a b c>.Mix;
    is-deeply $ì갢ч.Set,     <a b c>.Set,     'coerce Mix -> Set';
    is-deeply $ì갢ч.SetHash, <a b c>.SetHash, 'coerce Mix -> SetHash';
    is-deeply $ì갢ч.Bag,     <a b c>.Bag,     'coerce Mix -> Bag';
    is-deeply $ì갢ч.BagHash, <a b c>.BagHash, 'coerce Mix -> BagHash';
    is-deeply $ì갢ч.MixHash, <a b c>.MixHash, 'coerce Mix -> MixHash';
}

# https://github.com/Raku/old-issue-tracker/issues/6689
{
    my %ì is Mix[Int] = 1,2,3;
    is-deeply %ì.keys.sort, (1,2,3), 'parameterized Mix';
    is-deeply %ì.keyof, Int, 'did it parameterize ok';

    dies-ok { my %ì is Mix[Int] = <a b c> }, 'must have Ints on creation';
}

# https://github.com/rakudo/rakudo/issues/1862
is <a b c>.Mix.item.VAR.^name, 'Scalar', 'does .item work on Mixes';

{
    is-deeply Mix.of, Real, 'does Mix type object return proper type';
    is-deeply Mix.new.of, Real, 'does Mix object return proper type';
}

lives-ok { my %両 is Mix = 42 }, "Can we initialize a Mix with a single value";

# https://github.com/rakudo/rakudo/issues/5057
{
    my $ì := <a b c d e a b>.Mix;
    is-deeply $ì>>.&{ 3 }, <a a a b b b c c c d d d e e e>.Mix,
      'did on-the-fly value return original';
    is-deeply $ì, <a b c d e a b>.Mix,
      'did on-the-fly value leave original unchanged';
}

# https://github.com/rakudo/rakudo/issues/5229
{
    is-deeply List.Mix,  Mix.new(List),  'got a Mix with a List';
    is-deeply Array.Mix, Mix.new(Array), 'got a Mix with an Array';
}

is-deeply %(:42a, :b(-72)).Mix.Capture, %(:42a, :b(-72)).Capture, 'Mix Capture';

# https://github.com/rakudo/rakudo/issues/6246
{
    my %両 is Mix = <a b b>;
    is-deeply %両.keys.sort, <a b>, 'Did the keys get set';
    is-deeply mix().keys, (), 'did it not spoil the sentinel';
}

# vim: expandtab shiftwidth=4
