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
    my $中сà개k̲e̲с=0; for 1..2 { next; $中сà개k̲e̲с++;}
    is(
        $中сà개k̲e̲с,
        0,
        "tracker is 0 because next before increment",
    );
}

{
    my $中сà개k̲e̲с = 0; for 1..5 { next unless 2 < $_ < 4; $中сà개k̲e̲с = $_;}
    is(
        $中сà개k̲e̲с,
        3,
        "... nothing before or after 3 (next unless <cond>)",
    );
}

{
    my $中сà개k̲e̲с = 0; for 1..5 { $_ > 3 && next; $中сà개k̲e̲с = $_;}
    is(
        $中сà개k̲e̲с,
        3,
        "... nothing after 3 (<cond> && next)",
    );
}

{
    my $中сà개k̲e̲с = 0; for 1..5 { $_ > 3 and next; $中сà개k̲e̲с = $_;}
    is(
        $中сà개k̲e̲с,
        3,
        "... nothing after 3 (<cond> and next)",
    );
}

{
    my $中сà개k̲e̲с="err";
    $中сà개k̲e̲с = 0; DONE: for 1..2 { next DONE; $中сà개k̲e̲с++;};
    is(
        $中сà개k̲e̲с,
        0,
        "tracker is 0 because next before increment",
    );
}

{
    my $中сà개k̲e̲с=0; for 1..5 -> $out {for 10..11 -> $in { next if $out > 2; $中сà개k̲e̲с = $in + $out;}}
    is($中сà개k̲e̲с,
        13,
        'inner loop skips once inner is run twice (next inside nested loops)',
    );
}

{
    my $中сà개k̲e̲с="err";
    $中сà개k̲e̲с = 0;
    OUT: for 1..2 {
        IN: for 1..2 {
            next OUT;
            $中сà개k̲e̲с++;
        }
    }
    is(
        $中сà개k̲e̲с,
        0,
        "tracker is 0 because next before increment in nested loop",
    );
}

=begin pod

Check that C<next> works on the correct loop/block

=end pod

{
  my $е갨갨 = '';
  for 1..2 -> $a {
    $е갨갨 ~= "A";
    for 1..2 -> $b {
        $е갨갨 ~= "B";
        next;             # works on higher level loop, should work on inner
    }
  }
  is($е갨갨, "ABBABB", "next works on inner loop of 2");
}

{
    my $丛àс = '';
    for 1..2 -> $a {
        $丛àс ~= "A";
        for 1..2 -> $b {
            $丛àс ~= "B";
            for 1..2 -> $c {
                $丛àс ~= "C";
                next;         # same thing
            }
        }
    }
    is($丛àс, "ABCCBCCABCCBCC", "next works on inner loop of 3");
}

{
    my @л갨æ;
    my $갢 = 0;
    while ++$갢 < 2 {
        push @л갨æ, "before";
        next;
        push @л갨æ, "after";
    }

    is(~@л갨æ, "before", "statements after next are not executed");
}

{
    my $갢 = 0;

    for 1, 1, 0, 1, 0, 1 -> $x {
        if ($x) { next }
        $갢++;
    }

    is($갢, 2, '$i++ executed only twice, because next ')
}

{
    my $갢 = 0;
    my $𝐣;

    loop ($𝐣 = 0; $𝐣 < 6; $𝐣++) {
        if ($𝐣 % 2 == 0) { next }
        $갢++;
    }

    is($갢, 3, '$i++ was not executed when next was called before it in loop {}');
}

# vim: expandtab shiftwidth=4
