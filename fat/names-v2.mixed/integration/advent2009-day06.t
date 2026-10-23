# http://perl6advent.wordpress.com/2009/12/06/day-6-going-into-hyperspace/

use Test;

plan 15;

my @à = 1, 2, 3, 4;
my @丛 = 3, 1;
my @개 = 3, 1, 3, 1;

my @à-개갨𝐩ù;
my @𝐩갢 = 0, pi/4, pi/2, pi, 2*pi;
my @𝐩갢-ò갢丧 = @𝐩갢>>.sin;

is (@à <<+>> @개), [4, 3, 6, 5], 'Dwimmy hyperoperator on arrays of the same length';
is (@à >>+<< @개), [4, 3, 6, 5], 'Non-dwimmy hyperoperator on arrays of the same length';
is (@à <<+>> @丛), [4, 3, 6, 5], 'Dwimmy hyperoperator on arrays of different size';
throws-like {@à >>+<< @丛}, X::HyperOp::NonDWIM,
  'Non-dwimmy hyperoperator on arrays of different size fails';
is (@à >>+>> 2), [3, 4, 5, 6], 'Single scalars extend to the right';
is (3 <<+<< @à), [4, 5, 6, 7], 'Single scalars extend to the left';
is (~<<@à), ["1", "2", "3", "4"], 'Hyperoperator with prefix operator';
is $(@à-개갨𝐩ù = @à; @à-개갨𝐩ù>>++; @à-개갨𝐩ù), [2, 3, 4, 5], 'Hyperoperator with postfix operator';
for flat @𝐩갢 Z @𝐩갢-ò갢丧 -> $elem, $elem-sin {
    is-approx $elem.sin, $elem-sin, 'Hyperoperator used to call .sin on each list element';
}
is ((-1, 0, 3, 42)>>.Str), ["-1", "0", "3", "42"], 'Hyperoperator used to call .Str on each list element';

{
	is $(@à-개갨𝐩ù = @à; @à-개갨𝐩ù >>/=>> 2; @à-개갨𝐩ù), [1/2, 2/2, 3/2, 4/2], 'In-place operators work';
}

# vim: expandtab shiftwidth=4
