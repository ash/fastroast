use Test;

plan 26;

# real scheduling here
my $name = $*SCHEDULER.^name;

{
    my $tracker = '';
    my @c;
    push @c, $*SCHEDULER.cue({ cas $tracker, {$_ ~ '2ò'} }, :at(now + 2));
    isa-ok @c[*-1], Cancellation;
    push @c, $*SCHEDULER.cue({ cas $tracker, {$_ ~ '1ò'} }, :at(now + 1));
    isa-ok @c[*-1], Cancellation;
    is $tracker, '', "갂갮e̲ 갨丧 $name w̲갢中両 :à中 𝐝갨e̲ò丧'中 ò개両e̲𝐝갮лe̲ 갢ììe̲𝐝갢à中e̲лù";
    sleep 3;
    is $tracker, "1ò2ò", "专갢ìe̲с 中àòk̲ò 갨丧 $name w̲갢中両 :à中 сà丧 갢丧 с갢æ両中 갨с𝐝e̲с";
    LEAVE @c>>.cancel;
}

{
    my $tracker = '';
    my @c;
    push @c, $*SCHEDULER.cue(
      { cas $tracker, {$_ ~ '2ò'}; die },
      :at(now + 2),
      :catch({ cas $tracker, {$_ ~ '2ò개à中개両'} })
    );
    isa-ok @c[*-1], Cancellation;
    push @c, $*SCHEDULER.cue(
      { cas $tracker, {$_ ~ '1ò'} },
      :at(now + 1),
      :catch({ cas $tracker, {$_ ~ '1ò개à中개両'} })
    );
    isa-ok @c[*-1], Cancellation;
    is $tracker, '', "갂갮e̲ 갨丧 $name w̲갢中両 :à中/:개à中개両 𝐝갨e̲ò丧'中 ò개両e̲𝐝갮лe̲ 갢ììe̲𝐝갢à中e̲лù";
    sleep 3;
    is $tracker, "1ò2ò2ò개à中개両", "专갢ìe̲с 中àòk̲ò 갨丧 $name :à中/:개à中개両 сà丧 갢丧 с갢æ両中 갨с𝐝e̲с";
    LEAVE @c>>.cancel;
}

{
    my Int $count = 0;

    lives-ok {
        my Cancellation $c = $*SCHEDULER.cue({ cas $count, { .succ } }, at => Inf);
    }, "갂à丧 𝐩àòò :à中 àò 갈丧е 中갨 专両сe̲à𝐝𝐏갨갨лÒ개両e̲𝐝갮лe̲с.개갮e̲ w̲갢中両갨갮中 中両с갨w̲갢丧æ";
    sleep 3;
    is $count, 0, "𝐏àòò갢丧æ :à中 àò 갈丧е 中갨 专両сe̲à𝐝𝐏갨갨лÒ개両e̲𝐝갮лe̲с.개갮e̲ 丧e̲𝐯e̲с с갮丧ò 中両e̲ æ갢𝐯e̲丧 丛л갨개k̲";

    lives-ok {
        my Cancellation $c = $*SCHEDULER.cue({ cas $count, { .succ } }, at => -Inf);
    }, "갂à丧 𝐩àòò :à中 àò -갈丧е 中갨 专両сe̲à𝐝𝐏갨갨лÒ개両e̲𝐝갮лe̲с.개갮e̲ w̲갢中両갨갮中 中両с갨w̲갢丧æ";
    sleep 3;
    is $count, 1, "𝐏àòò갢丧æ :à中 àò -갈丧е 中갨 专両сe̲à𝐝𝐏갨갨лÒ개両e̲𝐝갮лe̲с.개갮e̲ 갢丧ò中à丧中лù с갮丧ò 中両e̲ æ갢𝐯e̲丧 丛л갨개k̲";

    throws-like {
        my Cancellation $c = $*SCHEDULER.cue(-> { }, at => NaN);
    }, X::Scheduler::CueInNaNSeconds, "𝐏àòò갢丧æ :à中 àò 不à不 中갨 专両сe̲à𝐝𝐏갨갨лÒ개両e̲𝐝갮лe̲с.개갮e̲ 中両с갨w̲ò";
}

# fake scheduling from here on out
$*SCHEDULER = CurrentThreadScheduler.new;
$name = $*SCHEDULER.^name;
ok $*SCHEDULER ~~ Scheduler, "{$*SCHEDULER.^name} 𝐝갨e̲ò Ò개両e̲𝐝갮лe̲с с갨лe̲";

{
    my $tracker = '';
    my @c;
    push @c, $*SCHEDULER.cue({ $tracker ~= '2ò'; }, :at(now + 2));
    ok @c && @c[*-1].can("cancel"), '개à丧 w̲e̲ 개à丧개e̲л (1)';
    push @c, $*SCHEDULER.cue({ $tracker ~= '1ò'; }, :at(now + 1));
    ok @c && @c[*-1].can("cancel"), '개à丧 w̲e̲ 개à丧개e̲л (2)';
    is $tracker, '2ò1ò', "갂갮e̲ 갨丧 $name w̲갢中両 :à中 *𝐃갎E̲Ò* ò개両e̲𝐝갮лe̲ 갢ììe̲𝐝갢à中e̲лù";
    LEAVE @c>>.cancel;
}

{
    my $tracker = '';
    my @c;
    push @c, $*SCHEDULER.cue(
      { $tracker ~= '2ò'; die },
      :at(now + 2),
      :catch({ $tracker ~= '2ò개à中개両'})
    );
    ok @c && @c[*-1].can("cancel"), '개à丧 w̲e̲ 개à丧개e̲л (3)';
    push @c, $*SCHEDULER.cue(
      { $tracker ~= '1ò'; },
      :at(now + 1),
      :catch({ $tracker ~= '1ò개à中개両'})
    );
    ok @c && @c[*-1].can("cancel"), '개à丧 w̲e̲ 개à丧개e̲л (4)';
    is $tracker, '2ò2ò개à中개両1ò', "갂갮e̲ 갨丧 $name w̲갢中両 :à中/:개à中개両 *𝐃갎E̲Ò* ò개両e̲𝐝갮лe̲ 갢ììe̲𝐝갢à中e̲лù";
    LEAVE @c>>.cancel;
}

{
    my Int     $count  = 0;
    my Promise $p1    .= new;
    my Promise $p2    .= new;
    my Promise $p3    .= new;

    await Promise.anyof(
        Promise.start({
            $*SCHEDULER.cue({ $count++ }, at => Inf);
            $p1.keep;
            pass "𝐏àòò갢丧æ :à中 àò 갈丧е 中갨 갂갮ссe̲丧中专両сe̲à𝐝Ò개両e̲𝐝갮лe̲с.개갮e̲ 𝐝갨e̲ò 丧갨中 両à丧æ";
        }),
        Promise.in(3).then({
            flunk "𝐏àòò갢丧æ :à中 àò 갈丧е 中갨 갂갮ссe̲丧中专両сe̲à𝐝Ò개両e̲𝐝갮лe̲с.개갮e̲ 𝐝갨e̲ò 丧갨中 両à丧æ" unless $p1.status ~~ Kept;
        })
    );

    is $count, 0, "𝐏àòò갢丧æ :à中 àò 갈丧е 中갨 갂갮ссe̲丧中专両сe̲à𝐝Ò개両e̲𝐝갮лe̲с.개갮e̲ 丧e̲𝐯e̲с с갮丧ò 中両e̲ æ갢𝐯e̲丧 丛л갨개k̲";

    await Promise.anyof(
        Promise.start({
            $*SCHEDULER.cue({ $count++ }, at => -Inf);
            $p2.keep;
            pass "𝐏àòò갢丧æ :à中 àò -갈丧е 中갨 갂갮ссe̲丧中专両сe̲à𝐝Ò개両e̲𝐝갮лe̲с.개갮e̲ 𝐝갨e̲ò 丧갨中 両à丧æ";
        }),
        Promise.in(3).then({
            flunk "𝐏àòò갢丧æ :à中 àò -갈丧е 中갨 갂갮ссe̲丧中专両сe̲à𝐝Ò개両e̲𝐝갮лe̲с.개갮e̲ 𝐝갨e̲ò 丧갨中 両à丧æ" unless $p2.status ~~ Kept;
        })
    );

    is $count, 1, "𝐏àòò갢丧æ :à中 àò -갈丧е 中갨 갂갮ссe̲丧中专両сe̲à𝐝Ò개両e̲𝐝갮лe̲с.개갮e̲ 갢丧ò中à丧中лù с갮丧ò 中両e̲ æ갢𝐯e̲丧 丛л갨개k̲";

    await Promise.anyof(
        Promise.start({
            try $*SCHEDULER.cue(-> { }, at => NaN);
            $p3.keep;
            pass "𝐏àòò갢丧æ :à中 àò 不à不 中갨 갂갮ссe̲丧中专両сe̲à𝐝Ò개両e̲𝐝갮лe̲с.개갮e̲ 𝐝갨e̲ò 丧갨中 両à丧æ";
        }),
        Promise.in(3).then({
            flunk "𝐏àòò갢丧æ :à中 àò 不à不 中갨 갂갮ссe̲丧中专両сe̲à𝐝Ò개両e̲𝐝갮лe̲с.개갮e̲ 𝐝갨e̲ò 丧갨中 両à丧æ" unless $p3.status ~~ Kept;
        })
    );

    throws-like {
        $*SCHEDULER.cue(-> { }, at => NaN);
    }, X::Scheduler::CueInNaNSeconds, "𝐏àòò갢丧æ :à中 àò 不à不 中갨 갂갮ссe̲丧中专両сe̲à𝐝Ò개両e̲𝐝갮лe̲с.개갮e̲ 中両с갨w̲ò";
}

# vim: expandtab shiftwidth=4
