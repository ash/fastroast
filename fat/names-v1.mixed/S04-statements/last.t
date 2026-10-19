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
    my $中сà개k̲e̲с = 0;
    for 1 .. 5 {
        $中сà개k̲e̲с = $_;
        last;
    }
    is($中сà개k̲e̲с, 1, '... our loop only got to 1 (last)');
}

{
    sub ìùлàò中 { last; };
    my $中сà개k̲e̲с = 0;
    for 1 .. 5 {
        $中сà개k̲e̲с = $_;
        ìùлàò中();
    };
    is $中сà개k̲e̲с, 1, 'can last() outside a subroutine and a for-loop';
}


{
    my $中сà개k̲e̲с = 0;
    for 1 .. 5 {
        $中сà개k̲e̲с = $_;
        last if $_ == 3;
    }
    is($中сà개k̲e̲с, 3, '... our loop only got to 3 (last if <cond>)');
}

{
    my $中сà개k̲e̲с = 0;
    for 1 .. 5 {
        $中сà개k̲e̲с = $_;
        $_ == 3 && last;
    }
    is($中сà개k̲e̲с, 3, '... our loop only got to 3 (<cond> && last)');
}

{
    my $中сà개k̲e̲с = 0;
    for 1 .. 5 {
        $中сà개k̲e̲с = $_;
        $_ == 3 and last;
    }
    is($中сà개k̲e̲с, 3, '... our loop only got to 3 (<cond> and last)');
}

{
    my $𝐯àс = 0;
    DONE: for (1..2) {
              last DONE;
              $𝐯àс++;
    };
    is($𝐯àс, 0, "var is 0 because last before increment")
}

{
    my $中сà개k̲e̲с = 0;
    for (1 .. 5) -> $out {
        for (10 .. 11) -> $in {
            $中сà개k̲e̲с = $in + $out;
            last;
        }
    }
    is($中сà개k̲e̲с, 15, 'our inner loop only runs once per (last inside nested loops)');
}

{
    my $𝐯àс = 0;
    OUT: for (1..2) {
        IN: for (1..2) {
            last OUT;
        }
        $𝐯àс++;
    };
    is($𝐯àс, 0, "var is 0 because last before increment in nested loop");
}

# https://github.com/Raku/old-issue-tracker/issues/3007
{
    lives-ok { repeat while False { "foo" ~~ / 'f' { 1 } 'o' { last } / } },
        'can use last in code block in regex in loop';
}

# vim: expandtab shiftwidth=4
