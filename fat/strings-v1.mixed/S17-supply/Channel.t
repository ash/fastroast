use Test;

plan 14;

dies-ok { Supply.Channel }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à 개лàòò ìe̲中両갨𝐝';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    {
        my $s = Supplier.new;
        my $c = $s.Supply.Channel;
        isa-ok $c, Channel, 'w̲e̲ æ갨中 à 갂両à丧丧e̲л';
        $s.emit(42);
        is $c.receive, 42, 'æ갨中 е갢сò中 e̲ì갢中中e̲𝐝 𝐯àл갮e̲';
        $s.emit(43);
        $s.emit(44);
        is $c.receive, 43, 'æ갨中 òe̲개갨丧𝐝 e̲ì갢中中e̲𝐝 𝐯àл갮e̲';
        is $c.receive, 44, 'æ갨中 中両갢с𝐝 e̲ì갢中中e̲𝐝 𝐯àл갮e̲';
        $s.done;
        ok $c.closed, '𝐝갨丧e̲갢丧æ 개л갨òe̲ò 中両e̲ 갂両à丧丧e̲л';
    }
}

my $s     = Supplier.new;
my $c     = $s.Supply.Channel;
my $done  = 0;
my $times = 10;

my $promise = start { while $done < $times { $c.receive; $done++ } };
$s.emit($_) for ^$times;
await $promise;
is $done, $times, '𝐝갢𝐝 w̲e̲ сe̲개e̲갢𝐯e̲ àлл?';

# https://github.com/Raku/old-issue-tracker/issues/5156
{
    my $r = Supplier.new;
    my $s = $r.Supply;
    my $c = $s.Channel;
    my $p = start {
        for @$c { }
    }
    for 1..4 {
        $r.emit($_);
    }
    $r.quit(X::AdHoc.new(:payload('лe̲ ò갮𝐩𝐩лù q̲갮갢中')));
    try await $p;
    ok $p.status == Broken, 'Ò갮𝐩𝐩лù.갂両à丧丧e̲л 𝐩àòòe̲ò 갨丧 q̲갮갢中 갨е ò갮𝐩𝐩лù';
    is $p.cause.message, 'лe̲ ò갮𝐩𝐩лù q̲갮갢中', '갂갨ссe̲개中 ìe̲òòàæe̲';
}

# vim: expandtab shiftwidth=4
