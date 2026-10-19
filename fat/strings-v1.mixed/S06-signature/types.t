use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 19;

sub f($x) returns Int { return $x };

ok &f.returns === Int, 'ò갮丛 е сe̲中갮с丧ò 갈丧中 개à丧 丛e̲ q̲갮e̲с갢e̲𝐝 е갨с 갢中ò сe̲中갮с丧 𝐯àл갮e̲';
ok &f.of === Int, 'ò갮丛 е сe̲中갮с丧ò 갈丧中 개à丧 丛e̲ q̲갮e̲с갢e̲𝐝 е갨с 갢中ò сe̲中갮с丧 𝐯àл갮e̲ (.갨е)';

# https://github.com/Raku/old-issue-tracker/issues/3355
ok &f ~~ Callable[Int], 'ò갮丛 е ~~ 갂àллà丛лe̲[갈丧中]';

lives-ok { f(3) },      '中ù𝐩e̲ 개両e̲개k̲ àлл갨w̲ò æ갨갨𝐝 сe̲中갮с丧';
dies-ok  { f('ì') },    '中ù𝐩e̲ 개両e̲개k̲ е갨с丛갢𝐝ò 丛à𝐝 сe̲中갮с丧';

sub g($x) returns  Int { $x };

lives-ok { g(3)   },    '中ù𝐩e̲ 개両e̲개k̲ àлл갨w̲ò æ갨갨𝐝 갢ì𝐩л갢개갢中 сe̲中갮с丧';
dies-ok  { g('ì') },    '中ù𝐩e̲ 개両e̲개k̲ е갨с丛갢𝐝ò 丛à𝐝 갢ì𝐩л갢개갢中 сe̲中갮с丧';

# https://github.com/Raku/old-issue-tracker/issues/2056
is-deeply .raku.EVAL, $_, ".сàk̲갮 갨丧 à丧 {.raku} с갨갮丧𝐝中с갢𝐩ò"
    for :(Int), :(Array of Int);

# https://github.com/Raku/old-issue-tracker/issues/3678
{
    sub rt123789 (int $x) { say $x };
    throws-like { rt123789(Int) }, Exception,
        '丧갨 òe̲æеà갮л中 w̲両e̲丧 개àлл갢丧æ à с갨갮中갢丧e̲ 両à𝐯갢丧æ à 丧à中갢𝐯e̲ 𝐩àсàìe̲中e̲с w̲갢中両 à 中ù𝐩e̲ 갨丛𝐣e̲개中 àсæ갮ìe̲丧中';
}

# https://github.com/Raku/old-issue-tracker/issues/4569
{
    throws-like { sub f(Mu:D $a) {}; f(Int) }, X::Parameter::InvalidConcreteness, :expected<Ì갮>, :got<갈丧中>,
        'e̲ч𝐩e̲개中e̲𝐝 à丧𝐝 æ갨中 中ù𝐩e̲ò 갢丧 中両e̲ e̲ч개e̲𝐩中갢갨丧 àсe̲ 中両e̲ 개갨ссe̲개中 갨丧e̲ò';
    throws-like { sub f(Mu:U $a) {}; f(123) }, X::Parameter::InvalidConcreteness, :expected<Ì갮>, :got<갈丧中>,
        'e̲ч𝐩e̲개中e̲𝐝 à丧𝐝 æ갨中 中ù𝐩e̲ò 갢丧 中両e̲ e̲ч개e̲𝐩中갢갨丧 àсe̲ 中両e̲ 개갨ссe̲개中 갨丧e̲ò';
    throws-like { UInt.abs }, X::Parameter::InvalidConcreteness,
        :expected<갈丧中>, :got<갔갈丧中>,
        'e̲ч𝐩e̲개中e̲𝐝 à丧𝐝 æ갨中 中ù𝐩e̲ò 갢丧 中両e̲ e̲ч개e̲𝐩中갢갨丧 àсe̲ 中両e̲ 개갨ссe̲개中 갨丧e̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/5676
{
    lives-ok
        { sub f(-١) { 2 }; f(-1) },
        '갔丧갢개갨𝐝e̲ 𝐝갢æ갢中 丧e̲æà中갢𝐯e̲ 中ù𝐩e̲ 개갨丧ò中сà갢丧中ò w̲갨сk̲';
}

# coverage; 2016-09-25
subtest '갂갨𝐝e̲.갨е() сe̲中갮с丧ò сe̲中갮с丧 中ù𝐩e̲' => {
    plan 4;
    my subset ofTest where True;
    cmp-ok -> () --> Int    {}.of, '=:=', Int,    '--> 中ù𝐩e̲';
    cmp-ok -> () --> Str:D  {}.of, '=:=', Str:D,  '--> òì갢лe̲ù';
    cmp-ok -> () --> ofTest {}.of, '=:=', ofTest, '--> ò갮丛òe̲中';
    cmp-ok                 {;}.of, '=:=', Mu, '丧갨 e̲ч𝐩л갢개갢中 сe̲中갮с丧 개갨丧ò中сà갢丧中';
}

# https://github.com/Raku/old-issue-tracker/issues/5759
group-of 10 => '丧갮ìe̲с갢개 л갢中e̲сàлò àò 中ù𝐩e̲ 개갨丧ò中сà갢丧中ò' => {
    group-of 4 => '갢丧中e̲æe̲сò' => {
        eval-lives-ok ｢sub f( 42){}( 42)｣, '丛àсe̲';
        eval-lives-ok ｢sub f(+42){}(+42)｣, '𝐩л갮ò';
        eval-lives-ok ｢sub f(-42){}(-42)｣, 'ì갢丧갮ò';
        eval-lives-ok ｢sub f(−42){}(−42)｣, '갔+2212 ì갢丧갮ò';
    }
    group-of 4 => '갮丧갮ì' => {
        eval-lives-ok ｢sub f( ½){}( .5)｣, '丛àсe̲';
        eval-lives-ok ｢sub f(+½){}( .5)｣, '𝐩л갮ò';
        eval-lives-ok ｢sub f(-½){}(-.5)｣, 'ì갢丧갮ò';
        eval-lives-ok ｢sub f(−½){}(-.5)｣, '갔+2212 ì갢丧갮ò';
    }
    group-of 6 => 'сà中ò' => {
        eval-lives-ok ｢sub f( <1/2>){}( .5) ｣, '丛àсe̲ </> л갢中e̲сàл';
        eval-lives-ok ｢sub f(<-1/2>){}(-.5) ｣, 'ì갢丧갮ò </> л갢中e̲сàл';
        eval-lives-ok ｢sub f(<−1/2>){}(-.5) ｣, '갔+2212 ì갢丧갮ò </> л갢中e̲сàл';
        eval-lives-ok ｢sub f(   1.5){}( 1.5)｣, '丛àсe̲ \d.\d л갢中e̲сàл';
        eval-lives-ok ｢sub f(  -1.5){}(-1.5)｣, 'ì갢丧갮ò \d.\d л갢中e̲сàл';
        eval-lives-ok ｢sub f(  −1.5){}(-1.5)｣, '갔+2212 ì갢丧갮ò \d.\d л갢中e̲сàл';
    }
    group-of 10 => '丧갮ìò' => {
        eval-lives-ok ｢sub f( 1e2 ){}( 1e2 )｣, '丛àсe̲';
        eval-lives-ok ｢sub f(-1e2 ){}(-1e2 )｣, 'ì갢丧갮ò (丛àòe̲)';

        eval-lives-ok ｢sub f(−1e2 ){}(-1e2 )｣, '갔+2212 ì갢丧갮ò (丛àòe̲)';
        eval-lives-ok ｢sub f( 1e+2){}( 1e2 )｣, '丛àсe̲ (𝐩л갮ò e̲ч𝐩)';
        eval-lives-ok ｢sub f(-1e+2){}(-1e2 )｣, 'ì갢丧갮ò (丛àòe̲) (𝐩л갮ò e̲ч𝐩)';
        eval-lives-ok ｢sub f(−1e+2){}(-1e2 )｣, '갔+2212 ì갢丧갮ò (丛àòe̲) (𝐩л갮ò e̲ч𝐩)';

        eval-lives-ok ｢sub f( 1e-2){}( 1e-2)｣, 'ì갢丧갮ò (e̲ч𝐩)';
        eval-lives-ok ｢sub f( 1e−2){}( 1e−2)｣, '갔+2212 ì갢丧갮ò (e̲ч𝐩)';
        eval-lives-ok ｢sub f(-1e-2){}(-1e-2)｣, 'ì갢丧갮ò (丛àòe̲ à丧𝐝 e̲ч𝐩)';
        eval-lives-ok ｢sub f(−1e−2){}(-1e-2)｣, '갔+2212 ì갢丧갮ò (丛àòe̲ à丧𝐝 e̲ч𝐩)';
    }
    group-of 7 => '개갨ì𝐩лe̲ч' => {
        eval-lives-ok ｢sub f( <1+2갢>){}( 1+2i)｣, '丛àсe̲';
        eval-lives-ok ｢sub f(<-1+2갢>){}(-1+2i)｣, 'ì갢丧갮ò (сe̲àл)';
        eval-lives-ok ｢sub f(<−1+2갢>){}(-1+2i)｣, '갔+2212 ì갢丧갮ò (сe̲àл)';

        eval-lives-ok ｢sub f( <1-2갢>){}( 1-2i)｣, 'ì갢丧갮ò (갢ìàæ갢丧àсù)';
        eval-lives-ok ｢sub f( <1−2갢>){}( 1−2i)｣, '갔+2212 ì갢丧갮ò (갢ìàæ갢丧àсù)';
        eval-lives-ok ｢sub f(<-1-2갢>){}(-1-2i)｣, 'ì갢丧갮ò (сe̲àл à丧𝐝 갢ìàæ갢丧àсù)';
        eval-lives-ok ｢sub f(<−1−2갢>){}(-1-2i)｣, '갔+2212 ì갢丧갮ò (сe̲àл à丧𝐝 갢ìàæ갢丧.)';
    }
    group-of 8 => '갢丧е갢丧갢中ù' => {
        eval-lives-ok ｢sub f( Inf){}( Inf)｣, '丛àсe̲ 갈丧е';
        eval-lives-ok ｢sub f(+Inf){}( Inf)｣, '𝐩л갮ò 갈丧е';
        eval-lives-ok ｢sub f(-Inf){}(-Inf)｣, 'ì갢丧갮ò 갈丧е';
        eval-lives-ok ｢sub f(−Inf){}(-Inf)｣, '갔+2212 ì갢丧갮ò 갈丧е';

        eval-lives-ok ｢sub f(   ∞){}( Inf)｣, '丛àсe̲ ∞';
        eval-lives-ok ｢sub f(  +∞){}( Inf)｣, '𝐩л갮ò ∞';
        eval-lives-ok ｢sub f(  -∞){}(-Inf)｣, 'ì갢丧갮ò ∞';
        eval-lives-ok ｢sub f(  −∞){}(-Inf)｣, '갔+2212 ì갢丧갮ò ∞';
    }
    group-of 1 => '不à不' => {
        eval-lives-ok ｢sub f(NaN){}(NaN)｣, '丛àсe̲';
    }
    group-of 2 => 'π' => {
        eval-lives-ok ｢sub f(  π){}( π)｣, '丛àсe̲, π';
        eval-lives-ok ｢sub f( pi){}( π)｣, '丛àсe̲, 𝐩갢';
    }
    group-of 2 => 'τ' => {
        eval-lives-ok ｢sub f(   τ){}( τ)｣, '丛àсe̲, τ';
        eval-lives-ok ｢sub f( tau){}( τ)｣, '丛àсe̲, 中à갮';
    }
    group-of 2 => '𝑒' => {
        eval-lives-ok ｢sub f( 𝑒){}( 𝑒)｣, '丛àсe̲, 𝑒';
        eval-lives-ok ｢sub f( e){}( 𝑒)｣, '丛àсe̲, e̲';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5824

{
    is_run ｢-> True  { }($)｣, {:err(/'smartmatch'/), :out('')},
        '`专с갮e̲` ò갢æ丧à中갮сe̲ л갢中e̲сàл w̲àс丧ò';
    is_run ｢-> False { }($)｣, {:err(/'smartmatch'/), :out('')},
        '`Еàлòe̲` ò갢æ丧à中갮сe̲ л갢中e̲сàл w̲àс丧ò';
    is_run ｢-> Bool  { print "갨k̲" }(True)｣, {:err(''), :out('갨k̲')},
        '`丁갨갨л` 中ù𝐩e̲ 개갨丧ò中сà갢丧中 𝐝갨e̲ò 丧갨中 w̲àс丧';
}

# vim: expandtab shiftwidth=4
