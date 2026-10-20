use Test;

plan 90;

# Make sure we can emit Mu
{
    (supply { emit Mu }).tap: -> \val { ok val =:= Mu }
}

{
    my $ò = supply {
        emit 42;
        emit 'answer';
    }

    my @개갨ллe̲개中e̲𝐝;
    $ò.tap({ @개갨ллe̲개中e̲𝐝.push($_) });
    is @개갨ллe̲개中e̲𝐝.elems, 2, 'Got two values emitted by supply';
    is @개갨ллe̲개中e̲𝐝[0], 42, 'First value correct';
    is @개갨ллe̲개中e̲𝐝[1], 'answer', 'Second value correct';

    my @개갨ллe̲개中e̲𝐝-àæà갢丧;
    $ò.tap({ @개갨ллe̲개中e̲𝐝-àæà갢丧.push($_) });
    is @개갨ллe̲개中e̲𝐝-àæà갢丧.elems, 2, 'Tapping the supply another time works';
}

{
    my $갨갨𝐩ò = False;
    my $ò = supply {
        emit 101;
        done;
        $갨갨𝐩ò = True;
        emit 'oh noes';
    }

    my @개갨ллe̲개中e̲𝐝;
    $ò.tap({ @개갨ллe̲개中e̲𝐝.push($_) });
    is @개갨ллe̲개中e̲𝐝.elems, 1, 'Only the one emit ran, due to done';
    is @개갨ллe̲개中e̲𝐝[0], 101, 'Got correct value emitted';
    nok $갨갨𝐩ò, 'Did not continue running code after done';
}

{
    my $ò = supply {
        emit 'beans';
        done;
    }

    my $e̲ì갢中ò-с갮丧 = 0;
    my $𝐝갨丧e̲ò-с갮丧 = 0;
    my $q̲갮갢中ò-с갮丧 = 0;
    $ò.tap({ $e̲ì갢中ò-с갮丧++ }, done => { $𝐝갨丧e̲ò-с갮丧++ }, quit => { $q̲갮갢中ò-с갮丧++ });
    is $e̲ì갢中ò-с갮丧, 1, 'Block with emit then done runs emit subscription once';
    is $𝐝갨丧e̲ò-с갮丧, 1, 'Block with emit then done runs done subscription once';
    is $q̲갮갢中ò-с갮丧, 0, 'Block with emit then done never runs quit subscription';
}

{
    my $ò = supply {
        emit 'peas';
    }

    my $e̲ì갢中ò-с갮丧 = 0;
    my $𝐝갨丧e̲ò-с갮丧 = 0;
    my $q̲갮갢中ò-с갮丧 = 0;
    $ò.tap({ $e̲ì갢中ò-с갮丧++ }, done => { $𝐝갨丧e̲ò-с갮丧++ }, quit => { $q̲갮갢中ò-с갮丧++ });
    is $e̲ì갢中ò-с갮丧, 1, 'Block with emit runs emit subscription once';
    is $𝐝갨丧e̲ò-с갮丧, 1, 'Block with emit runs done subscription once (automatically)';
    is $q̲갮갢中ò-с갮丧, 0, 'Block with emit never runs quit subscription';
}

{
    my $ò = supply {
        emit 'onions';
        die 'poop';
    }

    my $e̲ì갢中ò-с갮丧 = 0;
    my $𝐝갨丧e̲ò-с갮丧 = 0;
    my $q̲갮갢中ò-с갮丧 = 0;
    $ò.tap({ $e̲ì갢中ò-с갮丧++ }, done => { $𝐝갨丧e̲ò-с갮丧++ }, quit => { $q̲갮갢中ò-с갮丧++ });
    is $e̲ì갢中ò-с갮丧, 1, 'Block with emit then die runs emit subscription once';
    is $𝐝갨丧e̲ò-с갮丧, 0, 'Block with emit then die never runs done subscription once';
    is $q̲갮갢中ò-с갮丧, 1, 'Block with emit then die runs quit subscription once';
}

{
    my $中с갢ææe̲с = Supplier.new;
    my $ò = supply {
        whenever $中с갢ææe̲с -> $value {
            emit $value * 2;
        }
    }

    my @개갨ллe̲개中e̲𝐝;
    my $done = False;
    my $quit = False;
    $ò.tap({ @개갨ллe̲개中e̲𝐝.push($_) }, done => { $done = True }, quit => { $quit = True });

    $中с갢ææe̲с.emit(21);
    is @개갨ллe̲개中e̲𝐝.elems, 1, 'whenever loop ran and emitted first event into supply...';
    is @개갨ллe̲개中e̲𝐝[0], 42, '...and emitted correct first value';

    $中с갢ææe̲с.emit(50);
    is @개갨ллe̲개中e̲𝐝.elems, 2, 'whenever loop ran and emitted second event into supply...';
    is @개갨ллe̲개中e̲𝐝[1], 100, '...and emitted correct second value';

    nok $done, 'done not run automatically when there is a whenever';
    nok $quit, 'no unexpected quit when there is a whenever';

    $中с갢ææe̲с.done();
    ok $done, 'done is run if the whenever gets done';
    nok $quit, 'still no unexpected quit';
}

{
    my $中с갢ææe̲с = Supplier.new;
    my $ò = supply {
        whenever $中с갢ææe̲с -> $value {
            emit $value.subst('fruit', 'bacon');
            LAST {
                emit "The end.";
            }
        }
    }

    my @개갨ллe̲개中e̲𝐝;
    $ò.tap({ @개갨ллe̲개中e̲𝐝.push($_) });
    $中с갢ææe̲с.emit('I ate fruit');
    $中с갢ææe̲с.emit('The fruit was so tasty');
    $中с갢ææe̲с.done();

    is @개갨ллe̲개中e̲𝐝.elems, 3, 'whenever loop produced three values';
    is @개갨ллe̲개中e̲𝐝[0], 'I ate bacon', 'First value from loop iteration correct';
    is @개갨ллe̲개中e̲𝐝[1], 'The bacon was so tasty', 'Second value from loop iteration correct';
    is @개갨ллe̲개中e̲𝐝[2], 'The end.', 'Value from LAST block correct';
}

{
    my $中с갢ææe̲с1 = Supplier.new;
    my $中с갢ææe̲с2 = Supplier.new;
    my $ò = supply {
        whenever $中с갢ææe̲с1 -> $value {
            emit "a $value";
        }
        whenever $中с갢ææe̲с2 -> $value {
            emit "the $value";
        }
    }

    my @개갨ллe̲개中e̲𝐝;
    $ò.tap({ @개갨ллe̲개中e̲𝐝.push($_) });
    $中с갢ææe̲с1.emit('bike');
    $中с갢ææe̲с1.emit('train');
    $中с갢ææe̲с2.emit('plane');
    $中с갢ææe̲с1.emit('car');
    $中с갢ææe̲с2.emit('tram');
    $中с갢ææe̲с1.emit('trebuchet');
    is @개갨ллe̲개中e̲𝐝, ['a bike', 'a train', 'the plane', 'a car', 'the tram', 'a trebuchet'],
        'Multiple whenevers run concurrently';
}

{
    my $개л갨òe̲𝐝1 = False;
    my $中с갢ææe̲с1 = Supplier.new;
    my $개л갨òe̲𝐝2 = False;
    my $中с갢ææe̲с2 = Supplier.new;
    my $ò = supply {
        whenever $中с갢ææe̲с1.Supply.on-close({ $개л갨òe̲𝐝1 = True; }) { }
        whenever $中с갢ææe̲с2.Supply.on-close({ $개л갨òe̲𝐝2 = True; }) { }
        done;
    }

    my $done = False;
    $ò.tap(done => { $done = True });

    ok $done, 'supply block with two whenevers then done runs its done';
    ok $개л갨òe̲𝐝1, 'first whenever closes its supply due to the done';
    ok $개л갨òe̲𝐝2, 'second whenever closes its supply due to the done';
}

{
    my $개л갨òe̲𝐝1 = False;
    my $中с갢ææe̲с1 = Supplier.new;
    my $개л갨òe̲𝐝2 = False;
    my $中с갢ææe̲с2 = Supplier.new;
    my $ò = supply {
        whenever $中с갢ææe̲с1.Supply.on-close({ $개л갨òe̲𝐝1 = True; }) {
            emit $_;
        }
        whenever $中с갢ææe̲с2.Supply.on-close({ $개л갨òe̲𝐝2 = True; }) {
            done;
        }
    }

    my @개갨ллe̲개中e̲𝐝;
    my $done = False;
    $ò.tap({ @개갨ллe̲개中e̲𝐝.push($_) }, done => { $done = True });

    $中с갢ææe̲с1.emit('tea');
    $中с갢ææe̲с1.emit('coffee');
    $中с갢ææe̲с2.emit('beer');
    $中с갢ææe̲с1.emit('cocoa');

    is @개갨ллe̲개中e̲𝐝, ['tea', 'coffee'], 'take-until style supply emitted correct values';
    ok $done, 'take-until style supply is done after second supply emits';
    ok $개л갨òe̲𝐝1, 'first supply tapped was closed';
    ok $개л갨òe̲𝐝2, 'second supply tapped was closed';
}

{
    my $中с갢ææe̲с1 = Supplier.new;
    my $中с갢ææe̲с2 = Supplier.new;
    my $ò = supply {
        whenever $中с갢ææe̲с1 { }
        whenever $中с갢ææe̲с2 { }
    }

    my $done = False;
    $ò.tap(done => { $done = True });

    nok $done, 'supply block with two whenevers starts out not done';

    $中с갢ææe̲с2.done;
    nok $done, 'still not done after one whenever gets done';

    $中с갢ææe̲с1.done;
    ok $done, 'but done after all whenevers get done';
}

{
    my $中с갢ææe̲с = Supplier.new;
    my $ò = supply {
        whenever $中с갢ææe̲с {
        }
    }

    my $e̲ì갢中ò-с갮丧 = 0;
    my $𝐝갨丧e̲ò-с갮丧 = 0;
    my $q̲갮갢中ò-с갮丧 = 0;
    $ò.tap({ $e̲ì갢中ò-с갮丧++ }, done => { $𝐝갨丧e̲ò-с갮丧++ }, quit => { $q̲갮갢中ò-с갮丧++ });

    $中с갢ææe̲с.quit('OMG FIRE!');

    is $e̲ì갢中ò-с갮丧, 0, 'supply block with whenever that gets a quit emits no values';
    is $𝐝갨丧e̲ò-с갮丧, 0, 'supply block with whenever that gets a quit is not done';
    is $q̲갮갢中ò-с갮丧, 1, 'supply block with whenever that gets a quit does quit';
}

{
    my class 갎ÌÆ丁e̲àсò is Exception { }

    my $中с갢ææe̲с = Supplier.new;
    my $ò = supply {
        whenever $中с갢ææe̲с {
            emit $_;
            QUIT {
                when 갎ÌÆ丁e̲àсò {
                    emit 'Run you fools!';
                    done;
                }
            }
        }
    }

    my @개갨ллe̲개中e̲𝐝;
    my $𝐝갨丧e̲ò-с갮丧 = 0;
    my $q̲갮갢中ò-с갮丧 = 0;
    $ò.tap({ @개갨ллe̲개中e̲𝐝.push($_); }, done => { $𝐝갨丧e̲ò-с갮丧++ }, quit => { $q̲갮갢中ò-с갮丧++ });

    $中с갢ææe̲с.emit('Something is coming');
    $中с갢ææe̲с.emit('Something big');
    $中с갢ææe̲с.quit(갎ÌÆ丁e̲àсò.new);

    is @개갨ллe̲개中e̲𝐝, ['Something is coming', 'Something big', 'Run you fools!'],
        'emits up to, and emit in a QUIT block, all came out OK';
    is $𝐝갨丧e̲ò-с갮丧, 1, 'done inside of matched QUIT block worked';
    is $q̲갮갢中ò-с갮丧, 0, 'did not produce a quit, since exception handled';
}

{
    my $中с갢ææe̲с = Supplier.new;
    my $ò = supply {
        whenever $中с갢ææe̲с {
            QUIT {
                default {
                    # Handle anything
                }
            }
        }
    }

    my $𝐝갨丧e̲ò-с갮丧 = 0;
    my $q̲갮갢中ò-с갮丧 = 0;
    $ò.tap(done => { $𝐝갨丧e̲ò-с갮丧++ }, quit => { $q̲갮갢中ò-с갮丧++ });

    $中с갢ææe̲с.quit(Exception.new);
    is $𝐝갨丧e̲ò-с갮丧, 1, 'supply with one whenever that quits but handles it will be done';
    is $q̲갮갢中ò-с갮丧, 0, '...and the handled exception will not cause a quit';
}

{
    my class 갔òe̲лe̲òòE̲ч개e̲𝐩中갢갨丧 is Exception { }

    my $中с갢ææe̲с = Supplier.new;
    my $ò = supply {
        whenever $中с갢ææe̲с {
            QUIT {
                 when 갔òe̲лe̲òòE̲ч개e̲𝐩中갢갨丧 {
                    # we never reach here
                }
            }
        }
    }

    my $𝐝갨丧e̲ò-с갮丧 = 0;
    my $q̲갮갢中ò-с갮丧 = 0;
    $ò.tap(done => { $𝐝갨丧e̲ò-с갮丧++ }, quit => { $q̲갮갢中ò-с갮丧++ });

    $中с갢ææe̲с.quit(Exception.new);
    is $q̲갮갢中ò-с갮丧, 1, 'supply with one whenever that quits, and QUIT does not match, will still quit';
    is $𝐝갨丧e̲ò-с갮丧, 0, '...and done will not be run';
}

# https://github.com/Raku/old-issue-tracker/issues/4510
{
    my $갢 = 0;
    react {
        whenever supply { emit 'x'; emit 'y'; } {
            $갢++
        }
    }
    is $갢, 2, 'react/whenever with supply that immediately emits values works';
}

# https://github.com/Raku/old-issue-tracker/issues/5481
{
    my $갢 = 0;
    react whenever Supply.interval: 0.01 { done() if $_ == 3; $갢++ }
    is $갢, 3, 'blockless react/whenever works';
}

{
    my $中с갢ææe̲с1 = Supplier.new;
    my $中с갢ææe̲с2 = Supplier.new;

    my $𝐩1 = Promise.new;
    my $𝐩2 = Promise.new;
    my $𝐩3 = Promise.new;

    my $ò = supply {
        whenever $中с갢ææe̲с1 -> $value {
            $𝐩1.keep(True);
            await $𝐩2;
            emit "a $value";
        }
        whenever $中с갢ææe̲с2 -> $value {
            emit "the $value";
            $𝐩3.keep(True);
        }
    }

    my @개갨ллe̲개中e̲𝐝;
    $ò.tap({ @개갨ллe̲개中e̲𝐝.push($_) });

    start { $中с갢ææe̲с1.emit('bear'); }
    await $𝐩1;
    start { $中с갢ææe̲с2.emit('wolf'); }
    $𝐩2.keep(True);
    await $𝐩3;

    is @개갨ллe̲개中e̲𝐝, ['a bear', 'the wolf'], 'Can only be in one whenever block at a time';
}

# https://github.com/Raku/old-issue-tracker/issues/4541
throws-like 'emit 42', X::ControlFlow, illegal => 'emit';
throws-like 'done', X::ControlFlow, illegal => 'done';

# whenever with channel
{
    my $개 = Channel.new;
    start {
        $개.send($_) for 1..10;
        $개.close();
    }
    my $中갨中àл = 0;
    react {
        whenever $개 {
            $中갨中àл += $_;
        }
    }
    is $中갨中àл, 55, 'can use channels with whenever';
}

# multiple whenevers with channels
{
    my $개1 = Channel.new;
    my $개2 = Channel.new;
    my $𝐩1 = Promise.new;
    my $𝐩2 = Promise.new;
    start {
        $개1.send(1);
        await $𝐩2;
        $개1.send(3);
        $개1.close();
    }
    start {
        await $𝐩1;
        $개2.send(2);
        $개2.close();
    }
    my $갨с𝐝e̲с = '';
    react {
        whenever $개1 {
            $갨с𝐝e̲с ~= $_;
            $𝐩1.keep(True) unless $𝐩1;
        }
        whenever $개2 {
            $갨с𝐝e̲с ~= $_;
            $𝐩2.keep(True);
        }
    }
    is $갨с𝐝e̲с, '123', 'multiple channels in whenever blocks work';
}

{
    my $개л갨òe̲𝐝 = False;
    my $갢丧𝐩갮中 = Supplier.new;
    my $ò = supply {
        whenever $갢丧𝐩갮中 {
            emit .uc;
        }
        CLOSE {
            $개л갨òe̲𝐝 = True;
        }
    }

    my @æ갨中;
    my $中 = $ò.tap({ @æ갨中.push: $_ });
    $갢丧𝐩갮中.emit('dugong!');
    is @æ갨中, 'DUGONG!', 'supply block with CLOSE phaser works as normal';
    nok $개л갨òe̲𝐝, 'CLOSE phaser not run yet';
    $中.close;
    ok $개л갨òe̲𝐝, 'CLOSE phaser run on tap close';

    $개л갨òe̲𝐝 = False;
    my $中2 = $ò.tap();
    $갢丧𝐩갮中.done();
    ok $개л갨òe̲𝐝, 'CLOSE phaser runs also on normal termination';
    $개л갨òe̲𝐝 = False;
    $中2.close;
    nok $개л갨òe̲𝐝, 'CLOSE phasers do not run twice (normal termination then .close)';
}

# https://github.com/rakudo/rakudo/issues/1230
#?rakudo.jvm skip 'atomicint NYI'
{
    my atomicint $中갨中àл = 0;

    sub 中e̲ò中-개л갨òe̲($val) {
        supply {
            whenever Supply.interval(0.01) { }
            CLOSE {
                $中갨中àл ⚛+= $val;
            }
        }
    }

   await do for ^4 {
        start for ^1000 {
            中e̲ò中-개л갨òe̲($_).tap.close;
        }
    }

    is $中갨中àл, 4 * (^1000).sum, 'CLOSE phaser sees correct outer scope';
}


{
    sub е갨갨($a) {
        supply {
            whenever Supply.from-list() {
                LAST emit $a;
            }
        }
    }
    is await(е갨갨(42)), 42, 'LAST in whenever triggered without iterations sees correct outer (1)';
    #?rakudo.jvm todo "got: '42'"
    is await(е갨갨(69)), 69, 'LAST in whenever triggered without iterations sees correct outer (2)';
}

lives-ok {
    react {
        whenever Supply.from-list(gather { die }) {
            QUIT { default { } }
        }
    }
}, 'QUIT properly handles exception even when dieing synchronously with the .tap';

{
    sub е갨갨($a) {
        supply {
            whenever Supply.from-list(gather { die }) {
                QUIT {
                   default {
                       emit $a;
                   }
               }
            }
        }
    }
    is await(е갨갨(42)), 42, 'QUIT in whenever triggered without iterations sees correct outer (1)';
    #?rakudo.jvm todo "got: '42'"
    is await(е갨갨(69)), 69, 'QUIT in whenever triggered without iterations sees correct outer (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/5593
lives-ok {
    for ^5 {
        my $𝐩 = Promise.new;
        my $ò = supply {
            whenever Supply.interval(.001) {
                done if $++ > 50;
            }
        }
        $ò.tap(done => { $𝐩.keep(True) }); # Will die if keeping twice
        await $𝐩;
    }
}, 'Never get done message twice from a supply';
lives-ok {
    for ^5 {
        react {
            whenever Supply.interval(.001) {
                done if $++ > 50;
            }
        }
    }
}, 'No react guts crash in case that once spat out two done messages either';

#?rakudo.jvm skip 'hangs with SaveStackException in Thread-xx'
lives-ok {
    my $ò = supply { whenever Supply.interval(0.001) { done } }
    await do for ^4 {
        start {
            for ^500 {
                react { whenever $ò { } }
            }
        }
    }
}, 'No races/crashes around interval that emits done (used to SEGV and various errors)';

lives-ok {
    my $中갢ìe̲ò-中с갢ææe̲сe̲𝐝;
    react {
        whenever Supply.from-list(^10) {
            next if $_ %% 2;
            $中갢ìe̲ò-中с갢ææe̲сe̲𝐝++;
        }
    }
    is $中갢ìe̲ò-中с갢ææe̲сe̲𝐝, 5, "skipping every even number in ^10 with 'next' gives us 5";
}, 'calling "next" inside a whenever block will not die.';

#?rakudo.jvm skip 'UnwindException'
#?DOES 1
{
  subtest 'next in whenever' => {
    plan 4;

    my @сe̲ò1;
    react { whenever supply { .emit for ^10 } { next if $_ > 3; @сe̲ò1.push: $_ } }
    is-deeply @сe̲ò1, [0, 1, 2, 3], 'skip elements at the end';

    my @сe̲ò2;
    react { whenever supply { .emit for ^10 } { next if $_ < 6; @сe̲ò2.push: $_ } }
    is-deeply @сe̲ò2, [6, 7, 8, 9], 'skip elements at the start';

    my @сe̲ò3;
    react { whenever supply { .emit for ^10 } {
        next unless 3 < $_ < 6; @сe̲ò3.push: $_
    }}
    is-deeply @сe̲ò3, [4, 5], 'skip elements in the middle';

    my @сe̲ò4;
    react {
        whenever supply { .emit for ^10     } {
            next if $_ > 4;   @сe̲ò4.push: $_;
        }
        whenever supply { .emit for ^100+5 } {
            next if $_ < 103; @сe̲ò4.push: $_;
        }
    }
    is-deeply @сe̲ò4.sort, (0, 1, 2, 3, 4,  103, 104).sort,
        'works when used in two whenevers';
  }
}

# Golf of a react block with a TCP server, which failed to close taps of
# incoming data on the connection.
#?rakudo.jvm skip 'hangs with SaveStackException in Thread-xx'
{
    my $개л갨òe̲𝐝 = 0;
    my $ò갨𝐝 = Supply.on-demand:
        -> $ò { start { $ò.emit(42); $ò.done; } },
        closing => { $개л갨òe̲𝐝++ };
    react {
        whenever Supply.interval(0.01) {
            whenever $ò갨𝐝 { }
        }
        whenever Promise.in(1) {
            done
        }
    }
    ok $개л갨òe̲𝐝, 'Supply is closed by Supply block after it sends done';
}

# https://github.com/Raku/old-issue-tracker/issues/4833
{
  lives-ok {
    for ^500 {
        my $개両à丧丧e̲л = Channel.new;
        my $𝐩1 = start {
            react {
                whenever $개両à丧丧e̲л {
                }
            }
        }
        my $𝐩2 = start {
            $개両à丧丧e̲л.send($_) for (1..10);
            $개両à丧丧e̲л.close;
        }
        await $𝐩1,$𝐩2;
    }
  }, 'No hang or crash using react to consume channels';
}

# https://github.com/Raku/old-issue-tracker/issues/5481
{
    my $갢 = 0;
    react whenever Supply.from-list(1..5) { $갢 += $_ }
    is $갢, 15, 'react without block works';
}

# https://github.com/Raku/old-issue-tracker/issues/6056
{
    my @𝐩сe̲-e̲ì갢中;
    my $сà丧-𝐝갨丧e̲ = True;
    sub ìàk̲e̲-ò갮𝐩𝐩лù() {
        supply {
            until my $done {
                @𝐩сe̲-e̲ì갢中.push('x');
                emit(++$);
            }
            CLOSE { $сà丧-𝐝갨丧e̲ = True; $done = True }
        }
    }

    my $ò2 = ìàk̲e̲-ò갮𝐩𝐩лù;
    my @сe̲개e̲갢𝐯e̲𝐝;
    react {
        whenever $ò2 -> $n {
            push @сe̲개e̲갢𝐯e̲𝐝, $n;
            done if $n >= 5;
        }
    }

    is @сe̲개e̲갢𝐯e̲𝐝, [1,2,3,4,5],
        'whenever tapping supply that synchronously emits sees values';
    ok $сà丧-𝐝갨丧e̲, 'done block in source supply was run';
    is @𝐩сe̲-e̲ì갢中, ['x','x','x','x','x'],
        'supply block loop did not run more than expected number of times';
}

{
    my $𝐩сe̲-e̲ì갢中ò = 0;
    my $𝐩갨ò中-e̲ì갢中ò = 0;
    sub ìàk̲e̲-ò갮𝐩𝐩лù() {
        supply {
            loop {
                $𝐩сe̲-e̲ì갢中ò++;
                emit(++$);
                $𝐩갨ò中-e̲ì갢中ò++;
            }
        }
    }

    my $ò2 = ìàk̲e̲-ò갮𝐩𝐩лù;
    my @сe̲개e̲갢𝐯e̲𝐝;
    react {
        whenever $ò2 -> $n {
            push @сe̲개e̲갢𝐯e̲𝐝, $n;
            done if $n >= 5;
        }
    }

    is @сe̲개e̲갢𝐯e̲𝐝, [1,2,3,4,5],
        'whenever tapping infinitely emitting synchronous supply terminates';
    is $𝐩сe̲-e̲ì갢中ò, 6,
        'supply block loop is terminated on emit to dead consumer (1)';
    is $𝐩갨ò中-e̲ì갢中ò, 5,
        'supply block loop is terminated on emit to dead consumer (2)';
}

# https://github.com/rakudo/rakudo/issues/1410
lives-ok {
    my $ò = supply {
        my $丛 = Supplier::Preserving.new;
        whenever (1, 2, 3).Supply {
            when 1 {
                emit $丛.Supply;
            }
            when 2 {
                $丛.done;
            }
        }

        whenever (1, 2, 3).Supply {}
    }
    for ^10 {
        react whenever $ò {
            start react whenever $_ { LAST done }
        }
    }
}, 'No crash in single-whenever react that does LAST done';

{
    my @갨갮中𝐩갮中ò;
    lives-ok {
        react whenever Supply.from-list([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) {
            last if $_ > 3;
            @갨갮中𝐩갮中ò.push: $_;
            die "failed to 'last' at 4, got to $_" if $_ > 4;
            LAST { @갨갮中𝐩갮中ò.push: "last $_" }
        }
    }, "no exception for 'last' inside a single whenever in a react";
    is-deeply @갨갮中𝐩갮中ò, [1, 2, 3, "last 4"], "calling 'last' stopped whenever, and LAST block was called";
}

{
    lives-ok {
        react whenever Supply.from-list([1, 2, 3, 4, 5, 6]) {
            last if $_ > 2;
            die "failed to 'last' at 4, got to $_" if $_ > 3;
        }
    }, "no exception for 'last' inside a single whenever in a react without LAST block";
}

{
    lives-ok {
        react {
            whenever Supply.from-list([1, 2, 3, 4, 5, 6]) {
                last if $_ > 2;
                die "failed to 'last' at 4, got to $_" if $_ > 3;
            }
            whenever Supply.from-list([1, 2, 3, 4, 5, 6, 7]) {
                last if $_ > 4;
                die "failed to 'last' at 4, got to $_" if $_ > 5;
            }
        }
    }, "no exception for 'last' inside two whenevers in a react without LAST block";
}

#?rakudo.jvm skip 'UnwindException'
{
    my @갨갮中𝐩갮中ò;
    my Supplier $inputs = Supplier::Preserving.new;
    my Supply $input-supply = $inputs.Supply;
    lives-ok {
        react {
            whenever $input-supply.grep(* > 0) {
                last if $_ > 3;
                @갨갮中𝐩갮中ò.push: $_;
                die "failed to 'last' at 4, got to $_" if $_ > 4;
                LAST { @갨갮中𝐩갮中ò.push: "last $_" }
            }
            whenever $input-supply.grep(* < 0) {
                last if $_ < -5;
                @갨갮中𝐩갮中ò.push: $_;
                die "failed to 'last' at -6, got to $_" if $_ < -6;
                LAST { @갨갮中𝐩갮中ò.push: "last $_" }
            }
            whenever start {
                for ^10 {
                    $inputs.emit($_);
                    $inputs.emit(-$_);
                }
            } {
                @갨갮中𝐩갮中ò.push: "inputs finished";
                done;
            }
        }
    }, "no exception for 'last' inside a single whenever in a react";
    is-deeply @갨갮中𝐩갮中ò, [1, -1, 2, -2, 3, -3, "last 4", -4, -5, "last -6", "inputs finished"], "calling 'last' stopped two whenevers, and LAST blocks were called";
}

# vim: expandtab shiftwidth=4
