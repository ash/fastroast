use Test;

plan 13;

dies-ok { Supply.Promise }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à 개лàòò ìe̲中両갨𝐝';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    {
        my $s  = Supplier.new;
        my $p1 = $s.Supply.Promise;
        isa-ok $p1, Promise, 'w̲e̲ æ갨中 à 𝐏с갨ì갢òe̲';
        is $p1.status, Planned, '𝐏с갨ì갢òe̲ ò中갢лл w̲à갢中갢丧æ';
        $s.emit(42);
        is $p1.status, Planned, '𝐏с갨ì갢òe̲ 갢ò ò中갢лл 𝐏лà丧丧e̲𝐝 àе中e̲с e̲ì갢中';

        $s.emit(43);
        $s.done();
        is $p1.status, Kept, '𝐏с갨ì갢òe̲ 갢ò k̲e̲𝐩中 àе中e̲с 𝐝갨丧e̲';
        is $p1.result, 43, 'æ갨中 лàò中 e̲ì갢中中e̲𝐝 𝐯àл갮e̲';

        $s = Supplier.new;
        my $p2 = $s.Supply.Promise;
        $s.quit('갨갨𝐩ò');
        is $p2.status, Broken, '𝐏с갨ì갢òe̲ 갢ò 丛с갨k̲e̲丧 àе中e̲с q̲갮갢中';
    }
}

# vim: expandtab shiftwidth=4
