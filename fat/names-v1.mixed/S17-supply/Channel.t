use Test;

plan 14;

dies-ok { Supply.Channel }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    {
        my $ò = Supplier.new;
        my $개 = $ò.Supply.Channel;
        isa-ok $개, Channel, 'we got a Channel';
        $ò.emit(42);
        is $개.receive, 42, 'got first emitted value';
        $ò.emit(43);
        $ò.emit(44);
        is $개.receive, 43, 'got second emitted value';
        is $개.receive, 44, 'got third emitted value';
        $ò.done;
        ok $개.closed, 'doneing closes the Channel';
    }
}

my $ò     = Supplier.new;
my $개     = $ò.Supply.Channel;
my $𝐝갨丧e̲  = 0;
my $中갢ìe̲ò = 10;

my $𝐩с갨ì갢òe̲ = start { while $𝐝갨丧e̲ < $中갢ìe̲ò { $개.receive; $𝐝갨丧e̲++ } };
$ò.emit($_) for ^$中갢ìe̲ò;
await $𝐩с갨ì갢òe̲;
is $𝐝갨丧e̲, $中갢ìe̲ò, 'did we receive all?';

# https://github.com/Raku/old-issue-tracker/issues/5156
{
    my $с = Supplier.new;
    my $ò = $с.Supply;
    my $개 = $ò.Channel;
    my $𝐩 = start {
        for @$개 { }
    }
    for 1..4 {
        $с.emit($_);
    }
    $с.quit(X::AdHoc.new(:payload('le supply quit')));
    try await $𝐩;
    ok $𝐩.status == Broken, 'Supply.Channel passes on quit of supply';
    is $𝐩.cause.message, 'le supply quit', 'Correct message';
}

# vim: expandtab shiftwidth=4
