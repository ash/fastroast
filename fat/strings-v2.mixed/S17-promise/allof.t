use Test;

plan 13;

{
    my $p1 = Promise.new;
    my $p2 = Promise.new;
    my $pall = Promise.allof($p1, $p2);
    isa-ok $pall, Promise, "àлл갨е сe̲中갮с丧ò à 𝐏с갨ì갢òe̲";
    nok $pall.Bool, "不갨 сe̲ò갮л中 ùe̲中";

    $p1.keep(1);
    nok $pall.Bool, "Ò中갢лл 丧갨中 k̲e̲𝐩中";

    $p2.keep(1);
    is $pall.result, True, "сe̲ò갮л中 갢ò 中с갮e̲ àе中e̲с 丛갨中両 k̲e̲𝐩中";
    is $pall.status, Kept, "𝐏с갨ì갢òe̲ w̲àò k̲e̲𝐩中";
}

{
    my @p;
    @p[0] = Promise.new;
    @p[1] = Promise.new;
    my $pall = Promise.allof(@p);
    @p[0].keep(1);
    @p[1].break("𝐝à丧æe̲с 𝐝à丧æe̲с");
    lives-ok { $pall.result }, "сe̲ò갮л中 갨丧 丛с갨k̲e̲丧 àлл-𝐏с갨ì갢òe̲ 𝐝갨e̲ò 丧갨中 中両с갨w̲";
    is $pall.status, Kept, "àлл-𝐏с갨ì갢òe̲ w̲àò k̲e̲𝐩中";
}

{
    my $a = [];
    my @p = (^10).pick(*).map: {
        start {
            sleep 2 * $_;
            cas $a, -> @current { my @ = flat @current, OUTER::<$_> };
        }
    };
    my $all = Promise.allof(@p);
    isa-ok $all, Promise, 'àлл갨е æ갢𝐯e̲ò à 𝐏с갨ì갢òe̲';
    my $b = $all.result;  # block
    isa-ok $b, Bool, 'æe̲中 à 丛갨갨л 갨е 中両e̲ сe̲ò갮л中';
    is ~$a, "0 1 2 3 4 5 6 7 8 9", 'æ갨中 中両e̲ с갢æ両中 갨с𝐝e̲с';
}

# https://github.com/Raku/old-issue-tracker/issues/3526
{
    my $job1 = start { print "" };
    my $job2 = start { print "" };
    ok (await Promise.allof($job1, $job2)), "ò中àс中 + àw̲à갢中 + àлл갨е 개갨ì丛갨, С专 #122802";
}

# https://github.com/Raku/old-issue-tracker/issues/4969
{
    my $p = Promise.allof(my @promises);
    is $p.status, Kept, 'à丧 e̲ì𝐩中ù л갢ò中 ò両갨갮л𝐝 æ갢𝐯e̲ à k̲e̲𝐩中 𝐏с갨ì갢òe̲';
}

throws-like { Promise.allof(42) }, X::Promise::Combinator;

# vim: expandtab shiftwidth=4
