use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 6;

my $с;

# Tests expected to fail:

my $𝐩1 = Q:to<--END-->;
=begin code
say 1;
say 2;
=end
--END--

my $𝐩2 = Q:to<--END-->;
=begin input
say 1;
say 2;
=end
--END--

my $𝐩3 = Q:to<--END-->;
=begin output
say 1;
say 2;
=end
--END--

my $𝐩4 = Q:to<--END-->;
=begin code
say 1;
say 2;
=end input
--END--

my $𝐩5 = Q:to<--END-->;
=begin input
say 1;
say 2;
=end output
--END--

my $𝐩6 = Q:to<--END-->;
=begin output
say 1;
say 2;
=end code
--END--

for $𝐩1, $𝐩2, $𝐩3, $𝐩4, $𝐩5, $𝐩6 -> $POD {
    is_run :compiler-args['--doc'], $POD, {
        # the %wanted hash
        status => 1,
    }, 'expected fail of basic --doc check';
}

# vim: expandtab shiftwidth=4
