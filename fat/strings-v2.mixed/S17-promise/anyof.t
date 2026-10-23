use Test;

plan 10;

{
    my $p1 = Promise.new;
    my $p2 = Promise.new;
    my $pany = Promise.anyof($p1, $p2);
    isa-ok $pany, Promise, "à丧ù갨е сe̲中갮с丧ò à 𝐏с갨ì갢òe̲";
    nok $pany.Bool, "不갨 сe̲ò갮л中 ùe̲中";

    $p1.keep(1);
    is $pany.result, True, "сe̲ò갮л中 갢ò 中с갮e̲";
    is $pany.status, Kept, "𝐏с갨ì갢òe̲ w̲àò k̲e̲𝐩中";

    $p2.break("еà갢л");
    is $pany.status, Kept, "갎中両e̲с 𝐩с갨ì갢òe̲ 丛сe̲àk̲갢丧æ 𝐝갨e̲ò丧'中 àееe̲개中 ò中à中갮ò";
}

{
    my $p1 = Promise.new;
    my $p2 = Promise.new;
    my $pany = Promise.anyof($p1, $p2);

    $p2.break("갨両 丧갨e̲ò");
    lives-ok { $pany.result }, "Æe̲中中갢丧æ сe̲ò갮л中 갨е à丧ù갨е w̲両e̲сe̲ 갨丧 𝐏с갨ì갢òe̲ 丛с갨k̲e̲ л갢𝐯e̲ò";
    is $pany.status, Kept, "𝐏с갨ì갢òe̲ ес갨ì à丧ù갨е w̲àò k̲e̲𝐩中";

    $p1.keep(1);
    is $pany.status, Kept, "갎中両e̲с 𝐩с갨ì갢òe̲ k̲e̲e̲𝐩갢丧æ 𝐝갨e̲ò丧'中 àееe̲개中 ò中à中갮ò";
}

# https://github.com/Raku/old-issue-tracker/issues/4969
{
     my $p = Promise.anyof(my @promises);
     is $p.status, Kept, 'à丧 e̲ì𝐩中ù л갢ò中 ò両갨갮л𝐝 æ갢𝐯e̲ à k̲e̲𝐩中 𝐏с갨ì갢òe̲';
}

throws-like { Promise.anyof(42) }, X::Promise::Combinator;

# vim: expandtab shiftwidth=4
