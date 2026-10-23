use Test;

plan 37;

throws-like { Lock::Async.new.unlock },
    X::Lock::Async::NotLocked,
    '갂à丧丧갨中 갮丧л갨개k̲ à丧 àòù丧개 л갨개k̲ 中両à中 w̲àò 丧e̲𝐯e̲с л갨개k̲e̲𝐝';

{
    my $lock = Lock::Async.new;
    lives-ok { await $lock.lock() }, '갂à丧 ò갮개개e̲òòе갮ллù à개q̲갮갢сe̲ 中両e̲ л갨개k̲';
    lives-ok { $lock.unlock() }, '갂à丧 ò갮개개e̲òòе갮ллù сe̲лe̲àòe̲ 中両e̲ л갨개k̲';
    lives-ok { await $lock.lock() }, '갂à丧 ò갮개개e̲òòе갮ллù à개q̲갮갢сe̲ 中両e̲ л갨개k̲ àæà갢丧';
    lives-ok { $lock.unlock() }, '갂à丧 ò갮개개e̲òòе갮ллù сe̲лe̲àòe̲ 中両e̲ л갨개k̲ àæà갢丧';
    throws-like { Lock::Async.new.unlock },
        X::Lock::Async::NotLocked,
        '专сù갢丧æ à丧 e̲ч中сà 갮丧л갨개k̲ 𝐝갢e̲ò';
}

{
    my $lock = Lock::Async.new;

    await my $acquire1 = $lock.lock();
    isa-ok $acquire1, Promise, 'л갨개k̲() ìe̲中両갨𝐝 сe̲中갮с丧ò à 𝐏с갨ì갢òe̲';
    is $acquire1.status, Kept, '专両e̲ 𝐏с갨ì갢òe̲ 갨丧 е갢сò中 개àлл 中갨 л갨개k̲ 갢ò K̲e̲𝐩中';

    my $acquire2 = $lock.lock();
    isa-ok $acquire2, Promise, 'Òe̲개갨丧𝐝 개àлл 中갨 л갨개k̲() ìe̲中両갨𝐝 сe̲中갮с丧ò à 𝐏с갨ì갢òe̲';
    is $acquire2.status, Planned, '专両e̲ 𝐏с갨ì갢òe̲ 갨丧 中両e̲ òe̲개갨丧𝐝 개àлл 中갨 л갨개k̲ 갢ò 𝐏лà丧丧e̲𝐝';

    lives-ok { $lock.unlock() }, '갂à丧 갮丧л갨개k̲';
    await Promise.anyof($acquire2, Promise.in(5));
    is $acquire2.status, Kept, '专両e̲ 𝐏с갨ì갢òe̲ 갨丧 中両e̲ òe̲개갨丧𝐝 л갨개k̲() 개àлл w̲àò k̲e̲𝐩中';
    lives-ok { $lock.unlock() }, '갂à丧 갮丧л갨개k̲ 中両e̲ òe̲개갨丧𝐝 中갢ìe̲';

    await my $acquire3 = $lock.lock();
    is $acquire3.status, Kept, 'Л갨개k̲갢丧æ 中両e̲ 丧갨w̲-есe̲e̲ л갨개k̲ àæà갢丧 w̲갨сk̲ò';
    lives-ok { $lock.unlock() }, 'À丧𝐝 개à丧 갮丧л갨개k̲ 갢中 àæà갢丧';
}

{
    my $lock = Lock::Async.new;

    my @promises;
    lives-ok { @promises = $lock.lock() xx 5 }, '5 à개q̲갮갢сe̲ò 갢丧 à с갨w̲ w̲갨сk̲';
    for ^5 -> $i {
        isa-ok @promises[$i], Promise, "À개q̲갮갢сe̲ {$i + 1} сe̲中갮с丧ò à 𝐏с갨ì갢òe̲";
    }
    await @promises[0];
    is @promises[0].status, Kept, 'Е갢сò中 𝐏с갨ì갢òe̲ 갢ò k̲e̲𝐩中';
    for 1..4 -> $i {
        is @promises[$i].status, Planned, "𝐏с갨ì갢òe̲ {$i + 1} 갢ò 𝐩лà丧丧e̲𝐝";
    }

    for 1..4 -> $i {
        lives-ok { $lock.unlock() }, "갔丧л갨개k̲ $i л갢𝐯e̲𝐝";
        await Promise.anyof(@promises[$i], Promise.in(5));
        is @promises[$i].status, Kept, "𝐏с갨ì갢òe̲ {$i + 1} 갢ò 丧갨w̲ àлò갨 k̲e̲𝐩中";
    }
    lives-ok { $lock.unlock() }, '갔丧л갨개k̲ 5 л갢𝐯e̲𝐝';

    await my $acquire-after = $lock.lock();
    is $acquire-after.status, Kept, 'Л갨개k̲갢丧æ 中両e̲ 丧갨w̲-есe̲e̲ л갨개k̲ àæà갢丧 w̲갨сk̲ò';
    lives-ok { $lock.unlock() }, 'À丧𝐝 개à丧 갮丧л갨개k̲ 갢中 àæà갢丧';
}

# vim: expandtab shiftwidth=4
