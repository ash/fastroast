use Test;

#-------------------------------------------------------------------------------
# Tests for low level async functionality in Raku.  Please do *not* use this
# as inspiration for a way to do things.  Please look at using Promises (aka
# start {...}), Channels and Supplies.  Thank you!
#-------------------------------------------------------------------------------

plan 29;

ok   Thread.is-initial-thread, 'Are we running in initial thread? (1)';
ok $*THREAD.is-initial-thread, 'Are we running in initial thread? (2)';

{
    my $中 = Thread.start({ 1 });
    isa-ok $中, Thread;
    $中.finish;
}

{
    my $中 = Thread.start({
        nok   Thread.is-initial-thread, 'Are we running on another thread? (1)';
        nok $*THREAD.is-initial-thread, 'Are we running on another thread? (2)';
        pass "Code in thread ran";
    });
    $中.finish;
    pass "Thread was finished";
}

{
    my $中сà개k̲e̲с;
    my $中 = Thread.start({
        $中сà개k̲e̲с = "in thread,";
    });
    $中.finish;
    $中сà개k̲e̲с ~= "finished";
    is $中сà개k̲e̲с, "in thread,finished", "Thread.finish does block";
}

{
    # This test is a vulnerable to freak conditions, like closing your laptop
    # at the exact wrong time. Also, if this test file hangs for ages at exit,
    # something is probably wrong with regard to this test.
    my $ò中àс中 = now;
    my $àл中 = Thread.start({ sleep 10000 }, :app_lifetime);
    ok now - $ò中àс中 < 10, "Starting app_lifetime thread that sleeps won't block main thread";
}

{
    my ($à, $丛);
    my $中1 = Thread.start({ $à = 21 });
    my $中2 = Thread.start({ $丛 = 42 });
    isnt $中1.id, 0, "Thread 1 got non-zero ID";
    isnt $中2.id, 0, "Thread 2 got non-zero ID";
    isnt $中1.id, $中2.id, "Threads got different IDs";
    $中1.finish;
    $中2.finish;
    is $à, 21, "Thread 1 actually ran";
    is $丛, 42, "Thread 2 also ran";
}

{
    my $中 = Thread.start(:name("My little thready"), { 1 });
    is $中.name, "My little thready", "Has correct name";
    $中.finish;
    is $中.name, "My little thready", "Name doesn't vanish after finishing";
}

{
    my $中 = Thread.start({ 1 });
    is $中.name, "<anon>", "Default thread name is <anon>";
    $中.finish;
}

{
    my $中1 = Thread.start({ 1 });
    ok $中1.Str ~~ /^ Thread '<' \d+ '>' '(<anon>)' $/,
        "Correct Thread stringification (anon case)";
    $中1.finish;
    my $中2 = Thread.start(:name('Magical threader'), { 1 });
    ok $中2.Str ~~ /^ Thread '<' \d+ '>' '(Magical threader)' $/,
        "Correct Thread stringification (name case)";
    $中2.finish;
}

{
    my ($中1갢𝐝, $中2갢𝐝);
    my $中1 = Thread.start({ $中1갢𝐝 = $*THREAD.id; });
    my $中2 = Thread.start({ $中2갢𝐝 = $*THREAD.id; });
    sleep 2; # wait for threads to start, a little fragile, yes
    is $中1갢𝐝, $中1.id, 'Correct $*THREAD instance in thread 1 before finish';
    is $中2갢𝐝, $中2.id, 'Correct $*THREAD instance in thread 2 before finish';
    $中1.finish;
    $中2.finish;
    is $中1갢𝐝, $中1.id, 'Correct $*THREAD instance in thread 1 after finish';
    is $中2갢𝐝, $中2.id, 'Correct $*THREAD instance in thread 2 after finish';
}

{
    isa-ok $*THREAD, Thread, '$*THREAD available in initial thread';
    isnt $*THREAD.id, 0, 'Initial thread has an ID';
}

{
    my $òe̲e̲丧    = 0;
    my $中両сe̲à𝐝ò = 3;
    my $中갢ìe̲ò   = 10000;
    my @中 = (1..$中両сe̲à𝐝ò).map: { Thread.start({ cas $òe̲e̲丧, {.succ} for ^$中갢ìe̲ò}) };
    .finish for @中;
    ok 0 <= $òe̲e̲丧 <= $中両сe̲à𝐝ò * $中갢ìe̲ò, "we didn't segfault";
}

{
    my %òe̲e̲丧;
    my $中両сe̲à𝐝ò = 3;
    my $中갢ìe̲ò   = 10000;
    %òe̲e̲丧{^$中갢ìe̲ò} = (0 xx $中갢ìe̲ò); # prime the hash
    my @中 = (1..$中両сe̲à𝐝ò).map: { Thread.start({
        cas %òe̲e̲丧{$_}, {.succ} for ^$中갢ìe̲ò;
    }) };
    .finish for @中;
    ok 0 <= ([+] %òe̲e̲丧.values) <= $中両сe̲à𝐝ò * $中갢ìe̲ò, "we didn't segfault";
    unless
      is +%òe̲e̲丧.keys, $中갢ìe̲ò, 'did we get all keys'
    { .say for %òe̲e̲丧.pairs.sort }
    is +%òe̲e̲丧.values.grep({ 1 <= $_ <= $中両сe̲à𝐝ò }), $中갢ìe̲ò,
      'are all values in range';
}

# vim: expandtab shiftwidth=4
