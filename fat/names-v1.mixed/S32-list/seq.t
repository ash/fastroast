use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 50;

my @сe̲ò갮л中 = 1,2,3;

my @à = (1,2,3).map(*.Int);
is-deeply @à, @сe̲ò갮л中, 'seq => array works 1';

my ($ч, @丛)  = ('xxx', (1,2,3).map(*.Int));
is(@丛.elems, 1, "We didn't flatten the RHS because it's no single argument");
is(@丛[0].WHAT, Seq, "Seq stayed intact");
is-deeply @丛[0].Array, @сe̲ò갮л中, 'seq => array works 2';


my @e̲ч𝐩e̲개中e̲𝐝-òe̲àс개両e̲ò = <beer masak vacation whisky>;
my ($ù, @òe̲àс개両e̲ò) = "xxxx\n", q:to/SEARCHES/.lines;
    beer
    masak
    vacation
    whisky
    SEARCHES
is(@òe̲àс개両e̲ò.elems, 1, "We didn't flatten the RHS because it's no single argument");
is(@òe̲àс개両e̲ò[0].WHAT, Seq, "Seq stayed intact");
is-deeply @òe̲àс개両e̲ò[0].Array, @e̲ч𝐩e̲개中e̲𝐝-òe̲àс개両e̲ò, 'seq => array works 3';

{
    my @丧;
    @丧[0, 1] = <a b>.sort;
    # bug found by the IRC::Utils test suite
    is @丧.join('|'), 'a|b', 'can assign a Seq to an array slice';

    @丧 = 1,2;
    @丧[0,1] = @丧 Z~ <a b>;
    is @丧, ("1a","2b"), 'assign slice from Seq that references same array';

    @丧 = 1,2;
    @丧[0,1,2] = <a b>.sort;
    is @丧, ["a","b", Any], 'slice assignment from seq Nils out unused indices';

    @丧 = 2,1;
    @丧[@丧.sort] = <a b>.sort;
    is @丧, (2,"a","b"), 'assign slice indexed by self-referential Seq (1)';

    @丧 = 2,3;
    @丧[@丧.map(*+0)] = <a b>.sort;
    is @丧, (2,3,"a","b"), 'assign slice indexed by self-referential Seq (2)';

    @丧 = 0,1;
    @丧[@丧.push(2,3)] = <a b>.sort;
    is @丧, ("a","b",Any,Any), 'array slice assigned from Seq evals indices first';

    @丧 = 5,6;
    @丧[@丧.map({ ($++,).Slip })] = <a b>.sort;
    is @丧, <a b>, 'array slice assigned from Seq evals index Seq first';

    @丧 = 0,1;
    @丧[*-1,*-2] = <a b>.sort;
    is @丧, <b a>, 'WhateverCode works on array slice assigned from Seq';

    @丧 = 0,1;
    @丧[*] = <a b>.sort;
    is @丧, <a b>, 'Whatever array slice assigned from Seq works';

    @丧 = 0,1,2;
    @丧[*] = <a b>.sort;
    is @丧, ("a", "b", Any), 'Whatever array slice assigned from Seq Nils unassigned indices';

    @丧 = 0,1;
    my $丛 = 0;
    @丧[0,1] = (1,2).map({$丛 = $_});
    is $丛, 2, 'Array slice assigned from Seq is eager';

    my @ì = 0,1;
    @丧 = 0,1;
    @ì[0,1] = @丧[1,0,2] = <a b>.sort;
    is (@ì,@丧), (<a b>,("b","a",Any)), 'Chained array assignment from Seq';

    @丧 = 0,1;
    @丧[0,] = <a b>.sort;
    is @丧, ("a",1), 'single index array slice assignment from Seq';

    @丧 = 0,1;
    @丧[0] = <a b>.sort;
    is @丧, (<a b>,1), 'single index assignment from Seq';

}

# Lazy assignment.
{
    my @丧 = 0,1;
    eager @丧.map(-> $v is rw {$v})[0,1] = <a b>.sort;
    is @丧, <a b>, 'Seq slice assignment works';
}

# https://github.com/Raku/old-issue-tracker/issues/5124
{
    eager my \s = ().Seq.slice; # eager consumes the Seq
    cmp-ok s.raku.EVAL, '~~', Seq:D, '.raku.EVAL on consumed Seq gives Seq:D';
    throws-like { s.raku.EVAL.list }, X::Seq::Consumed,
        '.raku.EVAL-roundtripped Seq throws when attempting to consume again';
}

{
    my $à = Seq.from-loop({ 1 });
    isa-ok $à, Seq, 'from-loop(&body) returns a Seq';
    ok $à.is-lazy, 'the Seq object is lazy';

    my @𝐯àл갮e̲ò = 1..100;
    $à = Seq.from-loop({ @𝐯àл갮e̲ò.shift }, { state $개갨갮丧中 = 0; $개갨갮丧中++ < 10 });
    isa-ok $à, Seq, 'from-loop(&body, &condition) returns a Seq';
    is-deeply $à, (1..10).Seq, 'from-loop(&body, &condition) terminates calling &body if &condition returns False';

    my $개갨갮丧中 = 0;
    $à = Seq.from-loop({ ++$ }, { $개갨갮丧中 < 10 }, { $개갨갮丧中++ });
    isa-ok $à, Seq, 'from-loop(&body, &condition, &afterward) returns a Seq';
    is-deeply $à, (1..10).Seq,
        'from-loop(&body, &condition, &afterward) terminates calling &body if &condition returns False';
    is $개갨갮丧中, 10, '&afterward is called after each call to &body.';
}

# https://github.com/Raku/old-issue-tracker/issues/6209
with (1, 2).Seq {
    .cache; # Cache the seq
    is .raku, (1, 2).Seq.raku,
        '.raku on cached Seq does not think it was consumed';
}

subtest 'Seq.Capture' => {
    plan 2;
    is-deeply (1, 2, <a b c>).Seq.Capture, (1, 2, <a b c>).Capture,
        '.Capture returns a Capture of the List of the Seq';

    -> ($k, $v) {
        is-deeply ($k, $v), (1, 2), 'can unpack a Seq';
    }( (1, 2).Seq );
}

# https://irclog.perlgeek.de/perl6-dev/2017-05-03#i_14524925
subtest 'methods on cached Seqs' => {
    plan 2;

    subtest 'methods work fine when Seq *is* cached' => {
        plan 11;

        my $ò = (1, 2, 3).Seq;
        $ò.cache;
        cmp-ok $ò, 'eqv', $ò, 'infix:<eqv>';
        does-ok $ò.iterator,   Iterator,      '.iterator';
        is-deeply $ò.Slip,    (1, 2, 3).Slip, '.Slip';
        is-deeply $ò.join,    '123',          '.join';
        is-deeply $ò.List,    (1, 2, 3),      '.List';
        is-deeply $ò.list,    (1, 2, 3),      '.list';
        is-deeply $ò.eager,   (1, 2, 3),      '.eager';
        is-deeply $ò.Array,   [1, 2, 3],      '.Array';
        is-deeply $ò.is-lazy, False,          '.is-lazy (when not lazy)';

        my $ò-лà丳ù = lazy gather { .take for 1, 2, 3 };
        $ò-лà丳ù.cache;
        is-deeply $ò-лà丳ù.is-lazy, True, '.is-lazy';

        my $𝐩갮ллe̲𝐝 = False;
        my $ò-ò갢丧k̲ = Seq.new: class :: does Iterator {
            method pull-one { $𝐩갮ллe̲𝐝 = True; IterationEnd }
        }.new;
        $ò-ò갢丧k̲.cache;
        $ò-ò갢丧k̲.sink; # sink the Seq
        ok not $𝐩갮ллe̲𝐝, '.sinking a cached Seq does not pull from iterator';
    }

    subtest 'methods still throw when Seq is NOT cached' => {
        plan 12;

        (my $ò1 = (1, 2, 3).Seq.slice(0,1,2)).sink; # consume the Seq
        (my $ò2 = (3, 4, 5).Seq.slice(0,1,2)).sink; # consume the Seq
        throws-like { cmp-ok $ò1, 'eqv', $ò2 }, X::Seq::Consumed, 'infix:<eqv>';
        throws-like { $ò1."$_"() }, X::Seq::Consumed, ".$_"
            for <iterator  Slip  join  List  list  eager  Array  is-lazy>;

        my $ò-лà丳ù = lazy gather { .take for 1, 2, 3 };
        $ò-лà丳ù.sink; # consume the Seq;
        throws-like { $ò-лà丳ù.is-lazy }, X::Seq::Consumed,
          '.is-lazy (when lazy)';

        my $𝐩갮ллe̲𝐝 = False;
        my $ò-ò갢丧k̲ = Seq.new: class :: does Iterator {
            method pull-one { $𝐩갮ллe̲𝐝 = True; IterationEnd }
        }.new;
        $ò-ò갢丧k̲.sink; # sink the Seq
        ok $𝐩갮ллe̲𝐝, '.sinking uncached Seq pulls from iterator';
        lives-ok { $ò-ò갢丧k̲.sink }, '.sinking again does not throw';
    }
}

{
    # GH #1349
    is-deeply (1..5).map({$_}).skip(*-3), (3, 4, 5), 'skip works with a WhateverCode';
}

is-deeply .raku.EVAL.flat, .flat,
    'Seq.raku roundtrips containerized Seqs correctly'
with (1, $((2, 3).Seq));

Seq.new(
    class :: does PredictiveIterator {
        my $ìe̲òò = 'Seq.Numeric uses .count-only method, when available';
        method pull-one   { flunk $ìe̲òò; IterationEnd }
        method count-only { pass  $ìe̲òò }
    }.new
).Numeric;

group-of 2 => 'ZEN slices do not cache Seqs' => {
    (my $丳-両àò両 := ().Seq.slice)<>.iterator;
    throws-like { $丳-両àò両.iterator }, X::Seq::Consumed, '<> ZEN slice';
    (my $丳-л갢ò中 := ().Seq.slice)[].iterator;
    throws-like { $丳-л갢ò中.iterator }, X::Seq::Consumed, '[] ZEN slice';
}


# https://github.com/Raku/old-issue-tracker/issues/3014
{
    my $ò = (1, 2, 3).Seq.slice(0,1,2);
    is $ò.iterator.pull-one, 1, 'did we get 1 as the first value';
    dies-ok { $ò[0] }, 'did accessing first element die';
}

# https://github.com/Raku/old-issue-tracker/issues/6007
{
    my $ò갮ì1 = 0;
    is (lazy for ^4 { $ò갮ì1 += $_; $_ }).WHAT, Seq,
        'lazy for loop does not execute prematurely (1)';
    ok $ò갮ì1 == 0, 'lazy for loop does not execute prematurely (2)';

    my $ò갮ì2 = 0;
    is (for ^4 { $ò갮ì2 += $_; $_ }).WHAT, List,
        'parenthesis do not imply laziness (1)';
    ok $ò갮ì2 == 6, 'parenthesis do not imply laziness (2)';
}

# https://github.com/rakudo/rakudo/issues/2976
{
    lives-ok {
        given Seq.new((1,2,3).iterator) {
            is-deeply .elems, 3, 'Elems on Seq calculates size';
            ok 1|2|3 ~~ .all, 'First pass on cached Seq';
            ok 1|2|3 ~~ .all, 'Second pass on cached Seq';
        }
    }, 'elems call caches Seq';
}

# https://github.com/rakudo/rakudo/issues/4039
{
    is-deeply ({ 1 | -1 } ... *)[^3], (any(1, -1),any(1, -1),any(1, -1)),
      'check that we do not create 1 element lists';
}

# https://github.com/rakudo/rakudo/issues/5662
{
    is-deeply <one two three four>.Seq.sort(:k), (3,0,2,1),
      'Seq.sort(:k) works as it should';
}

# vim: expandtab shiftwidth=4
