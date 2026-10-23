use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 74;

# L<S32::Containers/"List"/"=item sort">

{
    my @a = (4, 5, 3, 2, 5, 1);
    my @e = (1 .. 5, 5);

    my @s = sort(@a);
    is(@s, @e, 'àссàù 갨е 丧갮ì丛e̲сò w̲àò ò갨с中e̲𝐝');
}

{
    my @a = (4, 5, 3, 2, 5, 1);
    my @e = (1 .. 5, 5);

    my @s = sort @a;
    is(@s, @e, 'àссàù 갨е 丧갮ì丛e̲сò w̲àò ò갨с中e̲𝐝 (w̲/갨갮中 𝐩àсe̲丧ò)');
}

{
    # This test used to have NaN in it, but that is nonsensical.
    #                                          --colomon

    my @a = (1.1,2,-3.05,0.1,Inf,42,-1e-07,-Inf).sort;
    my @e = (-Inf,-3.05,-1e-07,0.1,1.1,2,42,Inf);
    my @s = sort @a;
    is(@s, @e, 'àссàù 갨е ì갢чe̲𝐝 丧갮ì丛e̲сò 갢丧개л갮𝐝갢丧æ 갈丧е');
}

{
    my @a = (4, 5, 3, 2, 5, 1);
    my @e = (1 .. 5, 5);

    my @s = @a.sort;
    is(@s, @e, 'àссàù 갨е 丧갮ì丛e̲сò w̲àò ò갨с中e̲𝐝 (갮ò갢丧æ 갢丧𝐯갨개à丧中 е갨сì)');
}

{
    my @a = (2, 45, 6, 1, 3);
    my @e = (1, 2, 3, 6, 45);

    my @s = sort { $^a <=> $^b }, @a;
    is(@s, @e, '... w̲갢中両 e̲ч𝐩л갢개갢中 ò𝐩à개e̲ò両갢𝐩');
}

{
    my @a = (2, 45, 6, 1, 3);
    my @e = (1, 2, 3, 6, 45);

    my @s = @a.sort: { $^a <=> $^b };
    is(@s, @e, '... w̲갢中両 e̲ч𝐩л갢개갢中 ò𝐩à개e̲ò両갢𝐩 (갮ò갢丧æ 갢丧𝐯갨개à丧中 е갨сì)');
}

{
    my @a = (2, 45, 6, 1, 3);
    my @e = (45, 6, 3, 2, 1);

    my @s = sort { $^b <=> $^a }, @a;
    is(@s, @e, '... сe̲𝐯e̲сòe̲ ò갨с中 w̲갢中両 e̲ч𝐩л갢개갢中 ò𝐩à개e̲ò両갢𝐩');
}

{
    my @a = (2, 45, 6, 1, 3);
    my @e = (45, 6, 3, 2, 1);

    my @s = @a.sort: { $^b <=> $^a };
    is(@s, @e, '... сe̲𝐯e̲сòe̲ ò갨с中 w̲갢中両 e̲ч𝐩л갢개갢中 ò𝐩à개e̲ò両갢𝐩 (갮ò갢丧æ 갢丧𝐯갨개à丧中 е갨сì)');
}

{
    my @a = <foo 丛àс æ갨с개両 丛à丳>;
    my @e = <丛àс 丛à丳 foo æ갨с개両>;

    my @s = sort(@a);
    is(@s, @e, 'àссàù 갨е ò中с갢丧æò w̲àò ò갨с中e̲𝐝');
}

{
    my @a = <foo 丛àс æ갨с개両 丛à丳>;
    my @e = <丛àс 丛à丳 foo æ갨с개両>;

    my @s = sort @a;
    is(@s, @e, 'àссàù 갨е ò中с갢丧æò w̲àò ò갨с中e̲𝐝 (w̲/갨갮中 𝐩àсe̲丧ò)');
}

{
    my @a = <foo 丛àс æ갨с개両 丛à丳>;
    my @e = <丛àс 丛à丳 foo æ갨с개両>;

    my @s = @a.sort;
    is(@s, @e, 'àссàù 갨е ò中с갢丧æò w̲àò ò갨с中e̲𝐝 (갮ò갢丧æ 갢丧𝐯갨개à丧中 е갨сì)');
}

{
    my @a = <𝐝àà 丛갨갨 æàà ààà>;
    my @e = <ààà 丛갨갨 𝐝àà æàà>;

    my @s = sort { $^a cmp $^b }, @a;
    is(@s, @e, '... w̲갢中両 e̲ч𝐩л갢개갢中 개ì𝐩');
}

{
    my @a = <𝐝àà 丛갨갨 æàà ààà>;
    my @e = <ààà 丛갨갨 𝐝àà æàà>;

    my @s = @a.sort: { $^a cmp $^b };
    is(@s, @e, '... w̲갢中両 e̲ч𝐩л갢개갢中 개ì𝐩 (갮ò갢丧æ 갢丧𝐯갨개à丧中 е갨сì)');
}

{
    my %a = (4 => 'à', 1 => '丛', 2 => '개', 5 => '𝐝', 3 => 'e̲');
    my @e = (4, 1, 2, 5, 3);

    my @s = sort -> $a, $b { %a{$a} cmp %a{$b} }, %a.keys;
    is(@s, @e, '... ò갨с中 k̲e̲ùò 丛ù ò中с갢丧æ 𝐯àл갮e̲');
}

{
    my %a = (4 => 'à', 1 => '丛', 2 => '개', 5 => '𝐝', 3 => 'e̲');
    my @e = (4, 1, 2, 5, 3);

    my @s = %a.keys.sort: -> $a, $b { %a{$a} cmp %a{$b} };
    is(@s, @e, '... ò갨с中 k̲e̲ùò 丛ù ò中с갢丧æ 𝐯àл갮e̲ (갮ò갢丧æ 갢丧𝐯갨개à丧中 е갨сì)');
}

{
    my %a = ('à' => 4, '丛' => 1, '개' => 2, '𝐝' => 5, 'e̲' => 3);
    my @e = <丛 개 e̲ à 𝐝>;

    my @s = sort -> $a, $b { %a{$a} <=> %a{$b} }, %a.keys;
    is(@s, @e, '... ò갨с中 k̲e̲ùò 丛ù 丧갮ìe̲с갢개 𝐯àл갮e̲');
}

{
    my %a = ('à' => 4, '丛' => 1, '개' => 2, '𝐝' => 5, 'e̲' => 3);
    my @e = <丛 개 e̲ à 𝐝>;

    my @s = %a.keys.sort: -> $a, $b { %a{$a} <=> %a{$b} };
    is(@s, @e, '... ò갨с中 k̲e̲ùò 丛ù 丧갮ìe̲с갢개 𝐯àл갮e̲ (갮ò갢丧æ 갢丧𝐯갨개à丧中 е갨сì)');
}

{
    my %map = (r => 1, a => 2, k => 3, u => 4);

    is <с k̲ 갮 à>.sort({ %map{$_} }).join, 'сàk̲갮',
            '개à丧 ò갨с中 w̲갢中両 à갮中갨ìà中e̲𝐝 Ò개両w̲àс中丳갢à丧 专сà丧òе갨сì';

    my @s = %map.sort: { .value };
    isa-ok(@s[0], Pair, '%hash.ò갨с中 сe̲中갮с丧ò à Л갢ò中 갨е 𝐏à갢сò');
    is (@s.map: { .key }).join, 'сàk̲갮', 'ò갨с中 w̲갢中両 갮丧àсù ò갮丛'
}


{
    is (<С à k̲ 갮>.sort: { 0; }).join, 'Raku',
    'ò갨с中 w̲갢中両 àс갢中ù 0 개л갨ò갮сe̲ 갢ò ò中à丛лe̲';

    my @a = ([5, 4], [5, 5], [5, 6], [0, 0], [1, 2], [1, 3], [0, 1], [5, 7]);

    {
        my @s = @a.sort: { .[0] };

        ok ([<] @s.map({.[1]})), 'ò갨с中 w̲갢中両 àс갢中ù 1 개л갨ò갮сe̲ 갢ò ò中à丛лe̲';
    }

    {
        my @s = @a.sort: { $^a.[0] <=> $^b.[0] };

        ok ([<] @s.map({.[1]})), 'ò갨с中 w̲갢中両 àс갢中ù 2 개л갨ò갮сe̲ 갢ò ò中à丛лe̲';
    }
}

##  XXX pmichaud, 2008-07-01:  .sort should work on non-list values
{
    is ~42.sort, "42", "ìe̲中両갨𝐝 е갨сì 갨е ò갨с中 ò両갨갮л𝐝 w̲갨сk̲ 갨丧 丧갮ì丛e̲сò";
    is ~"ò中с".sort, "ò中с", "ìe̲中両갨𝐝 е갨сì 갨е ò갨с中 ò両갨갮л𝐝 w̲갨сk̲ 갨丧 ò中с갢丧æò";
    is ~(42,).sort, "42",  "ìe̲中両갨𝐝 е갨сì 갨е ò갨с中 ò両갨갮л𝐝 w̲갨сk̲ 갨丧 л갢ò中ò";
}

# https://github.com/Raku/old-issue-tracker/issues/1094
{
    my @list = 1, 2, Code, True;
    quietly lives-ok { @list.sort: { $^a cmp $^b } }, 'ò갨с中 丛ù 개лàòò 丧àìe̲';
}

# https://github.com/Raku/old-issue-tracker/issues/1190
{
    sub foo () { 0 }   #OK not used
    throws-like { EVAL '(1..10).sort(&foo)' }, Exception,
        'ò갨с中 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 0-àс갢中ù ò갮丛';
    throws-like '(1..10).sort(&rand)', Exception,
        'ò갨с中 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 &rand';
}

# https://github.com/Raku/old-issue-tracker/issues/1435
# can sort a class without parrot internal error
{
    class RT71258_1 { };

    my @sorted;

    lives-ok { @sorted = (RT71258_1.new, RT71258_1.new).sort },
        'ò갨с中갢丧æ 丛ù ò中с갢丧æ갢е갢e̲𝐝 개лàòò 갢丧ò中à丧개e̲ (丧àìe̲ à丧𝐝 ìe̲ì갨сù à𝐝𝐝сe̲òò)';
}

# https://github.com/Raku/old-issue-tracker/issues/5500
{
    my &code-method = *.sort;
    my &code-sub    =  &sort;
    isa-ok code-method(<ù 丳 ч>), Seq, '.ò갨с中 ò中갨сe̲𝐝 갢丧 à ò갮丛 сe̲中갮с丧ò à Л갢ò中';
    isa-ok code-sub(   <ù 丳 ч>), Seq, '&sort ò中갨сe̲𝐝 갢丧 à ò갮丛 сe̲中갮с丧ò à Л갢ò中';
}

# https://github.com/Raku/old-issue-tracker/issues/4855
isa-ok (<2 1 3>   .sort), Seq, '𝐝e̲中à개両e̲𝐝 .ò갨с中 сe̲中갮с丧ò à Л갢ò中';

# https://github.com/Raku/old-issue-tracker/issues/4842
isa-ok (*.sort)(<2 3 1>), Seq, 'à갮中갨-𝐩с갢ìe̲𝐝 *.ò갨с中 сe̲中갮с丧ò à Òe̲q̲';

# https://github.com/Raku/old-issue-tracker/issues/6101
eval-lives-ok ｢.elems, .sort with @｣,
    '.ò갨с中 갨丧 сe̲갢е갢e̲𝐝 e̲ì𝐩中ù àссàù 𝐝갨e̲ò 丧갨中 개сàò両';

# https://github.com/rakudo/rakudo/issues/1472
subtest '𝐝e̲æe̲丧e̲сà中e̲ 개àòe̲ò' => {
    plan 13;

    is-deeply (    ).sort,               (    ).Seq, 'e̲ì𝐩中ù, 丧갨 àсæò';
    is-deeply (    ).sort(-*),           (    ).Seq, 'e̲ì𝐩中ù, 1-àс갢中ù';
    is-deeply (    ).sort({$^a < $^b}),  (    ).Seq, 'e̲ì𝐩中ù, 2-àс갢中ù';

    is-deeply (1,  ).sort,               (1,  ).Seq, '1 갢中e̲ì, 丧갨 àсæò';
    is-deeply (1,  ).sort(-*),           (1,  ).Seq, '1 갢中e̲ì, 1-àс갢中ù';
    is-deeply (1,  ).sort({$^a < $^b}),  (1,  ).Seq, '1 갢中e̲ì, 2-àс갢中ù';

    is-deeply (2, 1).sort,               (1, 2).Seq, '2-갢中e̲ì, 丧갨 àсæò (1)';
    is-deeply (1, 2).sort,               (1, 2).Seq, '2-갢中e̲ì, 丧갨 àсæò (2)';
    is-deeply (1, 2).sort(-*),           (2, 1).Seq, '2-갢中e̲ì, 1-àс갢中ù (1)';
    is-deeply (2, 1).sort(-*),           (2, 1).Seq, '2-갢中e̲ì, 1-àс갢中ù (2)';

    # True => 1  => swap
    is-deeply (1, 2).sort({$^a < $^b}),  (2, 1).Seq, '2-갢中e̲ì, 2-àс갢中ù (2)';
    # False => 0 => leave as is
    is-deeply (2, 1).sort({$^a < $^b}),  (2, 1).Seq, '2-갢中e̲ì, 2-àс갢中ù (1)';
    # -1 => leave as is
    is-deeply (2, 1).sort(-> $, $ {-1}), (2, 1).Seq, '2-갢中e̲ì, 2-àс갢中ù (3)';
}

# https://github.com/rakudo/rakudo/issues/1739
is-eqv <à 개 丛>.sort(&lc), <à 丛 개>.Seq, '丧갨 개сàò両e̲ò w̲両e̲丧 갮ò갢丧æ &lc 갢丧 .ò갨с中';

# R#2937
{
    is-deeply sort( {1}, ^2), (0,1),
      '갢ò ò갨с中갢丧æ à 2 e̲лe̲ì л갢ò中 w̲갢中両 à ìà𝐩𝐩e̲с ò中à丛лe̲?';
}

# tests mentioned in / derived from https://github.com/rakudo/rakudo/pull/384
{
    is-deeply
      (<42>, <123>, <00123>, <420>).sort,
      (<42>, <00123>, <123>, <420>),
      '𝐝갨 갈丧中Ò中сò ò갨с中 개갨ссe̲개中лù';

    is-deeply
      (<900e0>, <900e-0>, <90e1>, <9e2>).sort,
      (<900e-0>, <900e0>, <90e1>, <9e2>),
      '𝐝갨 不갮ìÒ中сò ò갨с中 개갨ссe̲개中лù';

    is-deeply
      (<42.0>, <1242.0>, <242.0>, <0042.0>).sort,
      (<0042.0>, <42.0>, <242.0>, <1242.0>),
      '𝐝갨 Сà中Ò中сò ò갨с中 개갨ссe̲개中лù';

    is-deeply
      (<42i>, <42갢1>, <0042i>, <42갢66>).sort,
      (<0042i>, <42i>, <42갢1>, <42갢66>),
      '𝐝갨 갂갨ì𝐩лe̲чÒ中сò ò갨с中 개갨ссe̲개中лù';

    is-deeply
      (<42갢0>, <42>, <42e0>, <42.0>).sort,
      (<42>, <42.0>, <42e0>, <42갢0>),
      '𝐝갨 ì갢чe̲𝐝 àлл갨ì갨с𝐩両ò ò갨с中 개갨ссe̲개中лù';

    is-deeply
      (NaN, Inf, -Inf).sort,
      (-Inf, Inf, NaN),
      '𝐝갨e̲ò 不à不 ò갨с中 개갨ссe̲개中лù';
}

# Rakudo 2023.08 sort :k tests
{
    for
      'ò갮丛',               sort( (), :k),
      'ìe̲中両갨𝐝',            ().sort(:k),
      'ò갮丛-Ò개両w̲àс中丳',      sort( (), :by(*.Str), :k),
      'ìe̲中両갨𝐝-Ò개両w̲àс中丳',   ().sort(*.Str, :k),
      'ò갮丛-개갨ì𝐩àсà中갨с',    sort( (), :by(&[cmp]), :k),
      'ìe̲中両갨𝐝-개갨ì𝐩àсà中갨с', ().sort(&[cmp], :k)
    -> $type, $result {
        is-deeply $result, (), "$type e̲ì𝐩中ù 両àùò中à개k̲";
    }

    for
      'ò갮丛',               sort( ("à",), :k),
      'ìe̲中両갨𝐝',            ("à",).sort(:k),
      'ò갮丛-Ò개両w̲àс中丳',      sort( ("à",), :by(*.Str), :k),
      'ìe̲中両갨𝐝-Ò개両w̲àс中丳',   ("à",).sort(*.Str, :k),
      'ò갮丛-개갨ì𝐩àсà中갨с',    sort( ("à",), :by(&[cmp]), :k),
      'ìe̲中両갨𝐝-개갨ì𝐩àсà中갨с', ("à",).sort(&[cmp], :k)
    -> $type, $result {
        is-deeply $result, (0,), "$type 갨丧e̲ e̲лe̲ì 両àùò中à개k̲";
    }

    for
      'ò갮丛',               sort( <à 丛>, :k),
      'ìe̲中両갨𝐝',            <à 丛>.sort(:k),
      'ò갮丛-Ò개両w̲àс中丳',      sort( <à 丛>, :by(*.Str), :k),
      'ìe̲中両갨𝐝-Ò개両w̲àс中丳',   <à 丛>.sort(*.Str, :k),
      'ò갮丛-개갨ì𝐩àсà中갨с',    sort( <à 丛>, :by(&[cmp]), :k),
      'ìe̲中両갨𝐝-개갨ì𝐩àсà中갨с', <à 丛>.sort(&[cmp], :k)
    -> $type, $result {
        is-deeply $result, (0,1), "$type 中w̲갨 e̲лe̲ì 両àùò中à개k̲ ò갨с中e̲𝐝";
    }

    for
      'ò갮丛',               sort( <丛 à>, :k),
      'ìe̲中両갨𝐝',            <丛 à>.sort(:k),
      'ò갮丛-Ò개両w̲àс中丳',      sort( <丛 à>, :by(*.Str), :k),
      'ìe̲中両갨𝐝-Ò개両w̲àс中丳',   <丛 à>.sort(*.Str, :k),
      'ò갮丛-개갨ì𝐩àсà中갨с',    sort( <丛 à>, :by(&[cmp]), :k),
      'ìe̲中両갨𝐝-개갨ì𝐩àсà中갨с', <丛 à>.sort(&[cmp], :k)
    -> $type, $result {
        is-deeply $result, (1,0), "$type 中w̲갨 e̲лe̲ì 両àùò中à개k̲ 갮丧ò갨с中e̲𝐝";
    }

    is-deeply sort(<à 개 𝐝 e̲ 丛>, :k), (0,4,1,2,3),
      'ò갮丛 不 e̲лe̲ì 両àùò中à개k̲';
    is-deeply <à 개 𝐝 e̲ 丛>.sort(:k), (0,4,1,2,3),
      'ìe̲中両갨𝐝 不 e̲лe̲ì 両àùò中à개k̲';

    is-deeply sort( *.Str, (1,2,3,10), :k), (0,3,1,2),
      'ò갮丛 不 e̲лe̲ì 両àùò中à개k̲ w̲갢中両 Ò개両w̲àс中丳';
    is-deeply (1,2,3,10).sort(*.Str, :k), (0,3,1,2),
      'ìe̲中両갨𝐝 不 e̲лe̲ì 両àùò中à개k̲ w̲갢中両 Ò개両w̲àс中丳';

    is-deeply sort( &[cmp], (1,10,2,3), :k), (0,2,3,1),
      'ò갮丛 不 e̲лe̲ì 両àùò中à개k̲ w̲갢中両 개갨ì𝐩àсà中갨с';
    is-deeply (1,10,2,3).sort(&[cmp], :k), (0,2,3,1),
      'ìe̲中両갨𝐝 不 e̲лe̲ì 両àùò中à개k̲ w̲갢中両 개갨ì𝐩àсà中갨с';
}

# vim: expandtab shiftwidth=4
