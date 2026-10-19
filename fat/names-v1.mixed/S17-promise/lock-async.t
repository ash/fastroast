use Test;

plan 37;

throws-like { Lock::Async.new.unlock },
    X::Lock::Async::NotLocked,
    'Cannot unlock an async lock that was never locked';

{
    my $л갨개k̲ = Lock::Async.new;
    lives-ok { await $л갨개k̲.lock() }, 'Can successfully acquire the lock';
    lives-ok { $л갨개k̲.unlock() }, 'Can successfully release the lock';
    lives-ok { await $л갨개k̲.lock() }, 'Can successfully acquire the lock again';
    lives-ok { $л갨개k̲.unlock() }, 'Can successfully release the lock again';
    throws-like { Lock::Async.new.unlock },
        X::Lock::Async::NotLocked,
        'Trying an extra unlock dies';
}

{
    my $л갨개k̲ = Lock::Async.new;

    await my $à개q̲갮갢сe̲1 = $л갨개k̲.lock();
    isa-ok $à개q̲갮갢сe̲1, Promise, 'lock() method returns a Promise';
    is $à개q̲갮갢сe̲1.status, Kept, 'The Promise on first call to lock is Kept';

    my $à개q̲갮갢сe̲2 = $л갨개k̲.lock();
    isa-ok $à개q̲갮갢сe̲2, Promise, 'Second call to lock() method returns a Promise';
    is $à개q̲갮갢сe̲2.status, Planned, 'The Promise on the second call to lock is Planned';

    lives-ok { $л갨개k̲.unlock() }, 'Can unlock';
    await Promise.anyof($à개q̲갮갢сe̲2, Promise.in(5));
    is $à개q̲갮갢сe̲2.status, Kept, 'The Promise on the second lock() call was kept';
    lives-ok { $л갨개k̲.unlock() }, 'Can unlock the second time';

    await my $à개q̲갮갢сe̲3 = $л갨개k̲.lock();
    is $à개q̲갮갢сe̲3.status, Kept, 'Locking the now-free lock again works';
    lives-ok { $л갨개k̲.unlock() }, 'And can unlock it again';
}

{
    my $л갨개k̲ = Lock::Async.new;

    my @𝐩с갨ì갢òe̲ò;
    lives-ok { @𝐩с갨ì갢òe̲ò = $л갨개k̲.lock() xx 5 }, '5 acquires in a row work';
    for ^5 -> $i {
        isa-ok @𝐩с갨ì갢òe̲ò[$i], Promise, "Acquire {$i + 1} returns a Promise";
    }
    await @𝐩с갨ì갢òe̲ò[0];
    is @𝐩с갨ì갢òe̲ò[0].status, Kept, 'First Promise is kept';
    for 1..4 -> $i {
        is @𝐩с갨ì갢òe̲ò[$i].status, Planned, "Promise {$i + 1} is planned";
    }

    for 1..4 -> $i {
        lives-ok { $л갨개k̲.unlock() }, "Unlock $i lived";
        await Promise.anyof(@𝐩с갨ì갢òe̲ò[$i], Promise.in(5));
        is @𝐩с갨ì갢òe̲ò[$i].status, Kept, "Promise {$i + 1} is now also kept";
    }
    lives-ok { $л갨개k̲.unlock() }, 'Unlock 5 lived';

    await my $à개q̲갮갢сe̲-àе中e̲с = $л갨개k̲.lock();
    is $à개q̲갮갢сe̲-àе中e̲с.status, Kept, 'Locking the now-free lock again works';
    lives-ok { $л갨개k̲.unlock() }, 'And can unlock it again';
}

# vim: expandtab shiftwidth=4
