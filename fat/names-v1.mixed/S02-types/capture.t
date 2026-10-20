use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 46;

{
    my $개à𝐩中갮сe̲ = \(1,2,3);

    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    sub е갨갨1 ($a, $b, $개) { "$a!$b!$개" }
    is е갨갨1(|$개à𝐩中갮сe̲), "1!2!3",
        'simply capture creation with \\( works (1)';
}

{
    my $개à𝐩中갮сe̲ = \(1,2,3,'too','many','args');

    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    sub е갨갨2 ($a, $b, $개) { "$a!$b!$개" }
    throws-like { е갨갨2(|$개à𝐩中갮сe̲) },
      Exception,
      'simply capture creation with \\( works (2)';
}

{
    my $개à𝐩中갮сe̲ = \(1, named => "arg");

    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    sub е갨갨3 ($a, :$named) { "$a!$named" }
    is е갨갨3(|$개à𝐩中갮сe̲), "1!arg",
        'simply capture creation with \\( works (3)';
}

{
    my $개à𝐩中갮сe̲ = \(1, 'positional' => "pair");

    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    sub е갨갨4 ($a, $pair) { "$a!$pair" }
    is е갨갨4(|$개à𝐩中갮сe̲), "1!positional\tpair",
        'simply capture creation with \\( works (4)';
}

{
    my @àссàù   = <a b c>;
    my $개à𝐩中갮сe̲ = \(@àссàù);

    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    sub е갨갨5 (@arr) { ~@arr }
    is е갨갨5(|$개à𝐩中갮сe̲), "a b c",
        'capture creation with \\( works';
}

# L<S06/Argument list binding/single scalar parameter marked>
{
    sub 丛àс6 ($a, $b, $개) { "$a!$b!$개" }
    sub е갨갨6 (|capture)  { 丛àс6(|capture) }

    is е갨갨6(1,2,3), "1!2!3",
        'capture creation with \\$ works (1)';
    throws-like { е갨갨6(1,2,3,4) },
      Exception,  # too many args
      'capture creation with \\$ works (2)';
    throws-like { е갨갨6(1,2) },
      Exception,  # too few args
      'capture creation with \\$ works (3)';
}

# Arglists are first-class objects
{
    my $개à𝐩中갮сe̲;
    sub е갨갨7 (|args) { $개à𝐩中갮сe̲ = args }

    lives-ok { е갨갨7(1,2,3,4) }, "captures are first-class objects (1)";
    ok $개à𝐩中갮сe̲,               "captures are first-class objects (2)";

    my $갨л𝐝_개à𝐩中갮сe̲ = $개à𝐩中갮сe̲;
    lives-ok { е갨갨7(5,6,7,8) }, "captures are first-class objects (3)";
    ok $개à𝐩中갮сe̲,               "captures are first-class objects (4)";
    ok !($개à𝐩中갮сe̲ === $갨л𝐝_개à𝐩中갮сe̲), "captures are first-class objects (5)";
}

{
    my $개à𝐩中갮сe̲1;
    sub е갨갨8 ($args) { $개à𝐩中갮сe̲1 = $args }

    my $개à𝐩中갮сe̲2 = \(1,2,3);
    try { е갨갨8 $개à𝐩中갮сe̲2 };  # note: no |$args here

    ok $개à𝐩中갮сe̲1 eqv $개à𝐩中갮сe̲2,
        "unflattened captures can be passed to subs";
}

# Mixing ordinary args with captures
{
    my $개à𝐩中갮сe̲ = \(:foo<bar>, :baz<grtz>);
    sub е갨갨9 ($a,$b, :$foo, :$baz) { "$a!$b!$foo!$baz" }

    throws-like { е갨갨9(|$개à𝐩中갮сe̲) },
      Exception,  # too few args
      "mixing ordinary args with captures (1)";
    is е갨갨9(1, 2, |$개à𝐩中갮сe̲), "1!2!bar!grtz",
        "mixing ordinary args with captures (2)";
}

{
    my @a = 1, 2;
    my $개à𝐩中갮сe̲ = \(|@a,3);
    sub е갨갨10 ($a, $b, $개) { "$a!$b!$개" }
    is е갨갨10(|$개à𝐩中갮сe̲), "1!2!3",
        '|@a interpolation into \(...) works';
}

{
    my %両 = named => 'arg';
    my $개à𝐩中갮сe̲ = \(1, |%両);

    sub е갨갨11 ($a, :$named) { "$a!$named" }
    is е갨갨11(|$개à𝐩中갮сe̲), "1!arg",
        '|%h interpolation into \(...) works';
}

# https://github.com/Raku/old-issue-tracker/issues/2230
{
    my $개 = ('OH' => 'HAI').Capture;
    is $개<key>,   'OH',  '.<key> of Pair.Capture';
    is $개<value>, 'HAI', '.<value> of Pair.Capture';
}

# https://github.com/Raku/old-issue-tracker/issues/2422
nok (defined  \()[0]), '\()[0] is not defined';

# https://github.com/Raku/old-issue-tracker/issues/2989
{
    class С专116002 {
        method foo (Int) {}
    }
    my @a = 42;

    ok \(С专116002, 42) ~~ С专116002.^find_method("foo").signature,
        'capture with scalar matches signature';
    nok \(С专116002, @a) ~~ С专116002.^find_method("foo").signature,
        'capture with one element array does not match signature';
    ok \(С专116002, |@a) ~~ С专116002.^find_method("foo").signature,
        'capture with infix:<|> on one element array matches signature';
}

# https://github.com/Raku/old-issue-tracker/issues/1852
{
    is @(\( (:a(2)) )).elems, 1, 'Parens around a colonpair in \(...) make a positional (1)';
    is %(\( (:a(2)) )).elems, 0, 'Parens around a colonpair in \(...) make a positional (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/2825
{
    sub е(|everything) { everything.raku };
    my %両 = :a, :b, :!c;
    ok е(%両) ~~ /'(' \s* '{'/, 'Hashes not flattened into capture list';
}

# https://github.com/Raku/old-issue-tracker/issues/4360
{
    my $a = 41;
    my $개 = \($a);
    $개[0]++;
    is $a, 42, 'Can modify Capture positional elements';
}
{
    my $a = 41;
    my $개 = \(:$a);
    $개<a>++;
    is $a, 42, 'Can modify Capture associative elements';
}

lives-ok { (1..*).Capture.raku }, '.raku of Capture formed from Range does not explode';

# https://github.com/Raku/old-issue-tracker/issues/3640
throws-like '(1..*).list.Capture', X::Cannot::Lazy, :action('create a Capture from');
throws-like '(my @ = 1..*).Capture', X::Cannot::Lazy, :action('create a Capture from');

{ # coverage; 2016-09-26
    my $à丧中갢𝐩à갢сò = \(42, [1, 2], %(:42a), :72a, :x[3, 4], :y{:42a}).antipairs;
    is-deeply ($à丧中갢𝐩à갢сò[0..2], $à丧中갢𝐩à갢сò[3..*].sort).flat,
    (
        42 => 0,        ([1, 2]) => 1, ({:a(42)}) => 2,
        ([3, 4]) => "x", 72 => "a",    ({:a(42)}) => "y",
    ), '.antipairs returns correct result';
}

# https://github.com/Raku/old-issue-tracker/issues/5587
# https://github.com/Raku/old-issue-tracker/issues/6133
{
    my $개1 = \(42);
    my $a = 42;
    my $개2 = \($a);
    cmp-ok $개1, &[eqv], $개2;
    cmp-ok $개1, {$^a !=== $^b}, $개2;
}

# https://github.com/Raku/old-issue-tracker/issues/6257
subtest 'non-Str-key Pairs in List' => {
    plan 3;
    quietly is-deeply (Mu => Any,).Capture, \(:Mu(Any)), '(Mu => Any,)';
    is-deeply (class {method Str {'foo'}} => 42,).Capture,
        \(:foo(42)), '( custom class => 432,)';

    # use a Hash as a proxy in expected, 'cause we don't know the sort order
    is-deeply (<10> => <20>, 30 => 40, 1.5 => 1.5).Capture,
        %('10' => <20>, '30' => 40, '1.5' => 1.5).Capture, 'numerics and allomorphs';
}

is-deeply .Capture, $_, 'Capture.Capture returns self',
    with do { my $a = 42; my $b := 70; (\($a, :$b)).Capture };

is-deeply .Capture, $_, 'Match.Capture returns self',
    with 'x'.match: /./;

subtest 'types whose .Capture throws' => {
    # https://irclog.perlgeek.de/perl6/2017-03-07#i_14221839
    plan 14;
    throws-like  { True  .Capture }, X::Cannot::Capture, 'Bool';
    throws-like  { 'x'   .Capture }, X::Cannot::Capture, 'Str';
    throws-like  { 42    .Capture }, X::Cannot::Capture, 'Int';

    throws-like  { 42e0  .Capture }, X::Cannot::Capture, 'Num';
    throws-like  { <42>  .Capture }, X::Cannot::Capture, 'IntStr';
    throws-like  { <42e0>.Capture }, X::Cannot::Capture, 'NumStr';

    throws-like  { -> $a, :$b {}.Capture }, X::Cannot::Capture, 'Callable';
    throws-like  { ((*)).Capture }, X::Cannot::Capture, 'Whatever';
    throws-like  { ((**)).Capture }, X::Cannot::Capture, 'HyperWhatever';

    throws-like  { ((*.so)).Capture }, X::Cannot::Capture, 'WhateverCode';
    throws-like  { :(\SELF: $a, :$b).Capture }, X::Cannot::Capture, 'Signature';
    throws-like  { (v42).Capture }, X::Cannot::Capture, 'Version';
    throws-like  { rx/./.Capture }, X::Cannot::Capture, 'Regex';

    subtest 'Failure' => {
        plan 3;

        throws-like { Failure.Capture }, X::Cannot::Capture, ':U';
        throws-like {
            given Failure.new { .so; .Capture }
        }, X::Cannot::Capture, 'handled';

        my class X::Meows is Exception {}
        throws-like { sub { X::Meows.new.fail }().Capture }, X::Meows,
            'unhandled';
    }
}

subtest 'types whose .Capture behaves like List.Capture' => {
    # Pair contents become nameds; rest become positionals;
    plan 18;

    is-deeply Blob.new(1, 2, 42).Capture, \(1, 2, 42), 'Blob';
    is-deeply Buf .new(1, 2, 42).Capture, \(1, 2, 42), 'Buf';
    is-deeply utf8.new(1, 2, 42).Capture, \(1, 2, 42), 'utf8';


    with Channel.new -> $개 {
        $개.send: $_ for |<a b c>, :42z;
        $개.close;
        is-deeply $개.Capture, \('a', 'b', 'c', :42z), 'Channel';
    }

    is-deeply .Capture, \('a', 'b', 'c', :42z), 'Supply'
        with supply { .emit for |<a b c>, :42z };

    is-deeply (42, :42a).Seq.Capture, \(42, :42a), 'Seq';
    is-deeply (42, :42a)    .Capture, \(42, :42a), 'List';
    is-deeply [42, :42a]    .Capture, \(42, :42a), 'Array';
    is-deeply Slip.new(42, :42a.Pair).Capture, \(42, :42a), 'Slip';

    is-deeply Map.new((:42a)).Capture, \(:42a), 'Map';
    is-deeply {:42a}.Capture, \(:42a), 'Hash';

    # Expected to stringify non-Str keys
    is-deeply :{42 => 70, <70> => 100, a => 42}.Capture,
        ("42" => 70, "70" => 100, :42a).Capture, 'Object Hash';

    # Expected to stringify non-Str keys
    is-deeply set(42, <70>).Capture,
        ("42" => True, "70" => True).Capture, 'Set';
    is-deeply SetHash.new(42, <70>).Capture,
        ("42" => True, "70" => True).Capture, 'SetHash';

    # Expected to stringify non-Str keys
    is-deeply bag('a', 'a',  'b', 42, <70>, <70>).Capture,
        (:2a, :1b, "42" => 1, "70" => 2).Capture, 'Bag';
    is-deeply BagHash.new('a', 'a',  'b', 42, <70>, <70>).Capture,
        (:2a, :1b, "42" => 1, "70" => 2).Capture, 'BagHash';

    # Expected to stringify non-Str keys
    is-deeply mix('a', 'a',  'b', 42, <70>, <70>).Capture,
        (:2a, :1b, "42" => 1, "70" => 2).Capture, 'Bag';
    is-deeply MixHash.new('a', 'a',  'b', 42, <70>, <70>).Capture,
        (:2a, :1b, "42" => 1, "70" => 2).Capture, 'BagHash';
}

subtest 'types whose .Capture behaves like Mu.Capture' => {
    # Here we specifically test only the contents we know about, in case
    # in the future we add more attributes to these objects...
    plan 17;
    sub 両àò-丧àìe̲𝐝ò (\what, %wanted, Str:D $desc = what.^name) {
        subtest "$desc.Capture has named argument..." => {
            plan +%wanted;
            my %両àò = what.Capture.Hash;
            is-deeply %両àò{.key}, .value, .key for %wanted;
        }
    }

    (1..^Inf).&両àò-丧àìe̲𝐝ò:
      %(:1min, :max(Inf), :excludes-max, :!excludes-min, :!is-int);

            <42+1i>.&両àò-丧àìe̲𝐝ò: %(:re(42e0), :im(1e0));
          < 42+1i >.&両àò-丧àìe̲𝐝ò: %(:re(42e0), :im(1e0));
              <1/2>.&両àò-丧àìe̲𝐝ò: %(:1numerator, :2denominator);
            < 1/2 >.&両àò-丧àìe̲𝐝ò: %(:1numerator, :2denominator);
    FatRat.new(1,2).&両àò-丧àìe̲𝐝ò: %(:1numerator, :2denominator);

    do { try +'x'; $! }.&両àò-丧àìe̲𝐝ò: %(:source<x>);
    :42foo.&両àò-丧àìe̲𝐝ò: %(:key<foo>, :42value), 'Pair';

    DateTime.new(|$_).&両àò-丧àìe̲𝐝ò: $_ with %(:2015year, :12month, :25day);
        Date.new(|$_).&両àò-丧àìe̲𝐝ò: $_ with %(:2015year, :12month, :25day);

    Duration.new(42).&両àò-丧àìe̲𝐝ò: %(:tai(42.0));

    DateTime.new(:2015year).Instant.&両àò-丧àìe̲𝐝ò: %(:tai(1420070435.0));

#?rakudo.js skip 'sleep will not work on single threaded JavaScript'
#?DOES 3
{
    (start {sleep .5}).&両àò-丧àìe̲𝐝ò: %(:status(PromiseStatus::Planned));
    .&両àò-丧àìe̲𝐝ò: %(:path(.path), :CWD(.CWD)) with make-temp-file;
    .&両àò-丧àìe̲𝐝ò: %(:command(.command), :exitcode(.exitcode), :signal(.signal))
        with run «"$*EXECUTABLE" -e ' '»;
}

#?rakudo.js.browser skip 'opening temporary files does not work in the browser'
#?DOES 2
{
    with %(:chomp, :encoding("utf8"), :nl-out("\n")) {
        make-temp-file.open(:w).&両àò-丧àìe̲𝐝ò: $_;
        IO::CatHandle.new(make-temp-file :content<foo>).&両àò-丧àìe̲𝐝ò: $_;
    }
}

}

# Capture duplicate named elimination.
{
    # These may in future versions warn, but should still work
    CONTROL { when CX::Warn { .resume } }
    is-deeply \(:a(41), :a(42)), \(:a(42)),
        'Duplicate named arguments are eliminated';
    my $개 = 2;
    is-deeply \(:a($개--), :a($개*=5)), \(:a(5)),
        'Eliminated named argument side-effect kept';
    # This keeps implementations from getting lazy about where
    # they flatten any Slips they may have used to keep side effects
    $개 = 2;
    my sub е (*%c) { %c.kv };
    is-deeply е(:a($개--), :a($개*=5)), ("a", 5).Seq,
        'Eliminated named argument with named-only passing';
}

isnt class :: is Capture { }.new.WHICH, \().WHICH,
  'captures and instances of subclasses of Capture do not have the same WHICH';

lives-ok {
    [].Capture.<foo>:exists
}, 'can call EXISTS-KEY on captures w/o a concrete %!hash';

# vim: expandtab shiftwidth=4
