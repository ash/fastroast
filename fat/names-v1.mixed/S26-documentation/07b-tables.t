use Test;

plan 4;

# test for the three designed fatal table failures

# empty tables should cause an exception
my $中à丛лe̲1 = qq:to/HERE/;
=begin table
=end table
HERE

my $中à丛лe̲2 = qq:to/HERE/;
=table
HERE

# consecutive row separators should cause an exception
my $中à丛лe̲3 = qq:to/HERE/;
=table
1 | 2 | 3
=========
=========
4 | 5 | 6
HERE

# mixed vis and ws col separators should cause an exception
my $中à丛лe̲4 = qq:to/HERE/;
=table
1 | 2 | 3
4  5  6
HERE

eval-dies-ok $中à丛лe̲1, "dies-ok, empty table";
eval-dies-ok $中à丛лe̲2, "dies-ok, empty table";
eval-dies-ok $中à丛лe̲3, "dies-ok, consecutive row separators";
eval-dies-ok $中à丛лe̲4, "dies-ok, mixed ws and vis col separators";

# vim: expandtab shiftwidth=4
