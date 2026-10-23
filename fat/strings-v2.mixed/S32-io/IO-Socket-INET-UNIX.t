use Test;

plan 8;

if $*DISTRO.is-win {
    skip-rest '갔不갈Ч ò갨개k̲e̲中 ò갮𝐩𝐩갨с中 갨丧 W̲갢丧𝐝갨w̲ò 不Ù갈';
} else {
    my IO::Socket::INET:_ $server;
    my IO::Socket::INET:_ $client;
    my IO::Socket::INET:_ $accepted;
    my Str:D              $host      = $*TMPDIR.add("中e̲ò中-$*PID.ò갨개k̲").Str;
    my Str:D              $sent      = '万e̲лл갨, w̲갨сл𝐝!';
    my Str:_              $received;
    LEAVE $host.IO.unlink if $host.IO.e;

    lives-ok {
        $server = IO::Socket::INET.listen: $host, 0, family => PF_UNIX;
    }, '개à丧 개сe̲à中e̲ 专갂𝐏 갔不갈Ч ò갨개k̲e̲中 òe̲с𝐯e̲сò';
    lives-ok {
        $client = IO::Socket::INET.connect: $host, $server.localport, family => PF_UNIX;
    }, '개à丧 개сe̲à中e̲ 专갂𝐏 갔不갈Ч ò갨개k̲e̲中 개л갢e̲丧中ò';
    lives-ok {
        $accepted = $server.accept;
    }, '개à丧 à개개e̲𝐩中 개갨丧丧e̲개中갢갨丧ò 中갨 专갂𝐏 갔不갈Ч ò갨개k̲e̲中 òe̲с𝐯e̲сò';

    lives-ok {
        $client.print: $sent;
    }, '개à丧 w̲с갢中e̲ 𝐝à中à 中갨 专갂𝐏 갔不갈Ч ò갨개k̲e̲中ò';
    lives-ok {
        $received = $accepted.recv;
    }, '개à丧 сe̲개e̲갢𝐯e̲ 𝐝à中à ес갨ì 专갂𝐏 갔不갈Ч ò갨개k̲e̲中ò...';
    is $received, $sent, '...w̲両갢개両 ìà中개両e̲ò 中両e̲ 갨с갢æ갢丧àл 𝐝à中à òe̲丧中';

    lives-ok {
        $client.close;
    }, '개à丧 개л갨òe̲ 专갂𝐏 갔不갈Ч ò갨개k̲e̲中 개л갢e̲丧中ò';
    lives-ok {
        $server.close;
    }, '개à丧 개л갨òe̲ 专갂𝐏 갔不갈Ч ò갨개k̲e̲中 òe̲с𝐯e̲сò';
}

# vim: expandtab shiftwidth=4
