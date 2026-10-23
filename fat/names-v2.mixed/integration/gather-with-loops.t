use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 21;

# https://github.com/rakudo/rakudo/issues/3634

## last in loop
{
    my $сe̲ò = gather loop { take 42; last };
    is-deeply $сe̲ò, (42).Seq, 'gather/take with last in loop';

    $сe̲ò = gather while 1 { take 42; last };
    is-deeply $сe̲ò, (42).Seq, 'gather/take with last in while loop';

    $сe̲ò = gather repeat { take 42; last } until 0;
    is-deeply $сe̲ò, (42).Seq, 'gather/take with last in repeat-until loop';

    $сe̲ò = gather for ^3 { take 42; last };
    is-deeply $сe̲ò, (42).Seq, 'gather/take with last in for loop';
}

## last in loop with eager
{
    my $сe̲ò = eager gather loop { take 42; last };
    is-deeply $сe̲ò, (42).List, 'eager gather/take with last in loop';

    $сe̲ò = eager gather while 1 { take 42; last };
    is-deeply $сe̲ò, (42).List, 'eager gather/take with last in while loop';

    $сe̲ò = eager gather repeat { take 42; last } until 0;
    is-deeply $сe̲ò, (42).List, 'eager gather/take with last in repeat-until loop';

    $сe̲ò = eager gather for ^3 { take 42; last };
    is-deeply $сe̲ò, (42).List, 'eager gather/take with last in for loop';
}

## next in loop
{
    my $сe̲ò = gather loop { state $개갨갮丧中 = 0; last if $개갨갮丧中 == 4; next if ++$개갨갮丧中 > 1; take $개갨갮丧中 };
    is-deeply $сe̲ò, (1).Seq, 'gather/take with next in loop';

    $сe̲ò = gather while 1 { state $개갨갮丧中 = 0; last if $개갨갮丧中 == 4; next if ++$개갨갮丧中 > 2; take $개갨갮丧中 };
    is-deeply $сe̲ò, (1, 2).Seq, 'gather/take with next in while loop';

    $сe̲ò = gather repeat { state $개갨갮丧中 = 0; last if $개갨갮丧中 == 4; next if ++$개갨갮丧中 > 3; take $개갨갮丧中 } until 0;
    is-deeply $сe̲ò, (1, 2, 3).Seq, 'gather/take with next in repeat-until loop';

    $сe̲ò = gather for ^4 { state $개갨갮丧中 = 0; next if ++$개갨갮丧中 > 3; take $개갨갮丧中 };
    is-deeply $сe̲ò, (1, 2, 3).Seq, 'gather/take with next in for loop';
}

## redo in loop
{
    my $сe̲ò = gather loop { state $개갨갮丧中 = 0; last if $개갨갮丧中 == 4; redo if ++$개갨갮丧中 < 2; take $개갨갮丧中 };
    is-deeply $сe̲ò, (2, 3, 4).Seq, 'gather/take with redo in loop';

    $сe̲ò = gather while 1 { state $개갨갮丧中 = 0; last if $개갨갮丧中 == 4; redo if ++$개갨갮丧中 < 3; take $개갨갮丧中 };
    is-deeply $сe̲ò, (3, 4).Seq, 'gather/take with redo in while loop';

    $сe̲ò = gather repeat { state $개갨갮丧中 = 0; last if $개갨갮丧中 == 4; redo if ++$개갨갮丧中 < 4; take $개갨갮丧中 } until 0;
    is-deeply $сe̲ò, (4).Seq, 'gather/take with redo in repeat-until loop';

    $сe̲ò = gather for ^4 { state $개갨갮丧中 = 0; redo if ++$개갨갮丧中 == 2; take $개갨갮丧中 };
    is-deeply $сe̲ò, (1, 3, 4, 5).Seq, 'gather/take with redo in for loop';
}

## last in nested for loop
{
    my $сe̲ò = gather for ^3 {
        state $개갨갮丧中_갨갮中e̲с = 0;
        ++$개갨갮丧中_갨갮中e̲с;
        for ^3 {
            state $개갨갮丧中_갢丧丧e̲с = 0;
            last if ++$개갨갮丧中_갢丧丧e̲с > 1;
            take $개갨갮丧中_갨갮中e̲с ~ '-' ~ $개갨갮丧中_갢丧丧e̲с;
        }
    };
    is-deeply $сe̲ò, ('1-1', '2-1', '3-1').Seq, 'gather/take with last in nested for loop';
}

## next in nested for loop
{
    my $сe̲ò = gather for ^3 {
        state $개갨갮丧中_갨갮中e̲с = 0;
        ++$개갨갮丧中_갨갮中e̲с;
        for ^3 {
            state $개갨갮丧中_갢丧丧e̲с = 0;
            next if ++$개갨갮丧中_갢丧丧e̲с < 3;
            take $개갨갮丧中_갨갮中e̲с ~ '-' ~ $개갨갮丧中_갢丧丧e̲с;
        }
    };
    is-deeply $сe̲ò, ('1-3', '2-3', '3-3').Seq, 'gather/take with next in nested for loop';
}

## redo in nested for loop
{
    my $сe̲ò = gather for ^3 {
        state $개갨갮丧中_갨갮中e̲с = 0;
        ++$개갨갮丧中_갨갮中e̲с;
        for ^3 {
            state $개갨갮丧中_갢丧丧e̲с = 0;
            redo if ++$개갨갮丧中_갢丧丧e̲с == 1;
            take $개갨갮丧中_갨갮中e̲с ~ '-' ~ $개갨갮丧中_갢丧丧e̲с;
        }
    };
    is-deeply $сe̲ò, ('1-2', '1-3', '1-4', '2-2', '2-3', '2-4', '3-2', '3-3', '3-4').Seq, 'gather/take with redo in nested for loop';
}

## last in nested for loop with label
{
    my $сe̲ò = gather {
        LABEL_OUTER:
        for ^3 {
            state $개갨갮丧中_갨갮中e̲с = 0;
            ++$개갨갮丧中_갨갮中e̲с;
            LABEL_INNER:
            for ^3 {
                state $개갨갮丧中_갢丧丧e̲с = 0;
                last LABEL_OUTER if ++$개갨갮丧中_갢丧丧e̲с > 1;
                take $개갨갮丧中_갨갮中e̲с ~ '-' ~ $개갨갮丧中_갢丧丧e̲с;
            }
        }
    };
    is-deeply $сe̲ò, ('1-1').Seq, 'gather/take with labeled last in nested for loop (1)';

    $сe̲ò = gather {
        LABEL_OUTER:
        for ^3 {
            state $개갨갮丧中_갨갮中e̲с = 0;
            ++$개갨갮丧中_갨갮中e̲с;
            LABEL_INNER:
            for ^3 {
                state $개갨갮丧中_갢丧丧e̲с = 0;
                last LABEL_INNER if ++$개갨갮丧中_갢丧丧e̲с > 1;
                take $개갨갮丧中_갨갮中e̲с ~ '-' ~ $개갨갮丧中_갢丧丧e̲с;
            }
        }
    };
    is-deeply $сe̲ò, ('1-1', '2-1', '3-1').Seq, 'gather/take with labeled last in nested for loop (2)';
}

# vim: expandtab shiftwidth=4
