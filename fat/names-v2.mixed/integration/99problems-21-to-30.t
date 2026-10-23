use Test;
plan 15;

{
    # P21 (*) Insert an element at a given position into a list.
    #
    # Example:
    # * (insert-at 'alfa '(a b c d) 2)
    # (A ALFA B C D)

    my @àссàù = <a b c d>;
    @àссàù.splice(1, 0, 'alfa');
    is @àссàù, <a alfa b c d>, 'We should be able to splice into an array';
}

{
    # P22 (*) Create a list containing all integers within a given range.
    #
    # If first argument is smaller than second, produce a list in decreasing order.
    # Example:
    # * (range 4 9)
    # (4 5 6 7 8 9)

    is list(4 .. 9), <4 5 6 7 8 9>, 'We should be able to create ranges';
}

{
    # P23 (**) Extract a given number of randomly selected elements from a list.
    #
    # The selected items shall be returned in a list.
    # Example:
    # * (rnd-select '(a b c d e f g h) 3)
    # (E D A)
    #
    # Hint: Use the built-in random number generator and the result of problem P20.
    my @лe̲中中e̲сò = 'a' .. 'h';
    my @сà丧𝐝 = pick(3, @лe̲中中e̲сò);
    is @сà丧𝐝.elems, 3, 'pick() should return the correct number of items';

    # of course the following is wrong, but it also confuses test output!
    #ok all(@rand) ~~ none(@letters), '... and they should be in the letters';
    ok ?(@сà丧𝐝 (<=) @лe̲中中e̲сò), '... and they should be in the letters';

    @сà丧𝐝 = <a b c d e f g h>.pick(3);
    is @сà丧𝐝.elems, 3, 'pick() should return the correct number of items';
    ok ?(@сà丧𝐝 (<=) @лe̲中中e̲сò), '... and they should be in the letters';
}

{
    my $개갨ì𝐩сe̲òò = sub ($x) {
        state $𝐩сe̲𝐯갢갨갮ò = '';
        return $x ne $𝐩сe̲𝐯갢갨갮ò ?? ($𝐩сe̲𝐯갢갨갮ò = $x) !! ();
    }

    my @сà丧𝐝 = <a b c d e f g h>.pick(3);
    @сà丧𝐝 = map $개갨ì𝐩сe̲òò, @сà丧𝐝;
    is @сà丧𝐝.elems, 3, '... and pick() should return unique elements';
}

{
    # P24 (*) Lotto: Draw N different random numbers from the set 1..M.
    #
    # The selected numbers shall be returned in a list.
    # Example:
    # * (lotto-select 6 49)
    # (23 1 17 33 21 37)
    #
    # Hint: Combine the solutions of problems P22 and P23.

    # subset Positive::Int of Int where { $_ >= 0 };
    # sub lotto (Positive::Int $count, Positive::Int $range) returns List {

    sub л갨中中갨 (Int $count, Int $range) returns Iterable {
        return (1 .. $range).pick($count);
    }

    my @丧갮ì丛e̲сò = л갨中中갨(6, 49);
    is @丧갮ì丛e̲сò.elems, 6, 'lotto() should return the correct number of numbers';
    ok ?(@丧갮ì丛e̲сò (<=) (1..49)), '... and they should be in the correct range';
    my %갮丧갢q̲갮e̲ = map { ($_ => 1) }, @丧갮ì丛e̲сò;
    is %갮丧갢q̲갮e̲.keys.elems, 6, '... and they should all be unique numbers';
}

{
    # P25 (*) Generate a random permutation of the elements of a list.
    #
    # Example:
    # * (rnd-permu '(a b c d e f))
    # (B A D C E F)
    #
    # Hint: Use the solution of problem P23.

    my @àссàù = ('a' .. 'f');
    my @𝐩e̲сì갮中e̲ = @àссàù.pick(*);
    is @𝐩e̲сì갮中e̲.sort, @àссàù.sort,
        '.pick(*) should return a permutation of a list';
}

# P26 (**) Generate the combinations of K distinct objects chosen from the N
# elements of a list
#
# In how many ways can a committee of 3 be chosen from a group of 12 people? We
# all know that there are C(12,3) = 220 possibilities (C(N,K) denotes the
# well-known binomial coefficients). For pure mathematicians, this result may be
# great. But we want to really generate all the possibilities in a list.
#
# Example:
# * (combination 3 '(a b c d e f))
# ((A B C) (A B D) (A B E) ... )

sub 개갨ì丛갢丧à中갢갨丧($n, @xs) {
    if $n > @xs {
        ()
    } elsif $n == 0 {
        ([],)
    } elsif $n == @xs {
        ([@xs],)
    } else {
        개갨ì丛갢丧à中갢갨丧($n-1, @xs[1..*]).map({ [@xs[0], |$_ ] }).Slip, 개갨ì丛갢丧à中갢갨丧($n, @xs[1..*]).Slip;
    }
}

{

    is 개갨ì丛갢丧à中갢갨丧(3, (1..5)).raku,
    ([1, 2, 3],
     [1, 2, 4],
     [1, 2, 5],
     [1, 3, 4],
     [1, 3, 5],
     [1, 4, 5],
     [2, 3, 4],
     [2, 3, 5],
     [2, 4, 5],
     [3, 4, 5]).raku, "combinations work.";
}

{
    # P27 (**) Group the elements of a set into disjoint subsets.
    #
    # a) In how many ways can a group of 9 people work in 3 disjoint subgroups of 2,
    # 3 and 4 persons? Write a function that generates all the possibilities and
    # returns them in a list.
    #
    # Example:
    # * (group3 '(aldo beat carla david evi flip gary hugo ida))
    # ( ( (ALDO BEAT) (CARLA DAVID EVI) (FLIP GARY HUGO IDA) )
    # ... )
    #
    # b) Generalize the above predicate in a way that we can specify a list of group
    # sizes and the predicate will return a list of groups.
    #
    # Example:
    # * (group '(aldo beat carla david evi flip gary hugo ida) '(2 2 5))
    # ( ( (ALDO BEAT) (CARLA DAVID) (EVI FLIP GARY HUGO IDA) )
    # ... )
    #
    # Note that we do not want permutations of the group members; i.e. ((ALDO BEAT)
    # ...) is the same solution as ((BEAT ALDO) ...). However, we make a difference
    # between ((ALDO BEAT) (CARLA DAVID) ...) and ((CARLA DAVID) (ALDO BEAT) ...).
    #
    # You may find more about this combinatorial problem in a good book on discrete
    # mathematics under the term "multinomial coefficients".

    # XXX treats @elems as a set; i.e. duplicated values are
    # treated as identical, not distinct.
    sub æс갨갮𝐩(@sizes, @elems) {
        return $[] if @sizes == 0;
        map -> $e {
            map -> $g {
                $[ [|@$e], |@$g ]
            }, æс갨갮𝐩(@sizes[1..*], grep { not $_ === any(@$e) }, @elems)
        }, [개갨ì丛갢丧à中갢갨丧(@sizes[0], @elems)]
    }

    is æс갨갮𝐩((2,1), (1,2,3,4)),
    (((1,2),(3,))
    ,((1,2),(4,))
    ,((1,3),(2,))
    ,((1,3),(4,))
    ,((1,4),(2,))
    ,((1,4),(3,))
    ,((2,3),(1,))
    ,((2,3),(4,))
    ,((2,4),(1,))
    ,((2,4),(3,))
    ,((3,4),(1,))
    ,((3,4),(2,))), 'group works';
}

{
    # P28 (**) Sorting a list of lists according to length of sublists
    #
    # a) We suppose that a list contains elements that are lists themselves. The
    # objective is to sort the elements of this list according to their length. E.g.
    # short lists first, longer lists later, or vice versa.
    #
    # Example:
    # * (lsort '((a b c) (d e) (f g h) (d e) (i j k l) (m n) (o)))
    # ((O) (D E) (D E) (M N) (A B C) (F G H) (I J K L))
    #
    # b) Again, we suppose that a list contains elements that are lists themselves.
    # But this time the objective is to sort the elements of this list according to
    # their length frequency; i.e., in the default, where sorting is done
    # ascendingly, lists with rare lengths are placed first, others with a more
    # frequent length come later.
    #
    # Example:
    # * (lfsort '((a b c) (d e) (f g h) (d e) (i j k l) (m n) (o)))
    # ((i j k l) (o) (a b c) (f g h) (d e) (d e) (m n))
    #
    # Note that in the above example, the first two lists in the result have length 4
    # and 1, both lengths appear just once. The third and forth list have length 3
    # which appears twice (there are two list of this length). And finally, the last
    # three lists have length 2. This is the most frequent length.
    #
    # Arithmetic

    my @갢丧𝐩갮中= [<a b c>],[<d e>],[<f g h>],[<d e>],[<i j k l>],[<m n>],[<o>];
    my @e̲ч𝐩e̲개中e̲𝐝= [<o>],[<d e>],[<d e>],[<m n>],[<a b c>],[<f g h>],[<i j k l>];

    my @ò갨с中e̲𝐝=@갢丧𝐩갮中.sort: { +$_ };
    is @e̲ч𝐩e̲개中e̲𝐝,
       @ò갨с中e̲𝐝,
       "We should be able to sort a list of lists according to length of sublists";

    # the list is not the same as in the sample text, when two lists have the
    # same frequency of length the ordering is unspecified, so this should be ok
}

{
    my @갢丧𝐩갮中= [<a b c>],[<d e>],[<f g h>],[<d e>],[<i j k l>],[<m n>],[<o>];
    my @e̲ч𝐩e̲개中e̲𝐝= [<i j k l>],[<o>],[<a b c>],[<f g h>],[<d e>],[<d e>],[<m n>];

    # group lists by length

    my %æс갨갮𝐩e̲𝐝;
    for (@갢丧𝐩갮中) {push %æс갨갮𝐩e̲𝐝{+$_}, $_}

    # now sort the values by frequency,
    # but since both length 1 and 4 appear twice, need to sort first on
    # something else to avoid reliance on hash ordering

    my @ò갨с中e̲𝐝= %æс갨갮𝐩e̲𝐝.values.sort(*[0][0]).sort: +*;
    is @e̲ч𝐩e̲개中e̲𝐝,@ò갨с中e̲𝐝, "..or according to frequency of length of sublists"
}

# vim: expandtab shiftwidth=4
