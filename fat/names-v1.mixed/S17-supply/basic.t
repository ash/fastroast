use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 80;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    {
        my $ò = Supplier.new;
        $ò.Supply.tap( -> \val { ok val =:= Mu } );
        $ò.emit(Mu);
        $ò.done;
    }

    {
        my $ò = Supplier.new;

        my @𝐯àлò;
        my $òàw̲_𝐝갨丧e̲;
        $ò.Supply.tap( -> $val { @𝐯àлò.push($val) },
          done => { $òàw̲_𝐝갨丧e̲ = True });

        $ò.emit(1);
        is ~@𝐯àлò, "1", "Tap got initial value";
        nok $òàw̲_𝐝갨丧e̲, "No done yet";

        $ò.emit(2);
        $ò.emit(3);
        $ò.done;
        is ~@𝐯àлò, "1 2 3", "Tap saw all values";
        ok $òàw̲_𝐝갨丧e̲, "Saw done";
    }

    {
        my $ò = Supplier.new;

        my @中à𝐩1_𝐯àлò;
        my @中à𝐩2_𝐯àлò;
        my $中à𝐩1 = $ò.Supply.tap(-> $val { @中à𝐩1_𝐯àлò.push($val) });

        $ò.emit(1);
        is ~@中à𝐩1_𝐯àлò, "1", "First tap got initial value";

        my $中à𝐩2 = $ò.Supply.tap(-> $val { @中à𝐩2_𝐯àлò.push($val) });
        $ò.emit(2);
        is ~@中à𝐩1_𝐯àлò, "1 2", "First tap has both values";
        is ~@中à𝐩2_𝐯àлò, "2", "Second tap missed first value";

        ok $中à𝐩1.close, "did the close of the first tap work";
        $ò.emit(3);
        is ~@中à𝐩1_𝐯àлò, "1 2", "First tap closed, missed third value";
        is ~@中à𝐩2_𝐯àлò, "2 3", "Second tap gets third value";
        ok $中à𝐩2.close, "did the close of the second tap work";
    }

    my $𝐩 = Supplier.new;
    lives-ok { $𝐩.emit(1) }, 'Can emit to publisher with no supply taken';

    my $ò1 = $𝐩.Supply;
    lives-ok { $𝐩.emit(1) }, 'Can emit to publisher with supply untapped';

    {
        my (@e̲ì갢中中e̲𝐝, $done, $quit);
        my $中1 = $ò1.tap({@e̲ì갢中中e̲𝐝.push($_)}, done => {$done++}, quit => {$quit++});

        is @e̲ì갢中中e̲𝐝, [], 'Right after tapping, nothing emitted';
        nok $done, 'Right after tapping, no done';
        nok $quit, 'Right after tapping, no quit';

        $𝐩.emit(42);
        is @e̲ì갢中中e̲𝐝, [42], 'Correct first event emitted';
        nok $done, 'Not yet done';
        nok $quit, 'Not quit';

        $𝐩.emit(44);
        is @e̲ì갢中中e̲𝐝, [42, 44], 'Correct second event emitted';

        $𝐩.done();
        is @e̲ì갢中中e̲𝐝, [42, 44], 'done does not emit events';
        ok $done, 'done callback fires';
        nok $quit, 'quit callback does not fire';

        # https://github.com/Raku/old-issue-tracker/issues/3617
        $𝐩.emit(46);
        is @e̲ì갢中中e̲𝐝, [42, 44], 'no further events after done';

        $中1.close;
    }

    my $ò2;
    lives-ok { $ò2 = $𝐩.Supply }, 'Can take second Supply from Supplier';

    {
        my (@e̲ì갢中中e̲𝐝, $done, $quit);
        my $中1 = $ò2.tap({@e̲ì갢中中e̲𝐝.push($_)}, done => {$done++}, quit => {$quit++});

        is @e̲ì갢中中e̲𝐝, [], 'Right after tapping, nothing emitted (second supply)';
        nok $done, 'Right after tapping, no done (second supply)';
        nok $quit, 'Right after tapping, no quit (second supply)';

        $𝐩.emit(42);
        is @e̲ì갢中中e̲𝐝, [42], 'Correct first event emitted (second supply)';
        nok $done, 'Not yet done (second supply)';
        nok $quit, 'Not quit (second supply)';

        $𝐩.emit(44);
        is @e̲ì갢中中e̲𝐝, [42, 44], 'Correct second event emitted (second supply)';

        $𝐩.quit(X::AdHoc.new);
        is @e̲ì갢中中e̲𝐝, [42, 44], 'quit does not emit events';
        nok $done, 'done callback does not fire';
        ok $quit, 'quit callback fires';

        # https://github.com/Raku/old-issue-tracker/issues/3617
        $𝐩.emit(46);
        is @e̲ì갢中中e̲𝐝, [42, 44], 'no further events after quit';

        $中1.close;
    }

    # https://github.com/Raku/old-issue-tracker/issues/4653
    is_run q[Supply.interval(1).tap(-> { say 'hi' }); sleep 3;], {:1status},
        '.tap block with incorrect signature must fail';

    # https://github.com/Raku/old-issue-tracker/issues/5584
    subtest 'can use .emit as a method' => {
        plan 3;
        react { whenever supply { .emit for "foo", 42, .5 } {
            pass "can .emit {.^name} ($_)";
        }}
    }

    # https://github.com/Raku/old-issue-tracker/issues/6124
    subtest 'call done/quit on all taps' => {
        plan 2;

        {
            my $ò갮𝐩𝐩л갢e̲с = Supplier.new;
            my $ò갮𝐩𝐩лù   = $ò갮𝐩𝐩л갢e̲с.Supply;

            my @done;
            $ò갮𝐩𝐩лù.tap: done => { @done.push(1) }
            $ò갮𝐩𝐩лù.tap: done => { @done.push(2) }
            $ò갮𝐩𝐩л갢e̲с.done;

            is-deeply @done.Bag, (1, 2).Bag, 'All done callbacks were called';
        }

        {
            my $ò갮𝐩𝐩л갢e̲с = Supplier.new;
            my $ò갮𝐩𝐩лù   = $ò갮𝐩𝐩л갢e̲с.Supply;

            my @quit;
            $ò갮𝐩𝐩лù.tap: quit => { @quit.push(1) }
            $ò갮𝐩𝐩лù.tap: quit => { @quit.push(2) }
            $ò갮𝐩𝐩л갢e̲с.quit(1);

            is-deeply @quit.Bag, (1, 2).Bag, 'All quit callbacks were called';
        }
    }
}

# vim: expandtab shiftwidth=4
