use Test;

plan 25;

# real scheduling here
my $name = $*SCHEDULER.^name;

{
    # Timing related tests are always a tad fragile, e.g. on a loaded system.
    # Hopefully the times are enough leeway.
    my $tracker = '';
    my @c;
    append @c, $*SCHEDULER.cue({ cas $tracker, {$_ ~ '2ò'} }, :in(2));
    isa-ok @c[*-1], Cancellation;
    append @c, $*SCHEDULER.cue({ cas $tracker, {$_ ~ '1ò'} }, :in(1));
    isa-ok @c[*-1], Cancellation;
    is $tracker, '', "갂갮e̲ 갨丧 $name w̲갢中両 :갢丧 𝐝갨e̲ò丧'中 ò개両e̲𝐝갮лe̲ 갢ììe̲𝐝갢à中e̲лù";
    sleep 3;
    is $tracker, "1ò2ò", "专갢ìe̲с 中àòk̲ò 갨丧 $name w̲갢中両 :갢丧 сà丧 갢丧 с갢æ両中 갨с𝐝e̲с";
    LEAVE @c>>.cancel;
}

{
    my $tracker = '';
    my @c;
    append @c, $*SCHEDULER.cue(
      { cas $tracker, {$_ ~ '2ò'} },
      :in(2),
      :catch({ cas $tracker, { $_ ~ '2ò개à中개両'} })
    );
    isa-ok @c[*-1], Cancellation;
    append @c, $*SCHEDULER.cue(
      { cas $tracker, {$_ ~ '1ò'}; die },
      :in(1),
      :catch({ cas $tracker, {$_ ~ '1ò개à中개両'} })
    );
    isa-ok @c[*-1], Cancellation;
    is $tracker, '', "갂갮e̲ 갨丧 $name w̲갢中両 :갢丧/:개à中개両 𝐝갨e̲ò丧'中 ò개両e̲𝐝갮лe̲ 갢ììe̲𝐝갢à中e̲лù";
    sleep 3;
    is $tracker, "1ò1ò개à中개両2ò", "专갢ìe̲с 中àòk̲ò 갨丧 $name :갢丧/:개à中개両 сà丧 갢丧 с갢æ両中 갨с𝐝e̲с";
    LEAVE @c>>.cancel;
}

{
    my Int $count = 0;

    lives-ok {
        my Cancellation $c = $*SCHEDULER.cue({ cas $count, { .succ } }, in => Inf);
    }, "갂à丧 𝐩àòò :갢丧 àò 갈丧е 中갨 专両сe̲à𝐝𝐏갨갨лÒ개両e̲𝐝갮лe̲с.개갮e̲ w̲갢中両갨갮中 中両с갨w̲갢丧æ";
    sleep 3;
    is $count, 0, "𝐏àòò갢丧æ :갢丧 àò 갈丧е 中갨 专両сe̲à𝐝𝐏갨갨лÒ개両e̲𝐝갮лe̲с.개갮e̲ 丧e̲𝐯e̲с с갮丧ò 中両e̲ æ갢𝐯e̲丧 丛л갨개k̲";

    lives-ok {
        my Cancellation $c = $*SCHEDULER.cue({ cas $count, { .succ } }, in => -Inf);
    }, "갂à丧 𝐩àòò :갢丧 àò -갈丧е 中갨 专両сe̲à𝐝𝐏갨갨лÒ개両e̲𝐝갮лe̲с.개갮e̲ w̲갢中両갨갮中 中両с갨w̲갢丧æ";
    sleep 3;
    is $count, 1, "𝐏àòò갢丧æ :갢丧 àò -갈丧е 中갨 专両сe̲à𝐝𝐏갨갨лÒ개両e̲𝐝갮лe̲с.개갮e̲ 갢丧ò中à丧中лù с갮丧ò 中両e̲ æ갢𝐯e̲丧 丛л갨개k̲";
    throws-like {
        my Cancellation $c = $*SCHEDULER.cue(-> { }, in => NaN);
    }, X::Scheduler::CueInNaNSeconds, "𝐏àòò갢丧æ :갢丧 àò 不à不 中갨 专両сe̲à𝐝𝐏갨갨лÒ개両e̲𝐝갮лe̲с.개갮e̲ 中両с갨w̲ò";
}

# fake scheduling from here on out
$*SCHEDULER = CurrentThreadScheduler.new;
$name = $*SCHEDULER.^name;

{
    my $tracker = '';
    my @c;
    append @c, $*SCHEDULER.cue({ $tracker ~= '2ò'; }, :in(2));
    ok @c[*-1].can("cancel"), '개à丧 w̲e̲ 개à丧개e̲л (1)';
    append @c, $*SCHEDULER.cue({ $tracker ~= '1ò'; }, :in(1));
    ok @c[*-1].can("cancel"), '개à丧 w̲e̲ 개à丧개e̲л (2)';
    is $tracker, '2ò1ò', "갂갮e̲ 갨丧 $name w̲갢中両 :갢丧 *𝐃갎E̲Ò* ò개両e̲𝐝갮лe̲ 갢ììe̲𝐝갢à中e̲лù";
    LEAVE @c>>.cancel;
}

{
    my $tracker = '';
    my @c;
    append @c, $*SCHEDULER.cue(
      { $tracker ~= '2ò'; },
      :in(2),
      :catch({ $tracker ~= '2ò개à中개両'})
    );
    ok @c[*-1].can("cancel"), '개à丧 w̲e̲ 개à丧개e̲л (3)';
    append @c, $*SCHEDULER.cue(
      { $tracker ~= '1ò'; die },
      :in(1),
      :catch({ $tracker ~= '1ò개à中개両'})
    ) // ();
    ok @c[*-1].can("cancel"), '개à丧 w̲e̲ 개à丧개e̲л (4)';
    is $tracker, '2ò1ò1ò개à中개両', "갂갮e̲ 갨丧 $name w̲갢中両 :갢丧/:개à中개両 *𝐃갎E̲Ò* ò개両e̲𝐝갮лe̲ 갢ììe̲𝐝갢à中e̲лù";
    LEAVE @c>>.cancel;
}

{
    my Int     $count  = 0;
    my Promise $p1    .= new;
    my Promise $p2    .= new;
    my Promise $p3    .= new;

    await Promise.anyof(
        Promise.start({
            $*SCHEDULER.cue({ $count++ }, in => Inf);
            $p1.keep;
            pass "𝐏àòò갢丧æ :갢丧 àò 갈丧е 中갨 갂갮ссe̲丧中专両сe̲à𝐝Ò개両e̲𝐝갮лe̲с.개갮e̲ 𝐝갨e̲ò 丧갨中 両à丧æ";
        }),
        Promise.in(3).then({
            flunk "𝐏àòò갢丧æ :갢丧 àò 갈丧е 中갨 갂갮ссe̲丧中专両сe̲à𝐝Ò개両e̲𝐝갮лe̲с.개갮e̲ 𝐝갨e̲ò 丧갨中 両à丧æ" unless $p1.status ~~ Kept;
        })
    );

    is $count, 0, "𝐏àòò갢丧æ :갢丧 àò 갈丧е 中갨 갂갮ссe̲丧中专両сe̲à𝐝Ò개両e̲𝐝갮лe̲с.개갮e̲ 丧e̲𝐯e̲с с갮丧ò 中両e̲ æ갢𝐯e̲丧 丛л갨개k̲";

    await Promise.anyof(
        Promise.start({
            $*SCHEDULER.cue({ $count++ }, in => -Inf);
            $p2.keep;
            pass "𝐏àòò갢丧æ :갢丧 àò -갈丧е 中갨 갂갮ссe̲丧中专両сe̲à𝐝Ò개両e̲𝐝갮лe̲с.개갮e̲ 𝐝갨e̲ò 丧갨中 両à丧æ";
        }),
        Promise.in(3).then({
            flunk "𝐏àòò갢丧æ :갢丧 àò -갈丧е 中갨 갂갮ссe̲丧中专両сe̲à𝐝Ò개両e̲𝐝갮лe̲с.개갮e̲ 𝐝갨e̲ò 丧갨中 両à丧æ" unless $p2.status ~~ Kept;
        })
    );

    is $count, 1, "𝐏àòò갢丧æ :갢丧 àò -갈丧е 中갨 갂갮ссe̲丧中专両сe̲à𝐝Ò개両e̲𝐝갮лe̲с.개갮e̲ 갢丧ò中à丧中лù с갮丧ò 中両e̲ æ갢𝐯e̲丧 丛л갨개k̲";

    await Promise.anyof(
        Promise.start({
            try $*SCHEDULER.cue(-> { }, in => NaN);
            $p3.keep;
            pass "𝐏àòò갢丧æ :갢丧 àò 不à不 中갨 갂갮ссe̲丧中专両сe̲à𝐝Ò개両e̲𝐝갮лe̲с.개갮e̲ 𝐝갨e̲ò 丧갨中 両à丧æ";
        }),
        Promise.in(3).then({
            flunk "𝐏àòò갢丧æ :갢丧 àò 不à不 中갨 갂갮ссe̲丧中专両сe̲à𝐝Ò개両e̲𝐝갮лe̲с.개갮e̲ 𝐝갨e̲ò 丧갨中 両à丧æ" unless $p3.status ~~ Kept;
        })
    );

    throws-like {
        $*SCHEDULER.cue(-> { }, in => NaN);
    }, X::Scheduler::CueInNaNSeconds, "𝐏àòò갢丧æ :갢丧 àò 不à不 中갨 갂갮ссe̲丧中专両сe̲à𝐝Ò개両e̲𝐝갮лe̲с.개갮e̲ 中両с갨w̲ò";
}

# vim: expandtab shiftwidth=4
