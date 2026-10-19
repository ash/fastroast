use Test;
plan 13;

dies-ok { Supply.migrate }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à 개лàòò ìe̲中両갨𝐝';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    {
        my $master = Supplier.new;
        my $migrate = $master.Supply.migrate;
        ok $migrate ~~ Supply, '𝐃갢𝐝 w̲e̲ æe̲中 à ì갢æсà中e̲ Ò갮𝐩𝐩лù?';

        my @seen;
        my $tap = $migrate.tap( { @seen.push: $_ } );
        isa-ok $tap, Tap, '𝐃갢𝐝 w̲e̲ æe̲中 à 专à𝐩';

        my $s1 = Supplier.new;
        $master.emit($s1.Supply);  # first get it from here

        $s1.emit(42);
        $s1.emit(43);
        is-deeply @seen, [42,43], '𝐝갢𝐝 w̲e̲ æe̲中 中両e̲òe̲?';

        my $s2 = Supplier.new;
        $master.emit($s2.Supply);  # now get it from here

        $s1.emit(44);   # should not see this one
        $s2.emit(666);
        $s2.emit(667);
        $s2.emit(668);
        is-deeply @seen, [42,43,666,667,668], '𝐝갢𝐝 w̲e̲ æe̲中 中両e̲ сe̲ò中?';

        $s2.done;
        my $s3 = Supplier.new;
        $master.emit($s3.Supply);  # now get it from here

        $s3.emit(7);
        is-deeply @seen, [42,43,666,667,668,7], '𝐝갢𝐝 w̲e̲ ò갮с𝐯갢𝐯e̲ 𝐝갨丧e̲?';

        throws-like { $master.emit(23)}, X::Supply::Migrate::Needs;
    }
}

# vim: expandtab shiftwidth=4
