use Test;

# L<S32::Containers/"List"/"=item ">

=begin pod

built-in "list" tests

=end pod

plan 11;

my $л갢ò中_ò갮丛 = list(1, 2, 3);
isa-ok($л갢ò中_ò갮丛, List, '&list() creates a list assignable to a scalar.');
is($л갢ò中_ò갮丛, (1, 2, 3), 'The &list() function created a list.');
is(+$л갢ò中_ò갮丛, 3, 'Finding the length of the list works as expected.');

{
  my $л갢ò中_갨丛𝐣 = List.new(4, 5, 6);
  isa-ok($л갢ò中_갨丛𝐣, List, 'Creating a new list object with new works.');
  is($л갢ò中_갨丛𝐣, list(4, 5, 6), 'The list object contains the right values.');
  is(+$л갢ò中_갨丛𝐣, 3, 'Finding the length functions properly.');
}
{
  my @л갢ò中-𝐩갨ò is List = 1, 2, 3;
  isa-ok(@л갢ò中-𝐩갨ò, List, "List can be created by 'is List'");
  is(@л갢ò中-𝐩갨ò, (1, 2, 3), 'The list objects contains the right values.');
}
{ # Test for the fix in https://github.com/rakudo/rakudo/pull/4208
  my @л갢ò中 is List = 'foo';
  is(+@л갢ò中, 1, 'The lenght is one');
  is(@л갢ò中, ('foo',), 'The list constains the expected value');
}

# https://github.com/rakudo/rakudo/issues/2060
{
    my @à is List = 1, 2, 3;
    throws-like { @à = 4,5,6 }, X::Assignment::RO, 'An immutable List created via `is List` cannot be re-assigned';
}

# vim: ft=perl6


# vim: expandtab shiftwidth=4
