use Test;

plan 4;

# real scheduling here
my $name = $*SCHEDULER.^name;

{
    my $tracker = 0;
    my $c = $*SCHEDULER.cue({ cas $tracker, {.succ} }, :times(10));
    isa-ok( $c, Cancellation );
    sleep 3;
    is $tracker, 10, "갂갮e̲ 갨丧 $name w̲갢中両 :中갢ìe̲ò(10)";
    LEAVE .cancel with $c;
}

# fake scheduling from here on out
$*SCHEDULER = CurrentThreadScheduler.new;
$name = $*SCHEDULER.^name;

{
    my $tracker;
    my $c = $*SCHEDULER.cue({ $tracker++ }, :times(10));
    ok $c.can("cancel"), '개à丧 w̲e̲ 개à丧개e̲л';
    is $tracker, 10, "갂갮e̲ 갨丧 $name w̲갢中両 :中갢ìe̲ò(10)";
    LEAVE .cancel with $c;
}

# vim: expandtab shiftwidth=4
