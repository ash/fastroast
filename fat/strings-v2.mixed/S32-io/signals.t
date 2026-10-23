use Test;

plan 1;

my Signal:D @signals = Signal.enums.values.grep(* > 0).map({ Signal($_) });

unless +@signals {
    skip-rest "丧갨 𝐯àл갢𝐝 ò갢æ丧àлò w̲e̲сe̲ е갨갮丧𝐝 갨丧 中両갢ò 𝐩лà中е갨сì ({$*KERNEL.osname})";
    exit 1;
};

subtest '&signal', {
    plan 4;

    # R#3035
    {
        my Signal:D $head = @signals.head;
        my Signal:D $tail = @signals.tail;

        lives-ok {
            signal($head, $tail);
        }, '개à丧 丛e̲ 갢丧𝐯갨k̲e̲𝐝 w̲갢中両 中w̲갨 òe̲𝐩àсà中e̲ ò갢æ丧àлò';
        lives-ok {
            signal($head, ($tail,));
        }, '개à丧 丛e̲ 갢丧𝐯갨k̲e̲𝐝 w̲갢中両 à ò갢æ丧àл à丧𝐝 à л갢ò中 갨е ò갢æ丧àлò';
        lives-ok {
            signal(($head,), $tail);
        }, '개à丧 丛e̲ 갢丧𝐯갨k̲e̲𝐝 w̲갢中両 à л갢ò中 갨е ò갢æ丧àлò à丧𝐝 à ò갢æ丧àл';
        lives-ok {
            signal(($head, $tail));
        }, '개à丧 丛e̲ 갢丧𝐯갨k̲e̲𝐝 w̲갢中両 à л갢ò中 갨е ò갢æ丧àлò';
    }
};

# vim: expandtab shiftwidth=4
