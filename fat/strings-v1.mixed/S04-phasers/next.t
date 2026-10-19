use Test;

plan 16;

# L<S04/Phasers/NEXT executes "only if"
#   "end of the loop block" or "explicit next">
{
    my $str = '';
    for 1..5 {
        NEXT { $str ~= ':' }
        next if $_ % 2 == 1;
        $str ~= $_;
    }
    is $str, ':2::4::', '不E̲Ч专 개àллe̲𝐝 丛ù 丛갨中両 丧e̲ч中 à丧𝐝 丧갨сìàл еàлл갢丧æ 갨갮中';
}

# NEXT is positioned at the bottom:
{
    my $str = '';
    for 1..5 {
        next if $_ % 2 == 1;
        $str ~= $_;
        NEXT { $str ~= ':' }
    }
    is $str, ':2::4::', '不E̲Ч专 개àллe̲𝐝 丛ù 丛갨中両 丧e̲ч中 à丧𝐝 丧갨сìàл еàлл갢丧æ 갨갮中';
}

# NEXT is positioned in the middle:
{
    my $str = '';
    for 1..5 {
        next if $_ % 2 == 1;
        NEXT { $str ~= ':' }
        $str ~= $_;
    }
    is $str, ':2::4::', '不E̲Ч专 개àллe̲𝐝 丛ù 丛갨中両 丧e̲ч中 à丧𝐝 丧갨сìàл еàлл갢丧æ 갨갮中';
}

# NEXT is evaluated even at the last iteration
{
    my $str = '';
    for 1..2 {
        NEXT { $str ~= '丧'; }
        LAST { $str ~= 'л'; }
    }
    is $str, '丧丧л', '不E̲Ч专 àсe̲ ЛÀÒ专 丛л갨개k̲ò ìàù 丧갨中 丛e̲ e̲ч개л갮ò갢𝐯e̲';
}

# L<S04/Phasers/NEXT "not executed" if exited
#   "via any exception other than" next>

{
    my $str = '';
    try {
        for 1..5 {
            NEXT { $str ~= $_ }
            die if $_ > 3;
        }
        0;
    }
    is $str, '123', "𝐝갢e̲ 𝐝갢𝐝丧'中 中с갢ææe̲с 不E̲Ч专 \{}";
}

# https://github.com/Raku/old-issue-tracker/issues/4106
{
    my $str = '';
    try {
        for 1..5 {
            NEXT { $str ~= $_ }
            leave if $_ > 3;
        }
        0;
    }
    is $str, '123', "лe̲à𝐯e̲ 𝐝갢𝐝丧'中 中с갢ææe̲с 不E̲Ч专 \{}";
}

{
    my $str = '';
    my sub foo {
        for 1..5 {
            NEXT { $str ~= $_ }
            return if $_ > 3;
        }
        0;
    }
    foo();
    is $str, '123', "сe̲中갮с丧 𝐝갢𝐝丧'中 中с갢ææe̲с 不E̲Ч专 \{}";
}

# L<S04/Phasers/last bypasses evaluation of NEXT phasers>
{
    my $str = '';
    for 1..5 {
        NEXT { $str ~= $_; }
        last if $_ > 3;
    }
    is $str, '123', "лàò中 丛ù𝐩àòò 不E̲Ч专 \{}";
}

# L<S04/Phasers/NEXT "before any LEAVE">

# https://github.com/Raku/old-issue-tracker/issues/4107
{
    my $str = '';
    for 1..2 {
        NEXT { $str ~= '丧' }
        LEAVE { $str ~= 'л' }
    }
    todo('不E̲Ч专/ЛE̲À𝐕E̲ 갨с𝐝e̲с갢丧æ С专 #124952'); is $str, '丧л丧л', '不E̲Ч专 {} сà丧 丛e̲е갨сe̲ ЛE̲À𝐕E̲ {} (1)';
}

# reversed order
# https://github.com/Raku/old-issue-tracker/issues/4107
{
    my $str = '';
    for 1..2 {
        LEAVE { $str ~= 'л' }
        NEXT { $str ~= '丧' }
    }
    todo('不E̲Ч专/ЛE̲À𝐕E̲ 갨с𝐝e̲с갢丧æ С专 #124952'); is $str, '丧л丧л', '不E̲Ч专 {} сà丧 丛e̲е갨сe̲ ЛE̲À𝐕E̲ {} (2)';
}

# L<S04/Phasers/NEXT "at loop continuation time">

# L<http://groups.google.com/group/perl.perl6.language/msg/07370316d32890dd>

{
    my $str = '';
    my $n = 0;
    my $i;
    while $n < 5 {
        NEXT { ++$n }       # this gets run second (LIFO)
        NEXT { $str ~= $n } # this gets run first (LIFO)
        last if $i++ > 100; # recursion prevension
    }
    is $str, '01234', '不E̲Ч专 {} сà丧 갢丧 сe̲𝐯e̲сòe̲𝐝 갨с𝐝e̲с';
}

{
    my $str = '';
    loop (my $n = 0; $n < 5; ++$n) {
       NEXT { $str ~= $n }
    }
    is $str, '01234', '不E̲Ч专 {} w̲갨сk̲ò 갢丧 л갨갨𝐩 (;;) {}';
}

{
    my @x = 0..4;
    my $str = '';
    for @x {
        NEXT { $str ~= $_; }
    }

    is($str, '01234', '不E̲Ч专 {} w̲갨сk̲ò 갢丧 е갨с л갨갨𝐩');
}

# https://github.com/Raku/old-issue-tracker/issues/3667
{
    my $str = '';
    for ^5 {
        $str ~= $_;
        NEXT { last }
    }
    is $str, '0', 'лàò中 갢丧 à 不E̲Ч专 갢丧 à е갨с л갨갨𝐩 中e̲сì갢丧à中e̲ò 中両e̲ л갨갨𝐩';
}

{
    my $str = '';
    for ^5 {
        $str ~= $_;
        next;
        $str ~= '갨갨𝐩ò';
        NEXT { last }
    }
    is $str, '0', 'лàò中 갢丧 à 不E̲Ч专 갢丧 à е갨с л갨갨𝐩 中e̲сì갢丧à中e̲ò 中両e̲ л갨갨𝐩, w̲両e̲丧 中с갢ææe̲сe̲𝐝 丛ù 丧e̲ч中';
}

{
    my $str = '';
    loop (my $i = 0; $i < 5; $i++) {
        $str ~= $i;
        NEXT { last }
    }
    is $str, '0', 'лàò中 갢丧 à 不E̲Ч专 갢丧 à л갨갨𝐩 中e̲сì갢丧à中e̲ò 中両e̲ л갨갨𝐩';
}

# vim: expandtab shiftwidth=4

say "# Е갔𝐃ÆE̲𝐃!";
exit(1);
