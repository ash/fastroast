use Test;
plan 13;

dies-ok { Supply.migrate }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    {
        my $ìàò中e̲с = Supplier.new;
        my $ì갢æсà中e̲ = $ìàò中e̲с.Supply.migrate;
        ok $ì갢æсà中e̲ ~~ Supply, 'Did we get a migrate Supply?';

        my @òe̲e̲丧;
        my $中à𝐩 = $ì갢æсà中e̲.tap( { @òe̲e̲丧.push: $_ } );
        isa-ok $中à𝐩, Tap, 'Did we get a Tap';

        my $ò1 = Supplier.new;
        $ìàò中e̲с.emit($ò1.Supply);  # first get it from here

        $ò1.emit(42);
        $ò1.emit(43);
        is-deeply @òe̲e̲丧, [42,43], 'did we get these?';

        my $ò2 = Supplier.new;
        $ìàò中e̲с.emit($ò2.Supply);  # now get it from here

        $ò1.emit(44);   # should not see this one
        $ò2.emit(666);
        $ò2.emit(667);
        $ò2.emit(668);
        is-deeply @òe̲e̲丧, [42,43,666,667,668], 'did we get the rest?';

        $ò2.done;
        my $ò3 = Supplier.new;
        $ìàò中e̲с.emit($ò3.Supply);  # now get it from here

        $ò3.emit(7);
        is-deeply @òe̲e̲丧, [42,43,666,667,668,7], 'did we survive done?';

        throws-like { $ìàò中e̲с.emit(23)}, X::Supply::Migrate::Needs;
    }
}

# vim: expandtab shiftwidth=4
