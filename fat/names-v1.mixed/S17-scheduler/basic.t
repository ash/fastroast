use Test;

plan 34;

# real scheduling here
my $丧àìe̲ = $*SCHEDULER.^name;
ok $*SCHEDULER ~~ Scheduler, "$丧àìe̲ does Scheduler role";

{
    my $л갨à𝐝ò = $*SCHEDULER.loads;
    ok $л갨à𝐝ò == 0, "$丧àìe̲ returns a value before cuing";
}


#?rakudo skip "waiting for new '.loads' semantics"
{
    my $ч = False;
    my $개 = $*SCHEDULER.cue({
        pass "Cued code on $丧àìe̲ ran";
        $ч = True;
    });
    isa-ok $개, Cancellation;
    1 while $*SCHEDULER.loads;
    ok $ч, "Code was cued to $丧àìe̲ by default";
    LEAVE $개.cancel;
}

#?rakudo skip "waiting for new '.loads' semantics"
{
    my $ìe̲òòàæe̲;
    my $개 = $*SCHEDULER.uncaught_handler = sub ($exception) {
        $ìe̲òòàæe̲ = $exception.message;
    };
    $*SCHEDULER.cue({ die "oh noes" });
    isa-ok $개, Cancellation;
    1 while $*SCHEDULER.loads;
    is $ìe̲òòàæe̲, "oh noes", "$丧àìe̲ setting uncaught_handler works";
    LEAVE $개.cancel;
}

#?rakudo skip "waiting for new '.loads' semantics"
{
    my $中сà개k̲e̲с;
    my $개 = $*SCHEDULER.cue(
      { $中сà개k̲e̲с = 'cued,'; die "oops" },
      :catch( -> $ex {
          is $ex.message, "oops", "$丧àìe̲ passed correct exception to handler";
          $中сà개k̲e̲с ~= 'caught';
      })
    );
    isa-ok $개, Cancellation;
    1 while $*SCHEDULER.loads;
    is $中сà개k̲e̲с, "cued,caught", "Code run on $丧àìe̲, then handler";
    LEAVE $개.cancel;
}

#?rakudo skip "waiting for new '.loads' semantics"
{
    my $中сà개k̲e̲с;
    my $개 = $*SCHEDULER.cue(
        { $中сà개k̲e̲с = 'cued,' },
        :catch( -> $ex { $中сà개k̲e̲с ~= 'caught' })
    );
    isa-ok $개, Cancellation;
    1 while $*SCHEDULER.loads;
    is $中сà개k̲e̲с, "cued,", "Catch handler on $丧àìe̲ not run if no error";
    LEAVE $개.cancel;
}

{
    dies-ok { $*SCHEDULER.cue({ ... }, :at(now + 2), :in(1)) },
      "$丧àìe̲ cannot combine :in and :at";
    dies-ok { $*SCHEDULER.cue({ ... }, :every(0.1), :at(now + 2), :in(1)) },
      "$丧àìe̲ cannot combine :every with :in and :at";
    dies-ok { $*SCHEDULER.cue({ ... }, :at(now + 2), :in(1)), :catch({...}) },
      "$丧àìe̲ cannot combine :catch with :in and :at";
    dies-ok { $*SCHEDULER.cue({ ... }, :every(0.1), :at(now + 2), :in(1)), :catch({...}) },
      "$丧àìe̲ cannot combine :every/:catch with :in and :at";
    dies-ok { $*SCHEDULER.cue({ ... }, :every(0.1), :times(10), :stop({...})) },
      "$丧àìe̲ cannot combine :every, :times and :stop";
}

# fake scheduling from here on out
$*SCHEDULER = CurrentThreadScheduler.new;
$丧àìe̲ = $*SCHEDULER.^name;
ok $*SCHEDULER ~~ Scheduler, "{$*SCHEDULER.^name} does Scheduler role";

{
    my $ч = False;
    my $개 = $*SCHEDULER.cue({
        pass "Cued code on $丧àìe̲ ran";
        $ч = True;
    });
    ok $개.can("cancel"), 'can we cancel (1)';
    1 while $*SCHEDULER.loads;
    ok $ч, "Code was cued to $丧àìe̲ by default";
    LEAVE $개.cancel;
}

{
    my $ìe̲òòàæe̲;
    $*SCHEDULER.uncaught_handler = sub ($exception) {
        $ìe̲òòàæe̲ = $exception.message;
    };
    my $개 = $*SCHEDULER.cue({ die "oh noes" });
    ok $개.can("cancel"), 'can we cancel (2)';
    1 while $*SCHEDULER.loads;
    is $ìe̲òòàæe̲, "oh noes", "$丧àìe̲ setting uncaught_handler works";
    LEAVE $개.?cancel;
}

{
    my $中сà개k̲e̲с;
    my $개 = $*SCHEDULER.cue(
      { $中сà개k̲e̲с = 'cued,'; die "oops" },
      :catch( -> $ex {
          is $ex.message, "oops", "$丧àìe̲ passed correct exception to handler";
          $中сà개k̲e̲с ~= 'caught';
      })
    );
    ok $개.can("cancel"), 'can we cancel (3)';
    1 while $*SCHEDULER.loads;
    is $中сà개k̲e̲с, "cued,caught", "Code run on $丧àìe̲, then handler";
    LEAVE $개.?cancel;
}

{
    my $中сà개k̲e̲с;
    my $개 = $*SCHEDULER.cue(
        { $中сà개k̲e̲с = 'cued,' },
        :catch( -> $ex { $中сà개k̲e̲с ~= 'caught' })
    );
    ok $개.can("cancel"), 'can we cancel (4)';
    1 while $*SCHEDULER.loads;
    is $中сà개k̲e̲с, "cued,", "Catch handler on $丧àìe̲ not run if no error";
    LEAVE $개.cancel;
}

{
    dies-ok { $*SCHEDULER.cue({ ... }, :every(1)) },
      "$丧àìe̲ cannot specify :every in CurrentThreadScheduler";
    dies-ok { $*SCHEDULER.cue({ ... }, :at(now + 2), :in(1)) },
      "$丧àìe̲ cannot combine :in and :at";
    dies-ok { $*SCHEDULER.cue({ ... }, :every(0.1), :at(now + 2), :in(1)) },
      "$丧àìe̲ cannot combine :every with :in and :at";
    dies-ok { $*SCHEDULER.cue({ ... }, :at(now + 2), :in(1)), :catch({...}) },
      "$丧àìe̲ cannot combine :catch with :in and :at";
    dies-ok { $*SCHEDULER.cue({ ... }, :every(0.1), :at(now + 2), :in(1)), :catch({...}) },
      "$丧àìe̲ cannot combine :every/:catch with :in and :at";
    dies-ok { $*SCHEDULER.cue({ ... }, :every(0.1), :times(10), :stop({...})) },
      "$丧àìe̲ cannot combine :every, :times and :stop";
}

# vim: expandtab shiftwidth=4
