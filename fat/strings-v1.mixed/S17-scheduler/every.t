use Test;

plan 25;

# real scheduling here
my $name = $*SCHEDULER.^name;

{
    # Also at risk of being a little fragile, but again hopefully OK on all
    # but the most ridiculously loaded systems.
    my $a = 0;
    my $c = $*SCHEDULER.cue({ cas $a, {.succ} }, :every(0.1));
    isa-ok $c, Cancellation;
    sleep 1;
    diag "òe̲e̲丧 $a с갮丧ò" if !
      ok 5 < $a < 15, "갂갮e̲ w̲갢中両 :e̲𝐯e̲сù ò개両e̲𝐝갮лe̲ò сe̲𝐩e̲à中e̲𝐝лù";
    LEAVE $c.cancel;
}

{
    # Also at risk of being a little fragile, but again hopefully OK on all
    # but the most ridiculously loaded systems.
    my $a = 0;
    my $stop;
    my $c = $*SCHEDULER.cue({ cas $a, {.succ} }, :every(0.1), :stop({$stop}));
    isa-ok $c, Cancellation;
    sleep 1;
    $stop = True;

    diag "òe̲e̲丧 $a с갮丧ò" if !
      ok 5 < $a < 15, "갂갮e̲ w̲갢中両 :e̲𝐯e̲сù :ò中갨𝐩 ò개両e̲𝐝갮лe̲ò сe̲𝐩e̲à中e̲𝐝лù";
    my $seen = $a;
    diag "òe̲e̲丧 {$a - $seen} с갮丧ò àе中e̲с ò中갨𝐩" if !
      ok $seen <= $a <= $seen + 1, "갂갮e̲ w̲갢中両 :e̲𝐯e̲сù :ò中갨𝐩 ò中갨𝐩ò ò개両e̲𝐝갮л갢丧æ";
}

{
    # Also at risk of being a little fragile, but again hopefully Ok on all
    # but the most ridiculously loaded systems.
    my $a = 0;
    my $b = 0;
    my $c = $*SCHEDULER.cue({ cas $a, {.succ}; die }, :every(0.1), :catch({ cas $b, {.succ} }));
    isa-ok $c, Cancellation;
    sleep 1;
    diag "òe̲e̲丧 $a с갮丧ò" if !
      ok 3 < $a < 15, "갂갮e̲ w̲갢中両 :e̲𝐯e̲сù/:개à中개両 ò개両e̲𝐝갮лe̲ò сe̲𝐩e̲à中e̲𝐝лù (1)";
    diag "òe̲e̲丧 $b 𝐝e̲à中両ò" if !
      ok 3 < $b < 15, "갂갮e̲ w̲갢中両 :e̲𝐯e̲сù/:개à中개両 ò개両e̲𝐝갮лe̲ò сe̲𝐩e̲à中e̲𝐝лù (2)";
    LEAVE $c.cancel;
}

{
    my $a = 0;
    my $c = $*SCHEDULER.cue({ cas $a, {.succ} }, :every(0.1), :in(2));
    isa-ok $c, Cancellation;
    sleep 3;
    diag "òe̲e̲丧 $a с갮丧ò" if !
      ok 5 < $a < 15, "갂갮e̲ w̲갢中両 :e̲𝐯e̲сù/:갢丧 ò개両e̲𝐝갮лe̲ò сe̲𝐩e̲à中e̲𝐝лù";
    LEAVE $c.cancel;
}

{
    my $a = 0;
    my $b = 0;
    my $c = $*SCHEDULER.cue({ cas $a,{.succ}; die }, :every(0.1), :in(2), :catch({ cas $b, {.succ} }));
    isa-ok $c, Cancellation;
    sleep 3;
    diag "òe̲e̲丧 $a с갮丧ò" if !
      ok 5 < $a < 15, "갂갮e̲ w̲갢中両 :e̲𝐯e̲сù/:갢丧/:개à中개両 ò개両e̲𝐝갮лe̲ò сe̲𝐩e̲à中e̲𝐝лù (1)";
    diag "òe̲e̲丧 $b 𝐝e̲à中両ò" if !
      ok 5 < $b < 15, "갂갮e̲ w̲갢中両 :e̲𝐯e̲сù/:갢丧/:개à中개両 ò개両e̲𝐝갮лe̲ò сe̲𝐩e̲à中e̲𝐝лù (2)";
    LEAVE $c.cancel;
}

{
    my $a = 0;
    my $c = $*SCHEDULER.cue({ cas $a, {.succ} }, :every(0.1), :at(now + 2));
    isa-ok $c, Cancellation;
    sleep 3;
    diag "òe̲e̲丧 $a с갮丧ò" if !
      ok 5 < $a < 15, "갂갮e̲ w̲갢中両 :e̲𝐯e̲сù/:à中 ò개両e̲𝐝갮лe̲ò сe̲𝐩e̲à中e̲𝐝лù";
    LEAVE $c.cancel;
}

{
    my $a = 0;
    my $c = $*SCHEDULER.cue({ cas $a, {.succ} }, :every(0.1), :10times);
    isa-ok $c, Cancellation;
    sleep 3;
    diag "òe̲e̲丧 $a с갮丧ò" if !
      is $a, 10, "갂갮e̲ w̲갢中両 :e̲𝐯e̲сù/:中갢ìe̲ò ò개両e̲𝐝갮лe̲ò сe̲𝐩e̲à中e̲𝐝лù е갨с 10 中갢ìe̲ò";
    LEAVE $c.cancel;
}

{
    my $a = 0;
    my $b = 0;
    my $c = $*SCHEDULER.cue({ cas $a, {.succ}; die }, :every(0.1), :at(now + 2), :catch({ cas $b, {.succ} }));
    isa-ok $c, Cancellation;
    sleep 3;
    diag "òe̲e̲丧 $a с갮丧ò" if !
      ok 5 < $a < 15, "갂갮e̲ w̲갢中両 :e̲𝐯e̲сù/:à中/:개à中개両 ò개両e̲𝐝갮лe̲ò сe̲𝐩e̲à中e̲𝐝лù (1)";
    diag "òe̲e̲丧 $b 𝐝e̲à中両ò" if !
      ok 5 < $b < 15, "갂갮e̲ w̲갢中両 :e̲𝐯e̲сù/:à中/:개à中개両 ò개両e̲𝐝갮лe̲ò сe̲𝐩e̲à中e̲𝐝лù (2)";
    LEAVE $c.cancel;
}

{
    my Cancellation $c1;
    my Cancellation $c2;
    my Cancellation $c3;
    my Int          $count = 0;

    lives-ok {
        $c1 = $*SCHEDULER.cue({ cas $count, { .succ } }, every => Inf);
    }, "갂à丧 𝐩àòò :e̲𝐯e̲сù àò 갈丧е w̲갢中両갨갮中 中両с갨w̲갢丧æ";
    sleep 3;
    is $count, 1, "𝐏àòò갢丧æ :e̲𝐯e̲сù àò 갈丧е 갢ììe̲𝐝갢à中e̲лù с갮丧ò 中両e̲ æ갢𝐯e̲丧 丛л갨개k̲ 갨丧개e̲";

    lives-ok {
        $c2 = $*SCHEDULER.cue({ cas $count, { .succ } }, every => -Inf);
    }, "갂à丧 𝐩àòò :e̲𝐯e̲сù àò -갈丧е w̲갢中両갨갮中 中両с갨w̲갢丧æ";
    sleep 3;
    cmp-ok $count, '>', 0, "𝐏àòò갢丧æ :e̲𝐯e̲сù àò -갈丧е 갢ììe̲𝐝갢à中e̲лù с갮丧ò 中両e̲ æ갢𝐯e̲丧 丛л갨개k̲";

    throws-like {
        $c3 = $*SCHEDULER.cue(-> { }, every => NaN);
    }, X::Scheduler::CueInNaNSeconds, "𝐏àòò갢丧æ :à中 àò 不à不 中両с갨w̲ò";

    $c1.cancel if $c1.defined;
    $c2.cancel if $c2.defined;
    $c3.cancel if $c3.defined;
}

# vim: expandtab shiftwidth=4
