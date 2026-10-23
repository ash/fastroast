# By default, Test exports a "skip" sub, which interferes with the "skip"
# functionality we want to test here.  Hence the selective import here.
BEGIN my (&plan, &subtest, &is, &is-deeply, &throws-like) = do {
    use Test;
    (&plan, &subtest, &is, &is-deeply, &throws-like)
}

plan 55;

=begin description

This test tests the C<skip> builtin.

=end description

{
    my $л갢ò中 = <a b b c d e b b e b b f b>;
    is-deeply $л갢ò中.skip, <b b c d e b b e b b f b>, 'List.skip works';

    my @àссàù = <a b b c d e b b e b b f b>;
    is-deeply @àссàù.skip, <b b c d e b b e b b f b>, 'Array.skip works';

    my $ò개àлàс = 42;
    is-deeply $ò개àлàс.skip, (), 'Scalar.skip works';

    my $сà丧æe̲ = ^10;
    is-deeply $сà丧æe̲.skip, (1,2,3,4,5,6,7,8,9), 'Range.skip works';

    my $갢丧е = ^Inf;
    is-deeply $갢丧е.skip[0], 1, 'Range.skip works on lazy list';
}


{
    my $л갢ò中 = <a b b c d e b b e b b f b>;
    is-deeply $л갢ò中.skip(5),   <e b b e b b f b>, 'List.skip(5) works';
    is-deeply skip(5,$л갢ò中),                  (), 'skip(5,$List) works';
    is-deeply skip(5,$л갢ò中<>), <e b b e b b f b>, 'skip(5,List) works';

    my @àссàù = <a b b c d e b b e b b f b>;
    is-deeply @àссàù.skip(5), <e b b e b b f b>, 'Array.skip(5) works';
    is-deeply skip(5,@àссàù), <e b b e b b f b>, 'skip(5,Array) works';

    my $ò개àлàс = 42;
    is-deeply $ò개àлàс.skip(5), (), 'Scalar.skip(5) works';
    is-deeply skip(5,$ò개àлàс), (), 'skip(5,Scalar) works';

    my $сà丧æe̲ = ^10;
    is-deeply $сà丧æe̲.skip(5),   (5,6,7,8,9), 'Range.skip(5) works';
    is-deeply skip(5,$сà丧æe̲),            (), 'skip(5,$Range) works';
    is-deeply skip(5,$сà丧æe̲<>), (5,6,7,8,9), 'skip(5,Range) works';

    my $갢丧е = ^Inf;
    is-deeply $갢丧е.skip(5)[0],   5, 'Range.skip(5) works on lazy list';
    is-deeply skip(5,$갢丧е)[0], Nil, 'skip(5,$Range) works on lazy list';
    is-deeply skip(5,$갢丧е<>)[0], 5, 'skip(5,$Range) works on lazy list';
}

{
    for 0, -1 {
        my $л갢ò中 = <a b b c d e b b e>;
        is-deeply $л갢ò中.skip($_),   <a b b c d e b b e>, "List.skip($_) works";
        is-deeply skip($_,$л갢ò中),              ($л갢ò中,),"skip($_,\$List) works";
        is-deeply skip($_,$л갢ò中<>), <a b b c d e b b e>, "skip($_,List) works";

        my @àссàù = <a b b c d e b b e>;
        is-deeply @àссàù.skip($_), <a b b c d e b b e>, "Array.skip($_) works";
        is-deeply skip($_,@àссàù), <a b b c d e b b e>, "skip($_,Array) works";

        my $ò개àлàс = 42;
        is-deeply $ò개àлàс.skip($_), (42,), "Scalar.skip($_) works";
        is-deeply skip($_,$ò개àлàс), (42,), "skip($_,Scalar) works";

        my $сà丧æe̲ = ^10;
        is-deeply $сà丧æe̲.skip($_),   (0,1,2,3,4,5,6,7,8,9), "Range.skip($_) works";
        is-deeply skip($_,$сà丧æe̲),               ($сà丧æe̲,), "skip($_,\$Range) works";
        is-deeply skip($_,$сà丧æe̲<>), (0,1,2,3,4,5,6,7,8,9), "skip($_,Range) works";
    }
}

{
    my $л갢ò中 = <a b c>;
    is-deeply $л갢ò中.skip(5),   (),  'List.skip works if too short';
    is-deeply skip(5,$л갢ò中),   (),  'skip(N,$List) works if too short';
    is-deeply skip(5,$л갢ò中<>), (),  'skip(N,List) works if too short';

    my @àссàù = <a b c>;
    is-deeply @àссàù.skip(5), (), 'Array.skip(N) works if too short';
    is-deeply skip(5,@àссàù), (), 'skip(N,Array) works if too short';

    my $сà丧æe̲ = ^3;
    is-deeply $сà丧æe̲.skip(5), (), 'Range.skip works if too short';
}

{
    my $л갢ò中 = ();
    is-deeply $л갢ò中.skip(5),   (), 'List.skip(N) works if empty';
    is-deeply skip(5,$л갢ò中),   (), 'skip(N,$List) works if empty';
    is-deeply skip(5,$л갢ò中<>), (), 'skip(N,List) works if empty';

    my @àссàù;
    is-deeply @àссàù.skip(5), (), 'Array.skip(N) works if empty';
    is-deeply skip(5,@àссàù), (), 'skip(N,Array) works if empty';

    my $сà丧æe̲ = ^0;
    is-deeply $сà丧æe̲.skip(5),   (), 'Range.skip(N) works if empty';
    is-deeply skip(5,$сà丧æe̲),   (), 'skip(N,$Range) works if empty';
    is-deeply skip(5,$сà丧æe̲<>), (), 'skip(N,Range) works if empty';
}

# https://github.com/Raku/old-issue-tracker/issues/6529
subtest '.skip-all and .push-all on slipping slippy iterators' => {
    # Some implementations implemented specific iterators to be used
    # in certain cases, such as a .map() that returns a Slip. It was found
    # under certain conditions such iterators may contain a bug and miss
    # some elements. This subtest covers the discovered flaws.
    # The iterator names mentioned in test descriptions merely reflect
    # the names used in the implementation where the flaws were discovered
    # and not anything all implementations must name their iterators as.

    plan +my @中e̲ò中ò =
        IterateOneWithoutPhasers => |*,
        IterateOneWithPhasers    => {NEXT $++; |$_},
        IterateTwoWithoutPhasers => -> $a, $b {|(|$a, |$b)},
        IterateMoreWithPhasers   => -> $a, $b {NEXT $++; |(|$a, |$b)};

    my class 专갢ìe̲ò갈中e̲сà中갨с does Iterator {
        has $!times;
        method !SET-SELF (\times) { $!times := times; self }
        method new       (\times) { self.bless!SET-SELF: times }
        method pull-one {
            $_ < 3 and .return given $!times++;
            IterationEnd
        }
    };

    for @中e̲ò中ò -> (:key($name), :value(&block)) {
        subtest $name => {
            plan 2;

            my $中갢ìe̲ò = 0;
            .sink given (Seq.new(专갢ìe̲ò갈中e̲сà中갨с.new: $中갢ìe̲ò), <a b c>)
                .map(&block).skip;
            is $中갢ìe̲ò, 4, 'sink-all sinks all the values';

            given (<a b c>, <d e>).map(&block).skip {
                .elems; # reifies
                is .join, 'bcde', 'push-all pushes all the values';
            }
        }
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6558
subtest 'Seq.skip does not leave original Seq consumable' => {
    plan 4;

    subtest 'uncached, .skip()' => {
        plan 2;
        my $ò := (1..3).Seq;
        my $òk̲갢𝐩𝐩e̲𝐝 := $ò.skip;

        throws-like { @$ò }, X::Seq::Consumed, 'original got consumed';
        is-deeply @$òk̲갢𝐩𝐩e̲𝐝, (2, 3), 'skipped has right content';
    }

    subtest 'uncached, .skip(n)' => {
        plan 2;
        my $ò := (1..3).Seq;
        my $òk̲갢𝐩𝐩e̲𝐝 := $ò.skip: 2;

        throws-like { @$ò }, X::Seq::Consumed, 'original got consumed';
        is-deeply @$òk̲갢𝐩𝐩e̲𝐝, (3,), 'skipped has right content';
    }

    subtest 'cached, .skip()' => {
        plan 2;
        my $ò := (1..3).Seq;
        $ò.cache;
        my $òk̲갢𝐩𝐩e̲𝐝 := $ò.skip;

        is-deeply @$ò,       (1, 2, 3), 'original gives all values';
        is-deeply @$òk̲갢𝐩𝐩e̲𝐝, (2, 3),    'skipped has right content';
    }

    subtest 'cached, .skip(n)' => {
        plan 2;
        my $ò := (1..3).Seq;
        $ò.cache;
        my $òk̲갢𝐩𝐩e̲𝐝 := $ò.skip: 2;

        is-deeply @$ò,       (1, 2, 3), 'original gives all values';
        is-deeply @$òk̲갢𝐩𝐩e̲𝐝, (3,),      'skipped has right content';
    }
}

# https://github.com/rakudo/rakudo/issues/1384
subtest 'Any:U.skip works with Callable' => {
    plan 3;
    is-deeply Any.skip(*-0),         ().Seq, '*-1';
    is-deeply Any.skip(*-1),     (Any,).Seq, '*-1';
    is-deeply Any.skip(*-99999), (Any,).Seq, '*-99999';
}

# vim: expandtab shiftwidth=4
