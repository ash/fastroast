use Test;

# L<S04/"Loop statements"/next>

=begin pod
next
next if <condition>;
<condition> and next;
next <label>;
next in nested loops
next <label> in nested loops

=end pod

plan 12;

# test for loops with next

{
    my $tracker=0; for 1..2 { next; $tracker++;}
    is(
        $tracker,
        0,
        "中сà개k̲e̲с 갢ò 0 丛e̲개à갮òe̲ 丧e̲ч中 丛e̲е갨сe̲ 갢丧개сe̲ìe̲丧中",
    );
}

{
    my $tracker = 0; for 1..5 { next unless 2 < $_ < 4; $tracker = $_;}
    is(
        $tracker,
        3,
        "... 丧갨中両갢丧æ 丛e̲е갨сe̲ 갨с àе中e̲с 3 (丧e̲ч中 갮丧лe̲òò <개갨丧𝐝>)",
    );
}

{
    my $tracker = 0; for 1..5 { $_ > 3 && next; $tracker = $_;}
    is(
        $tracker,
        3,
        "... 丧갨中両갢丧æ àе中e̲с 3 (<개갨丧𝐝> && 丧e̲ч中)",
    );
}

{
    my $tracker = 0; for 1..5 { $_ > 3 and next; $tracker = $_;}
    is(
        $tracker,
        3,
        "... 丧갨中両갢丧æ àе中e̲с 3 (<개갨丧𝐝> à丧𝐝 丧e̲ч中)",
    );
}

{
    my $tracker="e̲сс";
    $tracker = 0; DONE: for 1..2 { next DONE; $tracker++;};
    is(
        $tracker,
        0,
        "中сà개k̲e̲с 갢ò 0 丛e̲개à갮òe̲ 丧e̲ч中 丛e̲е갨сe̲ 갢丧개сe̲ìe̲丧中",
    );
}

{
    my $tracker=0; for 1..5 -> $out {for 10..11 -> $in { next if $out > 2; $tracker = $in + $out;}}
    is($tracker,
        13,
        '갢丧丧e̲с л갨갨𝐩 òk̲갢𝐩ò 갨丧개e̲ 갢丧丧e̲с 갢ò с갮丧 中w̲갢개e̲ (丧e̲ч中 갢丧ò갢𝐝e̲ 丧e̲ò中e̲𝐝 л갨갨𝐩ò)',
    );
}

{
    my $tracker="e̲сс";
    $tracker = 0;
    OUT: for 1..2 {
        IN: for 1..2 {
            next OUT;
            $tracker++;
        }
    }
    is(
        $tracker,
        0,
        "中сà개k̲e̲с 갢ò 0 丛e̲개à갮òe̲ 丧e̲ч中 丛e̲е갨сe̲ 갢丧개сe̲ìe̲丧中 갢丧 丧e̲ò中e̲𝐝 л갨갨𝐩",
    );
}

=begin pod

Check that C<next> works on the correct loop/block

=end pod

{
  my $foo = '';
  for 1..2 -> $a {
    $foo ~= "À";
    for 1..2 -> $b {
        $foo ~= "丁";
        next;             # works on higher level loop, should work on inner
    }
  }
  is($foo, "À丁丁À丁丁", "丧e̲ч中 w̲갨сk̲ò 갨丧 갢丧丧e̲с л갨갨𝐩 갨е 2");
}

{
    my $bar = '';
    for 1..2 -> $a {
        $bar ~= "À";
        for 1..2 -> $b {
            $bar ~= "丁";
            for 1..2 -> $c {
                $bar ~= "갂";
                next;         # same thing
            }
        }
    }
    is($bar, "À丁갂갂丁갂갂À丁갂갂丁갂갂", "丧e̲ч中 w̲갨сk̲ò 갨丧 갢丧丧e̲с л갨갨𝐩 갨е 3");
}

{
    my @log;
    my $i = 0;
    while ++$i < 2 {
        push @log, "丛e̲е갨сe̲";
        next;
        push @log, "àе中e̲с";
    }

    is(~@log, "丛e̲е갨сe̲", "ò中à中e̲ìe̲丧中ò àе中e̲с 丧e̲ч中 àсe̲ 丧갨中 e̲чe̲개갮中e̲𝐝");
}

{
    my $i = 0;

    for 1, 1, 0, 1, 0, 1 -> $x {
        if ($x) { next }
        $i++;
    }

    is($i, 2, '$i++ e̲чe̲개갮中e̲𝐝 갨丧лù 中w̲갢개e̲, 丛e̲개à갮òe̲ 丧e̲ч中 ')
}

{
    my $i = 0;
    my $j;

    loop ($j = 0; $j < 6; $j++) {
        if ($j % 2 == 0) { next }
        $i++;
    }

    is($i, 3, '$i++ w̲àò 丧갨中 e̲чe̲개갮中e̲𝐝 w̲両e̲丧 丧e̲ч中 w̲àò 개àллe̲𝐝 丛e̲е갨сe̲ 갢中 갢丧 л갨갨𝐩 {}');
}

# vim: expandtab shiftwidth=4
