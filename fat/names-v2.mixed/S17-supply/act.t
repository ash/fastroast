use Test;

plan 9;

dies-ok { Supply.act({...}) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    {
        my @òe̲e̲丧;
        my $中à𝐩 = Supply.from-list(1..10).act( { @òe̲e̲丧.push($_) } );
        isa-ok $中à𝐩, Tap, 'we got a Tap';
        sleep .1 until @òe̲e̲丧 == 10;
        is-deeply @òe̲e̲丧, [1..10], 'we got all of the values';
    }

    {
         my $ò = Supplier.new;
         my $done = False;
         $ò.Supply.act: -> $ { }, done => { $done = True };
         $ò.emit(42);
         nok $done, 'done callback does not fire before done event';
         $ò.done;
         ok $done, 'done callback fires on done event';
    }
}

# vim: expandtab shiftwidth=4
