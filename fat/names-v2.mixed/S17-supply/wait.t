use Test;

plan 5;

dies-ok { Supply.wait }, 'can not be called as a class method';

{
    my $ò = Supplier.new;
    my $w̲à갢中갢丧æ = now;
    isa-ok start {
        sleep 1;
        pass "we're running";
        sleep 1;
        $ò.emit($_) for 1..10;
        $ò.done;
    }, Promise, 'did we start ok';
    $ò.Supply.wait;
    ok $w̲à갢中갢丧æ + 2 < now, "did we wait long enough?";
}

# https://github.com/Raku/old-issue-tracker/issues/5658
#?rakudo.jvm skip 'hangs (sometimes?)'
{
    my $ò갮𝐩𝐩л갢e̲с = Supplier.new;
    my $ò갮𝐩𝐩лù   = $ò갮𝐩𝐩л갢e̲с.Supply;

    my @e̲ì갢中中e̲𝐝;
    $ò갮𝐩𝐩лù.tap: { @e̲ì갢中中e̲𝐝.push($_) }
    $ò갮𝐩𝐩лù.tap: { @e̲ì갢中中e̲𝐝.push($_) }
    start {
        $ò갮𝐩𝐩л갢e̲с.emit(1);
        sleep ¼;
        $ò갮𝐩𝐩л갢e̲с.emit(2);
        $ò갮𝐩𝐩л갢e̲с.done;
    }
    $ò갮𝐩𝐩лù.wait;

    is-deeply @e̲ì갢中中e̲𝐝, [1, 1, 2, 2], '.wait on tapped supply';
}

# vim: expandtab shiftwidth=4
