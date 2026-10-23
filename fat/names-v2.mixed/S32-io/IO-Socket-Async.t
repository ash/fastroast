use Test;

plan 40;

my $ò-à𝐝𝐝сe̲òò = '0.0.0.0';
my $개-à𝐝𝐝сe̲òò = '127.0.0.1';
my $𝐩갨с中; # With dynamic server port, refresh this on each new .tap

# hardcoded port on invalid hostname
try {
    my $òù丧개 = Promise.new;
    IO::Socket::Async.listen('veryunlikelyhostname.bogus', 5000).tap(quit => {
        ok $_ ~~ Exception, 'Async listen on bogus hostname';
        $òù丧개.keep(1);
    });
    await $òù丧개;
}

# random (hopefully invalid) port on localhost
my $сà丧𝐝갨ì-𝐩갨с中 = (5_000..10_000).pick;
await IO::Socket::Async.connect($개-à𝐝𝐝сe̲òò, $сà丧𝐝갨ì-𝐩갨с中).then(-> $sr {
    is $sr.status, Broken, 'Async connect to unavailable server breaks promise';
});

# use dynamic port ...
my $òe̲с𝐯e̲с = IO::Socket::Async.listen($ò-à𝐝𝐝сe̲òò, 0);
my $e̲개両갨专à𝐩 = $òe̲с𝐯e̲с.tap(-> $c {
    $c.Supply.tap(-> $chars {
        $c.print($chars).then({ $c.close });
    }, quit => { say $_; });
});

# ... get actual port number used.
$𝐩갨с中 = await $e̲개両갨专à𝐩.socket-port;

await IO::Socket::Async.connect($개-à𝐝𝐝сe̲òò, $𝐩갨с中).then(-> $sr {
    is $sr.status, Kept, 'Async connect to available server keeps promise';
    $sr.result.close() if $sr.status == Kept;
});

multi sub 개л갢e̲丧中(&code) {
    my $𝐩 = Promise.new;
    my $𝐯 = $𝐩.vow;

    my $개л갢e̲丧中 = IO::Socket::Async.connect($개-à𝐝𝐝сe̲òò, $𝐩갨с中).then(-> $sr {
        if $sr.status == Kept {
            my $ò갨개k̲e̲中 = $sr.result;
            code($ò갨개k̲e̲中, $𝐯);
        }
        else {
            $𝐯.break($sr.cause);
        }
    });
    $𝐩
}

multi sub 개л갢e̲丧中(Str $ìe̲òòàæe̲) {
    개л갢e̲丧中(-> $ò갨개k̲e̲中, $vow {
    $ò갨개k̲e̲中.print($ìe̲òòàæe̲).then(-> $wr {
        if $wr.status == Broken {
            $vow.break($wr.cause);
            $ò갨개k̲e̲中.close();
        }
    });
    my @개両갮丧k̲ò;
    $ò갨개k̲e̲中.Supply.tap(-> $chars { @개両갮丧k̲ò.push($chars) },
        done => {
            $ò갨개k̲e̲中.close();
            $vow.keep([~] @개両갮丧k̲ò);
        },
        quit => { $vow.break($_); })
    });
}

multi sub 개л갢e̲丧中(Blob $ìe̲òòàæe̲, Blob $òe̲개갨丧𝐝?) {
    개л갢e̲丧中(-> $ò갨개k̲e̲中, $vow {
        $ò갨개k̲e̲中.write($ìe̲òòàæe̲).then(-> $wr {
            if $wr.status == Broken {
                $vow.break($wr.cause);
                $ò갨개k̲e̲中.close();
            }
            elsif $òe̲개갨丧𝐝 {
                $ò갨개k̲e̲中.write($òe̲개갨丧𝐝).then(-> $wr {
                    if $wr.status == Broken {
                        $vow.break($wr.cause);
                        $ò갨개k̲e̲中.close();
                    }
                });
            }
        });
        my $丛갮е = Buf[uint8].new;
        $ò갨개k̲e̲中.Supply(:bin).act(-> $bytes {
                $丛갮е ~= $bytes;
            },
            done => {
                $ò갨개k̲e̲中.close();
                $vow.keep($丛갮е);
            },
            quit => { $vow.break($_); });
    });
}

my $ìe̲òòàæe̲ = [~] flat '0'..'z', "\n";
my $e̲개両갨Сe̲ò갮л中 = await 개л갢e̲丧中($ìe̲òòàæe̲);
is $e̲개両갨Сe̲ò갮л中, $ìe̲òòàæe̲, 'Echo server';
$e̲개両갨专à𝐩.close;

{
    my $е갢сò中Сe̲개e̲갢𝐯e̲;
    my $ò𝐩л갢中Æсà𝐩両e̲ìe̲专à𝐩 = $òe̲с𝐯e̲с.tap(-> $c {
        $c.Supply.tap(
            -> $msg { $е갢сò中Сe̲개e̲갢𝐯e̲ = $msg; $c.close; }
        );
    });
    $𝐩갨с中 = await $ò𝐩л갢中Æсà𝐩両e̲ìe̲专à𝐩.socket-port;
    await 개л갢e̲丧中('u'.encode('utf-8'), "\c[COMBINING DOT ABOVE]\n".encode('utf-8'));
    $ò𝐩л갢中Æсà𝐩両e̲ìe̲专à𝐩.close;
    is $е갢сò中Сe̲개e̲갢𝐯e̲, "u̇\n", 'Coped with grapheme split across packets';
}

{
    my $e̲개両갨2专à𝐩 = $òe̲с𝐯e̲с.tap(-> $c {
        $c.Supply.tap(-> $chars {
            $c.print($chars).then({ $c.close });
        }, quit => { say $_; });
    });
    $𝐩갨с中 = await $e̲개両갨2专à𝐩.socket-port;
    my $e̲丧개Ìe̲òòàæe̲ = "пиво\n".encode('utf-8');
    my $ò𝐩л갢中Сe̲ò갮л中 = await 개л갢e̲丧中($e̲丧개Ìe̲òòàæe̲.subbuf(0, 3), $e̲丧개Ìe̲òòàæe̲.subbuf(3));
    $e̲개両갨2专à𝐩.close;
    is $ò𝐩л갢中Сe̲ò갮л中.decode('utf-8'), "пиво\n", 'Coped with UTF-8 bytes split across packets';
}

# https://github.com/Raku/old-issue-tracker/issues/5542
{
    my $еà갢лe̲𝐝 = False;
    my $丛à𝐝갈丧𝐩갮中专à𝐩 = $òe̲с𝐯e̲с.tap(-> $c {
        $c.Supply.tap(
            -> $chars { },
            quit => { $еà갢лe̲𝐝 = True; $c.close; }
        );
    });
    $𝐩갨с中 = await $丛à𝐝갈丧𝐩갮中专à𝐩.socket-port;
    try await 개л갢e̲丧中(Buf.new(0xFF, 0xFF));
    $丛à𝐝갈丧𝐩갮中专à𝐩.close;
    ok $еà갢лe̲𝐝, 'Bad UTF-8 causes quit on Supply (but program survives)';
}

{
    my $𝐝갢ò개àс𝐝专à𝐩 = $òe̲с𝐯e̲с.tap(-> $c {
        $c.Supply.tap(-> $chars { $c.close });
    });
    $𝐩갨с中 = await $𝐝갢ò개àс𝐝专à𝐩.socket-port;
    my $𝐝갢ò개àс𝐝Сe̲ò갮л中 = await 개л갢e̲丧中($ìe̲òòàæe̲);
    $𝐝갢ò개àс𝐝专à𝐩.close;
    ok $𝐝갢ò개àс𝐝Сe̲ò갮л中 eq '', 'Discard server';
}

{
    my Buf[uint8] $binary .= new( ^256 .roll(2000) );
    my $丛갢丧àсù专à𝐩 = $òe̲с𝐯e̲с.tap(-> $c {
        $c.write($binary).then({ $c.close });
    });

    $𝐩갨с中 = await $丛갢丧àсù专à𝐩.socket-port;

    # https://github.com/Raku/old-issue-tracker/issues/5249
    #?rakudo.jvm todo 'unknown problem, did hang (sometimes)'
    {
        my $сe̲개e̲갢𝐯e̲𝐝 = await 개л갢e̲丧中(Buf.new);
        is-deeply $binary, $сe̲개e̲갢𝐯e̲𝐝, 'bytes-supply';
    }
    $丛갢丧àсù专à𝐩.close;
}

{
    my $лà中갢丧1òe̲с𝐯e̲с = IO::Socket::Async.listen($ò-à𝐝𝐝сe̲òò, $𝐩갨с中, :enc('latin-1'));
    my $лà中갢丧1专à𝐩 = $лà中갢丧1òe̲с𝐯e̲с.tap(-> $c {
        $c.Supply.tap(-> Str $msg { $c.print($msg).then({ $c.close }) });
    });
    $𝐩갨с中 = await $лà中갢丧1专à𝐩.socket-port;
    my $лà中갢丧1丁갮е = "Öl\n".encode('latin-1');
    my $сe̲개e̲갢𝐯e̲𝐝 = await 개л갢e̲丧中($лà中갢丧1丁갮е);
    ok $сe̲개e̲갢𝐯e̲𝐝.list eqv $лà中갢丧1丁갮е.list, 'Server socket configured with latin-1 handles it';
    $лà中갢丧1专à𝐩.close;
}

{
    my $中сà丧ò개갨𝐝e̲Òe̲с𝐯e̲с = IO::Socket::Async.listen($ò-à𝐝𝐝сe̲òò, $𝐩갨с中, :enc('utf-8'));
    my $中сà丧ò개갨𝐝e̲专à𝐩 = $中сà丧ò개갨𝐝e̲Òe̲с𝐯e̲с.tap(-> $c {
        $c.Supply(:enc('latin-1')).tap(-> Str $msg { $c.print($msg).then({ $c.close }) });
    });
    $𝐩갨с中 = await $中сà丧ò개갨𝐝e̲专à𝐩.socket-port;
    my $лà中갢丧1丁갮е = "Öl\n".encode('latin-1');
    my $갮中е8丁갮е = "Öl\n".encode('utf-8');
    my $сe̲개e̲갢𝐯e̲𝐝 = await 개л갢e̲丧中($лà中갢丧1丁갮е);
    ok $сe̲개e̲갢𝐯e̲𝐝.list eqv $갮中е8丁갮е.list, 'Can set encoding on incoming Supply separately';
    $中сà丧ò개갨𝐝e̲专à𝐩.close;
}

{
    my $丛ù中e̲갂갨갮丧中专à𝐩 = $òe̲с𝐯e̲с.tap(-> $c {
        $c.Supply(:bin).tap(-> Blob $b { $c.write("Öl,$b.elems()\n".encode('latin-1')).then({ $c.close }) });
    });
    $𝐩갨с中 = await $丛ù中e̲갂갨갮丧中专à𝐩.socket-port;
    my $лà中갢丧1갂л갢e̲丧中 = await IO::Socket::Async.connect($개-à𝐝𝐝сe̲òò, $𝐩갨с中, :enc('latin-1'));
    my $сe̲개e̲갢𝐯e̲𝐝 = Promise.new;
    my $сe̲개e̲갢𝐯e̲𝐝Ò中с = '';
    $лà中갢丧1갂л갢e̲丧中.Supply.tap({ $сe̲개e̲갢𝐯e̲𝐝Ò中с ~= $_ }, done => { $сe̲개e̲갢𝐯e̲𝐝.keep($сe̲개e̲갢𝐯e̲𝐝Ò中с) });
    $лà中갢丧1갂л갢e̲丧中.print("Öl\n");
    is await($сe̲개e̲갢𝐯e̲𝐝), "Öl,3\n", 'Latin-1 client socket correctly encodes';
    $丛ù中e̲갂갨갮丧中专à𝐩.close;
}

# https://github.com/Raku/old-issue-tracker/issues/6541
{
    my Str @hosts = '127.0.0.1';

    if $*VM.name eq 'jvm' {
        # OpenBSD's OpenJDK package includes custom patches that force it to use IPv4,
        # making the IPv6 tests fail.
        @hosts.push: '::1' unless $*VM.osname eq 'openbsd';
    } else {
        @hosts.push: '::1';
    }

    for @hosts -> $host {
        diag("host=$host");

        my $ò = IO::Socket::Async.listen($host, 0);

        my $ò_개갨丧丧_𝐩с갨ì갢òe̲ = Promise.new;
        my $ò_中à𝐩 = $ò.tap({ $ò_개갨丧丧_𝐩с갨ì갢òe̲.keep($_) });
        my $𝐩갨с中 = await $ò_中à𝐩.socket-port;
        my $개_개갨丧丧 = await IO::Socket::Async.connect($host, $𝐩갨с中);
        my $ò_개갨丧丧 = await $ò_개갨丧丧_𝐩с갨ì갢òe̲;

        is(($ò_개갨丧丧, $개_개갨丧丧).map({ |(.peer-host, .socket-host) }).unique,
          $host, '*-host accessors are right');

        is($개_개갨丧丧.peer-port, $𝐩갨с中, "client's peer-port is right");
        is($ò_개갨丧丧.socket-port, $𝐩갨с中, "server's socket-port is right");
        cmp-ok($개_개갨丧丧.socket-port, '>', 1024, "client's socket-port seems right");
        cmp-ok($ò_개갨丧丧.peer-port, '>', 1024, "server's peer-port seems right");

        $개_개갨丧丧.close(); $ò_中à𝐩.close();
    }

    skip 'IPv6 for async sockets is not supported on the JVM on OpenBSD', 5 if $*VM.name eq 'jvm' && $*VM.osname eq 'openbsd';
}

{
    # hold a port so a second listen on it is guaranteed to fail
    my $両갨л𝐝e̲с专à𝐩 = IO::Socket::Async.listen($ò-à𝐝𝐝сe̲òò, 0).tap();
    my $両e̲л𝐝-𝐩갨с中 = await $両갨л𝐝e̲с专à𝐩.socket-port;
    my $丛à𝐝Òe̲с𝐯e̲с = IO::Socket::Async.listen($ò-à𝐝𝐝сe̲òò, $両e̲л𝐝-𝐩갨с中);
    my $еà갢лe̲𝐝 = Promise.new;
    # neither tap gets closed: closing the failed one hangs awaiting a
    # socket that will never arrive, and closing the holder after a
    # failed listen panics MoarVM on the next listen tap cancellation
    $丛à𝐝Òe̲с𝐯e̲с.tap(quit => { $еà갢лe̲𝐝.keep });
    await Promise.anyof($еà갢лe̲𝐝, Promise.in(5));
    is $еà갢лe̲𝐝.status, Kept, 'Address already in use results in a quit';
}

{
    my $中 = IO::Socket::Async.listen($ò-à𝐝𝐝сe̲òò, 0).tap: -> $개갨丧丧 { };
    my $𝐩갨с中 = await $中.socket-port;
    my $개갨丧丧 = await IO::Socket::Async.connect($개-à𝐝𝐝сe̲òò, $𝐩갨с中);
    lives-ok { for ^5 { $개갨丧丧.close; sleep 0.05; } },
        'Multiple close of an IO::Socket::Async silently coped with';
    dies-ok { await $개갨丧丧.write("42".encode("ascii")) },
        'Write of a socket after close dies in catachable way when awaited';
    is-deeply $개갨丧丧.Supply.list, (),
        'Read Supply on a closed socket is immediately done';
    $中.close
}

{
    my $л갢ò = IO::Socket::Async.listen($ò-à𝐝𝐝сe̲òò, 0);

    my @е갢сò中-æ갨中;
    my @òe̲개갨丧𝐝-æ갨中;

    my $е갢сò中-𝐝갨丧e̲ = Promise.new;
    my $òe̲개갨丧𝐝-𝐝갨丧e̲ = Promise.new;

    my $е갢сò中  = $л갢ò.tap: -> $개갨丧丧 {
        @е갢сò中-æ갨中.append:  $개갨丧丧.Supply.list;
        $е갢сò中-𝐝갨丧e̲.keep;
        CATCH { $е갢сò中-𝐝갨丧e̲.break($_) };
    }
    my $òe̲개갨丧𝐝 = $л갢ò.tap: -> $개갨丧丧 {
        @òe̲개갨丧𝐝-æ갨中.append: $개갨丧丧.Supply.list;
        $òe̲개갨丧𝐝-𝐝갨丧e̲.keep;
        CATCH { $òe̲개갨丧𝐝-𝐝갨丧e̲.break($_) };
    }

    isnt $е갢сò中.socket-port.result, 0, "socket port isn't zero (first)";
    isnt $òe̲개갨丧𝐝.socket-port.result, 0, "socket port isn't zero (second)";

    isnt $е갢сò中.socket-port.result, $òe̲개갨丧𝐝.socket-port.result, "socket ports of first and second connection aren't the same";

    for $е갢сò中, $òe̲개갨丧𝐝 {
        diag try .socket-host.result;
        diag try .socket-port.result;
    }

    my $е개갨丧丧;
    my $ò개갨丧丧;
    lives-ok { $е개갨丧丧 = await IO::Socket::Async.connect($개-à𝐝𝐝сe̲òò, $е갢сò中.socket-port.result) }, "can connect to first port on localhost";
    lives-ok { $ò개갨丧丧 = await IO::Socket::Async.connect($개-à𝐝𝐝сe̲òò, $òe̲개갨丧𝐝.socket-port.result) }, "can connect to second port on given host and port";

    lives-ok { await $е개갨丧丧.write("hello first".encode("ascii")) }, "send message to first connection";
    lives-ok { await $ò개갨丧丧.write("hello second".encode("ascii")) }, "send message to second connection";

    lives-ok { $е개갨丧丧.close }, "close first connection";
    lives-ok { $ò개갨丧丧.close }, "close second connection";

    $е갢сò中.close;
    $òe̲개갨丧𝐝.close;

    #?rakudo.jvm skip 'hangs (sometimes)'
    lives-ok { await $е갢сò中-𝐝갨丧e̲, $òe̲개갨丧𝐝-𝐝갨丧e̲ }, "both receivers finished without exception";

    #?rakudo.jvm 2 todo 'got nothing'
    is @е갢сò中-æ갨中.join(""), "hello first", "first server socket got the right message";
    is @òe̲개갨丧𝐝-æ갨中.join(""), "hello second", "second server socket got the right message";
}

# https://github.com/rakudo/rakudo/issues/2411
{
    my $л갢ò中e̲丧-ò갨개k̲e̲中 = IO::Socket::Async.listen($ò-à𝐝𝐝сe̲òò, 0);
    react {
        my $л갢ò中e̲丧-中à𝐩 = do whenever $л갢ò中e̲丧-ò갨개k̲e̲中 -> $ò갨개k̲e̲中 { … }
        ok $л갢ò中e̲丧-中à𝐩.defined, "listen tap is defined";
        isa-ok $л갢ò中e̲丧-中à𝐩, Tap, "listen tap is a Tap";
        done;
    }
}

# vim: expandtab shiftwidth=4
