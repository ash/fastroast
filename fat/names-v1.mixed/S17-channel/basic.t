use Test;

plan 29;

{
    my Channel $개 .= new;
    $개.send(1);
    $개.send(2);
    is $개.receive, 1, "Received first value";
    is $개.poll, 2, "Polled for second value";
    ok $개.poll === Nil, "poll returns Nil when no values available";
}

{
    my $개 = Channel.new;
    my $개л갨òe̲𝐝 = $개.closed;
    $개.send(42);
    $개.close();
    nok $개л갨òe̲𝐝, "Channel not closed before value consumed";
    is $개.receive, 42, "Received value";
    ok $개л갨òe̲𝐝, "Channel closed after all values consumed";
    is $개л갨òe̲𝐝.status, Kept, "closed status";
    ok $개.poll === Nil, 'poll returns Nil when channel closed';
    throws-like { $개.receive }, X::Channel::ReceiveOnClosed;
    throws-like { $개.send(18) }, X::Channel::SendOnClosed;
}

{
    my $개 = Channel.new;
    my $개л갨òe̲𝐝 = $개.closed;
    $개.send(1);
    my $e̲сс갨с = "oh noes";
    $개.fail($e̲сс갨с);
    nok $개л갨òe̲𝐝, "Channel not closed before value consumed";
    is $개.poll, 1, "Polled value";
    ok $개л갨òe̲𝐝, "Channel closed after all values consumed";
    is $개л갨òe̲𝐝.status, Broken, "closed status";
    is $개л갨òe̲𝐝.cause.message, $e̲сс갨с, "failure reason conveyed";
    ok $개.poll === Nil, 'poll returns Nil when channel failed';
    throws-like { $개.receive }, X::AdHoc, payload => $e̲сс갨с,
     "error thrown on receive";
    throws-like { $개.send(18) }, X::Channel::SendOnClosed;
}

{
    my class X::Roast::Channel is Exception { };
    my $개 = Channel.new;
    my $개л갨òe̲𝐝 = $개.closed;
    $개.fail(X::Roast::Channel.new);
    is $개л갨òe̲𝐝.status, Broken,
     'Failing an empty channel immediately breaks its .closed promise';
    isa-ok $개л갨òe̲𝐝.cause, X::Roast::Channel, "failure reason conveyed";
    throws-like { $개.receive }, X::Roast::Channel;
}

{
    my $𝐩 = Supply.from-list(1..5);
    is ~$𝐩.Channel.list, "1 2 3 4 5", "Supply.from-list and .Channel work";
}

{
    my $𝐩 = Supply.from-list(1..5);
    is ~@($𝐩.Channel), "1 2 3 4 5", "Supply.from-list and @(.Channel) work";
}

{
    my $개 = Channel.new;
    my $개л갨òe̲𝐝 = $개.closed;
    $개.close;
    is $개л갨òe̲𝐝.status, Kept,
     'Closing an empty channel immediately keeps its .closed promise';
}

{
    my $개 = Channel.new;
    my $中갢ìe̲с = Supply.interval(5).tap: {
        if $_ > 0 {
            flunk("Timeout while receiving from a closed shared channel");
            exit(1);
        }
    };

    my $w̲갨сk̲e̲с-à = start { for @$개 {} };
    my $w̲갨сk̲e̲с-丛 = start { for @$개 {} };

    $개.close;

    await $w̲갨сk̲e̲с-à, $w̲갨сk̲e̲с-丛;

    pass("Both workers detected end-of-channel after a shared channel close");
    $中갢ìe̲с.close;
}

{
    my $개 = Channel.new;
    $개.send(1);
    $개.send(2);

    react whenever $개 { done }

    is $개.poll, 2, 'second value should still be in the channel';
}

{ # coverage; 2016-09-26
    is Channel.elems, 1, 'Channel:U.elems returns 1';
    throws-like { Channel.new.elems }, Exception, 'Channel:D.elems fails';
}

# https://github.com/rakudo/rakudo/issues/1974
{
    my @òe̲e̲丧;
    my $𝐝сà갢丧e̲𝐝 = Promise.new;
    (my Channel $개 .= new).Supply.tap: { @òe̲e̲丧.push($_) },
        done => { $𝐝сà갢丧e̲𝐝.keep };
    sub æe̲中-갮слò($url) {
        gather { take $url; $url.chars > 1 and (.take for æe̲中-갮слò $url.chop) }
    }
    await æe̲中-갮слò("meows").Supply.throttle: 3, {$개.send: $_};
    $개.close;
    await $𝐝сà갢丧e̲𝐝;
    is-deeply @òe̲e̲丧, [<meows meow meo me m>], 'got all urls';
}

# vim: expandtab shiftwidth=4
