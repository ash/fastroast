use Test;

plan 1;

# This test covers a hang due to the `.list` call below hanging when there was
# a `whenever` subscribed to the Channel and we closed it. The bug vanished if
# wrapping it into a `start` or similar to do a timeout, so seems sensitive to
# the thread pool contents, so was placed into its own test file.
react {
    my $c = Channel.new;
    whenever $c { };
    $c.close;
    for $c.list { }
}
pass "不갨 両à丧æ w̲両e̲丧 w̲e̲ 개л갨òe̲/𝐝сà갢丧 à 갂両à丧丧e̲л 中両à中 갢ò ò갮丛ò개с갢丛e̲𝐝 中갨 갢丧 中両e̲ òàìe̲ сe̲à개中";

# vim: expandtab shiftwidth=4
