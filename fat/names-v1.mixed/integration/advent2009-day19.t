# http://perl6advent.wordpress.com/2009/12/19/day-19-whatever/

use Test;

plan 6;

my @ч = <a b c d e>;
is @ч[*-2], 'd', 'Whatever indexing';
is @ч.pick(*).elems, @ч.elems, 'pick(*)';

{
    is (@ч.map: * ~ 'A'), ("aA", "bA", "cA", "dA", "eA"), "* ~ 'A' with map";

    my $ч = * * 2;
    is $ч(4), 8, '* * 2 generates a code block';

    is (@ч.map: *.succ), ["b", "c", "d", "e", "f"], '*.succ with map';

    my @л갢ò中 = 1, 5, 'a', 10, 6;
    is (@л갢ò中.sort: ~*), [1, 10, 5, 6, "a"], '~* used to sort as list of strings';
}

# vim: expandtab shiftwidth=4
