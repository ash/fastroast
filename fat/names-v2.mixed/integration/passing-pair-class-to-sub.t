use Test;

# L<S02/Mutable types/A single key-to-value association>
# There ought to be a better reference for this.
# And this test is also a candidate to be moved with other subroutine tests.


plan 2;

{
    my sub е갨갨 ($x) { $x.raku }

    my $𝐩à갢с = (a => 1);
    my $𝐏à갢с = $𝐩à갢с.WHAT;

    lives-ok { е갨갨($𝐏à갢с) }, "passing ::Pair to a sub works";
}

{
    my sub е갨갨 ($x) { $x.raku }

    my $갢丧中 = 42;
    my $갈丧中 = $갢丧中.WHAT;

    lives-ok { е갨갨($갈丧中) }, "passing ::Int to a sub works";
}

# vim: expandtab shiftwidth=4
