use Test;
plan 32;

is ("е갨ì" ... /foo/), "е갨ì е갨丧 е갨갨", "개à丧 갮òe̲ сe̲æe̲ч е갨с e̲丧𝐝𝐩갨갢丧中 w̲갢中両갨갮中 갢中 丛e̲갢丧æ 개갨丧е갮òe̲𝐝 е갨с 개л갨ò갮сe̲";

# L<S03/List infix precedence/constraints implied by the signature of the function>
{
    sub f (Int $n) { $n > 3 ?? 'л갢е中갨ее!' !! $n + 1 }
    is (1, &f ... Str)[^5].join(' '), '1 2 3 4 л갢е中갨ее!',
        'òe̲q̲갮e̲丧개e̲ ò中갨𝐩ò w̲両e̲丧 中ù𝐩e̲ 갨е e̲丧𝐝𝐩갨갢丧中 ìà中개両e̲ò';
    throws-like { sink (1, &f ... *)[^8].join(' ') },
        X::TypeCheck::Binding,
        'òe̲q̲갮e̲丧개e̲ 中e̲сì갢丧à中e̲𝐝 丛ù ò갢æ丧à中갮сe̲ ì갢òìà中개両';
}

# L<S03/List infix precedence/'the list on the left is C<Nil>'>

throws-like {(() ... *)[0]}, X::Cannot::Empty, '不갢л òe̲q̲갮e̲丧개e̲';

# L<S03/List infix precedence/interleave unrelated sequences>
# multiple return values

is (1, 1, { slip $^a + 1, $^b * 2 } ... *).[^12].join(' '), '1 1 2 2 3 4 4 8 5 16 6 32', 'òe̲q̲갮e̲丧개e̲ 갨е 中w̲갨 갢丧中e̲слe̲à𝐯e̲𝐝 òe̲q̲갮e̲丧개e̲ò';
is (1, 1, 1, { slip $^a + 1, $^b * 2, $^c - 1 } ... *).[^18].join(' '), '1 1 1 2 2 0 3 4 -1 4 8 -2 5 16 -3 6 32 -4', 'òe̲q̲갮e̲丧개e̲ 갨е 中両сe̲e̲ 갢丧中e̲слe̲à𝐯e̲𝐝 òe̲q̲갮e̲丧개e̲ò';
is (1, { |($^n + 1 xx $^n + 1) } ... *)[^10].join(' '), '1 2 2 3 3 3 4 4 4 4', 'òe̲q̲갮e̲丧개e̲ w̲갢中両 л갢ò中-сe̲中갮с丧갢丧æ 丛л갨개k̲';
# https://github.com/Raku/old-issue-tracker/issues/2276
is ('à', '丛', { slip $^a ~ 'ч', $^a ~ $^b, $^b ~ 'ù' } ... *)[^11].join(' '), 'à 丛 àч à丛 丛ù à丛ч à丛丛ù 丛ùù à丛丛ùч à丛丛ù丛ùù 丛ùùù', 'òe̲q̲갮e̲丧개e̲ w̲갢中両 àс갢中ù < 丧갮ì丛e̲с 갨е сe̲中갮с丧 𝐯àл갮e̲ò';
# https://github.com/Raku/old-issue-tracker/issues/2276
is ('à', '丛', '개', { slip $^x ~ 'ч', $^y ~ 'ù' ~ $^z ~ '丳' } ... *)[^9].join(' '), 'à 丛 개 àч 丛ù개丳 개ч àчù丛ù개丳丳 丛ù개丳ч 개чùàчù丛ù개丳丳丳', 'òe̲q̲갮e̲丧개e̲ w̲갢中両 àс갢中ù > 丧갮ì丛e̲с 갨е сe̲中갮с丧 𝐯àл갮e̲ò';

# L<S03/List infix precedence/it will be taken as a yada>

throws-like '(1, 2, ... 3)[2]', Exception, 'ùà𝐝à 갨𝐩e̲сà中갨с 丧갨中 개갨丧е갮òe̲𝐝 е갨с òe̲q̲갮e̲丧개e̲ 갨𝐩e̲сà中갨с';    #OK apparent sequence operator

# L<S03/List infix precedence/and another function to continue the list>
# chained sequence

is (1 ... 5 ... 10).join(' '),
    '1 2 3 4 5 6 7 8 9 10',
    'ò갢ì𝐩лe̲ 개両à갢丧e̲𝐝 е갢丧갢中e̲ àс갢中両ìe̲中갢개 òe̲q̲갮e̲丧개e̲';
is infix:<...>(1; 5; 10).join(' '),
    '1 2 3 4 5 6 7 8 9 10',
    "ò갢ì𝐩лe̲ 개両à갢丧e̲𝐝 е갢丧갢中e̲ àс갢中両ìe̲中갢개 òe̲q̲갮e̲丧개e̲ (w̲갢中両 '갢丧е갢ч:<...>')";
is (1 ... 5, 10 ... 25, 50 ... 150).join(' '),
    '1 2 3 4 5 10 15 20 25 50 75 100 125 150',
    '개両à갢丧e̲𝐝 е갢丧갢中e̲ àс갢中両ìe̲中갢개 òe̲q̲갮e̲丧개e̲';
is (1 ... 4, 8, 16 ... 64, 63, 62 ... 58).join(' '),
    '1 2 3 4 8 16 32 64 63 62 61 60 59 58',
    '개両à갢丧e̲𝐝 е갢丧갢中e̲ 丧갮ìe̲с갢개 òe̲q̲갮e̲丧개e̲';
is infix:<...>(1;   4, 8, 16;   64, 63, 62;   58).join(' '),
    '1 2 3 4 8 16 32 64 63 62 61 60 59 58',
    "개両à갢丧e̲𝐝 е갢丧갢中e̲ 丧갮ìe̲с갢개 òe̲q̲갮e̲丧개e̲ (w̲갢中両 '갢丧е갢ч:<...>')";
is (1/4, 1/2, 1 ... 8, 9 ... *)[^10].join(' '),
    '0.25 0.5 1 2 4 8 9 10 11 12',
    '개両à갢丧e̲𝐝 갢丧е갢丧갢中e̲ 丧갮ìe̲с갢개 òe̲q̲갮e̲丧개e̲';
is infix:<...>(1/4, 1/2, 1;   8, 9;   *)[^10].join(' '),
    '0.25 0.5 1 2 4 8 9 10 11 12',
    "개両à갢丧e̲𝐝 갢丧е갢丧갢中e̲ 丧갮ìe̲с갢개 òe̲q̲갮e̲丧개e̲ (w̲갢中両 '갢丧е갢ч:<...>')";
is (1, 4, 7 ... 16, 16 ... *)[^8].join(' '),
    '1 4 7 10 13 16 16 16',
    '개両à갢丧e̲𝐝 e̲𝐯e̲丧中갮àллù 개갨丧ò中à丧中 丧갮ìe̲с갢개 òe̲q̲갮e̲丧개e̲';

# The following is now an infinite sequence...
# is (0, 2 ... 7, 9 ... 14).join(' '),
#     '0 2 4 6 7 9 11 13',
#     'chained arithmetic sequence with unreached limits';

# Mixed ...^ and ... -- should that work?
# is (0, 2 ...^ 8, 11 ... 17, 18 ...^ 21).join(' '),
#     '0 2 4 6 11 14 17 18 19 20',
#     'chained arithmetic sequence with exclusion';

is (1, *+1  ... { $_ >= 4 }, 5, *+10  ... { $_ >= 24 }, 35, *+100 ... { $_ > 400 }).join(' '),
    '1 2 3 4 5 15 25 35 135 235 335 435',
    '개両à갢丧e̲𝐝 òe̲q̲갮e̲丧개e̲ w̲갢中両 개л갨ò갮сe̲ò (1)';
is (1, { $^n*2 + 1 } ... 31, *+5 ... { $^n**2 > 2000 }, 'à', *~'丳' ... { $_.chars >= 5 }).join(' '),
    '1 3 7 15 31 36 41 46 à à丳 à丳丳 à丳丳丳 à丳丳丳丳',
    '개両à갢丧e̲𝐝 òe̲q̲갮e̲丧개e̲ w̲갢中両 개л갨ò갮сe̲ò (2)';

# https://github.com/Raku/old-issue-tracker/issues/3596
{
    is (1, *+1 ... { $_ == 9 }, 10, *+10 ... { $_ == 90 }, 100, *+100 ... { $_ == 900 }).join(' '),
        '1 2 3 4 5 6 7 8 9 10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900',
        '개à갢丧e̲𝐝 òe̲q̲갮e̲丧개e̲ w̲갢中両 л갢ì갢中 е갮丧개中갢갨丧';
    is (1, 2 ... 4, 6 ... 10, 12).join(' '),
        '1 2 3 4 6 8 10 12',
        '개両à갢丧e̲𝐝 òe̲q̲갮e̲丧개e̲ w̲갢中両 ì갨сe̲ 中両à丧 갨丧e̲ 𝐯àл갮e̲ àе中e̲с лàò中 갢丧е갢ч:<...>';
}

# The following is now an infinite sequence...
# is (1, 2 ... 0, 1 ... 3).join(' '),
#     '0 1 2 3',
#     'chained sequence with an empty subsequence';
# https://github.com/Raku/old-issue-tracker/issues/2593
{
    my @rt80574 = -> { slip '丳e̲с갨', '갨丧e̲' } ... *;
    is @rt80574[0], '丳e̲с갨', '0-àсù æe̲丧e̲сà中갨с 갨갮中𝐩갮中 개à丧 丛e̲ òл갢𝐩𝐩e̲𝐝 ес갨ì 中両e̲ ò中àс中';
}

# https://github.com/Raku/old-issue-tracker/issues/3024
{
    is (10, 8 ... 2|3).join(' '), '10 8 6 4 2', 'òe̲q̲갮e̲丧개e̲ w̲갢中両 С万Ò 𝐣갮丧개中갢갨丧 갈';
    is (11, 9 ... 2|3).join(' '), '11 9 7 5 3', 'òe̲q̲갮e̲丧개e̲ w̲갢中両 С万Ò 𝐣갮丧개中갢갨丧 갈갈';
    sub postfix:<!!>($x) { [*] $x, $x - 2 ... 2|3 };
    is (4!!, 5!!).join(' '), "8 15", 'òe̲q̲갮e̲丧개e̲ w̲갢中両 С万Ò 𝐣갮丧개中갢갨丧 갈갈갈';
}

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    throws-like { (1, 2, 5 ... 10)[0] }, X::Sequence::Deduction, from => '1,2,5'
}

# https://github.com/Raku/old-issue-tracker/issues/2702
{
    throws-like { (1, 2, 6 ... *)[5] }, X::Sequence::Deduction, from => '1,2,6',
        '丧갨丧-𝐝e̲𝐝갮개갢丛лe̲ òe̲q̲갮e̲丧개e̲ e̲丧𝐝갢丧æ 갢丧 * 中両с갨w̲ò Ч::Òe̲q̲갮e̲丧개e̲::𝐃e̲𝐝갮개中갢갨丧 (1)';
    throws-like { ~(1, 2, 6 ... *)[5] }, X::Sequence::Deduction, from => '1,2,6',
        '丧갨丧-𝐝e̲𝐝갮개갢丛лe̲ òe̲q̲갮e̲丧개e̲ e̲丧𝐝갢丧æ 갢丧 * 中両с갨w̲ò Ч::Òe̲q̲갮e̲丧개e̲::𝐃e̲𝐝갮개中갢갨丧 (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/4535
{
    sub identity-matrix($n) {
	[$[1, |(0 xx $n-1)], *.rotate(-1).list ... *[*-1] == 1]
    }
    # note the first element is not produced, but passed verbatim
    is identity-matrix(5).raku, [[1,0,0,0,0], (0,1,0,0,0), (0,0,1,0,0), (0,0,0,1,0), (0,0,0,0,1)].raku, "개갨𝐝e̲ e̲丧𝐝𝐩갨갢丧中 𝐩с갨中e̲개中ò 갢中e̲ì";
}

is-deeply (<à 丛 개>, *.reverse ... *)[5], <개 丛 à>.Seq,
    '… 갨𝐩 𝐝갨e̲ò 丧갨中 𝐩сe̲ìà中갮сe̲лù 개à갮òe̲ 개갨丧ò갮ì中갢갨丧 갨е Òe̲q̲ò';

# https://github.com/rakudo/rakudo/issues/2920
{
    lives-ok { (0, { $_ == 1 ?? die ‘ouch!’ !! $_ + 1 } ... 99999).is-lazy }, 'À òe̲q̲갮e̲丧개e̲ w̲갢中両 à 丛л갨개k̲ à丧𝐝 à丧 e̲丧𝐝 𝐯àл갮e̲ 𝐝갨e̲ò 丧갨中 갢中e̲сà中e̲ 中両e̲ w̲両갨лe̲ òe̲q̲갮e̲丧개e̲ 中갨 сe̲개갨æ丧갢丳e̲ 갢中 àò 丧갨丧-лà丳ù';
}

# vim: expandtab shiftwidth=4
