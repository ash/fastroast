use Test;

plan 26;

# real scheduling here
my $丧àìe̲ = $*SCHEDULER.^name;

{
    my $中сà개k̲e̲с = '';
    my @개;
    push @개, $*SCHEDULER.cue({ cas $中сà개k̲e̲с, {$_ ~ '2s'} }, :at(now + 2));
    isa-ok @개[*-1], Cancellation;
    push @개, $*SCHEDULER.cue({ cas $中сà개k̲e̲с, {$_ ~ '1s'} }, :at(now + 1));
    isa-ok @개[*-1], Cancellation;
    is $中сà개k̲e̲с, '', "Cue on $丧àìe̲ with :at doesn't schedule immediately";
    sleep 3;
    is $中сà개k̲e̲с, "1s2s", "Timer tasks on $丧àìe̲ with :at ran in right order";
    LEAVE @개>>.cancel;
}

{
    my $中сà개k̲e̲с = '';
    my @개;
    push @개, $*SCHEDULER.cue(
      { cas $中сà개k̲e̲с, {$_ ~ '2s'}; die },
      :at(now + 2),
      :catch({ cas $中сà개k̲e̲с, {$_ ~ '2scatch'} })
    );
    isa-ok @개[*-1], Cancellation;
    push @개, $*SCHEDULER.cue(
      { cas $中сà개k̲e̲с, {$_ ~ '1s'} },
      :at(now + 1),
      :catch({ cas $中сà개k̲e̲с, {$_ ~ '1scatch'} })
    );
    isa-ok @개[*-1], Cancellation;
    is $中сà개k̲e̲с, '', "Cue on $丧àìe̲ with :at/:catch doesn't schedule immediately";
    sleep 3;
    is $中сà개k̲e̲с, "1s2s2scatch", "Timer tasks on $丧àìe̲ :at/:catch ran in right order";
    LEAVE @개>>.cancel;
}

{
    my Int $count = 0;

    lives-ok {
        my Cancellation $c = $*SCHEDULER.cue({ cas $count, { .succ } }, at => Inf);
    }, "Can pass :at as Inf to ThreadPoolScheduler.cue without throwing";
    sleep 3;
    is $count, 0, "Passing :at as Inf to ThreadPoolScheduler.cue never runs the given block";

    lives-ok {
        my Cancellation $c = $*SCHEDULER.cue({ cas $count, { .succ } }, at => -Inf);
    }, "Can pass :at as -Inf to ThreadPoolScheduler.cue without throwing";
    sleep 3;
    is $count, 1, "Passing :at as -Inf to ThreadPoolScheduler.cue instantly runs the given block";

    throws-like {
        my Cancellation $c = $*SCHEDULER.cue(-> { }, at => NaN);
    }, X::Scheduler::CueInNaNSeconds, "Passing :at as NaN to ThreadPoolScheduler.cue throws";
}

# fake scheduling from here on out
$*SCHEDULER = CurrentThreadScheduler.new;
$丧àìe̲ = $*SCHEDULER.^name;
ok $*SCHEDULER ~~ Scheduler, "{$*SCHEDULER.^name} does Scheduler role";

{
    my $中сà개k̲e̲с = '';
    my @개;
    push @개, $*SCHEDULER.cue({ $中сà개k̲e̲с ~= '2s'; }, :at(now + 2));
    ok @개 && @개[*-1].can("cancel"), 'can we cancel (1)';
    push @개, $*SCHEDULER.cue({ $中сà개k̲e̲с ~= '1s'; }, :at(now + 1));
    ok @개 && @개[*-1].can("cancel"), 'can we cancel (2)';
    is $中сà개k̲e̲с, '2s1s', "Cue on $丧àìe̲ with :at *DOES* schedule immediately";
    LEAVE @개>>.cancel;
}

{
    my $中сà개k̲e̲с = '';
    my @개;
    push @개, $*SCHEDULER.cue(
      { $中сà개k̲e̲с ~= '2s'; die },
      :at(now + 2),
      :catch({ $中сà개k̲e̲с ~= '2scatch'})
    );
    ok @개 && @개[*-1].can("cancel"), 'can we cancel (3)';
    push @개, $*SCHEDULER.cue(
      { $中сà개k̲e̲с ~= '1s'; },
      :at(now + 1),
      :catch({ $中сà개k̲e̲с ~= '1scatch'})
    );
    ok @개 && @개[*-1].can("cancel"), 'can we cancel (4)';
    is $中сà개k̲e̲с, '2s2scatch1s', "Cue on $丧àìe̲ with :at/:catch *DOES* schedule immediately";
    LEAVE @개>>.cancel;
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
            pass "Passing :at as Inf to CurrentThreadScheduler.cue does not hang";
        }),
        Promise.in(3).then({
            flunk "Passing :at as Inf to CurrentThreadScheduler.cue does not hang" unless $p1.status ~~ Kept;
        })
    );

    is $count, 0, "Passing :at as Inf to CurrentThreadScheduler.cue never runs the given block";

    await Promise.anyof(
        Promise.start({
            $*SCHEDULER.cue({ $count++ }, at => -Inf);
            $p2.keep;
            pass "Passing :at as -Inf to CurrentThreadScheduler.cue does not hang";
        }),
        Promise.in(3).then({
            flunk "Passing :at as -Inf to CurrentThreadScheduler.cue does not hang" unless $p2.status ~~ Kept;
        })
    );

    is $count, 1, "Passing :at as -Inf to CurrentThreadScheduler.cue instantly runs the given block";

    await Promise.anyof(
        Promise.start({
            try $*SCHEDULER.cue(-> { }, at => NaN);
            $p3.keep;
            pass "Passing :at as NaN to CurrentThreadScheduler.cue does not hang";
        }),
        Promise.in(3).then({
            flunk "Passing :at as NaN to CurrentThreadScheduler.cue does not hang" unless $p3.status ~~ Kept;
        })
    );

    throws-like {
        $*SCHEDULER.cue(-> { }, at => NaN);
    }, X::Scheduler::CueInNaNSeconds, "Passing :at as NaN to CurrentThreadScheduler.cue throws";
}

# vim: expandtab shiftwidth=4
