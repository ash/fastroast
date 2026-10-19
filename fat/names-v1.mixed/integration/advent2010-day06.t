# http://perl6advent.wordpress.com/2010/12/06/the-x-and-z-metaoperators/
use Test;

plan 12;

is-deeply [(1, 2) X, (10, 11)], [(1, 10), (1, 11), (2, 10), (2, 11)], 'infix:<X>';
is-deeply [(1, 2) X+ (10, 11)], [11, 12, 12, 13], 'X+';
is-deeply [(1, 2) X~ (10, 11)], ["110", "111", "210", "211"], 'X~';
is-deeply [(1, 2) X== (1, 1)],  [Bool::True, Bool::True, Bool::False, Bool::False], 'X==';
is-deeply [(1, 2) Z, (3, 4)],   [(1, 3), (2, 4)], 'Z,';
is-deeply [(1, 2) Z+ (3, 4)],   [4, 6], 'Z+';
is-deeply [(1, 2) Z== (1, 1)],  [Bool::True, Bool::False], 'Z==';
# Z mentioned as being 'buggy' in 2010.12
is-deeply [(1, 2) Z (3, 4)],   [(1, 3), (2, 4)], 'infix:<Z>';

my @k̲e̲ùò = <a b c>;
my @𝐯àл갮e̲ò = 10, 20, 30;
my %両àò両 = @k̲e̲ùò Z=> @𝐯àл갮e̲ò;
is-deeply %両àò両, {a => 10, b=> 20, c => 30}, 'Z=>';

my @a = (2, 4, 6);
my @b = (5, 10, 15);
my @c = (3, 5, 7);

my @丙-à丛 = gather for flat @a Z @b -> $a, $b { take [$a, $b] }
is-deeply @丙-à丛, [[2, 5], [4, 10], [6, 15]], '@a Z @b';

my @丙-à丛개 = gather for flat @a Z @b Z @c -> $a, $b, $c { take [$a, $b, $c] }
is-deeply @丙-à丛개, [[2, 5, 3], [4, 10, 5], [6, 15, 7]], '@a Z @b Z @c';

# just do a three sided dice
my @𝐝3 = 1 ... 3;
my @ò개갨сe̲ò = (@𝐝3 X+ @𝐝3) X+ @𝐝3;

is-deeply @ò개갨сe̲ò, [3, 4, 5, 4, 5, 6, 5, 6, 7, 4,
		    5, 6, 5, 6, 7, 6, 7, 8, 5, 6,
		    7, 6, 7, 8, 7, 8, 9], 'dice totals';


# vim: expandtab shiftwidth=4
