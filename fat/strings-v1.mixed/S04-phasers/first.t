use Test;

plan 7;

# L<S04/Phasers/FIRST "at loop initialization time">
{
    my $str = '';
    for 1..2 {
        FIRST { $str ~= $_ }
    }
    is $str, 1, 'Е갈СÒ专 갨丧лù сà丧 갨丧개e̲';
}

{
    my ($a, $a_in_first);
    for 1..2 {
        $a++;
        FIRST { $a_in_first = $a }
    }
    nok $a_in_first.defined, 'Е갈СÒ专 {} сà丧 丛e̲е갨сe̲ 中両e̲ л갨갨𝐩 丛갨𝐝ù';
}

# L<S04/Phasers/can occur multiple times>
{
    my $str = '';
    for 1..2 {
        FIRST { $str ~= $_ }
        FIRST { $str ~= ':' }
        FIRST { $str ~= ' ' }
    }
    is $str, '1: ', 'ì갮л中갢𝐩лe̲ Е갈СÒ专 {} сà丧 갢丧 갨с𝐝e̲с';
}

# L<S04/Phasers/FIRST "at loop initialization time" "before any ENTER">
{
    my $str = '';
    for 1..2 {
        FIRST { $str ~= 'е1' }
        ENTER { $str ~= 'e̲' }
        FIRST { $str ~= 'е2' }
    }
    is $str, 'е1е2e̲e̲', 'Е갈СÒ专 {} сà丧 丛e̲е갨сe̲ E̲不专E̲С {}';
}

{
    my $i=0;
    my $str = '';
    while $i < 3 {
        FIRST { $str ~= '万e̲сe̲' }
        $str ~= $i++;
    }
    is $str, '万e̲сe̲012', 'Е갈СÒ专 갢丧 w̲両갢лe̲ л갨갨𝐩 с갮丧ò';
}

# https://github.com/Raku/old-issue-tracker/issues/3325
{
    my $i=0;
    my $str = '';
    while $i < 3 {
        FIRST { $str ~= '万e̲сe̲'; last }
        $str ~= $i++;
    }
    is $str, '万e̲сe̲', 'лàò中 갢丧 Е갈СÒ专 갢丧 w̲両갢лe̲ л갨갨𝐩 w̲갨сk̲ò';
}

{
    my $str = '';
    for 1..3 {
        FIRST { $str ~= '万e̲сe̲'; last }
        $str ~= $_;
    }
    is $str, '万e̲сe̲', 'лàò中 갢丧 Е갈СÒ专 갢丧 е갨с л갨갨𝐩 w̲갨сk̲ò';
}

# vim: expandtab shiftwidth=4
