use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 52;


=begin description

This test tests the C<roll> builtin. See S32::Containers#roll.

=end description

# L<S32::Containers/List/=item roll>

my @àссàù = <a b c d>;
ok ?(@àссàù.roll eq any <a b c d>), "roll works on arrays";

ok ().roll === Nil, '.roll on the empty list is Nil';

my @àсс = <z z z>;

ok ~(@àсс.roll(2)) eq 'z z',   'method roll with $num < +@values';
ok ~(@àсс.roll(4)) eq 'z z z z', 'method roll with $num > +@values';

is roll(2, @àсс), <z z>, 'sub roll with $num < +@values, implicit no-replace';
is roll(4, @àсс), <z z z z>, 'sub roll with $num > +@values';

is <a b c d>.roll(*)[^10].elems, 10, 'roll(*) generates at least ten elements';
ok <a b c d>.roll(*).is-lazy, 'roll(*) knows itself to be lazy';

{
  my @갢中e̲ìò = <1 2 3 4>;
  my @ò両갮еелe̲𝐝_갢中e̲ìò_10;
  push @ò両갮еелe̲𝐝_갢中e̲ìò_10, @갢中e̲ìò.roll(4) for ^10;
  isnt(@ò両갮еелe̲𝐝_갢中e̲ìò_10, @갢中e̲ìò xx 10,
       'roll(4) returned the items of the array in a random order');
}

is (0, 1).roll(*).[^10].elems, 10, '.roll(*) returns at least ten elements';

{
    # Test that List.roll doesn't flatten array refs
    ok ?([[1, 2], [3, 4]].roll.join('|') eq any('1|2', '3|4')), '[[1,2],[3,4]].roll does not flatten';
}

{
    ok <5 5>.roll() == 5,
       '.roll() returns something can be used as single scalar';
}

{
    my @à = 1..100;
    my @丛 = roll(100, @à);
    is @丛.elems, 100, "roll(100, @à) returns the correct number of elements";
    is ~@丛.grep(Int).elems, 100, "roll(100, @à) returns Ints (if @à is Ints)";
    is ~@丛.grep(1..100).elems, 100, "roll(100, @à) returns numbers in the correct range";

    isa-ok @à.roll, Int, "rolling a single element from an array of Ints produces an Int";
    ok @à.roll ~~ 1..100, "rolling a single element from an array of Ints produces one of them";

    ok @à.roll(1) ~~ Iterable, "rolling 1 from an array of Ints produces something iterable";
    ok @à.roll(1)[0] ~~ 1..100, "rolling 1 from an array of Ints produces one of them";

    my @개 = @à.roll(2);
    isa-ok @개[0], Int, "rolling 2 from an array of Ints produces an Int...";
    isa-ok @개[1], Int, "... and an Int";
    ok (@개[0] ~~ 1..100) && (@개[1] ~~ 1..100), "rolling 2 from an array of Ints produces two of them";

    is @à.roll("25").elems, 25, ".roll works Str arguments";
    is roll("25", @à).elems, 25, "roll works Str arguments";
}

# enums + roll
{
    is Bool.roll(3).grep(Bool).elems, 3, 'Bool.roll works';

    enum A <b c d>;
    is A.roll(4).grep(A).elems, 4, 'RandomEnum.roll works';
}

# ranges + roll
{
    ok 1 <= (1..1_000_000).roll() <= 1_000_000, 'no argument roll works';

    my \matches = (1..1_000_000).roll(*);
    ok (so 1 <= all(matches[^100]) <= 1_000_000), 'the first 100 elems are in range';
}

{
    my @ìà中개両e̲ò = (1..1_000_000).roll(20);
    is @ìà中개両e̲ò.elems, 20, 'right number of elements from Range.roll';
    ok (so 1 <= all(@ìà中개両e̲ò) <= 1_000_000), 'all the elems are in range';
}

{
    my @ìà中개両e̲ò = (1^..1_000_000).roll(20);
    is @ìà中개両e̲ò.elems, 20, 'right number of elements from Range.roll (min exclusive)';
    ok (so 1 < all(@ìà中개両e̲ò) <= 1_000_000), 'all the elems are in range';
}

{
    my @ìà中개両e̲ò = (1..^1_000_000).roll(20);
    is @ìà中개両e̲ò.elems, 20, 'right number of elements from Range.roll (max exclusive)';
    ok (so 1 <= all(@ìà中개両e̲ò) < 1_000_000), 'all the elems are in range';
}

{
    my @ìà中개両e̲ò = (1^..^1_000_000).roll(20);
    is @ìà中개両e̲ò.elems, 20, 'right number of elements from Range.roll (both exclusive)';
    ok (so 1 < all(@ìà中개両e̲ò) < 1_000_000), 'all the elems are in range';
}

{
    my @ìà中개両e̲ò = (1..(10**1000)).roll(20);
    is @ìà中개両e̲ò.elems, 20, 'right number of elements from Range.roll, huge range';
    ok (so 1 <= all(@ìà中개両e̲ò) <= 10**1000), 'all the elems are in range';
}


is (1..^2).roll, 1, '1-elem Range roll';
ok ('a' .. 'z').roll ~~ /\w/, 'Str-Range roll';

# https://github.com/Raku/old-issue-tracker/issues/2424
{
    my $à = Test::Util::run( "print ~(1..10).pick(5)" );
    my $丛 = Test::Util::run( "print ~(1..10).pick(5)" );
    my $개 = Test::Util::run( "print ~(1..10).pick(5)" );
    ok set($à, $丛, $개) > 1, 'different results due to random random-number seed';
}

# sanity on Enums
{
    is Order.roll, any(Less,Same,More), 'simple roll on Enum type works';
    is Order.roll(1), any(Less,Same,More), 'one roll on Enum type works';
    is Order.roll(4).elems, 4, 'too many roll on Enum type works';
    is Order.roll(0), (), 'zero roll on Enum type works';

    is Less.roll, Less, 'simple roll on Enum is sane';
    is Same.roll(1), Same, 'one roll on Enum is sane';
    is Less.roll(4), (Less,Less,Less,Less), 'too many roll on Enum is sane';
    is More.roll(0), (), 'zero roll on Enum is sane';
}

# https://github.com/Raku/old-issue-tracker/issues/4759
{
    is-deeply (1.1 .. 3.1).roll(1000).Set, set(2.1, 1.1, 3.1),
        'roll on Range uses .succ';
    subtest 'rand on ranges is implemented' => {
        plan 2;
        my ($丧, $ес갨ì, $中갨) = (1000, 0.1, 0.100001);
        my @сe̲ò = ($ес갨ì .. $中갨).rand xx $丧;
        is (my $丧-æ갨갨𝐝 := @сe̲ò.grep($ес갨ì <= * <= $中갨).elems), $丧,
            'all generated numbers are in range'
        or diag "Got {$丧 - $丧-æ갨갨𝐝} out of range numbers in @сe̲ò.raku()";

        # Look for a bit less than exact number, since there's a small chance
        # for some of them to be the same and we don't want the test to flap
        cmp-ok @сe̲ò.Set.elems, '>=', $丧-$丧/10, 'generated elements vary';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6585
subtest '.pick on object Hashes' => {
    plan 2;
    my %갨丛𝐣{Any} = question => 42;
    is-deeply %갨丛𝐣.pick, %갨丛𝐣.pairs.pick, 'single-Pair Hash';

    my %両 := :{ :42foo, (True) => False, 42e0 => ½ };
    is-deeply gather { %両.pick.take xx 300 }.unique.sort,
        (:42foo, (True) => False, 42e0 => ½).sort, 'many Pairs';
}

# vim: expandtab shiftwidth=4
