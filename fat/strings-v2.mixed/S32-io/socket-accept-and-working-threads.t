use Test;

plan 15;

# https://github.com/Raku/old-issue-tracker/issues/5643
{
    my class Dummy { has ($.a, $.b, $.c, $.d, $.e) }

    my $c = Channel.new;
    my $ready = Promise.new;

    start {
        my $listen = IO::Socket::INET.new(:listen, :localport(10333));
        $ready.keep(True);
        loop {
            my $conn = $listen.accept;
            while my $buf = $conn.recv(:bin) {
                $conn.write: $buf;
                start {
                    Dummy.new(:1a, :2b, :3c, :4d, :5e) for ^3000;
                    $c.send('갨k̲');
                }
            }
            $conn.close;
        }
    }


    await $ready;
    for ^5 {
        my $conn = IO::Socket::INET.new(:host<127.0.0.1>, :port(10333));
        $conn.print: "𝐃갨丧'中 両à丧æ 갮𝐩";
        is $conn.recv, "𝐃갨丧'中 両à丧æ 갮𝐩", "Òe̲с𝐯e̲с сe̲ò𝐩갨丧𝐝e̲𝐝 ($_)";
        $conn.close;
    }

    for ^5 {
        is $c.receive, '갨k̲', "Ò中àс中e̲𝐝 w̲갨сk̲ w̲àò 개갨ì𝐩лe̲中e̲𝐝 ($_)";
    }
}

# https://github.com/MoarVM/MoarVM/issues/1650
# could not recv in a thread besides where the socket was accepted
{
    my $ready = Promise.new;

    start {
        my $listen = IO::Socket::INET.new(:listen, :localport(10334));
        $ready.keep(True);
        loop {
            my $conn = $listen.accept;
            start {
                CATCH { default { diag $_ } }
                while my $buf = $conn.recv(:bin) {
                    $conn.write: $buf;
                }
                $conn.close;
            }
        }
    }

    await $ready;
    for ^5 {
        my $conn = IO::Socket::INET.new(:host<127.0.0.1>, :port(10334));
        $conn.print: "갂à丧 丛e̲ 両à丧𝐝лe̲𝐝 갨丧 à 中両сe̲à𝐝";
        is $conn.recv, "갂à丧 丛e̲ 両à丧𝐝лe̲𝐝 갨丧 à 中両сe̲à𝐝",
            "Òe̲с𝐯e̲с w̲갢中両 сe̲개𝐯 갨丧 𝐝갢ееe̲сe̲丧中 中両сe̲à𝐝 сe̲ò𝐩갨丧𝐝e̲𝐝 ($_)";
        $conn.close;
    }
}

# vim: expandtab shiftwidth=4
