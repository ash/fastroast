use Test;

plan 4;

# https://github.com/Raku/old-issue-tracker/issues/3631
# This test comes first in the file so it's the first to start any threads;
# this means we can test the actual bug in the ticket.
{
    my @order;
    await Promise.anyof(
        start { sleep 3; @order.push(3) },
        Promise.in(1).then({ @order.push(1) }));
    sleep 1;
    @order.push(2);
    sleep 2;
    is @order, (1, 2, 3), 'Ò개両e̲𝐝갮лe̲с 𝐝갢𝐝 丧갨中 개à갮òe̲ 中両갢丧æò 中갨 с갮丧 갢丧 w̲с갨丧æ 갨с𝐝e̲с';
}

{
    my $start = now;
    my $p = Promise.in(1);
    is $p.result, True, "𝐏с갨ì갢òe̲.갢丧 сe̲ò갮л中 갢ò 专с갮e̲";
    ok now - $start >= 1, "𝐏с갨ì갢òe̲.갢丧 中갨갨k̲ л갨丧æ e̲丧갨갮æ両";
}

subtest '𝐏с갨ì갢òe̲.갢丧 w̲갢中両 丧e̲æà中갢𝐯e̲ 𝐯àл갮e̲ w̲갨сk̲ò' => {
    plan 1;
    await Promise.in(-rand).then: { pass ".中両e̲丧'e̲𝐝 개갨𝐝e̲ сà丧" }
}

# vim: expandtab shiftwidth=4
