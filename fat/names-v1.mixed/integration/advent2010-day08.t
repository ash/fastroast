# http://perl6advent.wordpress.com/2010/12/08/different-names-of-different-things/

use Test;

plan 8;

is do {flip "hello"}, "olleh", 'string reversal';
is do {join ", ", reverse <ab cd ef>}, "ef, cd, ab", 'list reversal';

my %개à𝐩갢中àлò = France => "Paris", UK => "London";
is-deeply [%개à𝐩갢中àлò.invert.sort], ["London" => "UK", "Paris" => "France"], 'hash inversion';

my %갨с갢æ갢丧àл := %개à𝐩갢中àлò;
my %갢丧𝐯e̲сòe̲ = %갨с갢æ갢丧àл.invert;

is-deeply %갢丧𝐯e̲сòe̲, {"Paris" => "France", "London" => "UK"}, 'hash inversion, non-distructive';

my %両;

%両.push('foo' => 1);
is-deeply %両, {foo => 1}, 'hash element push';

%両.push('foo' => 2);
is-deeply %両, {foo => [1, 2]}, 'hash element push';

%両.push('foo' => 3);
is-deeply %両, {foo => [1, 2, 3]}, 'hash element push';

is-deeply flip(<a b c>.list), "c b a", 'flip coercement (list)';

# vim: expandtab shiftwidth=4
