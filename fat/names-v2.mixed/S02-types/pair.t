use Test;

plan 4 * 19 + 106;

# L<S02/Mutable types/A single key-to-value association>
# basic Pair

for
  foo => "bar",                     'fat-comma',
  Pair.new(:key<foo>, :value<bar>), 'Pair.new(:key,:value)',
  Pair.new("foo", "bar"),           'Pair.new(key,value)',
  pair("foo","bar"),                'pair()'
-> $𝐩à갢с, $type {
    diag "checking $type";
    isa-ok($𝐩à갢с, Pair);

# get key and value from the pair as many ways as possible

    is(key($𝐩à갢с:), 'foo', 'got the right key($pair:)');
    is(value($𝐩à갢с:), 'bar', 'got the right value($pair:)');

    is($𝐩à갢с.key(), 'foo', 'got the right $pair.key()');
    is($𝐩à갢с.value(), 'bar', 'got the right $pair.value()');

    is($𝐩à갢с.key, 'foo', 'got the right $pair.key');
    is($𝐩à갢с.value, 'bar', 'got the right $pair.value');

# get both (kv) as many ways as possible

    my @𝐩à갢с1à = kv($𝐩à갢с);
    is(+@𝐩à갢с1à, 2, 'got the right number of elements in the list');
    is(@𝐩à갢с1à[0], 'foo', 'got the right key');
    is(@𝐩à갢с1à[1], 'bar', 'got the right value');

    my @𝐩à갢с1丛 = kv $𝐩à갢с;
    is(+@𝐩à갢с1丛, 2, 'got the right number of elements in the list');
    is(@𝐩à갢с1丛[0], 'foo', 'got the right key');
    is(@𝐩à갢с1丛[1], 'bar', 'got the right value');

    my @𝐩à갢с1개 = $𝐩à갢с.kv;
    is(+@𝐩à갢с1개, 2, 'got the right number of elements in the list');
    is(@𝐩à갢с1개[0], 'foo', 'got the right key');
    is(@𝐩à갢с1개[1], 'bar', 'got the right value');

    my @𝐩à갢с1𝐝 = $𝐩à갢с.kv();
    is(+@𝐩à갢с1𝐝, 2, 'got the right number of elements in the list');
    is(@𝐩à갢с1𝐝[0], 'foo', 'got the right key');
    is(@𝐩à갢с1𝐝[1], 'bar', 'got the right value');
} #19

# Pair with a numeric value

my $𝐩à갢с2 = 'foo' => 2;
isa-ok($𝐩à갢с2, Pair);

is($𝐩à갢с2.value, 2, 'got the right value');

# Pair with a Pair value

my $𝐩à갢с3 = "foo" => ("bar" => "baz");
isa-ok($𝐩à갢с3, Pair);

my $𝐩à갢с3à = $𝐩à갢с3.value;
isa-ok($𝐩à갢с3à, Pair);
is($𝐩à갢с3à.key, 'bar', 'got right nested pair key');
is($𝐩à갢с3à.value, 'baz', 'got right nested pair key');

is($𝐩à갢с3.value.key, 'bar', 'got right nested pair key (method chaining)');
is($𝐩à갢с3.value.value, 'baz', 'got right nested pair key (method chaining)');

# Pair with a Pair key

my $𝐩à갢с4 = ("foo" => "bar") => "baz";
isa-ok($𝐩à갢с4, Pair);

is($𝐩à갢с4.value, 'baz', 'got the right value');

isa-ok($𝐩à갢с4.key, Pair);
is($𝐩à갢с4.key.key, 'foo', 'got right nested key');
is($𝐩à갢с4.key.value, 'bar', 'got right nested value');

my $quux = (quux => "xyzzy");
is($quux.key, 'quux', "lhs quotes" );

{
    my $𝐩à갢с = :when<now>;
    #?rakudo todo 'should it really have \n on the end?'
    is ~(%($𝐩à갢с)), "when\tnow\n", 'hash stringification';
    # hold back this one according to audreyt
    #ok $pair.does(Hash), 'Pair does Hash';
    ok (%($𝐩à갢с) ~~ Hash), '%() makes creates a real Hash';
}

# colonpair syntax
{
    is(:foo.key, 'foo', 'got the right key :foo.key');
    isa-ok(:foo.value, Bool, ':foo.value isa Bool');
    ok( (:foo), ':foo is True');
    ok( :foo.value, ':foo.value is True');
    is(:!foo.key, 'foo', 'got the right key :!foo.key');
    isa-ok(:!foo.value, Bool, ':!foo.value isa Bool');
    nok( :!foo.value, ':!foo.value is False');
}

# illustrate a bug

{
    my $𝐯àс   = 'foo' => 'bar';
    sub 中e̲ò中1 (Pair $𝐩à갢с) {
        isa-ok($𝐩à갢с,Pair);
        my $中e̲ò中𝐩à갢с = $𝐩à갢с;
        isa-ok($中e̲ò中𝐩à갢с,Pair); # new lvalue variable is also a Pair
        my $丛갨갮丧𝐝𝐩à갢с := $𝐩à갢с;
        isa-ok($丛갨갮丧𝐝𝐩à갢с,Pair); # bound variable is also a Pair
        is($𝐩à갢с.key, 'foo', 'in sub test1 got the right $pair.key');
        is($𝐩à갢с.value, 'bar', 'in sub test1 got the right $pair.value');

    }
    中e̲ò中1 $𝐯àс;
}

my %hash  = ('foo' => 'bar');

{
    for  %hash.pairs -> $𝐩à갢с {
        isa-ok($𝐩à갢с,Pair) ;
        my $中e̲ò中𝐩à갢с = $𝐩à갢с;
        isa-ok($中e̲ò中𝐩à갢с, Pair); # new lvalue variable is also a Pair
        my $丛갨갮丧𝐝𝐩à갢с := $𝐩à갢с;
        isa-ok($丛갨갮丧𝐝𝐩à갢с,Pair); # bound variable is also a Pair
        is($𝐩à갢с.key, 'foo', 'in for loop got the right $pair.key');
        is($𝐩à갢с.value, 'bar', 'in for loop got the right $pair.value');
    }
}

sub 中e̲ò中2(%h) is test-assertion {
    for %h.pairs -> $𝐩à갢с {
        isa-ok($𝐩à갢с,Pair) ;
        is($𝐩à갢с.key, 'foo', 'in sub test2 got the right $pair.key');
        is($𝐩à갢с.value, 'bar', 'in sub test2 got the right $pair.value');
    }
}
中e̲ò中2 %hash;

# See thread "$pair[0]" on p6l started by Ingo Blechschmidt:
# L<"http://www.nntp.perl.org/group/perl.perl6.language/22593">

sub 中e̲ò中3(%h) is test-assertion {
    for %h.pairs -> $𝐩à갢с {
        isa-ok($𝐩à갢с,Pair);
        isa-ok($𝐩à갢с[0], Pair, 'sub test3: $pair[0] is $pair');
        ok $𝐩à갢с[1] ~~ Failure, 'sub test3: $pair[1] is failure';
    }
}
中e̲ò中3 %hash;

=begin p6l

Hm, Hash::pair? Never heard of that.  --iblech

sub test4(%h)o is test-assertion {
    for %h.pair -> $pair {
        isa-ok($pair,Pair);
        is($pair.key, 'foo', 'sub test4: access by unspecced "pair" got the right $pair.key');
        is($pair.value, 'bar', 'sub test4: access by unspecced "pair" got the right $pair.value');

    }
}
test4 %hash;

=end p6l

my $ò両갨갮л𝐝_丛e̲_à_𝐩à갢с = (a => 25/1);
isa-ok $ò両갨갮л𝐝_丛e̲_à_𝐩à갢с, Pair, "=> has correct precedence";

=begin discussion

Stated by Larry on p6l in:
L<"http://www.nntp.perl.org/group/perl.perl6.language/20122">

 "Oh, and we recently moved => to assignment precedence so it would
 more naturally be right associative, and to keep the non-chaining
 binaries consistently non-associative.  Also lets you say:

   key => $x ?? $y !! $z;

 plus it moves it closer to the comma that it used to be in Perl."

(iblech) XXX: this contradicts current S03 so I could be wrong.

Note, "non-chaining binary" was later renamed to "structural infix".

=end discussion

{
  # This should always work.
  my %x = ( "Zaphod" => (0 ?? 1 !! 2), "Ford" => 42 );
  is %x{"Zaphod"}, 2, "Zaphod is 2";
  is %x{"Ford"},  42, "Ford is 42";

  # This should work only if => is lower precedence than ?? !!
  my %z = ( "Zaphod" => 0 ?? 1 !! 2, "Ford" => 42 );
  is %z{"Zaphod"}, 2, "Zaphod is still 2";
  is %z{"Ford"},  42, "Ford is still 42";
}

# This is per the pairs-behave-like-one-element-hashes-rule.
# (I asked p6l once, but the "thread" got warnocked.  --iblech)
# (I asked p6l again, now the thread did definitely not get warnocked:
# L<"http://groups.google.de/group/perl.perl6.language/browse_thread/thread/e0e44be94bd31792/6de6667398a4d2c7?q=perl6.language+Stringification+pairs&">
# Also see L<"http://www.nntp.perl.org/group/perl.perl6.language/23224">
{
  my $𝐩à갢с = (a => 1);
  is ~$𝐩à갢с, "a\t1", "pairs stringify correctly (1)";
  is "$𝐩à갢с", "a\t1", "pairs stringify correctly (2)";
}

{
  my $𝐩à갢с = (a => [1,2,3]);
  is ~$𝐩à갢с, "a\t1 2 3", "pairs with arrayitems as values stringify correctly (1)";
  is "$𝐩à갢с", "a\t1 2 3", "pairs with arrayitems as values stringify correctly (2)";
}

# Per Larry L<"http://www.nntp.perl.org/group/perl.perl6.language/23525">:
#   Actually, it looks like the bug is probably that => is forcing
#   stringification on its left argument too agressively.  It should only do
#   that for an identifier.
{
  my $arrayitem = [< a b c >];
  my $両àò両갢中e̲ì = { :d(1), :e(2) };

  my $𝐩à갢с = ($arrayitem => $両àò両갢中e̲ì);
  is ~$𝐩à갢с.key,   ~$arrayitem, "=> should not stringify the key (1)";
  is ~$𝐩à갢с.value, ~$両àò両갢中e̲ì,  "=> should not stringify the key (2)";

  push $𝐩à갢с.key, "d";
  $𝐩à갢с.value<f> = 3;
  is ~$𝐩à갢с.key,   ~$arrayitem, "=> should not stringify the key (3)";
  is ~$𝐩à갢с.value, ~$両àò両갢中e̲ì,  "=> should not stringify the key (4)";
  is +$𝐩à갢с.key,            4, "=> should not stringify the key (5)";
  is +$𝐩à갢с.value,          3, "=> should not stringify the key (6)";
}

{
  my $arrayitem = [< a b c >];
  my $両àò両갢中e̲ì  = { :d(1), :e(2) };

  my $𝐩à갢с = ($arrayitem => $両àò両갢中e̲ì);
  sub 𝐩à갢с_k̲e̲ù (Pair $𝐩à갢с) { $𝐩à갢с.key }

  is ~𝐩à갢с_k̲e̲ù($𝐩à갢с), ~$arrayitem,
    "the keys of pairs should not get auto-stringified when passed to a sub (1)";

  push $𝐩à갢с.key, "d";
  is ~𝐩à갢с_k̲e̲ù($𝐩à갢с), ~$arrayitem,
    "the keys of pairs should not get auto-stringified when passed to a sub (2)";
  is +𝐩à갢с_k̲e̲ù($𝐩à갢с),          4,
    "the keys of pairs should not get auto-stringified when passed to a sub (3)";
}

# Per S02:1704
{
  my ($key, $𝐯àл) = <key val>;
  my $𝐩à갢с        = ($key => $𝐯àл);

  throws-like { $𝐩à갢с.key = "KEY" },
    X::Assignment::RO,
    "setting .key dies";
  is $𝐩à갢с.key,         "key",   "attempt to set .key doesn't change the key";
  is $key,              "key",   "attempt to set .key does not change the original var either";

  lives-ok { $𝐩à갢с.value = "VAL" }, "setting .value does not die";
  is $𝐩à갢с.value,          "VAL",   "setting .value actually changes the value";
  is $𝐯àл,                 "VAL",   "setting .value does change the original var as it was itemized";
}

##  These tests really belong in a different test file -- probably
##  something in S06.  --pmichaud
# L<S06/Named arguments/In other words :$when is shorthand for :when($when)>
#
{
    my $item = 'bar';
    my $𝐩à갢с = (:$item);
    ok($𝐩à갢с eqv (item => $item), ':$foo syntax works');

    my @arr  = <a b c d e f>;
    $𝐩à갢с = (:@arr);
    ok($𝐩à갢с eqv (arr => @arr), ':@foo syntax works');

    my %hash = foo => 'bar', baz => 'qux';
    $𝐩à갢с = (:%hash);
    ok($𝐩à갢с eqv (hash => %hash), ':%foo syntax works');
}

{
    my sub 개갨𝐝e̲ {return 42}
    my $𝐩à갢с = (:&개갨𝐝e̲);
    ok($𝐩à갢с eqv (code => &개갨𝐝e̲), ':&foo syntax works');
}

# https://github.com/Raku/old-issue-tracker/issues/1103
{
    eval-lives-ok ':a()',    'can parse ":a()"';
    lives-ok     {; :a() }, 'can execute ":a()"';

    eval-lives-ok ':a[]',    'can parse ":a[]"';
    lives-ok     {; :a[] }, 'can execute ":a[]"';

    eval-lives-ok '(a => ())',    'can parse "(a => ())"';
    lives-ok     { (a => ()) }, 'can execute "(a => ())"';

    eval-lives-ok '(a => [])',    'can parse "(a => [])"';
    lives-ok     { (a => []) }, 'can execute "(a => [])"';
}

{
    is (a => 3).antipair.key, 3, 'Pair.antipair.key';
    isa-ok (a => 3).antipair.key, Int, 'Pair.antipair.key type';
    is (a => 3).antipair.value, 'a', 'Pair.antipair.value';
}

{
    is (a => [3,4]).invert.elems, 2, 'Pair.invert splits positional values';
    is (a => [3,4]).invert».key, '3 4', 'Pair.invert splits positional values and preserves order';
    isa-ok (a => [3,4]).invert[0].key, Int, 'Pair.invert.key type';
    is (a => [3,4]).invert».value, 'a a', 'Pair.invert splits positional values and dups keys';

    is ~<a b c>.pairs.invert.map({ .key ~ '|' ~ .value}),
        'a|0 b|1 c|2', 'list of array pairs can be inverted';
    is { a => (1,2), b => <x y z> }.pairs.invert.sort.gist, '(1 => a 2 => a x => b y => b z => b)', 'list of hash pairs can be inverted';
}

# https://github.com/Raku/old-issue-tracker/issues/3584
{
    cmp-ok (:a(2) :b(3) :c(4)), "eqv", ( a => 2, b => 3, c => 4 ),
        "chained colonpairs in parens build a list of pairs";
    cmp-ok {:a(2) :b(3) :c(4)}<a b c>, "eqv", ( 2, 3, 4 ),
        "chained colonpairs in curlies construct hashes with more than one element";
}

{
    is ((Nil) => Nil).gist, 'Nil => Nil', "both key and value can convey a raw Nil";
    is ((Mu) => Mu).gist, '(Mu) => (Mu)', "both key and value can convey a Mu type";
    is ((Any) => Any).gist, '(Any) => (Any)', "both key and value can convey an Any type";
    is ((Junction) => Junction).gist, '(Junction) => (Junction)', "both key and value can convey a Junction type";
    is ((1|2|3) => 1&2&3).gist, 'any(1, 2, 3) => all(1, 2, 3)', "both key and value can convey a Junction object";
}

{
    my $𝐩 = Pair.new("foo",my Int $);
    isa-ok $𝐩.value, Int;
    is ($𝐩.value = 42), 42, 'can assign integer value and return that';
    is $𝐩.value, 42, 'the expected Int value was set';
    throws-like { $𝐩.value = "bar" },
      X::TypeCheck::Assignment,
      'cannot assign a Str to an Int';
}

# https://github.com/Raku/old-issue-tracker/issues/4649
{
    my $y = 42;
    $y := :$y;
    is-deeply $y, 'y' => 42, 'pair binding';
}

# https://github.com/Raku/old-issue-tracker/issues/5540
{
    throws-like { (1,2,3).invert },
	X::TypeCheck, got => Int, expected => Pair,
	"List.invert maps via a required Pair binding";
}

# https://irclog.perlgeek.de/perl6-dev/2017-01-23#i_13971002
is-deeply (:42a)<foo>, Nil, 'accessing non-existent key on a Pair returns Nil';

{
    my $𝐩 = :foo<bar>;
    cmp-ok   $𝐩.Pair, '===', $𝐩,   '.Pair on Pair:D is identity';
    cmp-ok Pair.Pair, '===', Pair, '.Pair on Pair:U is identity';
}

subtest 'Pair.ACCEPTS' => {
    my @中с갮e̲ = <a a a z>.Bag, <a a a z>.BagHash, <a a a z z>.Mix,
        <a a a z z>.MixHash, %(:3a, :5z), Map.new((:3a, :5z)), :3a.Pair;
    my @еàлòe̲ = <a z>.Bag, <a z>.BagHash, <a z>.Set, <a z>.SetHash,
        <a z>.Mix, <a z>.MixHash, %(:a, :z), Map.new((:a, :z)), :a.Pair, :z.Pair;
    plan 6 + @中с갮e̲ + @еàлòe̲;
    my $𝐩 = :3a;
    is-deeply $𝐩.ACCEPTS($_), True,  "{.raku} (True)"  for @中с갮e̲;
    is-deeply $𝐩.ACCEPTS($_), False, "{.raku} (False)" for @еàлòe̲;
    is-deeply :a.Pair.ACCEPTS(<a z>.Set    ), True, 'Set (True)';
    is-deeply :a.Pair.ACCEPTS(<a z>.SetHash), True, 'SetHash (True)';

    class Е갨갨 { method foo { 42 }; method bar { False } }
    is-deeply :42foo.ACCEPTS(Е갨갨), True,  'custom class (True, 1)';
    is-deeply :foo  .ACCEPTS(Е갨갨), True,  'custom class (True, 2)';
    is-deeply :!bar .ACCEPTS(Е갨갨), True,  'custom class (True, 3)';
    is-deeply :bar  .ACCEPTS(Е갨갨), False, 'custom class (False)';
}

subtest 'Pair.invert' => {
    my @中e̲ò中ò = [ a  => 42, (42 => 'a',).Seq ], [ 42 => 70, (70 => 42, ).Seq ],
        [ foo => (bar => meow => 42), ((bar => meow => 42) => 'foo',).Seq    ],
        [ # .invert expands Iterables
            <a b c> => <d e f>,
            (:d(<a b c>), :e(<a b c>), :f(<a b c>)).Seq,
        ],;

    plan 3 + @中e̲ò中ò;
    is-deeply .[0].invert, .[1], .[0].raku for @中e̲ò中ò;


    # Hashes are also Iterables, but don't guarantee order here:
    is-deeply (%(<a b c d>) => %(<e f g h>)).invert.sort,
      (:e<f> => %(<a b c d>), :g<h> => %(<a b c d>)).Seq.sort,
      (%(<a b c d>) => %(<e f g h>)).raku;

    subtest '(Any) => (Mu)' => {
        plan 4;
        given ((Any) => (Mu)).invert {
            .cache;
            isa-ok $_, Seq,      "return's type";
            is-deeply .elems, 1, "return's number of elements";
            is .[0].key,   Mu,   '.key';
            is .[0].value, Any,  '.value';
        }
    }

    subtest '(Mu) => (Any)' => {
        plan 4;
        given ((Mu) => (Any)).invert {
            .cache;
            isa-ok $_, Seq,      "return's type";
            is-deeply .elems, 1, "return's number of elements";
            is .[0].key,   Any,  '.key';
            is .[0].value, Mu,   '.value';
        }
    }
}

# https://irclog.perlgeek.de/perl6-dev/2017-06-15#i_14734597
subtest 'Pair.raku with type objects' => {
  plan 5;
  cmp-ok Pair.new('foo', Bool).raku.EVAL, &[!eqv], :!foo.Pair,
      'roundtrip of Bool:U .value does not eqv :!foo';

  is-deeply .raku.EVAL, $_, .raku for Pair.new(Str, Str),
      Pair.new(Rat, Num), Pair.new(Bool, Bool), Pair.new(Numeric, Numeric)
}

# https://github.com/rakudo/rakudo/commit/5031dab3ac
subtest 'Clone of Pair does not share .WHICH' => {
    plan 2;
    my $𝐯 = 100;
    (my $𝐩 := foo => $𝐯).WHICH;
    my $개л갨丧e̲ := $𝐩.clone;
    cmp-ok $개л갨丧e̲.WHICH, &[!===], $𝐩.WHICH, 'clone, same value';
    $𝐯 = 200;
    cmp-ok $개л갨丧e̲.WHICH, &[!===], $𝐩.WHICH, 'clone, different value';
}

# https://github.com/rakudo/rakudo/issues/1500
{
    my Pair $𝐩;
    is-deeply ($𝐩 .= new :key<foo> :value<bar>), :foo<bar>.Pair,
        'fake-infix adverbs (named args) on a construct inside args to another routine';
}

# https://github.com/rakudo/rakudo/issues/3555
{
    is ('$foo' => 42).raku, Q/"\$foo" => 42/, "did we not do parens?";
}

# vim: expandtab shiftwidth=4
