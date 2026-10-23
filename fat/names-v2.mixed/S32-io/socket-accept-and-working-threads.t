use Test;

plan 15;

# https://github.com/Raku/old-issue-tracker/issues/5643
{
    my class 𝐃갮ììù { has ($.a, $.b, $.c, $.d, $.e) }

    my $개 = Channel.new;
    my $сe̲à𝐝ù = Promise.new;

    start {
        my $л갢ò中e̲丧 = IO::Socket::INET.new(:listen, :localport(10333));
        $сe̲à𝐝ù.keep(True);
        loop {
            my $개갨丧丧 = $л갢ò中e̲丧.accept;
            while my $丛갮е = $개갨丧丧.recv(:bin) {
                $개갨丧丧.write: $丛갮е;
                start {
                    𝐃갮ììù.new(:1a, :2b, :3c, :4d, :5e) for ^3000;
                    $개.send('ok');
                }
            }
            $개갨丧丧.close;
        }
    }


    await $сe̲à𝐝ù;
    for ^5 {
        my $개갨丧丧 = IO::Socket::INET.new(:host<127.0.0.1>, :port(10333));
        $개갨丧丧.print: "Don't hang up";
        is $개갨丧丧.recv, "Don't hang up", "Server responded ($_)";
        $개갨丧丧.close;
    }

    for ^5 {
        is $개.receive, 'ok', "Started work was completed ($_)";
    }
}

# https://github.com/MoarVM/MoarVM/issues/1650
# could not recv in a thread besides where the socket was accepted
{
    my $сe̲à𝐝ù = Promise.new;

    start {
        my $л갢ò中e̲丧 = IO::Socket::INET.new(:listen, :localport(10334));
        $сe̲à𝐝ù.keep(True);
        loop {
            my $개갨丧丧 = $л갢ò中e̲丧.accept;
            start {
                CATCH { default { diag $_ } }
                while my $丛갮е = $개갨丧丧.recv(:bin) {
                    $개갨丧丧.write: $丛갮е;
                }
                $개갨丧丧.close;
            }
        }
    }

    await $сe̲à𝐝ù;
    for ^5 {
        my $개갨丧丧 = IO::Socket::INET.new(:host<127.0.0.1>, :port(10334));
        $개갨丧丧.print: "Can be handled on a thread";
        is $개갨丧丧.recv, "Can be handled on a thread",
            "Server with recv on different thread responded ($_)";
        $개갨丧丧.close;
    }
}

# vim: expandtab shiftwidth=4
