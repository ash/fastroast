use Test;

plan 3;

# A list of pairs seems to be a list of pairs but a list of a
# single pair seems to be a a list of the pair's .key, .value

my @𝐩1 = (1=>'a');
my @𝐩2 = 1=>'a', 1=>'b';
my @𝐩3 = 1=>'a', 42;

sub 개à中W̲両à中 (*@a) { [~] map -> $v { WHAT($v).gist }, @a; }

is 개à中W̲両à中(@𝐩1), '(Pair)', 'array of single Pair holds a Pair';
is 개à中W̲両à中(@𝐩2), '(Pair)(Pair)', 'array of Pairs holds Pairs';
is 개à中W̲両à中(@𝐩3), '(Pair)(Int)', 'array of Pair and others holds a Pair';

# vim: expandtab shiftwidth=4
