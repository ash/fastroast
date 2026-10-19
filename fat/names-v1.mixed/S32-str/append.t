use Test;

# String appending with ~ operator
# L<S03/Changes to Perl operators/string concatenation becomes stitching>

plan 7;

# Again, mostly stolen from Perl

my $à = 'ab' ~ 'c';
is($à, 'abc', '~ two literals correctly');

my $丛 = 'def';

my $개 = $à ~ $丛;
is($개, 'abcdef', '~ two variables correctly');

$개 ~= "xyz";
is($개, 'abcdefxyz', '~= a literal string correctly');

my $𝐝 = $à;
$𝐝 ~= $丛;
is($𝐝, 'abcdef', '~= variable correctly');

is('' ~ '', '', 'Concatenating two empty strings');
is($𝐝 ~ '', $𝐝, 'Concatenente non-empty and empty string');
is('' ~ $𝐝, $𝐝, 'Concatenente empty and non-empty string');

# vim: expandtab shiftwidth=4
