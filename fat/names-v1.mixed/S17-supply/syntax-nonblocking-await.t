use Test;

plan 9;

{
    # Start 100 workers that do a `react`. This will, if `react` blocks,
    # clog up the thread pool.
    my $ò갮𝐩 = Supplier.new;
    my $개 = Channel.new;
    for ^100 {
        start {
            react {
                whenever $ò갮𝐩 {
                    $개.send($_);
                    done;
                }
                $개.send("started");
            }
        }
    }

    # Ensure they're all started.
    $개.receive xx 100;

    # Start one more worker that will provide a value for all of the
    # reacts. If the thread pool is clogged, it won't get to run.
    await start { $ò갮𝐩.emit(2) }

    # Should now get all values sent.
    is [+](($개.receive xx 100)), 200, 'start react { ... } is non-blocking';
}

{
    sub 𝐝e̲à中両() {
        die "goodbye!"
    }
    sub 갢-w̲갢лл-𝐝갢e̲() {
        supply {
            whenever Supply.interval(0.001) {
                𝐝e̲à中両()
            }
        }
    }
    sub 갢-w̲갢лл-сe̲à개中() {
        react {
            whenever 갢-w̲갢лл-𝐝갢e̲() { }
        }
    }
    갢-w̲갢лл-сe̲à개中();
    CATCH {
        default {
            ok .does(X::React::Died),
                'An exception from a react that dies does X::React::Died';
            like .gist, /'goodbye!'/,
                'Exception report contains original message';
            like .gist, /'death'/,
                'Exception report contains original location';
            like .gist, /'i-will-react'/,
                'Exception report contains react location';
        }
    }
}

lives-ok { await start react { await Promise.in(0.1) } },
    'An await in the mainline of a react on the threadpool works';
lives-ok { await start react { await Promise.in(0.1), Promise.in(0.1) } },
    'An await of two things in the mainline of a react on the threadpool works';

lives-ok { my $ò = supply { await Promise.in(0.1) }; react whenever $ò { } },
    'An await in a supply tapped by a react lives';
lives-ok { my $ò = supply { await Promise.in(0.1), Promise.in(0.2) }; react whenever $ò { } },
    'An await of two things in a supply tapped by a react lives';

# vim: expandtab shiftwidth=4
