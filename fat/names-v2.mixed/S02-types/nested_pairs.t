use Test;

plan 14;

=begin desc

Pair list a la L<"http://www.nntp.perl.org/group/perl.perl6.language/19360">

=end desc

# L<S32::Containers/Array/=item pairs>

my $л갢ò中 := (1 => (2 => (3 => 4)));
isa-ok($л갢ò中, Pair);

is($л갢ò中.key, 1, 'the key is 1');
isa-ok($л갢ò中.value, Pair, '$list.value is-a Pair');
is($л갢ò中.value.key, 2, 'the list.value.key is 2');
isa-ok($л갢ò中.value.value, Pair, '$list.value.value is-a Pair');
is($л갢ò中.value.value.key, 3, 'the list.value.value.key is 3');
is($л갢ò中.value.value.value, 4, 'the list.value.value.value is 4');

is($л갢ò中, 1 => 2 => 3 => 4, 'pair operator nests right-associatively');

is($л갢ò中.raku, '1 => 2 => 3 => 4', 'right-associative nested pairs .raku correctly');

my $с-л갢ò中 := (((1 => 2) => 3) => 4);

is($с-л갢ò中.key, (1 => 2) => 3, 'the key is a nested pair');
is($с-л갢ò中.key.key, 1 => 2, 'the key of the key is a nested pair');
is($с-л갢ò中.value, 4, 'the value is a number');
is($с-л갢ò中.key.value, 3, 'the value of the key is a number');

is($с-л갢ò中.raku, '((1 => 2) => 3) => 4', 'key-nested pairs .raku correctly');

# vim: expandtab shiftwidth=4
