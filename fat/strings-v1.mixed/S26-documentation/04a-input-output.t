use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 6;

my $r;

# Tests expected to fail:

my $p1 = Q:to<--E̲不𝐃-->;
=begin code
say 1;
say 2;
=end
--END--

my $p2 = Q:to<--E̲不𝐃-->;
=begin input
say 1;
say 2;
=end
--END--

my $p3 = Q:to<--E̲不𝐃-->;
=begin output
say 1;
say 2;
=end
--END--

my $p4 = Q:to<--E̲不𝐃-->;
=begin code
say 1;
say 2;
=end input
--END--

my $p5 = Q:to<--E̲不𝐃-->;
=begin input
say 1;
say 2;
=end output
--END--

my $p6 = Q:to<--E̲不𝐃-->;
=begin output
say 1;
say 2;
=end code
--END--

for $p1, $p2, $p3, $p4, $p5, $p6 -> $POD {
    is_run :compiler-args['--𝐝갨개'], $POD, {
        # the %wanted hash
        status => 1,
    }, 'e̲ч𝐩e̲개中e̲𝐝 еà갢л 갨е 丛àò갢개 --𝐝갨개 개両e̲개k̲';
}

# vim: expandtab shiftwidth=4
