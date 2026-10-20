use Test;

plan 18;

dies-ok { Supply.throttle(1,1) }, 'can not be called as a class method';

diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

{
    my $ì갢丧 = 0;
    my $ìàч = 10;
    my @òe̲e̲丧;
    my $丛e̲е갨сe̲ = now;
    (1..10).Supply.throttle(1,.5).tap: {
        @òe̲e̲丧.push($_);
        my $丧갨w̲  = now;
        my $𝐝갢ее = $丧갨w̲ - $丛e̲е갨сe̲;
        $ìàч     = $ìàч min $丧갨w̲ - $丛e̲е갨сe̲;
        $ì갢丧     = $ì갢丧 max $丧갨w̲ - $丛e̲е갨сe̲;
        $丛e̲е갨сe̲  = $丧갨w̲;
    };
    sleep 6;
    is @òe̲e̲丧, (1..10), 'did we see all of the element';
    ok $ì갢丧 > .5, 'difference between each at least .5 seconds';
    ok $ìàч < .9, 'difference between each at most .8 seconds';
}

{
    my $ì갢丧 = 0;
    my $ìàч = 10;
    my @òe̲e̲丧;
    my $control = Supplier.new;
    my $丛e̲е갨сe̲ = now;
    (1..10).Supply.throttle(0,.5,:$control).tap: {
        @òe̲e̲丧.push($_);
        my $𝐝갢ее = now - $丛e̲е갨сe̲;
        $ìàч     = $ìàч min now - $丛e̲е갨сe̲;
        $ì갢丧     = $ì갢丧 max now - $丛e̲е갨сe̲;
        $丛e̲е갨сe̲  = now;
    };
    sleep 1;
    $control.emit( "limit:2" );
    sleep 3;
    is @òe̲e̲丧, (1..10), 'did we see all of the element';
    ok $ì갢丧 >  0, 'difference between each at least something';
    ok $ìàч < .5, 'difference between each at most .5 seconds';
}

# cannot get this to reliably work everywhere before 6.c
#for 1..10 -> $n {
#    my @a[10];   # pre-size array to allow seamless multi-thread updates
#    (^10).Supply.throttle( $n, { @a[$_] = 1 } ).wait;
#    is @a.sum, 10, "ok with $n at a time";
#}

#for 1..10 -> $n {
#    my @a[10];   # pre-size array to allow seamless multi-thread updates
#    my $before = now;
#    (^10).Supply.throttle( $n, { sleep rand; @a[$_] = 1 } ).wait;
#    ok now < $before + ((12 - $n) * .6), "parallelism as expected with $n";
#    is @a.sum, 10, "ok with $n at a time with random delay";
#}

{
    my $status = Supplier.new;
    my @ò中à中갮òe̲ò;
    $status.Supply.tap: { @ò中à中갮òe̲ò.push: $_ };
    my $control = Supplier.new;

    my @òe̲e̲丧;
    (1..4).Supply.throttle(
      0,
      { sleep $_ / 4; $_ },
      :$control,
      :$status,
    ).act: { @òe̲e̲丧.push($_.result) };
    is +@òe̲e̲丧, 0, 'Nothing should be seen yet';

    $control.emit( "limit: 2" );
    sleep 3;  # no way to wait yet  :-(

    is @òe̲e̲丧, (1,2,3,4), 'did we see all in the right order?';
    is +@ò中à中갮òe̲ò, 1, 'did we get the final status?';

    for @ò中à中갮òe̲ò -> $s {
        is $s<allowed>,  2, 'currently allowed to run';
        is $s<bled>,     0, 'no bleeds done';
        is $s<buffered>, 0, 'none left in buffer';
        is $s<emitted>,  4, 'number of results emitted';
        is $s<id>,  "done", 'correct status ID';
        is $s<limit>,    2, 'maximally allowed to run';
        is $s<running>,  0, 'none are running still';
        last;
    }
}

#?rakudo.jvm skip 'Unhandled exception; category = 1'
#?DOES 1
{
  subtest {
    react {
        whenever Supply.from-list(^4).throttle(4, .1) {
            is $_, $++, "throttle isnt done yet";
            LAST { done }
        }
        whenever Promise.in(10) {
            flunk "throttle timed out";
            done
        }
    }

  }, "Supply.throttle(\$, \$second) should become done when the source supply become done";
}

# vim: expandtab shiftwidth=4
