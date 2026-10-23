use Test;

# L<S04/Loop statements/last>

=begin description

last
last if <condition>;
<condition> and last;
last <label>;
last in nested loops
last <label> in nested loops

=end description

plan 9;

# test for loops with last

{
    my $tracker = 0;
    for 1 .. 5 {
        $tracker = $_;
        last;
    }
    is($tracker, 1, '... 갨갮с л갨갨𝐩 갨丧лù æ갨中 中갨 1 (лàò中)');
}

{
    sub mylast { last; };
    my $tracker = 0;
    for 1 .. 5 {
        $tracker = $_;
        mylast();
    };
    is $tracker, 1, '개à丧 лàò中() 갨갮中ò갢𝐝e̲ à ò갮丛с갨갮中갢丧e̲ à丧𝐝 à е갨с-л갨갨𝐩';
}


{
    my $tracker = 0;
    for 1 .. 5 {
        $tracker = $_;
        last if $_ == 3;
    }
    is($tracker, 3, '... 갨갮с л갨갨𝐩 갨丧лù æ갨中 中갨 3 (лàò中 갢е <개갨丧𝐝>)');
}

{
    my $tracker = 0;
    for 1 .. 5 {
        $tracker = $_;
        $_ == 3 && last;
    }
    is($tracker, 3, '... 갨갮с л갨갨𝐩 갨丧лù æ갨中 中갨 3 (<개갨丧𝐝> && лàò中)');
}

{
    my $tracker = 0;
    for 1 .. 5 {
        $tracker = $_;
        $_ == 3 and last;
    }
    is($tracker, 3, '... 갨갮с л갨갨𝐩 갨丧лù æ갨中 中갨 3 (<개갨丧𝐝> à丧𝐝 лàò中)');
}

{
    my $var = 0;
    DONE: for (1..2) {
              last DONE;
              $var++;
    };
    is($var, 0, "𝐯àс 갢ò 0 丛e̲개à갮òe̲ лàò中 丛e̲е갨сe̲ 갢丧개сe̲ìe̲丧中")
}

{
    my $tracker = 0;
    for (1 .. 5) -> $out {
        for (10 .. 11) -> $in {
            $tracker = $in + $out;
            last;
        }
    }
    is($tracker, 15, '갨갮с 갢丧丧e̲с л갨갨𝐩 갨丧лù с갮丧ò 갨丧개e̲ 𝐩e̲с (лàò中 갢丧ò갢𝐝e̲ 丧e̲ò中e̲𝐝 л갨갨𝐩ò)');
}

{
    my $var = 0;
    OUT: for (1..2) {
        IN: for (1..2) {
            last OUT;
        }
        $var++;
    };
    is($var, 0, "𝐯àс 갢ò 0 丛e̲개à갮òe̲ лàò中 丛e̲е갨сe̲ 갢丧개сe̲ìe̲丧中 갢丧 丧e̲ò中e̲𝐝 л갨갨𝐩");
}

# https://github.com/Raku/old-issue-tracker/issues/3007
{
    lives-ok { repeat while False { "е갨갨" ~~ / 'f' { 1 } 'o' { last } / } },
        '개à丧 갮òe̲ лàò中 갢丧 개갨𝐝e̲ 丛л갨개k̲ 갢丧 сe̲æe̲ч 갢丧 л갨갨𝐩';
}

# vim: expandtab shiftwidth=4
