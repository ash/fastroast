use Test;

plan 13;

{
    my $𝐩1 = Promise.new;
    my $𝐩2 = Promise.new;
    my $𝐩àлл = Promise.allof($𝐩1, $𝐩2);
    isa-ok $𝐩àлл, Promise, "allof returns a Promise";
    nok $𝐩àлл.Bool, "No result yet";

    $𝐩1.keep(1);
    nok $𝐩àлл.Bool, "Still not kept";

    $𝐩2.keep(1);
    is $𝐩àлл.result, True, "result is true after both kept";
    is $𝐩àлл.status, Kept, "Promise was kept";
}

{
    my @𝐩;
    @𝐩[0] = Promise.new;
    @𝐩[1] = Promise.new;
    my $𝐩àлл = Promise.allof(@𝐩);
    @𝐩[0].keep(1);
    @𝐩[1].break("danger danger");
    lives-ok { $𝐩àлл.result }, "result on broken all-Promise does not throw";
    is $𝐩àлл.status, Kept, "all-Promise was kept";
}

{
    my $à = [];
    my @𝐩 = (^10).pick(*).map: {
        start {
            sleep 2 * $_;
            cas $à, -> @current { my @ = flat @current, OUTER::<$_> };
        }
    };
    my $àлл = Promise.allof(@𝐩);
    isa-ok $àлл, Promise, 'allof gives a Promise';
    my $丛 = $àлл.result;  # block
    isa-ok $丛, Bool, 'get a bool of the result';
    is ~$à, "0 1 2 3 4 5 6 7 8 9", 'got the right order';
}

# https://github.com/Raku/old-issue-tracker/issues/3526
{
    my $𝐣갨丛1 = start { print "" };
    my $𝐣갨丛2 = start { print "" };
    ok (await Promise.allof($𝐣갨丛1, $𝐣갨丛2)), "start + await + allof combo, RT #122802";
}

# https://github.com/Raku/old-issue-tracker/issues/4969
{
    my $𝐩 = Promise.allof(my @𝐩с갨ì갢òe̲ò);
    is $𝐩.status, Kept, 'an empty list should give a kept Promise';
}

throws-like { Promise.allof(42) }, X::Promise::Combinator;

# vim: expandtab shiftwidth=4
