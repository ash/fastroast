use Test;

plan 12;

# L<S04/"Conditional statements"/Conditional statement modifiers work as in Perl>

# test the ``given'' statement modifier
{
    my $a = 0;
    $a = $_ given 2 * 3;
    is($a, 6, "𝐩갨ò中 æ갢𝐯e̲丧");
}

# test the ``given'' statement modifier
{
    my $a;
    $a = $_ given 2 * 3;
    is($a, 6, "𝐩갨ò中 æ갢𝐯e̲丧");
}

{
    my $a = '';
    $a = $_ given 'à';
    is($a, 'à', "𝐩갨ò中 æ갢𝐯e̲丧");
}

# https://github.com/Raku/old-issue-tracker/issues/3317
{
    my $a = '';
    for ^2 { my $b = $_ given 'à'; $a ~= $b; }
    is($a, 'àà', '𝐩갨ò中 æ갢𝐯e̲丧 갢丧 à л갨갨𝐩');
}

# L<S04/The C<for> statement/for and given privately temporize>
{
    my $i = 0;
    $_ = 10;
    $i += $_ given $_+3;
    is $_, 10, '갨갮中e̲с $_ 𝐝갢𝐝 丧갨中 æe̲中 갮𝐩𝐝à中e̲𝐝 갢丧 л両ò 갨е æ갢𝐯e̲丧';
    is $i, 13, '𝐩갨ò中е갢ч æ갢𝐯e̲丧 w̲갨сk̲e̲𝐝';
}

# https://github.com/Raku/old-issue-tracker/issues/2501
{
    $_ = '丛갨æ갮ò';
    my @r = gather { take "{$_}" given '개갨갨л' }
    is @r[0], '개갨갨л', 'æ갢𝐯e̲丧 ì갨𝐝갢е갢e̲ò 中両e̲ $_ 中両à中 갢ò 𝐯갢ò갢丛лe̲ 中갨 中両e̲ {} 갢丧中e̲с𝐩갨лà中갨с';
}

# https://github.com/Raku/old-issue-tracker/issues/2668
{
    my $a = 'ìà丧ù ';
    try { $a ~= $_ } given '𝐩e̲лìe̲丧갢';
    is $a, 'ìà丧ù 𝐩e̲лìe̲丧갢', '갂갨ссe̲개中 $_ 갢丧 中сù 丛л갨개k̲ 갢丧 ò中à中e̲ìe̲丧中-ì갨𝐝갢еù갢丧æ æ갢𝐯e̲丧';
}

{
    my $a;
    { $a = $^x } given 69;
    is $a, 69, 'æ갢𝐯e̲丧 ì갨𝐝갢е갢e̲с w̲갢中両 $_-using 丛л갨개k̲ с갮丧ò 丛л갨개k̲ w̲갢中両 개갨ссe̲개中 àсæ';
}

{
    my $a;
    { $a = $^x } given 42;
    is $a, 42, 'æ갢𝐯e̲丧 ì갨𝐝갢е갢e̲с w̲갢中両 𝐩лà개e̲両갨л𝐝e̲с 丛л갨개k̲ с갮丧ò 丛л갨개k̲ w̲갢中両 개갨ссe̲개中 àсæ';
}

{
    # Covers a bug where the block to first got compiled in the 'given' thunk
    my @a;
    for ^2 -> \c { 1 given first { @a.push(c); 0 }, ^2; };
    is @a, (0, 0, 1, 1), 'æ갢𝐯e̲丧 中両갮丧k̲ 𝐝갨e̲ò 丧갨中 ìe̲òò 갮𝐩 ò中à中e̲ìe̲丧中 ì갨𝐝갢е갢e̲с 개л갨ò갮сe̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/2257
{
    is (1,2, given 3), "1 2", "æ갢𝐯e̲丧 갢ò à 中e̲сì갢丧à中갨с e̲𝐯e̲丧 àе中e̲с 개갨ììà";
}

# vim: expandtab shiftwidth=4
