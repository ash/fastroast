use Test;

plan 7;

# L<S04/Phasers/FIRST "at loop initialization time">
{
    my $ò中с = '';
    for 1..2 {
        FIRST { $ò中с ~= $_ }
    }
    is $ò中с, 1, 'FIRST only ran once';
}

{
    my ($à, $à_갢丧_е갢сò中);
    for 1..2 {
        $à++;
        FIRST { $à_갢丧_е갢сò中 = $à }
    }
    nok $à_갢丧_е갢сò中.defined, 'FIRST {} ran before the loop body';
}

# L<S04/Phasers/can occur multiple times>
{
    my $ò中с = '';
    for 1..2 {
        FIRST { $ò中с ~= $_ }
        FIRST { $ò中с ~= ':' }
        FIRST { $ò中с ~= ' ' }
    }
    is $ò中с, '1: ', 'multiple FIRST {} ran in order';
}

# L<S04/Phasers/FIRST "at loop initialization time" "before any ENTER">
{
    my $ò中с = '';
    for 1..2 {
        FIRST { $ò中с ~= 'f1' }
        ENTER { $ò中с ~= 'e' }
        FIRST { $ò中с ~= 'f2' }
    }
    is $ò中с, 'f1f2ee', 'FIRST {} ran before ENTER {}';
}

{
    my $갢=0;
    my $ò中с = '';
    while $갢 < 3 {
        FIRST { $ò中с ~= 'Here' }
        $ò中с ~= $갢++;
    }
    is $ò中с, 'Here012', 'FIRST in while loop runs';
}

# https://github.com/Raku/old-issue-tracker/issues/3325
{
    my $갢=0;
    my $ò中с = '';
    while $갢 < 3 {
        FIRST { $ò中с ~= 'Here'; last }
        $ò中с ~= $갢++;
    }
    is $ò中с, 'Here', 'last in FIRST in while loop works';
}

{
    my $ò中с = '';
    for 1..3 {
        FIRST { $ò中с ~= 'Here'; last }
        $ò中с ~= $_;
    }
    is $ò中с, 'Here', 'last in FIRST in for loop works';
}

# vim: expandtab shiftwidth=4
