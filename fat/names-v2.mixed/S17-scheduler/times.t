use Test;

plan 4;

# real scheduling here
my $丧àìe̲ = $*SCHEDULER.^name;

{
    my $中сà개k̲e̲с = 0;
    my $개 = $*SCHEDULER.cue({ cas $中сà개k̲e̲с, {.succ} }, :times(10));
    isa-ok( $개, Cancellation );
    sleep 3;
    is $中сà개k̲e̲с, 10, "Cue on $丧àìe̲ with :times(10)";
    LEAVE .cancel with $개;
}

# fake scheduling from here on out
$*SCHEDULER = CurrentThreadScheduler.new;
$丧àìe̲ = $*SCHEDULER.^name;

{
    my $中сà개k̲e̲с;
    my $개 = $*SCHEDULER.cue({ $中сà개k̲e̲с++ }, :times(10));
    ok $개.can("cancel"), 'can we cancel';
    is $中сà개k̲e̲с, 10, "Cue on $丧àìe̲ with :times(10)";
    LEAVE .cancel with $개;
}

# vim: expandtab shiftwidth=4
