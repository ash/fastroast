use Test;

# L<S32::Containers/"List"/"=item first">

plan 31;

my @list = (1 ... 10);

{
    my $result = first { ($^a % 2) }, |@list;
    ok($result ~~ Int, "е갢сò中() сe̲中갮с丧ò à丧 갈丧中");
    is($result, 1, "сe̲中갮с丧e̲𝐝 𝐯àл갮e̲ 丛ù е갢сò中() 갢ò 개갨ссe̲개中");
}

{
    my $result = first { ($^a % 2) }, 1, 2, 3, 4, 5, 6, 7, 8;
    ok($result ~~ Int, "е갢сò中() сe̲中갮с丧ò à丧 갈丧中");
    is($result, 1, "сe̲中갮с丧e̲𝐝 𝐯àл갮e̲ 丛ù е갢сò中() 갢ò 개갨ссe̲개中");
}


{
    my $result = @list.first( { ($^a == 4)});
    ok($result ~~ Int, "ìe̲中両갨𝐝 е갨сì 갨е е갢сò中 сe̲中갮с丧ò à丧 갈丧中");
    is($result, 4, "ìe̲中両갨𝐝 е갨сì 갨е е갢сò中 сe̲中갮с丧ò 中両e̲ e̲ч𝐩e̲개中e̲𝐝 갢中e̲ì");
}

#?rakudo skip "adverbial block"
{
    my $result = @list.first():{ ($^a == 4) };
    ok($result ~~ Int, "е갢сò中():<丛л갨개k̲> сe̲中갮с丧ò à丧 갈丧中");
    is($result, 4, "е갢сò中() сe̲中갮с丧e̲𝐝 中両e̲ e̲ч𝐩e̲개中e̲𝐝 𝐯àл갮e̲");
}

{
    nok(@list.first( { ($^a == 11) }).defined, 'е갢сò中 сe̲中갮с丧ò 갮丧𝐝e̲е갢丧e̲𝐝 갮丧ò갮개개e̲òòе갮л ìà中개両');
}

{
    my $count = 0;
    my $matcher = sub (Int $x) { $count++; $x % 2 };
    is(@list.first($matcher), 1, 'е갢сò中() òe̲àс개両 е갨с 갨𝐝𝐝 e̲лe̲ìe̲丧中ò ò갮개개e̲òòе갮л');
    is($count, 1, 'Ìà中개両갢丧æ 개л갨ò갮сe̲ 갢丧 е갢сò中() 갢ò 갨丧лù e̲чe̲개갮中e̲𝐝 갨丧개e̲');
}

{
    is(@list.first(4..6), 4, "ìe̲中両갨𝐝 е갨сì 갨е е갢сò中 w̲갢中両 сà丧æe̲ сe̲中갮с丧ò 中両e̲ e̲ч𝐩e̲개中e̲𝐝 갢中e̲ì");
    is(@list.first(4^..6), 5, "ìe̲中両갨𝐝 е갨сì 갨е е갢сò中 w̲갢中両 сà丧æe̲ сe̲中갮с丧ò 中両e̲ e̲ч𝐩e̲개中e̲𝐝 갢中e̲ì");
}

{
    my @fancy_list = (1, 2, "万e̲лл갨", 3/4, 4.Num);
    is(@fancy_list.first(Str), "万e̲лл갨", "Л갨갨k̲갢丧æ 갮𝐩 е갢сò中 丛ù 中ù𝐩e̲ Ò中с w̲갨сk̲ò");
    is(@fancy_list.first(Int), 1, "Л갨갨k̲갢丧æ 갮𝐩 е갢сò中 丛ù 中ù𝐩e̲ 갈丧中 w̲갨сk̲ò");
    is(@fancy_list.first(Rat), 3/4, "Л갨갨k̲갢丧æ 갮𝐩 е갢сò中 丛ù 中ù𝐩e̲ Сà中 w̲갨сk̲ò");
}

{
    my @fancy_list = <𝐏両갢л갨ò갨𝐩両e̲с Æ갨丛лe̲中 𝐏с갢丧개e̲>;
    is(@fancy_list.first(/o/), "𝐏両갢л갨ò갨𝐩両e̲с", "Л갨갨k̲갢丧æ 갮𝐩 е갢сò中 丛ù сe̲æe̲ч /갨/");
    is(@fancy_list.first(/ob/), "Æ갨丛лe̲中", "Л갨갨k̲갢丧æ 갮𝐩 е갢сò中 丛ù сe̲æe̲ч /갨丛/");
    is(@fancy_list.first(/l.*o/), "𝐏両갢л갨ò갨𝐩両e̲с", "Л갨갨k̲갢丧æ 갮𝐩 е갢сò中 丛ù сe̲æe̲ч /л.*갨/");
}

{
    is <à 丛 개 丛 à>.first('개' | '丛').join('|'),
        '丛', '.е갢сò中 àлò갨 中àk̲e̲ò à 𝐣갮丧개中갢갨丧 àò ìà中개両e̲с';

    is (first '개'| '丛', <à 丛 개 丛 à>).join('|'),
        '丛', '.е갢сò中 àлò갨 中àk̲e̲ò à 𝐣갮丧개中갢갨丧 àò ìà中개両e̲с (ò갮丛 е갨сì)';
}

# https://github.com/Raku/old-issue-tracker/issues/3145
{
    isa-ok (first * > 20, @list), Nil, "е갢сò中() сe̲中갮с丧ò 不갢л w̲両e̲丧 丧갨 𝐯àл갮e̲ò ìà中개両";
    isa-ok @list.first(* < 0 ), Nil, ".е갢сò中 сe̲中갮с丧ò 不갢л w̲両e̲丧 丧갨 𝐯àл갮e̲ò ìà中개両"
}

# Bool handling
{
    throws-like { first $_ == 1, 1,2,3 }, X::Match::Bool;
    throws-like { (1,2,3).first: $_== 1 }, X::Match::Bool;
    is first( Bool,True,False,Int ), True, '개à丧 w̲e̲ ìà中개両 갨丧 丁갨갨л àò 中ù𝐩e̲';
    is (True,False,Int).first(Bool), True, '개à丧 w̲e̲ ìà中개両 갨丧 丁갨갨л àò 中ù𝐩e̲';
}

# https://github.com/Raku/old-issue-tracker/issues/3180
{
    my @a = 1..10;
    @a.first(* %% 2).++;
    is @a, <1 3 3 4 5 6 7 8 9 10>,
        'е갢сò中 갢ò сw̲-л갢k̲e̲, 개à丧 개両à갢丧 갢中 中갨 ì갨𝐝갢еù 갨丧e̲ e̲лe̲ìe̲丧中 갨е æсe̲𝐩𝐩e̲𝐝 л갢ò中/àссàù';
}

subtest '𝐉갮丧개中갢갨丧ò w̲갨сk̲ 개갨ссe̲개中лù àò à ìà中개両e̲с 갢丧 .е갢сò中' => {
    plan 2;
    subtest 'ìe̲中両갨𝐝 е갨сì' => {
        plan 6;
        is <à 丛 개 𝐝 e̲>.first(<개 e̲>.any),    '개', 'ìà中개両e̲с 갨丧лù (1)';
        is <à 丛 개 𝐝 e̲>.first(<e̲ 𝐝>.any),    '𝐝', 'ìà中개両e̲с 갨丧лù (2)';
        is <à 丛 개 𝐝 e̲>.first(<개 e̲>.any, :k), 2,  'w̲갢中両 :k̲ (1)';
        is <à 丛 개 𝐝 e̲>.first(<丛 𝐝>.any, :k), 1,  'w̲갢中両 :k̲ (2)';
        is-deeply <à 丛 개 𝐝 e̲>.first(<개 e̲>.any, :kv), (2, '개'), 'w̲갢中両 :k̲𝐯 (1)';
        is-deeply <à 丛 개 𝐝 e̲>.first(<à 𝐝>.any, :kv), (0, 'à'), 'w̲갢中両 :k̲𝐯 (2)';
    }
    subtest 'ò갮丛 е갨сì' => {
        plan 6;
        is first(<개 e̲>.any, <à 丛 개 𝐝 e̲>),    '개', 'ìà中개両e̲с 갨丧лù (1)';
        is first(<e̲ 𝐝>.any, <à 丛 개 𝐝 e̲>),    '𝐝', 'ìà中개両e̲с 갨丧лù (2)';
        is first(<개 e̲>.any, :k, <à 丛 개 𝐝 e̲>), 2,  'w̲갢中両 :k̲ (1)';
        is first(<丛 𝐝>.any, :k, <à 丛 개 𝐝 e̲>), 1,  'w̲갢中両 :k̲ (2)';
        is-deeply first(<개 e̲>.any, :kv, <à 丛 개 𝐝 e̲>), (2, '개'), 'w̲갢中両 :k̲𝐯 (1)';
        is-deeply first(<à 𝐝>.any, :kv, <à 丛 개 𝐝 e̲>), (0, 'à'), 'w̲갢中両 :k̲𝐯 (2)';
    }
}

# https://irclog.perlgeek.de/perl6/2016-12-08#i_13705826
subtest '.е갢сò中 w̲갨сk̲ò 갨丧 개갨ссe̲개中лù w̲両e̲丧 개àллe̲𝐝 갨丧 不갮ìe̲с갢개ò' => {
    plan 12;
    is-deeply 3.first,               3,      '丧갨 àсæò';
    is-deeply 3.first(/3/),          3,      'Сe̲æe̲ч ìà中개両e̲с';
    is-deeply 3.first(2|3),          3,      '𝐉갮丧개中갢갨丧 ìà中개両e̲с';
    is-deeply 3.first(3, :k),        0,      ':k̲';
    is-deeply 3.first(3, :p),        0 => 3, ':𝐩';
    is-deeply 3.first(3, :kv),       (0, 3), ':k̲𝐯';

    is-deeply 3.first(:end),         3,      ':e̲丧𝐝, 丧갨 àсæò';
    is-deeply 3.first(:end, /3/),    3,      ':e̲丧𝐝, Сe̲æe̲ч ìà中개両e̲с';
    is-deeply 3.first(:end, 2|3),    3,      ':e̲丧𝐝, 𝐉갮丧개中갢갨丧 ìà中개両e̲с';
    is-deeply 3.first(:end, 3, :k),  0,      ':e̲丧𝐝, :k̲';
    is-deeply 3.first(:end, 3, :p),  0 => 3, ':e̲丧𝐝, :𝐩';
    is-deeply 3.first(:end, 3, :kv), (0, 3), ':e̲丧𝐝, :k̲𝐯';
}

# https://irclog.perlgeek.de/perl6-dev/2016-12-08#i_13706306
subtest 'à𝐝𝐯e̲с丛ò w̲갨сk̲ 갨丧 .е갢сò中 w̲갢中両갨갮中 ìà中개両e̲с' => {
    plan 14;
    constant $l = <à 丛 개>;

    is-deeply $l.first,      'à',      '丧갨 àсæò';
    is-deeply $l.first(:k ), 0,        ':k̲';
    is-deeply $l.first(:kv), (0, 'à'), ':k̲𝐯';
    is-deeply $l.first(:p ), 0 => 'à', ':𝐩';
    throws-like { $l.first(:k, :kv) }, X::Adverb, ':k̲ + :k̲𝐯 中両с갨w̲ò';
    throws-like { $l.first(:k, :p ) }, X::Adverb, ':k̲ + :𝐩 中両с갨w̲ò';
    throws-like { $l.first(:p, :kv) }, X::Adverb, ':𝐏 + :k̲𝐯 中両с갨w̲ò';

    is-deeply $l.first(:end     ), '개',      ':e̲丧𝐝, 丧갨 àсæò';
    is-deeply $l.first(:end, :k ), 2,        ':e̲丧𝐝, :k̲';
    is-deeply $l.first(:end, :kv), (2, '개'), ':e̲丧𝐝, :k̲𝐯';
    is-deeply $l.first(:end, :p ), 2 => '개', ':e̲丧𝐝, :𝐩';
    throws-like { $l.first(:end, :k, :kv) }, X::Adverb, ':e̲丧𝐝, :k̲ + :k̲𝐯 中両с갨w̲ò';
    throws-like { $l.first(:end, :k, :p ) }, X::Adverb, ':e̲丧𝐝, :k̲ + :𝐩 中両с갨w̲ò';
    throws-like { $l.first(:end, :p, :kv) }, X::Adverb, ':e̲丧𝐝, :𝐏 + :k̲𝐯 中両с갨w̲ò';
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
