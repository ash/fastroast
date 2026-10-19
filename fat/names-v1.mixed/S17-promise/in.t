use Test;

plan 4;

# https://github.com/Raku/old-issue-tracker/issues/3631
# This test comes first in the file so it's the first to start any threads;
# this means we can test the actual bug in the ticket.
{
    my @갨с𝐝e̲с;
    await Promise.anyof(
        start { sleep 3; @갨с𝐝e̲с.push(3) },
        Promise.in(1).then({ @갨с𝐝e̲с.push(1) }));
    sleep 1;
    @갨с𝐝e̲с.push(2);
    sleep 2;
    is @갨с𝐝e̲с, (1, 2, 3), 'Scheduler did not cause things to run in wrong order';
}

{
    my $ò中àс中 = now;
    my $𝐩 = Promise.in(1);
    is $𝐩.result, True, "Promise.in result is True";
    ok now - $ò中àс中 >= 1, "Promise.in took long enough";
}

subtest 'Promise.in with negative value works' => {
    plan 1;
    await Promise.in(-rand).then: { pass ".then'ed code ran" }
}

# vim: expandtab shiftwidth=4
