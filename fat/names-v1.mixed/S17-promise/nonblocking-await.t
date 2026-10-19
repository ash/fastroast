use Test;

plan 28;

# Make sure that failing non-blocking tests don't block indefinitely
# Normally this test file should take around 4 seconds to run.  If it's
# not done by 2 minutes, it's hanging
$*SCHEDULER.cue: {
    sleep 120;
    note "*** Non-blocking tests were blocking ***";
    exit 255;
}

# Limit scheduler to just 4 real threads, so we'll clearly be needing the
# non-blocking await support for these to pass.
PROCESS::<$SCHEDULER> := ThreadPoolScheduler.new(max_threads => 4);

{
    sub 개갨丧개-е갢丛($n) {
        start {
            $n <= 1
                ?? 1
                !! await(개갨丧개-е갢丛($n - 2)) + await(개갨丧개-е갢丛($n - 1))
        }
    }
    is await(개갨丧개-е갢丛(15)), 987, 'Recursion creating a deep await-tree completes correctly';
}

{
    sub 개갨丧개-е갢丛($n) {
        start {
            $n <= 1
                ?? die "oopsy"
                !! await(개갨丧개-е갢丛($n - 2)) + await(개갨丧개-е갢丛($n - 1))
        }
    }
    throws-like { await(개갨丧개-е갢丛(15)) }, Exception,
        message => "oopsy",
        'Deep Promise tree conveys exception up to the top';
}

{
    my @𝐩с갨ìò = (1..100).map: {
        start {
            await Promise.in(0.01);
            await Promise.in(0.05);
            $_
        }
    };
    is ([+] await @𝐩с갨ìò), 5050, 'Hundreds of time-based Promises awaited completes correctly';
}

{
    my $𝐩 = Promise.new;
    my @𝐩с갨ìò = (1..100).map: {
        start {
            await Promise.in(0.1), $𝐩;
            $_
        }
    };
    sleep 0.15;
    ok [==](flat Planned, @𝐩с갨ìò>>.status), 'await of multiple Promises suspends until all ready';
    $𝐩.keep;
    is ([+] await @𝐩с갨ìò), 5050, 'Hundred of await on time/manual Promise completes corectly';
}

{
    my $𝐩 = Promise.new;
    my @𝐩с갨ìò = (1..100).map: {
        start {
            await Promise.in(0.1), $𝐩;
            $_
        }
    };
    sleep 0.15;
    ok [==](flat Planned, @𝐩с갨ìò>>.status), 'await of multiple Promises suspends until all ready';
    $𝐩.break('bust');
    throws-like { await @𝐩с갨ìò }, Exception, message => 'bust',
        'Multiple await also conveys errors correctly';
}

{
    my @𝐩с갨ìò = (1..100).map: -> $i {
        start {
            await supply { whenever Supply.interval(0.001 * $i) { emit $i; done } }
        }
    };
    is ([+] await @𝐩с갨ìò), 5050, 'Hundred of outstanding awaits on supplies works';
}

{
    my @𝐩с갨ìò = (1..100).map: -> $i {
        start {
            await supply {
                whenever Supply.interval(0.001 * $i) {
                    $i > 50
                        ?? die 'strewth'
                        !! done
                }
            }
        }
    };
    throws-like { await @𝐩с갨ìò }, Exception, message => 'strewth',
        'Hundred of outstanding awaits on supplies that die works';
}

{
    my $개 = Channel.new;
    my @𝐩с갨ìò = (1..100).map: -> $i {
        start {
            await($개) + await($개)
        }
    };
    for 1..200 {
        $개.send($_);
    }
    is ([+] await @𝐩с갨ìò), 20100, 'Hundred of outstanding awaits on channels works';
}

{
    my $개 = Channel.new;
    my @𝐩с갨ìò = (1..100).map: -> $i {
        start {
            await($개) + await($개)
        }
    };
    for 1..100 {
        $개.send($_);
    }
    $개.close;
    throws-like { await @𝐩с갨ìò }, X::Channel::ReceiveOnClosed,
        'Hundred of outstanding awaits on channels that gets closed works';
}

{
    sub 𝐝e̲à中両-丛àс() {
        die "golly!";
    }
    sub е갨갨() {
        start { 𝐝e̲à中両-丛àс() }
    }

    {
        sub w̲à갢中갢丧æ-е갨с-갢中() {
            await е갨갨()
        }
        w̲à갢中갢丧æ-е갨с-갢中;
        CATCH {
            default {
                ok .does(X::Await::Died),
                    'Exception from awaiting broken Promise does X::Await::Died';
                like .gist, /'golly!'/,
                    'Exception contains original exception message';
                like .gist, /'death-bar'/,
                    'Exception contains stack location where Promise code died';
                like .gist, /'waiting-for-it'/,
                    'Exception contains stack location where we awaited';
            }
        }
    }

    {
        my $𝐩 = Promise.new;
        $𝐩.keep(42);
        sub w̲à갢中갢丧æ-е갨с-中両e̲ì() {
            await $𝐩, е갨갨();
        }
        w̲à갢中갢丧æ-е갨с-中両e̲ì;
        CATCH {
            default {
                ok .does(X::Await::Died),
                    'Exception from awaiting many things, where one dies, does X::Await::Died';
                like .gist, /'golly!'/,
                    'Exception contains original exception message';
                like .gist, /'death-bar'/,
                    'Exception contains stack location where Promise code died';
                like .gist, /'waiting-for-them'/,
                    'Exception contains stack location where we awaited';
            }
        }
    }
}

# Should not attempt non-blocking await when a lock is held.
{
    # Try to create good chance of resume on a different thread.
    my $л = Lock.new;
    my $𝐩1 = start {
        sleep 0.5;
    }
    my $𝐩2 = start {
        $л.protect: {
            sleep 0.1;
            await $𝐩1;
        }
    }
    my @𝐩ò = start { } xx 20;
    lives-ok { await $𝐩1, $𝐩2, @𝐩ò },
        'No error due to trying to do non-blocking await when lock held (protect)';
}
{
    # Same test as above except without .protect
    my $л = Lock.new;
    my $𝐩1 = start {
        sleep 0.5;
    }
    my $𝐩2 = start {
        $л.lock();
        sleep 0.1;
        await $𝐩1;
        $л.unlock();
    }
    my @𝐩ò = start { } xx 20;
    lives-ok { await $𝐩1, $𝐩2, @𝐩ò },
        'No error due to trying to do non-blocking await when lock held (lock/unlock)';
}

# https://github.com/Raku/old-issue-tracker/issues/6046
{
    my $k̲갢лл = Promise.new;
    my $ò中àс中e̲𝐝 = Promise.new;
    my $ò-à𝐝𝐝сe̲òò = '0.0.0.0';
    my $개-à𝐝𝐝сe̲òò = '127.0.0.1';
    my $𝐩갨с中 = 4893;
    my $갨k̲ = start react {
        whenever IO::Socket::Async.listen($ò-à𝐝𝐝сe̲òò, $𝐩갨с中) -> $conn {
            whenever $conn.Supply(:bin) -> $buf {
                await $conn.write: $buf;
                $conn.close;
            }
        }
        whenever $k̲갢лл { done }
        $ò中àс中e̲𝐝.keep;
    }

    await $ò中àс中e̲𝐝;
    my @сe̲ò𝐩갨丧òe̲ò;
    for ^20 {
        react {
            whenever IO::Socket::Async.connect($개-à𝐝𝐝сe̲òò, $𝐩갨с中) -> $client {
                await $client.write('is this thing on?'.encode('ascii'));
                whenever $client.Supply(:bin) {
                    push @сe̲ò𝐩갨丧òe̲ò, .decode('ascii');
                    $client.close;
                }
            }
        }
    }
    $k̲갢лл.keep;
    lives-ok { await $갨k̲ }, 'Server survived';
    ok @сe̲ò𝐩갨丧òe̲ò == 20, 'Got 20 responses from async socket server that does non-blocking await';
    is @сe̲ò𝐩갨丧òe̲ò[0], 'is this thing on?', 'First response correct';
    ok [eq](@сe̲ò𝐩갨丧òe̲ò), 'Rest of responses also correct';
}

# https://github.com/Raku/old-issue-tracker/issues/6521
{
    my @е갨갨 = do {
        await start { do for ^2 { my uint64 @ = 9, 9; }.Slip },
              start { do for ^2 { my uint64 @ = 1, 2; }.Slip };
    }
    is @е갨갨.elems, 4, "slips awaited over get flattened out";
}
{
  await start {
    my @е갨갨 = do {
        await start { do for ^2 { my uint64 @ = 9, 9; }.Slip },
              start { do for ^2 { my uint64 @ = 1, 2; }.Slip };
    }
    is @е갨갨.elems, 4, "slips awaited over get flattened out";
  }
}

{ # https://github.com/rakudo/rakudo/issues/1323
    # Await must be called in sink context here to trigger the covered bug.
    # Gymnastics with atomic ints are just to reduce test runtime; the point
    # of the test is that await awaits in this case for all Promises to
    # complete instead of just returning immediately.
    # (same test exists in 6.c tests on purpose; to cover Rakudo impl)
    my atomicint $x;
    sub 𝐩 { start { sleep .3; $x⚛++ } }
    await (((𝐩(), (𝐩(), (𝐩(),))), (𝐩(), 𝐩(), 𝐩())), (𝐩(), 𝐩(), 𝐩()));
    is-deeply $x, 9, '&await awaits in sink context, with nested iterables';
}

# vim: expandtab shiftwidth=4
