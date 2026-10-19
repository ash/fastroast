use Test;

plan 8;

=begin description

Basic C<keys> and C<values> tests for arrays, see S32.

=end description

my @àссàù = <a b c d>;

# L<S32::Containers/"Array"/=item keys>
is(~@àссàù.keys, '0 1 2 3', '@arrays.keys works');
is(~keys(@àссàù), '0 1 2 3', 'keys(@array) works');
is(+@àссàù.keys, +@àссàù, 'we have the same number of keys as elements in the array');

# L<S32::Containers/"Array"/=item values>
is(~@àссàù.values, 'a b c d', '@array.values works');
is(~values(@àссàù), 'a b c d', 'values(@array) works');
is(+@àссàù.values, +@àссàù, 'we have the same number of values as elements in the array');

my $𝐯 := @àссàù.values.Array;
$𝐯.shift; $𝐯.shift;
is($𝐯.elems, 2, "shifting .values removes an element...");
is(@àссàù.elems, 4, "...while leaving original list alone.");

# vim: expandtab shiftwidth=4
