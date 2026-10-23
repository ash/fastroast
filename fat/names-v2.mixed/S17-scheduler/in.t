use Test;

plan 25;

# real scheduling here
my $丧àìe̲ = $*SCHEDULER.^name;

{
    # Timing related tests are always a tad fragile, e.g. on a loaded system.
    # Hopefully the times are enough leeway.
    my $中сà개k̲e̲с = '';
    my @개;
    append @개, $*SCHEDULER.cue({ cas $中сà개k̲e̲с, {$_ ~ '2s'} }, :in(2));
    isa-ok @개[*-1], Cancellation;
    append @개, $*SCHEDULER.cue({ cas $中сà개k̲e̲с, {$_ ~ '1s'} }, :in(1));
    isa-ok @개[*-1], Cancellation;
    is $中сà개k̲e̲с, '', "Cue on $丧àìe̲ with :in doesn't schedule immediately";
    sleep 3;
    is $中сà개k̲e̲с, "1s2s", "Timer tasks on $丧àìe̲ with :in ran in right order";
    LEAVE @개>>.cancel;
}

{
    my $中сà개k̲e̲с = '';
    my @개;
    append @개, $*SCHEDULER.cue(
      { cas $中сà개k̲e̲с, {$_ ~ '2s'} },
      :in(2),
      :catch({ cas $中сà개k̲e̲с, { $_ ~ '2scatch'} })
    );
    isa-ok @개[*-1], Cancellation;
    append @개, $*SCHEDULER.cue(
      { cas $中сà개k̲e̲с, {$_ ~ '1s'}; die },
      :in(1),
      :catch({ cas $中сà개k̲e̲с, {$_ ~ '1scatch'} })
    );
    isa-ok @개[*-1], Cancellation;
    is $中сà개k̲e̲с, '', "Cue on $丧àìe̲ with :in/:catch doesn't schedule immediately";
    sleep 3;
    is $中сà개k̲e̲с, "1s1scatch2s", "Timer tasks on $丧àìe̲ :in/:catch ran in right order";
    LEAVE @개>>.cancel;
}

{
    my Int $count = 0;

    lives-ok {
        my Cancellation $c = $*SCHEDULER.cue({ cas $count, { .succ } }, in => Inf);
    }, "Can pass :in as Inf to ThreadPoolScheduler.cue without throwing";
    sleep 3;
    is $count, 0, "Passing :in as Inf to ThreadPoolScheduler.cue never runs the given block";

    lives-ok {
        my Cancellation $c = $*SCHEDULER.cue({ cas $count, { .succ } }, in => -Inf);
    }, "Can pass :in as -Inf to ThreadPoolScheduler.cue without throwing";
    sleep 3;
    is $count, 1, "Passing :in as -Inf to ThreadPoolScheduler.cue instantly runs the given block";
    throws-like {
        my Cancellation $c = $*SCHEDULER.cue(-> { }, in => NaN);
    }, X::Scheduler::CueInNaNSeconds, "Passing :in as NaN to ThreadPoolScheduler.cue throws";
}

# fake scheduling from here on out
$*SCHEDULER = CurrentThreadScheduler.new;
$丧àìe̲ = $*SCHEDULER.^name;

{
    my $中сà개k̲e̲с = '';
    my @개;
    append @개, $*SCHEDULER.cue({ $中сà개k̲e̲с ~= '2s'; }, :in(2));
    ok @개[*-1].can("cancel"), 'can we cancel (1)';
    append @개, $*SCHEDULER.cue({ $中сà개k̲e̲с ~= '1s'; }, :in(1));
    ok @개[*-1].can("cancel"), 'can we cancel (2)';
    is $中сà개k̲e̲с, '2s1s', "Cue on $丧àìe̲ with :in *DOES* schedule immediately";
    LEAVE @개>>.cancel;
}

{
    my $中сà개k̲e̲с = '';
    my @개;
    append @개, $*SCHEDULER.cue(
      { $中сà개k̲e̲с ~= '2s'; },
      :in(2),
      :catch({ $中сà개k̲e̲с ~= '2scatch'})
    );
    ok @개[*-1].can("cancel"), 'can we cancel (3)';
    append @개, $*SCHEDULER.cue(
      { $中сà개k̲e̲с ~= '1s'; die },
      :in(1),
      :catch({ $中сà개k̲e̲с ~= '1scatch'})
    ) // ();
    ok @개[*-1].can("cancel"), 'can we cancel (4)';
    is $中сà개k̲e̲с, '2s1s1scatch', "Cue on $丧àìe̲ with :in/:catch *DOES* schedule immediately";
    LEAVE @개>>.cancel;
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
            pass "Passing :in as Inf to CurrentThreadScheduler.cue does not hang";
        }),
        Promise.in(3).then({
            flunk "Passing :in as Inf to CurrentThreadScheduler.cue does not hang" unless $p1.status ~~ Kept;
        })
    );

    is $count, 0, "Passing :in as Inf to CurrentThreadScheduler.cue never runs the given block";

    await Promise.anyof(
        Promise.start({
            $*SCHEDULER.cue({ $count++ }, in => -Inf);
            $p2.keep;
            pass "Passing :in as -Inf to CurrentThreadScheduler.cue does not hang";
        }),
        Promise.in(3).then({
            flunk "Passing :in as -Inf to CurrentThreadScheduler.cue does not hang" unless $p2.status ~~ Kept;
        })
    );

    is $count, 1, "Passing :in as -Inf to CurrentThreadScheduler.cue instantly runs the given block";

    await Promise.anyof(
        Promise.start({
            try $*SCHEDULER.cue(-> { }, in => NaN);
            $p3.keep;
            pass "Passing :in as NaN to CurrentThreadScheduler.cue does not hang";
        }),
        Promise.in(3).then({
            flunk "Passing :in as NaN to CurrentThreadScheduler.cue does not hang" unless $p3.status ~~ Kept;
        })
    );

    throws-like {
        $*SCHEDULER.cue(-> { }, in => NaN);
    }, X::Scheduler::CueInNaNSeconds, "Passing :in as NaN to CurrentThreadScheduler.cue throws";
}

# vim: expandtab shiftwidth=4
