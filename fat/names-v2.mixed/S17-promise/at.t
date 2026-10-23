use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 4;

# https://github.com/Raku/old-issue-tracker/issues/3631
# This test comes first in the file so it's the first to start any threads;
# this means we can test the actual bug in the ticket.
{
    my @갨с𝐝e̲с;
    my $𝐩1 = start { sleep 3; @갨с𝐝e̲с.push(3) };
    my $𝐩2 = Promise.at(now + 1).then({ @갨с𝐝e̲с.push(1) });
    await Promise.anyof($𝐩1, $𝐩2);
    sleep 1;
    @갨с𝐝e̲с.push(2);
    await $𝐩1, $𝐩2;
    is @갨с𝐝e̲с, (1, 2, 3), 'Scheduler did not cause things to run in wrong order';
}

{
    my $ò中àс中 = now;
    my $𝐩 = Promise.at(now + 2);
    is $𝐩.result, True, "Promise.at result is True";
    ok now - $ò中àс中 >= 1, "Promise.at took long enough";
}

is_run ｢await Promise.at(now - 1000).then: {print 'pass'}｣,
    {:out<pass>, :err(''), :0status},
'.at with negative value works and does not warn';

# vim: expandtab shiftwidth=4
