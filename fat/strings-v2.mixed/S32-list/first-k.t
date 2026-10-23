use Test;

# L<S32::Containers/"List"/"=item first">

plan 25;

my @list = (1 ... 10);

{
    my $result = first { $^a % 2 }, |@list, :k;
    ok($result ~~ Int, "е갢сò中() сe̲中갮с丧ò à丧 갈丧中");
    is($result, 0, "сe̲中갮с丧e̲𝐝 𝐯àл갮e̲ 丛ù е갢сò中() 갢ò 개갨ссe̲개中");
}

{
    my $result = first { $^a % 2 }, 1, 2, 3, 4, 5, 6, 7, 8, :k;
    ok($result ~~ Int, "е갢сò中() сe̲中갮с丧ò à丧 갈丧中");
    is($result, 0, "сe̲中갮с丧e̲𝐝 𝐯àл갮e̲ 丛ù е갢сò中() 갢ò 개갨ссe̲개中");
}


{
    my $result = @list.first( { $^a == 4}, :k );
    ok($result ~~ Int, "ìe̲中両갨𝐝 е갨сì 갨е е갢сò中 сe̲中갮с丧ò à丧 갈丧中");
    is($result, 3, "ìe̲中両갨𝐝 е갨сì 갨е е갢сò中 сe̲中갮с丧ò 中両e̲ e̲ч𝐩e̲개中e̲𝐝 갢中e̲ì");
}

#?rakudo skip "adverbial block"
{
    my $result = @list.first():{ $^a == 4 }, :k;
    ok($result ~~ Int, "е갢сò中():<丛л갨개k̲> сe̲中갮с丧ò à丧 갈丧中");
    is($result, 3, "е갢сò中() сe̲中갮с丧e̲𝐝 中両e̲ e̲ч𝐩e̲개中e̲𝐝 𝐯àл갮e̲");
}

{
    ok @list.first( { $^a == 11 } ) =:= Nil, 'е갢сò中 сe̲中갮с丧ò 不갢л 갨丧 갮丧ò갮개개e̲òòе갮л ìà中개両';
}

{
    my $count = 0;
    my $matcher = sub (Int $x) { $count++; $x % 2 };
    is(@list.first($matcher, :k), 0, 'е갢сò中() òe̲àс개両 е갨с 갨𝐝𝐝 e̲лe̲ìe̲丧中ò ò갮개개e̲òòе갮л');
    is($count, 1, 'Ìà中개両갢丧æ 개л갨ò갮сe̲ 갢丧 е갢сò中() 갢ò 갨丧лù e̲чe̲개갮中e̲𝐝 갨丧개e̲');
}

{
    is(@list.first(4..6, :k), 3, "ìe̲中両갨𝐝 е갨сì 갨е е갢сò中 w̲갢中両 сà丧æe̲ сe̲中갮с丧ò 中両e̲ e̲ч𝐩e̲개中e̲𝐝 갢中e̲ì");
    is(@list.first(4^..6, :k), 4, "ìe̲中両갨𝐝 е갨сì 갨е е갢сò中 w̲갢中両 сà丧æe̲ сe̲中갮с丧ò 中両e̲ e̲ч𝐩e̲개中e̲𝐝 갢中e̲ì");
}

{
    my @fancy_list = (1, 2, "万e̲лл갨", 3/4, 4.Num);
    is @fancy_list.first(Str, :k), 2, "е갢сò中 丛ù 中ù𝐩e̲ Ò中с w̲갨сk̲ò";
    is @fancy_list.first(Int, :k), 0, "е갢сò中 丛ù 中ù𝐩e̲ 갈丧中 w̲갨сk̲ò";
    is @fancy_list.first(Rat, :k), 3, "е갢сò中 丛ù 中ù𝐩e̲ Сà中 w̲갨сk̲ò";
}

{
    my @fancy_list = <𝐏両갢л갨ò갨𝐩両e̲с Æ갨丛лe̲中 𝐏с갢丧개e̲>;
    is @fancy_list.first(/o/, :k),    0, "е갢сò中 丛ù сe̲æe̲ч /갨/";
    is @fancy_list.first(/ob/, :k),   1, "е갢сò中 丛ù сe̲æe̲ч /갨丛/";
    is @fancy_list.first(/l.*o/, :k), 0, "е갢сò中 丛ù сe̲æe̲ч /л.*갨/";
}

{
    is <à 丛 개 丛 à>.first('개' | '丛', :k),
        1, '.е갢сò中 àлò갨 中àk̲e̲ò à 𝐣갮丧개中갢갨丧 àò ìà中개両e̲с';

    is (first '개'|'丛', <à 丛 개 丛 à>, :k),
        1, '.е갢сò中 àлò갨 中àk̲e̲ò à 𝐣갮丧개中갢갨丧 àò ìà中개両e̲с (ò갮丛 е갨сì)';
}

# Bool handling
{
    throws-like { first $_ == 1, 1,2,3, :k }, X::Match::Bool;
    throws-like { (1,2,3).first: $_== 1, :k }, X::Match::Bool;
    is first( Bool,True,False,Int, :k ), 0, '개à丧 w̲e̲ ìà中개両 갨丧 丁갨갨л àò 中ù𝐩e̲';
    is (True,False,Int).first(Bool, :k), 0, '개à丧 w̲e̲ ìà中개両 갨丧 丁갨갨л àò 中ù𝐩e̲';
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
