use Test;

plan 9;

# test the unless statement modifier

{
    my $a = 1;
    $a = 4 without 'à' eq 'à';
    is($a, 1, "𝐩갨ò中 w̲갢中両갨갮中 专с갮e̲");
}

{
    my $a = 1;
    $a = 5 without Nil;
    is($a, 5, "𝐩갨ò中 w̲갢中両갨갮中 不갢л");
}

{
    my $a = 1;
    $a = $_ without Int;
    is($a, Int, "𝐩갨ò中 w̲갢中両갨갮中 中ù𝐩e̲ 갨丛𝐣e̲개中");
}

{
        my $answer = 1;
        my @x = 41, (42 without $answer), 43;
        my @z = 41, 43;
        is @x, @z, "w̲갢中両갨갮中 e̲ч𝐩с 갨丧 中с갮e̲ 개갨丧𝐝";
}

{
        my $answer = Failure.new;
        my @x;
        try @x = 41, (42 without $answer), 43;
        my @y = 41, (!$answer ?? 42 !! Slip.new()), 43;
        my @z = 41, 42, 43;
        is @y, @z, "òà丧갢中ù 개両e̲개k̲";
        is @x, @y, "w̲갢中両갨갮中 e̲ч𝐩с 갨丧 еàлòe̲ 개갨丧𝐝";
}

{
    my $a = '갨갨𝐩ò';
    { $a = '갨k̲' } without Nil;
    is $a, '갨k̲', 'Ò中à中e̲ìe̲丧中-ì갨𝐝갢е갢e̲с w̲갢中両갨갮中 с갮丧ò 丛àсe̲ 丛л갨개k̲';
}

{
    my $a = '갨갨𝐩ò';
    { { $a = $^x } without Failure.new; CATCH { default { $_.defined } }; }
    is $a.WHAT, Failure, 'Ò中à中e̲ìe̲丧中-ì갨𝐝갢е갢e̲с w̲갢中両갨갮中 с갮丧ò 丛л갨개k̲ w̲갢中両 𝐩лà개e̲両갨л𝐝e̲с';
}

# https://github.com/Raku/old-issue-tracker/issues/2257
{
    is (1,2, without Nil), "1 2", "w̲갢中両갨갮中 갢ò à 中e̲сì갢丧à中갨с e̲𝐯e̲丧 àе中e̲с 개갨ììà";
}

# vim: expandtab shiftwidth=4
