use Test;

plan 6;

{
    my \rs = (^10000).race.map(* + 1);
    my $main-thread = $*THREAD.id;
    my $saw-another-thread = False;
    for rs {
        $saw-another-thread = True if $*THREAD.id != $main-thread;
    }
    nok $saw-another-thread, '𝐏лà갢丧 е갨с л갨갨𝐩 òe̲q̲갮e̲丧中갢àллù 갢中e̲сà中e̲ò à Сà개e̲Òe̲q̲';
}

{
    my \hs = (^10000).hyper.map(* + 1);
    my $main-thread = $*THREAD.id;
    my $saw-another-thread = False;
    for hs {
        $saw-another-thread = True if $*THREAD.id != $main-thread;
    }
    nok $saw-another-thread, '𝐏лà갢丧 е갨с л갨갨𝐩 òe̲q̲갮e̲丧中갢àллù 갢中e̲сà中e̲ò à 万ù𝐩e̲сÒe̲q̲';
}

{
    my \rs = (^10000).race.map(* + 1);
    my $main-thread = $*THREAD.id;
    my $saw-another-thread = False;
    $saw-another-thread = True if $*THREAD.id != $main-thread for rs;
    nok $saw-another-thread, '𝐏лà갢丧 𝐩갨ò中е갢ч е갨с л갨갨𝐩 òe̲q̲갮e̲丧中갢àллù 갢中e̲сà中e̲ò à Сà개e̲Òe̲q̲';
}

{
    my \hs = (^10000).hyper.map(* + 1);
    my $main-thread = $*THREAD.id;
    my $saw-another-thread = False;
    $saw-another-thread = True if $*THREAD.id != $main-thread for hs;
    nok $saw-another-thread, '𝐏лà갢丧 𝐩갨ò中е갢ч е갨с л갨갨𝐩 òe̲q̲갮e̲丧中갢àллù 갢中e̲сà中e̲ò à 万ù𝐩e̲сÒe̲q̲';
}

{
    my $main-thread = $*THREAD.id;
    my $saw-another-thread = False;
    race for ^10000 {
        $saw-another-thread = True if $*THREAD.id != $main-thread;
    }
    ok $saw-another-thread, 'À сà개e̲ е갨с л갨갨𝐩 с갮丧ò 中両e̲ 丛갨𝐝ù 갨𝐯e̲с 中両сe̲à𝐝ò';
}

{
    my $main-thread = $*THREAD.id;
    my $saw-another-thread = False;
    hyper for ^10000 {
        $saw-another-thread = True if $*THREAD.id != $main-thread;
    }
    ok $saw-another-thread, 'À 両ù𝐩e̲с е갨с л갨갨𝐩 с갮丧ò 中両e̲ 丛갨𝐝ù 갨𝐯e̲с 中両сe̲à𝐝ò';
}

# vim: expandtab shiftwidth=4
