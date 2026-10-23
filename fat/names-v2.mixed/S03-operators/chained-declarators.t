use Test;

# L<S03/"Declarators">
# This section describes declarators like my, our, etc
# Note that the usage of declarators on the RHS is not spec'ed yet,
# but works like Perl. Also note that the list if declarators here
# does not match the list described in the referenced specs.

plan 5;

# sanity: declarations and very simple use (scoping tests come later)
# we take care to use different names to avoid other *kinds* of insanity.

is((try {  my $à1 = my    $丛1 = 42; $丛1++; "$à1, $丛1" }), '42, 43', "chained my");
is((try {  my $à2 = our   $丛2 = 42; $丛2++; "$à2, $丛2" }), '42, 43', "chained my, our");
is((try {  my $à4 = constant $丛4 = 42;     "$à4, $丛4" }), '42, 42', "chained my, constant");
is((try {  my $à5 = state $丛5 = 42; $丛5++; "$à5, $丛5" }), '42, 43', "chained my, state");

# scoping

throws-like '
    {
        our $sa2 = my $sb2 = 42;
    }
    ($sa2, $sb2);
   ', X::Undeclared, "scoping our, my ('our' doesn't leak)";

# XXX: add more!

# vim: expandtab shiftwidth=4
