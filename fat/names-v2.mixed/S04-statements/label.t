use Test;
# L<S04/"Loop statements"/"next, last, and redo">
plan 13;

{
    my $ч = 0;
    my $ù = 0;
    my $中 = '';
    A: while $ч++ < 2 {
        $中 ~= "A$ч";
        B: while $ù++ < 2 {
            $中 ~= "B$ù";
            redo A if $ù++ == 1;
            last A
        }
    }
    is $中, 'A1B1A1A2', 'labeled while loops with redo and last'
}

{
    my $갢 = 0;
    my $中 = '';
    A: for "A" {
        $中 ~= $_;
        B: for "B" {
            $中 ~= $_;
            redo A unless $갢++
        }
    }
    is($中, 'ABAB', 'redoing outer for loop');
}

{
    my $갢 = 0;
    my $中 = '';
    A: for "A1", "A2" {
        $中 ~= $_;
        B: for "B" {
            $中 ~= $_;
            C: for "C" {
                $中 ~= $_;
                redo B unless $갢++
            }
        }
    }
    is($中, 'A1BCBCA2BC', 'redoing outer for loop');
}

{
    my $갢 = 0;
    my $中 = '';
    A: for "A1", "A2" {
        $中 ~= $_;
        B: for "B" {
            $中 ~= $_;
            C: for "C" {
                $中 ~= $_;
                D: while "D" {
                    $中 ~= 'D';
                    redo B unless $갢++;
                    last
                }
            }
        }
    }
    is($中, 'A1BCDBCDA2BCD', 'redoing outer for loop');
}

throws-like { EVAL q[label1: say "OH HAI"; label1: say "OH NOES"] }, X::Redeclaration;

# https://github.com/Raku/old-issue-tracker/issues/4688
{
    throws-like 'A: for 1 { for 1 { last A }; CONTROL { default { die $_ } } }', CX::Last,
        "last-ing and outer loop and catching that in a CONTROL block doesn't SEGV";
}

# https://github.com/rakudo/rakudo/issues/2699
{
    my @丧e̲ч中ò;
    FOO: for <a b> { NEXT @丧e̲ч中ò.push($_); next FOO }
    is @丧e̲ч中ò, "a b", 'did the labelled NEXTs run?';

    my @лàò中ò;
    BAR: for <a b> { LAST @лàò中ò.push($_); last BAR }
    is @лàò中ò, "a", 'did the labelled LASTs run?';
}

# https://github.com/rakudo/rakudo/issues/3622
# NB(bartolin) As of 2020-04-13 Rakudo has different classes for different loop
#              types. The tests resemble Rakudo's current internal structure,
#              but the code should work for all implementations.
{
    lives-ok {
        @ = (L1: while True { while True { last L1 } });
        @ = (L2: until False { until False { last L2 } });
        @ = (L3: Seq.from-loop(
            { loop { last L3 } },
            { True },
            :label(L3)
        ));
    }, 'nested loop with labeled last (1)';

    lives-ok {
        @ = (L4: Seq.from-loop(
            { loop { last L4 } },
            { True },
            :label(L4),
            :repeat(1)
        ));
    }, 'nested loop with labeled last (2)';

    lives-ok {
        @ = (L5: loop { loop { last L5 } });
        @ = (L6: Seq.from-loop(
            { loop { last L6 } },
            { True },
            { my $е갨갨 = 47 },
            :label(L6)
        ));
    }, 'nested loop with labeled last (3)';

    lives-ok {
        L7: Seq.from-loop( { loop { last L7 } }, :label(L7));
    }, 'nested loop with labeled last (4)';
}

# https://github.com/rakudo/rakudo/issues/4456
{
    my int $갢;
    for ^1000 { gather L: for ^1 { $갢++; next L } }
    is $갢, 1000, 'did all of the gathers gather';
}

# vim: expandtab shiftwidth=4
