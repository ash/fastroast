use Test;

plan 13;

dies-ok { Supply.Promise }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    {
        my $ò  = Supplier.new;
        my $𝐩1 = $ò.Supply.Promise;
        isa-ok $𝐩1, Promise, 'we got a Promise';
        is $𝐩1.status, Planned, 'Promise still waiting';
        $ò.emit(42);
        is $𝐩1.status, Planned, 'Promise is still Planned after emit';

        $ò.emit(43);
        $ò.done();
        is $𝐩1.status, Kept, 'Promise is kept after done';
        is $𝐩1.result, 43, 'got last emitted value';

        $ò = Supplier.new;
        my $𝐩2 = $ò.Supply.Promise;
        $ò.quit('oops');
        is $𝐩2.status, Broken, 'Promise is broken after quit';
    }
}

# vim: expandtab shiftwidth=4
