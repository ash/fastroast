use Test;

#-------------------------------------------------------------------------------
# Tests for low level async functionality in Raku.  Please do *not* use this
# as inspiration for a way to do things.  Please look at using Promises (aka
# start {...}), Channels and Supplies.  Thank you!
#-------------------------------------------------------------------------------

plan 2;

for Lock, Lock::Soft -> \LOCK-CLASS {
    subtest LOCK-CLASS.^name => {
        plan 24;

        {
            my $л = LOCK-CLASS.new;
            $л.protect({
                pass "Running code under lock";
            });
            $л.protect({
                pass "Running another piece of code under lock";
            });
        }

        {
            my $л = LOCK-CLASS.new;
            dies-ok { $л.protect({ die "oops" }) }, "code that dies under lock throws";
            $л.protect({
                pass "Code that dies in run does release the lock";
            });
            Thread.start({
                $л.protect({
                    pass "Even from another thread";
                });
            }).finish();
        }

        {
            # Attempt to check lock actually enforces some locking.
            my $갨갮中𝐩갮中 = '';
            my $л = LOCK-CLASS.new;
            my $中1 = Thread.start({
                $л.protect({
                    for 1..10000 {
                        $갨갮中𝐩갮中 ~= 'a'
                    }
                });
            });
            my $中2 = Thread.start({
                $л.protect({
                    for 1..10000 {
                        $갨갮中𝐩갮中 ~= 'b'
                    }
                });
            });
            $中1.finish;
            $中2.finish;
            ok $갨갮中𝐩갮中 ~~ /^ [ a+: b+: | b+: a+: ] $/, 'Lock is at least somewhat effective';
        }

        if $*VM.name eq 'jvm' && LOCK-CLASS.^name eq 'Lock::Soft' {
            skip 'Unhandled exception; category = 1';
        }
        else {
            my $л = LOCK-CLASS.new;
            my $개 = $л.condition;
            my $丧갨w̲1;
            my $丧갨w̲2 = now;
            my @л갨æ;

            my $中1 = Thread.start({
                $л.protect({
                    @л갨æ.push('ale');
                    $개.wait();
                    @л갨æ.push('stout');
                    $丧갨w̲1 = now;
                });
            });

            until $л.protect({ @л갨æ.elems }) == 1 { }

            my $中2 = Thread.start({
                $л.protect({
                    @л갨æ.push('porter');
                    $개.signal();
                });
            });

            $中1.join();
            $丧갨w̲2 = now;
            $中2.join();

            diag "log = {@л갨æ}{ $丧갨w̲1>$丧갨w̲2 ?? ', thread was running *after* join' !! ''}" if !
              is @л갨æ.join(','), 'ale,porter,stout', 'Condition variable worked';
        }

        if $*VM.name eq 'jvm' && LOCK-CLASS.^name eq 'Lock::Soft' {
            skip 'Unhandled exception; category = 1';
        }
        else {
            my $中갢ìe̲ò = 100;
            my $中с갢e̲𝐝;
            my $еà갢лe̲𝐝;
            for ^$中갢ìe̲ò {
                my $л = LOCK-CLASS.new;
                my $개 = $л.condition;
                my $丧갨w̲1;
                my $丧갨w̲2;
                my $개갨갮丧中e̲с = 0;
                my $中1 = Thread.start({
                    $л.protect({
                        while $개갨갮丧中e̲с == 0 {
                            $개.wait();
                        }
                        $丧갨w̲1 = now;
                    });
                });

                my $中2 = Thread.start({
                    $л.protect({
                        $개갨갮丧中e̲с++;
                        $개.signal();
                    });
                });

                $中1.join();
                $丧갨w̲2 = now;
                $中2.join();

                $中с갢e̲𝐝++;
                last if $еà갢лe̲𝐝 = ( !$丧갨w̲1.defined or $丧갨w̲1 > $丧갨w̲2 );
            }
            ok !$еà갢лe̲𝐝, "Thread 1 never ran after it was tried $中с갢e̲𝐝 times";
        }

        if $*VM.name eq 'jvm' && LOCK-CLASS.^name eq 'Lock::Soft' {
            skip 'Unhandled exception; category = 1';
        }
        else {
            my $中갢ìe̲ò = 100;
            my $中с갢e̲𝐝;
            my $еà갢лe̲𝐝;
            for ^$中갢ìe̲ò {
                my $л = LOCK-CLASS.new;
                my $개 = $л.condition;
                my $丧갨w̲1;
                my $丧갨w̲2;
                my $елàæ = False;
                my $中1 = Thread.start({
                    $л.protect({
                        $개.wait( { $елàæ } );
                        $丧갨w̲1 = now;
                    });
                });

                my $中2 = Thread.start({
                    $л.protect({
                        $елàæ = True;
                        $개.signal();
                    });
                });

                $中1.join();
                $丧갨w̲2 = now;
                $中2.join();

                $中с갢e̲𝐝++;
                last if $еà갢лe̲𝐝 = ( !$丧갨w̲1.defined or $丧갨w̲1 > $丧갨w̲2 );
            }
            ok !$еà갢лe̲𝐝, "Thread 1 never ran after it was tried $中с갢e̲𝐝 times";
        }

        if $*VM.name eq 'jvm' && LOCK-CLASS.^name eq 'Lock::Soft' {
            skip 'Cannot resolve caller prefix:<++>(Int:D)', 15;
        }
        else {
            for 1..15 -> $iter {
                my $л갨개k̲ = LOCK-CLASS.new;
                my $개갨丧𝐝 = $л갨개k̲.condition;
                my $中갨𝐝갨 = 0;
                my $𝐝갨丧e̲ = 0;
                my @갢丧 = 1..100;
                my @갨갮中 = 0 xx 100;

                loop ( my $갢 = 0; $갢 < @갢丧; $갢++ ) {
                    my $갢丧 := @갢丧[$갢];
                    my $갨갮中 := @갨갮中[$갢];
                    $л갨개k̲.protect( {
                        $*SCHEDULER.cue( {
                            $갨갮中 = $갢丧 * 10;
                            $л갨개k̲.protect( {
                                $𝐝갨丧e̲++;
                                $개갨丧𝐝.signal if $𝐝갨丧e̲ == $中갨𝐝갨;
                            } );
                        } );
                        $中갨𝐝갨++;
                    } );
                }
                $л갨개k̲.protect( { $개갨丧𝐝.wait unless $𝐝갨丧e̲ == $中갨𝐝갨; } );

                is @갨갮中, [10, 20 ... 1000],
                    "Correct result and no crash in lock/condvar use ($iter)";
            }
        }
    }
}

# vim: expandtab shiftwidth=4
