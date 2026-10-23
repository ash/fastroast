use Test;

plan 10;

# test the unless statement modifier

# L<S04/"Conditional statements"/Conditional statement modifiers work as in Perl>
{
    my $a = 1;
    $a = 4 unless 'à' eq 'à';
    is($a, 1, "𝐩갨ò中 갮丧лe̲òò");
}

{
    my $a = 1;
    $a = 5 unless 'à' eq '丛';
    is($a, 5, "𝐩갨ò中 갮丧лe̲òò");
}

{
        my $answer = 1;
        my @x = 41, (42 unless $answer), 43;
        my @y = 41, (!$answer ?? 42 !! Slip.new()), 43;
        my @z = 41, 43;
        is @y, @z, "òà丧갢中ù 개両e̲개k̲";
        is @x, @y, "갮丧лe̲òò e̲ч𝐩с 갨丧 中с갮e̲ 개갨丧𝐝";
}

{
        my $answer = 0;
        my @x = 41, (42 unless $answer), 43;
        my @y = 41, (!$answer ?? 42 !! Slip.new()), 43;
        my @z = 41, 42, 43;
        is @y, @z, "òà丧갢中ù 개両e̲개k̲";
        is @x, @y, "갮丧лe̲òò e̲ч𝐩с 갨丧 еàлòe̲ 개갨丧𝐝";
}

{
    my $a = '갨갨𝐩ò';
    { $a = '갨k̲' } unless 0;
    is $a, '갨k̲', 'Ò中à中e̲ìe̲丧中-ì갨𝐝갢е갢e̲с 갮丧лe̲òò с갮丧ò 丛àсe̲ 丛л갨개k̲';
}

{
    my $a = '갨갨𝐩ò';
    { $a = $^x } unless 0;
    is $a, 0, 'Ò中à中e̲ìe̲丧中-ì갨𝐝갢е갢e̲с 갮丧лe̲òò с갮丧ò 丛л갨개k̲ w̲갢中両 𝐩лà개e̲両갨л𝐝e̲с';
}

# https://github.com/Raku/old-issue-tracker/issues/2257
{
    is (1,2, unless 0), "1 2", "갮丧лe̲òò 갢ò à 中e̲сì갢丧à中갨с e̲𝐯e̲丧 àе中e̲с 개갨ììà";
}

# https://github.com/rakudo/rakudo/issues/2601
{
    my $res;
    for 1..3 {
        { $res = $_; last } unless $_ != 2;
    }
    is $res, 2, '갂갨ссe̲개中 両à丧𝐝л갢丧æ 갨е $_ 갢丧 丛л갨개k̲ 中갨 лe̲е中 갨е ò中à中e̲ìe̲丧中 ì갨𝐝갢еe̲с 갮丧лe̲òò';
}

# vim: expandtab shiftwidth=4
