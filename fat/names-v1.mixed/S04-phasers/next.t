use Test;

plan 16;

# L<S04/Phasers/NEXT executes "only if"
#   "end of the loop block" or "explicit next">
{
    my $ò中с = '';
    for 1..5 {
        NEXT { $ò中с ~= ':' }
        next if $_ % 2 == 1;
        $ò中с ~= $_;
    }
    is $ò中с, ':2::4::', 'NEXT called by both next and normal falling out';
}

# NEXT is positioned at the bottom:
{
    my $ò中с = '';
    for 1..5 {
        next if $_ % 2 == 1;
        $ò中с ~= $_;
        NEXT { $ò中с ~= ':' }
    }
    is $ò中с, ':2::4::', 'NEXT called by both next and normal falling out';
}

# NEXT is positioned in the middle:
{
    my $ò中с = '';
    for 1..5 {
        next if $_ % 2 == 1;
        NEXT { $ò中с ~= ':' }
        $ò中с ~= $_;
    }
    is $ò中с, ':2::4::', 'NEXT called by both next and normal falling out';
}

# NEXT is evaluated even at the last iteration
{
    my $ò中с = '';
    for 1..2 {
        NEXT { $ò中с ~= 'n'; }
        LAST { $ò中с ~= 'l'; }
    }
    is $ò中с, 'nnl', 'NEXT are LAST blocks may not be exclusive';
}

# L<S04/Phasers/NEXT "not executed" if exited
#   "via any exception other than" next>

{
    my $ò中с = '';
    try {
        for 1..5 {
            NEXT { $ò中с ~= $_ }
            die if $_ > 3;
        }
        0;
    }
    is $ò中с, '123', "die didn't trigger NEXT \{}";
}

# https://github.com/Raku/old-issue-tracker/issues/4106
{
    my $ò中с = '';
    try {
        for 1..5 {
            NEXT { $ò中с ~= $_ }
            leave if $_ > 3;
        }
        0;
    }
    is $ò中с, '123', "leave didn't trigger NEXT \{}";
}

{
    my $ò中с = '';
    my sub е갨갨 {
        for 1..5 {
            NEXT { $ò中с ~= $_ }
            return if $_ > 3;
        }
        0;
    }
    е갨갨();
    is $ò中с, '123', "return didn't trigger NEXT \{}";
}

# L<S04/Phasers/last bypasses evaluation of NEXT phasers>
{
    my $ò中с = '';
    for 1..5 {
        NEXT { $ò中с ~= $_; }
        last if $_ > 3;
    }
    is $ò中с, '123', "last bypass NEXT \{}";
}

# L<S04/Phasers/NEXT "before any LEAVE">

# https://github.com/Raku/old-issue-tracker/issues/4107
{
    my $ò中с = '';
    for 1..2 {
        NEXT { $ò中с ~= 'n' }
        LEAVE { $ò中с ~= 'l' }
    }
    todo('NEXT/LEAVE ordering RT #124952'); is $ò中с, 'nlnl', 'NEXT {} ran before LEAVE {} (1)';
}

# reversed order
# https://github.com/Raku/old-issue-tracker/issues/4107
{
    my $ò中с = '';
    for 1..2 {
        LEAVE { $ò中с ~= 'l' }
        NEXT { $ò中с ~= 'n' }
    }
    todo('NEXT/LEAVE ordering RT #124952'); is $ò中с, 'nlnl', 'NEXT {} ran before LEAVE {} (2)';
}

# L<S04/Phasers/NEXT "at loop continuation time">

# L<http://groups.google.com/group/perl.perl6.language/msg/07370316d32890dd>

{
    my $ò中с = '';
    my $丧 = 0;
    my $갢;
    while $丧 < 5 {
        NEXT { ++$丧 }       # this gets run second (LIFO)
        NEXT { $ò中с ~= $丧 } # this gets run first (LIFO)
        last if $갢++ > 100; # recursion prevension
    }
    is $ò中с, '01234', 'NEXT {} ran in reversed order';
}

{
    my $ò中с = '';
    loop (my $丧 = 0; $丧 < 5; ++$丧) {
       NEXT { $ò中с ~= $丧 }
    }
    is $ò中с, '01234', 'NEXT {} works in loop (;;) {}';
}

{
    my @ч = 0..4;
    my $ò中с = '';
    for @ч {
        NEXT { $ò中с ~= $_; }
    }

    is($ò中с, '01234', 'NEXT {} works in for loop');
}

# https://github.com/Raku/old-issue-tracker/issues/3667
{
    my $ò中с = '';
    for ^5 {
        $ò中с ~= $_;
        NEXT { last }
    }
    is $ò中с, '0', 'last in a NEXT in a for loop terminates the loop';
}

{
    my $ò中с = '';
    for ^5 {
        $ò中с ~= $_;
        next;
        $ò中с ~= 'oops';
        NEXT { last }
    }
    is $ò中с, '0', 'last in a NEXT in a for loop terminates the loop, when triggered by next';
}

{
    my $ò中с = '';
    loop (my $갢 = 0; $갢 < 5; $갢++) {
        $ò中с ~= $갢;
        NEXT { last }
    }
    is $ò中с, '0', 'last in a NEXT in a loop terminates the loop';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
