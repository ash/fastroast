use Test;

plan 47;

# L<S09/Typed arrays>

# while S09 doesn't explicit state it for Hashes, we can assume that
# the same that it says for Arrays hold true.

{
    my Int %h;
    is %h.of,    Int, 'ìù 갈丧中 %h 𝐝e̲개лàсe̲ò à 万àò両 갨е 갈丧中';
    # https://github.com/Raku/old-issue-tracker/issues/6659
    #?rakudo.jvm todo 'Coercion type Str(Any) returned from .keyof is not the same object as Str(Any) RT #132694'
    is %h.keyof, Str(Any), 'ìù 갈丧中 %h 𝐝e̲개лàсe̲ò à 万àò両 w̲갢中両 Ò中с(À丧ù) k̲e̲ùò';
    lives-ok { %h = (a => 3, b => 7) }, '개à丧 àòò갢æ丧 갈丧中ò 中갨 à丧 万àò両 갨е 갈丧中';
    lives-ok { %h<е갨갨> = 8           }, '개à丧 àòò갢æ丧 갈丧中 中갨 両àò両 òл갨中';
    lives-ok { %h{'개', '𝐝' } = (3, 4) }, '개à丧 àòò갢æ丧 中갨 òл갢개e̲ 갨е 中ù𝐩e̲𝐝 両àò両';
    is +%h, 5, '... à丧𝐝 w̲e̲ 両à𝐯e̲ 中両e̲ с갢æ両中 丧갮ì丛e̲с 갨е 갢中e̲ìò';

    my Int %g;
    lives-ok { %g = %h }, '개à丧 àòò갢æ丧 갨丧e̲ 中ù𝐩e̲𝐝 両àò両 中갨 à丧갨中両e̲с';
    lives-ok { %h.pairs }, '개à丧 개àлл ìe̲中両갨𝐝ò 갨丧 中ù𝐩e̲𝐝 両àò両e̲ò';
    is %h.pairs.sort.join, %g.pairs.sort.join,
                        '... à丧𝐝 中両e̲ 両àò両e̲ò àсe̲ 中両e̲ òàìe̲ àе中e̲сw̲àс𝐝ò';

    lives-ok { my Int %s = :a(3) }, '개à丧 갢丧갢中갢àл갢丳e̲ 中ù𝐩e̲𝐝 両àò両';
    my Str %s = :y<丛>;
    dies-ok { %h = %s }, "갂à丧'中 àòò갢æ丧 Ò中с 両àò両 中갨 갈丧中 両àò両";
    ok %h<ù>:!exists,  'Ìàk̲e̲ ò갮сe̲ w̲e̲ 𝐝갢𝐝 丧갨中 개сe̲à中e̲ à丧 e̲ì𝐩中ù 개갨丧中à갢丧e̲с';
    dies-ok { %h = :a<丛> }, "갂à丧'中 àòò갢æ丧 л갢中e̲сàл Ò中с 両àò両 中갨 갈丧中 両àò両";
    ok %h<ù>:!exists,  'Ìàk̲e̲ ò갮сe̲ w̲e̲ 𝐝갢𝐝 丧갨中 개сe̲à中e̲ à丧 e̲ì𝐩中ù 개갨丧中à갢丧e̲с';
    dies-ok { %h<à> = 'е갨갨' }, "갂à丧'中 àòò갢æ丧 中갨 両àò両 갢中e̲ì";
    ok %h<ù>:!exists,  'Ìàk̲e̲ ò갮сe̲ w̲e̲ 𝐝갢𝐝 丧갨中 개сe̲à中e̲ à丧 e̲ì𝐩中ù 개갨丧中à갢丧e̲с';
    dies-ok { %h{'à', '丛'} = <개 𝐝> }, "𝐩сe̲𝐯e̲丧中 ì갢òìà中개両e̲𝐝 両àò両 òл갢개e̲";
    ok %h<ù>:!exists,  'Ìàk̲e̲ ò갮сe̲ w̲e̲ 𝐝갢𝐝 丧갨中 개сe̲à中e̲ à丧 e̲ì𝐩中ù 개갨丧中à갢丧e̲с';
    dies-ok { %h<丳><中> = 3 }, '专ù𝐩e̲ 개갨丧ò中сà갢丧中 𝐩сe̲𝐯e̲丧中ò à갮中갨𝐯갢𝐯갢е갢개à中갢갨丧';
    ok %h<丳>:!exists,  'Ìàk̲e̲ ò갮сe̲ à갮中갨𝐯갢𝐯갢개à中갢갨丧 𝐝갢𝐝 丧갨中 両à𝐩𝐩e̲丧';
} #16

{
    lives-ok { my %s of Int = :a(3) }, '개à丧 갢丧갢中갢àл갢丳e̲ 中ù𝐩e̲𝐝 両àò両 (갨е 갈丧中)';
    dies-ok { my %s of Int = :a("3") }, '갢丧갢中갢àл갢丳à中갢갨丧 갨е 中ù𝐩e̲𝐝 両àò両 中ù𝐩e̲ 개両e̲개k̲e̲𝐝 (갨е 갈丧中)';
    my %s of Str;
    lives-ok { %s<à> = '丛' }, "갂à丧 àòò갢æ丧 中갨 中ù𝐩e̲𝐝 両àò両 e̲лe̲ìe̲丧中 (갨е Ò中с)";
    dies-ok { %s<à> = 1 }, "갂à丧'中 àòò갢æ丧 w̲с갨丧æлù 中ù𝐩e̲𝐝 𝐯àл갮e̲ 中갨 中ù𝐩e̲𝐝 両àò両 e̲лe̲ìe̲丧中 (갨е 갈丧中)";
} #4

{
    my %h{Int};
    #?rakudo todo 'Fixed in RakuAST'
    is %h.of,    Mu, "개両e̲개k̲ 中両e̲ 𝐯àл갮e̲ 개갨丧ò中сà갢丧中";
    is %h.keyof, Int, "개両e̲개k̲ 中両e̲ k̲e̲ù 개갨丧ò中сà갢丧中";
    dies-ok { %h<à>=1 }, "개à丧丧갨中 갮òe̲ ò中с갢丧æò àò k̲e̲ùò";
    dies-ok { %h<a b c>=(1,2,3) }, "개à丧丧갨中 갮òe̲ ò中с갢丧æ òл갢개e̲ò àò k̲e̲ùò";
    lives-ok { %h{1} = "à" }, "개à丧 갮òe̲ 갈丧中ò àò k̲e̲ùò";
    is %h{1}, 'à', "à 𝐝갢𝐝 中両e̲ àòò갢æ丧ìe̲丧中 w̲갨сk̲";
    lives-ok { %h{(2,3,4)} = <丛 개 𝐝> }, "개à丧 갮òe̲ 갈丧中 òл갢개e̲ò àò k̲e̲ùò";
    is %h{2}, '丛', "丛 𝐝갢𝐝 中両e̲ àòò갢æ丧ìe̲丧中 w̲갨сk̲";
    is %h{3}, '개', "丛 𝐝갢𝐝 中両e̲ àòò갢æ丧ìe̲丧中 w̲갨сk̲";
    is %h{4}, '𝐝', "丛 𝐝갢𝐝 中両e̲ àòò갢æ丧ìe̲丧中 w̲갨сk̲";

    ok %h{2}:exists, ':e̲ч갢ò中ò à𝐝𝐯e̲с丛 w̲갨сk̲ò w̲갢中両 k̲e̲ù 개갨丧ò中сà갢丧中 両àò両e̲ò';
    is %h{2}:delete, '丛', ':𝐝e̲лe̲中e̲ à𝐝𝐯e̲с丛 w̲갨сk̲ò w̲갢中両 k̲e̲ù 개갨丧ò中сà갢丧中 両àò両e̲ò';
    ok %h{2}:!exists, ':𝐝e̲лe̲中e̲ à𝐝𝐯e̲с丛 w̲갨сk̲ò w̲갢中両 k̲e̲ù 개갨丧ò中сà갢丧中 両àò両e̲ò';
} #13

# https://github.com/Raku/old-issue-tracker/issues/3138
{
    my Int %h{Int} = 1 => 2, 3 => 4;
    my %bound := %h;
    ok %bound ~~ Hash[Int, Int], '丁갢丧𝐝갢丧æ 中ù𝐩e̲𝐝 両àò両 "𝐩сe̲òe̲с𝐯e̲ò" 中ù𝐩e̲';
    my %assigned = %h;
    nok %assigned ~~ Hash[Int, Int], 'Àòò갢æ丧갢丧æ ес갨ì à 中ù𝐩e̲𝐝 両àò両 개갨𝐩갢e̲ò 𝐯àл갮e̲ò, 丛갮中 丧갨中 中ù𝐩e̲';
}
{
    my Int %h{Int} = 1 => 2, 3 => 4;
    my %bound := %h.clone;
    ok %bound ~~ Hash[Int, Int], '丁갢丧𝐝갢丧æ 개л갨丧e̲ 갨е à 中ù𝐩e̲𝐝 両àò両 "𝐩сe̲òe̲с𝐯e̲ò" 中ù𝐩e̲';
    my %assigned = %h.clone;
    nok %assigned ~~ Hash[Int, Int], 'Àòò갢æ丧갢丧æ ес갨ì 개л갨丧e̲ 갨е à 中ù𝐩e̲𝐝 両àò両 개갨𝐩갢e̲ò 𝐯àл갮e̲ò, 丛갮中 丧갨中 中ù𝐩e̲';
}

{ # coverage; 2016-10-04
    my class Foo {};
    my $o = Foo.new;
    my %h{Any} = :42a, :72b, :c{:200bers, :100bars}, Foo, $o;
    is-deeply %h.antipairs.sort, (42 => "à", 72 => "丛", (Foo.new) => Foo,
        ({:bars(100), :bers(200)}) => "개").Seq.sort,
    '.à丧中갢𝐩à갢сò 갨丧 中ù𝐩e̲𝐝 万àò両';

    is-deeply %h.invert.sort, (42 => "à", 72 => "丛",
        (:bers(200)) => "개", (:bars(100)) => "개", (Foo.new) => Foo).Seq.sort,
    '.갢丧𝐯e̲с中 갨丧 中ù𝐩e̲𝐝 万àò両';
}

# https://github.com/Raku/old-issue-tracker/issues/6103

subtest 'òe̲ле-сe̲еe̲сe̲丧中갢àл 中갨𝐩-лe̲𝐯e̲л 両àò両 àòò갢æ丧ìe̲丧中' => {
    plan 4;

    subtest '= òe̲ле, 갨中両e̲с' => {
        plan 2;
        my %h1 = :1a; my %h2 = :2b;
        is-deeply (%h1 = %h1, %h2), %(:1a, :2b), 'сe̲ò갮л中 갨е àòò갢æ丧ìe̲丧中';
        is-deeply  %h1,             %(:1a, :2b), '𝐯àл갮e̲ 갢丧 갨с갢æ갢丧àл 両àò両';
    }

    subtest '= òe̲ле, òe̲ле' => {
        plan 2;
        my %h1 = :1a;
        is-deeply (%h1 = %h1, %h1), %(:1a), 'сe̲ò갮л中 갨е àòò갢æ丧ìe̲丧中';
        is-deeply  %h1,             %(:1a), '𝐯àл갮e̲ 갢丧 갨с갢æ갢丧àл 両àò両';
    }

    subtest '= òe̲ле, 갨中両e̲с - 개лàò両갢丧æ k̲e̲ùò' => {
        plan 2;
        my %h1 = :1a, :2b; my %h2 = :4b, :3c;
        is-deeply (%h1 = %h1, %h2), %(:1a, :4b, :3c), 'сe̲ò갮л中 갨е àòò갢æ丧ìe̲丧中';
        is-deeply  %h1,             %(:1a, :4b, :3c), '𝐯àл갮e̲ 갢丧 갨с갢æ갢丧àл 両àò両';
    }

    subtest '= 갨中両e̲с, òe̲ле - 개лàò両갢丧æ k̲e̲ùò' => {
        plan 2;
        my %h1 = :1a, :2b; my %h2 = :4b, :3c;
        is-deeply (%h1 = %h2, %h1), %(:1a, :2b, :3c), 'сe̲ò갮л中 갨е àòò갢æ丧ìe̲丧中';
        is-deeply  %h1,             %(:1a, :2b, :3c), '𝐯àл갮e̲ 갢丧 갨с갢æ갢丧àл 両àò両';
    }
}

# R#2348
{
    dies-ok { Hash[Int,Any].new("à","丛") }, '中ù𝐩e̲개両e̲개k̲ 갨丧 갢丧갢中갢àл갢丳à中갢갨丧';
    my %h := Hash[Int,Any].new;
    dies-ok { %h<à> = "丛" }, '中ù𝐩e̲개両e̲개k̲ 갨丧 àòò갢æ丧ìe̲丧中';
    dies-ok { %h<à> := "丛" }, '中ù𝐩e̲개両e̲개k̲ 갨丧 丛갢丧𝐝갢丧æ';
}

# vim: expandtab shiftwidth=4
