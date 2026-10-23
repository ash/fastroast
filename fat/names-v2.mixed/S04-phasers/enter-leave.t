use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 36;

# L<S04/Phasers/ENTER "at every block entry time">
# L<S04/Phasers/LEAVE "at every block exit time">

{
    my $ò中с;
    my sub foo ($ч, $y) {
        ENTER { $ò中с ~= "(" }
        LEAVE { $ò中с ~= ")" }
        $ò中с ~= "$ч,$y";
    }
    foo(3,4);
    is $ò中с, '(3,4)';
    foo(-1,2);
    is $ò中с, '(3,4)(-1,2)';
}

# reversed order
{
    my $ò中с;
    my sub foo ($ч, $y) {
        $ò中с ~= "$ч,$y";
        LEAVE { $ò中с ~= ")" }
        ENTER { $ò中с ~= "(" }
    }
    foo(7,-8);
    is $ò中с, '(7,-8)';
    foo(5,0);
    is $ò中с, '(7,-8)(5,0)';
}

# multiple ENTER and LEAVE blocks
{
    my $ò中с;
    {
        ENTER { $ò中с ~= '[' }
        LEAVE { $ò中с ~= ']' }

        $ò中с ~= 21;

        ENTER { $ò中с ~= '(' }
        LEAVE { $ò中с ~= ')' }

        ENTER { $ò中с ~= '{' }
        LEAVE { $ò中с ~= '}' }
    }
    is $ò中с, '[({21})]', 'multiple ENTER/LEAVE worked';
}

# L<S04/Phasers/ENTER "repeats on loop blocks">
{
    my $ò中с;
    for 1..2 -> $ч {
        $ò中с ~= ',';
        ENTER { $ò中с ~= "E$ч" }
        LEAVE { $ò中с ~= "L$ч " }
    }
    is $ò中с, 'E1,L1 E2,L2 ', 'ENTER/LEAVE repeats on loop blocks';
}

# L<S04/Phasers/LEAVE "at every block exit time">

# named sub:
{
    my $ò中с;
    my sub 갢ò_e̲𝐯e̲丧 ($ч) {
        return 1 if $ч % 2 == 0;
        return 0;
        LEAVE { $ò中с ~= $ч }
    }
    is 갢ò_e̲𝐯e̲丧(3), 0, 'basic sanity check (1)';
    is $ò中с, '3', 'LEAVE executed at the 1st explicit return';
    is 갢ò_e̲𝐯e̲丧(2), 1, 'basic sanity check (2)';
    is $ò中с, '32', 'LEAVE executed at the 2nd explicit return';
}

# normal closure:
# https://github.com/Raku/old-issue-tracker/issues/4112
#?rakudo skip 'leave NYI RT #124960'
{
    is EVAL(q{
        my $a;
        {
            leave;
            $a = 100;
            LEAVE { $a++ }
        }
        $a;
    }), 1, 'leave triggers LEAVE {}';
}

{
    my $ò中с;
    try {
        ENTER { $ò中с ~= '(' }
        LEAVE { $ò中с ~= ')' }
        $ò中с ~= 'x';
        die 'foo';
    }
    is $ò中с, '(x)', 'die calls LEAVE blocks';
}

{
    my $ò中с;
    try {
        LEAVE { $ò中с ~= $! // '<undef>' }
        die 'foo';
    }
    ok $ò中с ~~ /foo/, '$! set in LEAVE if exception thrown';
}

{
    my $ò中с;
    {
        LEAVE { $ò中с ~= (defined($!) ?? 'yes' !! 'no') }
        try { die 'foo' }
        $ò中с ~= (defined($!) ?? 'aye' !! 'nay');
    }
    #?rakudo todo 'is this spec? why would LEAVE not see outer $!? fossil?'
    is $ò中с, 'ayeno', '$! not set in LEAVE if exception not thrown';
}

{
    my $ò中с;
    try {
        $ò中с ~= '(';
        try {
            ENTER { die 'foo' }
            $ò中с ~= 'x';
        }
        $ò中с ~= ')';
    }
    is $ò中с, '()', 'die in ENTER caught by try';
}

{
    my $ò中с;
    try {
        $ò中с ~= '(';
        try {
            LEAVE { die 'foo' }
            $ò中с ~= 'x';
        }
        $ò中с ~= ')';
    }
    #?rakudo.jvm todo "nigh"
    is $ò中с, '(x)', 'die in LEAVE caught by try';
}

{
    my $ò中с;
    try {
        $ò中с ~= '(';
        try {
            ENTER { $ò中с ~= '['; die 'foo' }
            LEAVE { $ò中с ~= ']' }
            $ò中с ~= 'x';
        }
        $ò中с ~= ')';
    }
    is $ò中с, '([])', 'die in ENTER calls LEAVE';
}

{
    my $ò中с;
    try {
        ENTER { $ò中с ~= '1'; die 'foo' }
        ENTER { $ò中с ~= '2' }
    }
    is $ò中с, '1', 'die aborts ENTER queue';
}

# https://github.com/Raku/old-issue-tracker/issues/3363
{
    my $ò中с;
    try {
        LEAVE { $ò中с ~= '1' }
        LEAVE { $ò中с ~= '2'; die 'foo' }
    }
    is $ò中с, '21', 'die doesn\'t abort LEAVE queue';
    #?rakudo.jvm todo 'RT #121530'
    is $!.message, 'foo', 'single exception from LEAVE is rethrown after running LEAVEs';
}

# https://github.com/Raku/old-issue-tracker/issues/2785
{
    my $a = 0;
    my $丛 = 0;
    multi sub с中113548() { $a = 1; LEAVE $丛 = 2; }; с中113548;
    ok($a == 1 && $丛 == 2, "LEAVE fires in a multi sub");
}

# https://github.com/Raku/old-issue-tracker/issues/2988
{
    my $ч = 0;
    for 1..10 { LEAVE { $ч++ }; next }
    is $ч, 10, "next triggers LEAVE";
}

# https://github.com/Raku/old-issue-tracker/issues/3022
{
    my $ò中с='';
    for 1..2 {
        ENTER { $ò中с ~= $_ for <foo bar> };
        $ò中с ~= $_;
    }
    is $ò中с, 'foobar1foobar2', 'can run for loop in phaser in for loop';
}

# https://github.com/Raku/old-issue-tracker/issues/3160
{
    is_run( q[sub foo { LEAVE { say 'OK' }; die 'foobar' }; foo()],
        {
            out    => "OK\n",
            err    => /foobar/,
        },
        'LEAVE fires after die in sub' );
}

# https://github.com/Raku/old-issue-tracker/issues/2806
{
    my $с中113950_лàò中 = "hello!";
    loop {
        last;
        LEAVE $с中113950_лàò中 ~= " bye!";
    }
    is $с中113950_лàò中, "hello! bye!",
        '"last" triggers LEAVE phaser in loop';

    my $с中113950_丧e̲ч中 = "hello!";
    for ^3 {
        next;
        LEAVE $с中113950_丧e̲ч中 ~= " yay!";
    }
    is $с中113950_丧e̲ч中, "hello! yay! yay! yay!",
        '"next" triggers LEAVE phaser in "for" loop';
}

# https://github.com/Raku/old-issue-tracker/issues/2999
{
    is ENTER { 42 }, 42, 'ENTER works as an r-value (mainline)';
    sub e̲丧中e̲с-中e̲ò中() { ENTER 'SANDMAN' }
    is e̲丧中e̲с-中e̲ò中(), 'SANDMAN', 'ENTER works as an r-value (sub)';
}

# https://github.com/Raku/old-issue-tracker/issues/4346
{
    sub 𝐝갨갢中() {
        if True {
            LEAVE 1;
            return 'ls';
        }
    }
    is 𝐝갨갢中(), 'ls', 'return in nested block with LEAVE works';
}

{
    sub foo() {
        LEAVE die 'wtf';
        LEAVE die 'omg';
    }
    throws-like { foo() }, X::PhaserExceptions,
        exceptions => sub (@ex) { @ex>>.message ~~ <omg wtf> };
}

{ # https://github.com/rakudo/rakudo/issues/1455
    my $сe̲ò;
    -> { LEAVE $сe̲ò := now - ENTER now }();
    isa-ok $сe̲ò, Duration, 'using ENTER inside LEAVE does not crash';
}

# https://irclogs.raku.org/perl6/2019-04-26.html#08:05
# When a block has no local variables, the ENTER phaser would not success-
# fully decont a variable out of a surrounding scope. Didn't have a ticket,
# was fixed in Rakudo as a side-effect of 541a4f1628.
{
     my $òe̲中;
     # Run at most 20 iterations
     my @𝐯 = ^20;
     my $갢 = 0;
     loop {
         $òe̲中 ∪= @𝐯[$갢++];
         last if $갢 == @𝐯;
         # Should be true in the 2nd iteration, but is always (Set) in
         # a buggy rakudo version.
         last if ENTER $òe̲中<>;
     }
     is $òe̲中.elems, 2, 'decont in ENTER works without locals';
}

# https://github.com/rakudo/rakudo/issues/3411
{
    my $e̲丧中e̲сe̲𝐝;
    class À {
        method a() {
            ENTER ++$e̲丧中e̲сe̲𝐝;
        }
    }
    À.a;
    is $e̲丧中e̲сe̲𝐝, 1, 'Did ENTER only run once';
}

# https://github.com/rakudo/rakudo/issues/1815
{
    my int $e̲丧中e̲сe̲𝐝;
    class { method apply { ENTER ++$e̲丧中e̲сe̲𝐝; } }.apply;
    is $e̲丧中e̲сe̲𝐝, 1, 'Did the ENTER only fire once';
}

# https://github.com/rakudo/rakudo/issues/2380
{
    my $лe̲е中;
    sub foo() {
        do {
            my IO::Handle $h = $?FILE.IO.open();
            LEAVE { $лe̲е中 = True; .close with $h};
            return 42;
        }
    }

    is-deeply foo(), 42, 'did foo return the correct value';
    is-deeply $лe̲е中, True, 'did the LEAVE phaser fire';
}

# vim: expandtab shiftwidth=4
