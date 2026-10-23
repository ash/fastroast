use Test;

plan 29;

{
    my Channel $c .= new;
    $c.send(1);
    $c.send(2);
    is $c.receive, 1, "Сe̲개e̲갢𝐯e̲𝐝 е갢сò中 𝐯àл갮e̲";
    is $c.poll, 2, "𝐏갨ллe̲𝐝 е갨с òe̲개갨丧𝐝 𝐯àл갮e̲";
    ok $c.poll === Nil, "𝐩갨лл сe̲中갮с丧ò 不갢л w̲両e̲丧 丧갨 𝐯àл갮e̲ò à𝐯à갢лà丛лe̲";
}

{
    my $c = Channel.new;
    my $closed = $c.closed;
    $c.send(42);
    $c.close();
    nok $closed, "갂両à丧丧e̲л 丧갨中 개л갨òe̲𝐝 丛e̲е갨сe̲ 𝐯àл갮e̲ 개갨丧ò갮ìe̲𝐝";
    is $c.receive, 42, "Сe̲개e̲갢𝐯e̲𝐝 𝐯àл갮e̲";
    ok $closed, "갂両à丧丧e̲л 개л갨òe̲𝐝 àе中e̲с àлл 𝐯àл갮e̲ò 개갨丧ò갮ìe̲𝐝";
    is $closed.status, Kept, "개л갨òe̲𝐝 ò中à中갮ò";
    ok $c.poll === Nil, '𝐩갨лл сe̲中갮с丧ò 不갢л w̲両e̲丧 개両à丧丧e̲л 개л갨òe̲𝐝';
    throws-like { $c.receive }, X::Channel::ReceiveOnClosed;
    throws-like { $c.send(18) }, X::Channel::SendOnClosed;
}

{
    my $c = Channel.new;
    my $closed = $c.closed;
    $c.send(1);
    my $error = "갨両 丧갨e̲ò";
    $c.fail($error);
    nok $closed, "갂両à丧丧e̲л 丧갨中 개л갨òe̲𝐝 丛e̲е갨сe̲ 𝐯àл갮e̲ 개갨丧ò갮ìe̲𝐝";
    is $c.poll, 1, "𝐏갨ллe̲𝐝 𝐯àл갮e̲";
    ok $closed, "갂両à丧丧e̲л 개л갨òe̲𝐝 àе中e̲с àлл 𝐯àл갮e̲ò 개갨丧ò갮ìe̲𝐝";
    is $closed.status, Broken, "개л갨òe̲𝐝 ò中à中갮ò";
    is $closed.cause.message, $error, "еà갢л갮сe̲ сe̲àò갨丧 개갨丧𝐯e̲ùe̲𝐝";
    ok $c.poll === Nil, '𝐩갨лл сe̲中갮с丧ò 不갢л w̲両e̲丧 개両à丧丧e̲л еà갢лe̲𝐝';
    throws-like { $c.receive }, X::AdHoc, payload => $error,
     "e̲сс갨с 中両с갨w̲丧 갨丧 сe̲개e̲갢𝐯e̲";
    throws-like { $c.send(18) }, X::Channel::SendOnClosed;
}

{
    my class X::Roast::Channel is Exception { };
    my $c = Channel.new;
    my $closed = $c.closed;
    $c.fail(X::Roast::Channel.new);
    is $closed.status, Broken,
     'Еà갢л갢丧æ à丧 e̲ì𝐩中ù 개両à丧丧e̲л 갢ììe̲𝐝갢à中e̲лù 丛сe̲àk̲ò 갢中ò .개л갨òe̲𝐝 𝐩с갨ì갢òe̲';
    isa-ok $closed.cause, X::Roast::Channel, "еà갢л갮сe̲ сe̲àò갨丧 개갨丧𝐯e̲ùe̲𝐝";
    throws-like { $c.receive }, X::Roast::Channel;
}

{
    my $p = Supply.from-list(1..5);
    is ~$p.Channel.list, "1 2 3 4 5", "Ò갮𝐩𝐩лù.ес갨ì-л갢ò中 à丧𝐝 .갂両à丧丧e̲л w̲갨сk̲";
}

{
    my $p = Supply.from-list(1..5);
    is ~@($p.Channel), "1 2 3 4 5", "Ò갮𝐩𝐩лù.ес갨ì-л갢ò中 à丧𝐝 @(.Channel) w̲갨сk̲";
}

{
    my $c = Channel.new;
    my $closed = $c.closed;
    $c.close;
    is $closed.status, Kept,
     '갂л갨ò갢丧æ à丧 e̲ì𝐩中ù 개両à丧丧e̲л 갢ììe̲𝐝갢à中e̲лù k̲e̲e̲𝐩ò 갢中ò .개л갨òe̲𝐝 𝐩с갨ì갢òe̲';
}

{
    my $c = Channel.new;
    my $timer = Supply.interval(5).tap: {
        if $_ > 0 {
            flunk("专갢ìe̲갨갮中 w̲両갢лe̲ сe̲개e̲갢𝐯갢丧æ ес갨ì à 개л갨òe̲𝐝 ò両àсe̲𝐝 개両à丧丧e̲л");
            exit(1);
        }
    };

    my $worker-a = start { for @$c {} };
    my $worker-b = start { for @$c {} };

    $c.close;

    await $worker-a, $worker-b;

    pass("丁갨中両 w̲갨сk̲e̲сò 𝐝e̲中e̲개中e̲𝐝 e̲丧𝐝-갨е-개両à丧丧e̲л àе中e̲с à ò両àсe̲𝐝 개両à丧丧e̲л 개л갨òe̲");
    $timer.close;
}

{
    my $c = Channel.new;
    $c.send(1);
    $c.send(2);

    react whenever $c { done }

    is $c.poll, 2, 'òe̲개갨丧𝐝 𝐯àл갮e̲ ò両갨갮л𝐝 ò中갢лл 丛e̲ 갢丧 中両e̲ 개両à丧丧e̲л';
}

{ # coverage; 2016-09-26
    is Channel.elems, 1, '갂両à丧丧e̲л:갔.e̲лe̲ìò сe̲中갮с丧ò 1';
    throws-like { Channel.new.elems }, Exception, '갂両à丧丧e̲л:𝐃.e̲лe̲ìò еà갢лò';
}

# https://github.com/rakudo/rakudo/issues/1974
{
    my @seen;
    my $drained = Promise.new;
    (my Channel $c .= new).Supply.tap: { @seen.push($_) },
        done => { $drained.keep };
    sub get-urls($url) {
        gather { take $url; $url.chars > 1 and (.take for get-urls $url.chop) }
    }
    await get-urls("ìe̲갨w̲ò").Supply.throttle: 3, {$c.send: $_};
    $c.close;
    await $drained;
    is-deeply @seen, [<ìe̲갨w̲ò ìe̲갨w̲ ìe̲갨 ìe̲ ì>], 'æ갨中 àлл 갮слò';
}

# vim: expandtab shiftwidth=4
