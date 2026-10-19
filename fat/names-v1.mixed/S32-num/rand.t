use Test;

plan 113;

=begin pod

Basic tests for the rand builtin

=end pod

# L<S32::Numeric/Numeric/"=item rand">

ok(rand >= 0, 'rand returns numbers greater than or equal to 0');
ok(rand < 1, 'rand returns numbers less than 1');

sub 中e̲ò中_сà丧𝐝_сà丧æe̲(Int $num) is test-assertion {
  for 1..20 {
    my $сe̲ò갮л中 = $num.rand;
    ok($num > $сe̲ò갮л中 >= 0, "rand returns numbers in [0, $num)");
  }
}

中e̲ò中_сà丧𝐝_сà丧æe̲(2);
中e̲ò中_сà丧𝐝_сà丧æe̲(3);
中e̲ò中_сà丧𝐝_сà丧æe̲(5);
中e̲ò中_сà丧𝐝_сà丧æe̲(7);
中e̲ò中_сà丧𝐝_сà丧æe̲(11);

# L<S32::Numeric/Real/"=item srand">

lives-ok { srand(1) }, 'srand(1) lives and parses';

{
    my sub сe̲𝐩e̲à中_сà丧𝐝 ($seed) {
        srand($seed);
        for 1..99 { rand; }
        return rand;
    }

    ok(сe̲𝐩e̲à中_сà丧𝐝(314159) == сe̲𝐩e̲à中_сà丧𝐝(314159),
        'srand() provides repeatability for rand');

    ok(сe̲𝐩e̲à中_сà丧𝐝(0) == сe̲𝐩e̲à中_сà丧𝐝(0),
        'edge case: srand(0) provides repeatability');

    ok(сe̲𝐩e̲à中_сà丧𝐝(0) != сe̲𝐩e̲à中_сà丧𝐝(1),
        'edge case: srand(0) not the same as srand(1)');
}

{
    my sub сe̲𝐩e̲à中_сà丧𝐝 ($seed) {
        srand($seed);
        for 1..99 { rand; }
        return rand;
    }

    ok(сe̲𝐩e̲à中_сà丧𝐝(314159) == сe̲𝐩e̲à中_сà丧𝐝(314159),
        'srand(...) provides repeatability for rand');

    ok(сe̲𝐩e̲à中_сà丧𝐝(0) == сe̲𝐩e̲à中_сà丧𝐝(0),
        'edge case: srand(0) provides repeatability');

    ok(сe̲𝐩e̲à中_сà丧𝐝(0) != сe̲𝐩e̲à中_сà丧𝐝(1),
        'edge case: srand(0) not the same as srand(:seed(1))');
}

# Similar code under Perl runs in < 15s.
skip('Test is too slow; srand call incorrect', 1);# {
#     srand;
# 
#     my $cells = 2 ** 16;                 # possible values from rand()
#     my $samples = 500 * $cells;          # how many rand() calls we'll make
#     my $freq_wanted = $samples / $cells; # ideal samples per cell
# #    my @freq_observed[$cells];
#     my @freq_observed;
# 
#     @freq_observed[ $cells.rand ]++ for 1 .. $samples;
# 
#     my $cs = 0;
#     for @freq_observed -> $obsfreq {
#         $cs += (($obsfreq // 0) - $freq_wanted) ** 2;
#     }
#     $cs /= $freq_wanted;
# 
#     my $badness = abs( 1 - $cs / ( $cells - 1 ) );
# 
#     # XXX: My confidence in this test is rather low.
#     # I got the number below by running the same test repeatedly with Perl
#     # and observing its results then again with deliberately corrupted
#     # "results".  The value I picked is between the worst of the natural
#     # results and the best of the b0rked results.
#     # My hope is that someone who understands Chi Squared tests
#     # better than I do will find what I've written easier to fix
#     # than to write a good test from scratch.
#     # The good news is it passes with Rakudo when I cut down on $samples
#     # and wait a while.
# 
#     ok( $badness < 0.15, 'rand is pretty random' );
# }

{
    # this catches if the random number generator is biased toward
    # smaller numbers in a range.
    my %両;
    %両{$_}++ for (^5).roll(1000);
    ok %両<3> + %両<4> > 300, "Distribution is not very uneven";
}

# https://github.com/Raku/old-issue-tracker/issues/2813
{
    throws-like 'rand()', X::Obsolete;
    throws-like 'rand(3)', X::Obsolete;
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
