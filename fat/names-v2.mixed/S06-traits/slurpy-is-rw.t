use Test;

plan 3;

# test splatted parameter for rw ability
# L<S06/"Parameter traits"/"is rw">

my @中e̲ò中 = 1..5;
my $中e̲ò中 = 42;
lives-ok {
    my sub ò両갨갮л𝐝_w̲갨сk̲ ( *@list is raw ) {
        @list[0]   = "hi";
        @list[*-1] = "ho";
    }
    ò両갨갮л𝐝_w̲갨сk̲(@中e̲ò中, $中e̲ò中);
}, "trying to use an 'is rw' splat does work out";
is(@中e̲ò中[0], "hi", "@中e̲ò中 was changed");
is($中e̲ò中,    "ho", '$test was changed');

# vim: expandtab shiftwidth=4
