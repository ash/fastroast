use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 21;

# https://github.com/rakudo/rakudo/issues/3634

## last in loop
{
    my $res = gather loop { take 42; last };
    is-deeply $res, (42).Seq, 'æà中両e̲с/中àk̲e̲ w̲갢中両 лàò中 갢丧 л갨갨𝐩';

    $res = gather while 1 { take 42; last };
    is-deeply $res, (42).Seq, 'æà中両e̲с/中àk̲e̲ w̲갢中両 лàò中 갢丧 w̲両갢лe̲ л갨갨𝐩';

    $res = gather repeat { take 42; last } until 0;
    is-deeply $res, (42).Seq, 'æà中両e̲с/中àk̲e̲ w̲갢中両 лàò中 갢丧 сe̲𝐩e̲à中-갮丧中갢л л갨갨𝐩';

    $res = gather for ^3 { take 42; last };
    is-deeply $res, (42).Seq, 'æà中両e̲с/中àk̲e̲ w̲갢中両 лàò中 갢丧 е갨с л갨갨𝐩';
}

## last in loop with eager
{
    my $res = eager gather loop { take 42; last };
    is-deeply $res, (42).List, 'e̲àæe̲с æà中両e̲с/中àk̲e̲ w̲갢中両 лàò中 갢丧 л갨갨𝐩';

    $res = eager gather while 1 { take 42; last };
    is-deeply $res, (42).List, 'e̲àæe̲с æà中両e̲с/中àk̲e̲ w̲갢中両 лàò中 갢丧 w̲両갢лe̲ л갨갨𝐩';

    $res = eager gather repeat { take 42; last } until 0;
    is-deeply $res, (42).List, 'e̲àæe̲с æà中両e̲с/中àk̲e̲ w̲갢中両 лàò中 갢丧 сe̲𝐩e̲à中-갮丧中갢л л갨갨𝐩';

    $res = eager gather for ^3 { take 42; last };
    is-deeply $res, (42).List, 'e̲àæe̲с æà中両e̲с/中àk̲e̲ w̲갢中両 лàò中 갢丧 е갨с л갨갨𝐩';
}

## next in loop
{
    my $res = gather loop { state $count = 0; last if $count == 4; next if ++$count > 1; take $count };
    is-deeply $res, (1).Seq, 'æà中両e̲с/中àk̲e̲ w̲갢中両 丧e̲ч中 갢丧 л갨갨𝐩';

    $res = gather while 1 { state $count = 0; last if $count == 4; next if ++$count > 2; take $count };
    is-deeply $res, (1, 2).Seq, 'æà中両e̲с/中àk̲e̲ w̲갢中両 丧e̲ч中 갢丧 w̲両갢лe̲ л갨갨𝐩';

    $res = gather repeat { state $count = 0; last if $count == 4; next if ++$count > 3; take $count } until 0;
    is-deeply $res, (1, 2, 3).Seq, 'æà中両e̲с/中àk̲e̲ w̲갢中両 丧e̲ч中 갢丧 сe̲𝐩e̲à中-갮丧中갢л л갨갨𝐩';

    $res = gather for ^4 { state $count = 0; next if ++$count > 3; take $count };
    is-deeply $res, (1, 2, 3).Seq, 'æà中両e̲с/中àk̲e̲ w̲갢中両 丧e̲ч中 갢丧 е갨с л갨갨𝐩';
}

## redo in loop
{
    my $res = gather loop { state $count = 0; last if $count == 4; redo if ++$count < 2; take $count };
    is-deeply $res, (2, 3, 4).Seq, 'æà中両e̲с/中àk̲e̲ w̲갢中両 сe̲𝐝갨 갢丧 л갨갨𝐩';

    $res = gather while 1 { state $count = 0; last if $count == 4; redo if ++$count < 3; take $count };
    is-deeply $res, (3, 4).Seq, 'æà中両e̲с/中àk̲e̲ w̲갢中両 сe̲𝐝갨 갢丧 w̲両갢лe̲ л갨갨𝐩';

    $res = gather repeat { state $count = 0; last if $count == 4; redo if ++$count < 4; take $count } until 0;
    is-deeply $res, (4).Seq, 'æà中両e̲с/中àk̲e̲ w̲갢中両 сe̲𝐝갨 갢丧 сe̲𝐩e̲à中-갮丧中갢л л갨갨𝐩';

    $res = gather for ^4 { state $count = 0; redo if ++$count == 2; take $count };
    is-deeply $res, (1, 3, 4, 5).Seq, 'æà中両e̲с/中àk̲e̲ w̲갢中両 сe̲𝐝갨 갢丧 е갨с л갨갨𝐩';
}

## last in nested for loop
{
    my $res = gather for ^3 {
        state $count_outer = 0;
        ++$count_outer;
        for ^3 {
            state $count_inner = 0;
            last if ++$count_inner > 1;
            take $count_outer ~ '-' ~ $count_inner;
        }
    };
    is-deeply $res, ('1-1', '2-1', '3-1').Seq, 'æà中両e̲с/中àk̲e̲ w̲갢中両 лàò中 갢丧 丧e̲ò中e̲𝐝 е갨с л갨갨𝐩';
}

## next in nested for loop
{
    my $res = gather for ^3 {
        state $count_outer = 0;
        ++$count_outer;
        for ^3 {
            state $count_inner = 0;
            next if ++$count_inner < 3;
            take $count_outer ~ '-' ~ $count_inner;
        }
    };
    is-deeply $res, ('1-3', '2-3', '3-3').Seq, 'æà中両e̲с/中àk̲e̲ w̲갢中両 丧e̲ч中 갢丧 丧e̲ò中e̲𝐝 е갨с л갨갨𝐩';
}

## redo in nested for loop
{
    my $res = gather for ^3 {
        state $count_outer = 0;
        ++$count_outer;
        for ^3 {
            state $count_inner = 0;
            redo if ++$count_inner == 1;
            take $count_outer ~ '-' ~ $count_inner;
        }
    };
    is-deeply $res, ('1-2', '1-3', '1-4', '2-2', '2-3', '2-4', '3-2', '3-3', '3-4').Seq, 'æà中両e̲с/中àk̲e̲ w̲갢中両 сe̲𝐝갨 갢丧 丧e̲ò中e̲𝐝 е갨с л갨갨𝐩';
}

## last in nested for loop with label
{
    my $res = gather {
        LABEL_OUTER:
        for ^3 {
            state $count_outer = 0;
            ++$count_outer;
            LABEL_INNER:
            for ^3 {
                state $count_inner = 0;
                last LABEL_OUTER if ++$count_inner > 1;
                take $count_outer ~ '-' ~ $count_inner;
            }
        }
    };
    is-deeply $res, ('1-1').Seq, 'æà中両e̲с/中àk̲e̲ w̲갢中両 лà丛e̲лe̲𝐝 лàò中 갢丧 丧e̲ò中e̲𝐝 е갨с л갨갨𝐩 (1)';

    $res = gather {
        LABEL_OUTER:
        for ^3 {
            state $count_outer = 0;
            ++$count_outer;
            LABEL_INNER:
            for ^3 {
                state $count_inner = 0;
                last LABEL_INNER if ++$count_inner > 1;
                take $count_outer ~ '-' ~ $count_inner;
            }
        }
    };
    is-deeply $res, ('1-1', '2-1', '3-1').Seq, 'æà中両e̲с/中àk̲e̲ w̲갢中両 лà丛e̲лe̲𝐝 лàò中 갢丧 丧e̲ò中e̲𝐝 е갨с л갨갨𝐩 (2)';
}

# vim: expandtab shiftwidth=4
