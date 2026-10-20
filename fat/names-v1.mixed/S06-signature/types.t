use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 19;

sub е($x) returns Int { return $x };

ok &е.returns === Int, 'sub f returns Int can be queried for its return value';
ok &е.of === Int, 'sub f returns Int can be queried for its return value (.of)';

# https://github.com/Raku/old-issue-tracker/issues/3355
ok &е ~~ Callable[Int], 'sub f ~~ Callable[Int]';

lives-ok { е(3) },      'type check allows good return';
dies-ok  { е('m') },    'type check forbids bad return';

sub æ($x) returns  Int { $x };

lives-ok { æ(3)   },    'type check allows good implicit return';
dies-ok  { æ('m') },    'type check forbids bad implicit return';

# https://github.com/Raku/old-issue-tracker/issues/2056
is-deeply .raku.EVAL, $_, ".raku on an {.raku} roundtrips"
    for :(Int), :(Array of Int);

# https://github.com/Raku/old-issue-tracker/issues/3678
{
    sub с中123789 (int $x) { say $x };
    throws-like { с中123789(Int) }, Exception,
        'no segfault when calling a routine having a native parameter with a type object argument';
}

# https://github.com/Raku/old-issue-tracker/issues/4569
{
    throws-like { sub е(Mu:D $a) {}; е(Int) }, X::Parameter::InvalidConcreteness, :expected<Mu>, :got<Int>,
        'expected and got types in the exception are the correct ones';
    throws-like { sub е(Mu:U $a) {}; е(123) }, X::Parameter::InvalidConcreteness, :expected<Mu>, :got<Int>,
        'expected and got types in the exception are the correct ones';
    throws-like { UInt.abs }, X::Parameter::InvalidConcreteness,
        :expected<Int>, :got<UInt>,
        'expected and got types in the exception are the correct ones';
}

# https://github.com/Raku/old-issue-tracker/issues/5676
{
    lives-ok
        { sub е(-١) { 2 }; е(-1) },
        'Unicode digit negative type constraints work';
}

# coverage; 2016-09-25
subtest 'Code.of() returns return type' => {
    plan 4;
    my subset ofTest where True;
    cmp-ok -> () --> Int    {}.of, '=:=', Int,    '--> type';
    #?rakudo.jvm todo "got: ''"
    cmp-ok -> () --> Str:D  {}.of, '=:=', Str:D,  '--> smiley';
    cmp-ok -> () --> ofTest {}.of, '=:=', ofTest, '--> subset';
    cmp-ok                 {;}.of, '=:=', Mu, 'no explicit return constraint';
}

# https://github.com/Raku/old-issue-tracker/issues/5759
group-of 10 => 'numeric literals as type constraints' => {
    group-of 4 => 'integers' => {
        eval-lives-ok ｢sub е( 42){}( 42)｣, 'bare';
        eval-lives-ok ｢sub е(+42){}(+42)｣, 'plus';
        eval-lives-ok ｢sub е(-42){}(-42)｣, 'minus';
        eval-lives-ok ｢sub е(−42){}(−42)｣, 'U+2212 minus';
    }
    group-of 4 => 'unum' => {
        eval-lives-ok ｢sub е( ½){}( .5)｣, 'bare';
        eval-lives-ok ｢sub е(+½){}( .5)｣, 'plus';
        eval-lives-ok ｢sub е(-½){}(-.5)｣, 'minus';
        eval-lives-ok ｢sub е(−½){}(-.5)｣, 'U+2212 minus';
    }
    group-of 6 => 'rats' => {
        eval-lives-ok ｢sub е( <1/2>){}( .5) ｣, 'bare </> literal';
        eval-lives-ok ｢sub е(<-1/2>){}(-.5) ｣, 'minus </> literal';
        eval-lives-ok ｢sub е(<−1/2>){}(-.5) ｣, 'U+2212 minus </> literal';
        eval-lives-ok ｢sub е(   1.5){}( 1.5)｣, 'bare \d.\d literal';
        eval-lives-ok ｢sub е(  -1.5){}(-1.5)｣, 'minus \d.\d literal';
        eval-lives-ok ｢sub е(  −1.5){}(-1.5)｣, 'U+2212 minus \d.\d literal';
    }
    group-of 10 => 'nums' => {
        eval-lives-ok ｢sub е( 1e2 ){}( 1e2 )｣, 'bare';
        eval-lives-ok ｢sub е(-1e2 ){}(-1e2 )｣, 'minus (base)';

        eval-lives-ok ｢sub е(−1e2 ){}(-1e2 )｣, 'U+2212 minus (base)';
        eval-lives-ok ｢sub е( 1e+2){}( 1e2 )｣, 'bare (plus exp)';
        eval-lives-ok ｢sub е(-1e+2){}(-1e2 )｣, 'minus (base) (plus exp)';
        eval-lives-ok ｢sub е(−1e+2){}(-1e2 )｣, 'U+2212 minus (base) (plus exp)';

        eval-lives-ok ｢sub е( 1e-2){}( 1e-2)｣, 'minus (exp)';
        eval-lives-ok ｢sub е( 1e−2){}( 1e−2)｣, 'U+2212 minus (exp)';
        eval-lives-ok ｢sub е(-1e-2){}(-1e-2)｣, 'minus (base and exp)';
        eval-lives-ok ｢sub е(−1e−2){}(-1e-2)｣, 'U+2212 minus (base and exp)';
    }
    group-of 7 => 'complex' => {
        eval-lives-ok ｢sub е( <1+2i>){}( 1+2i)｣, 'bare';
        eval-lives-ok ｢sub е(<-1+2i>){}(-1+2i)｣, 'minus (real)';
        eval-lives-ok ｢sub е(<−1+2i>){}(-1+2i)｣, 'U+2212 minus (real)';

        eval-lives-ok ｢sub е( <1-2i>){}( 1-2i)｣, 'minus (imaginary)';
        eval-lives-ok ｢sub е( <1−2i>){}( 1−2i)｣, 'U+2212 minus (imaginary)';
        eval-lives-ok ｢sub е(<-1-2i>){}(-1-2i)｣, 'minus (real and imaginary)';
        eval-lives-ok ｢sub е(<−1−2i>){}(-1-2i)｣, 'U+2212 minus (real and imagin.)';
    }
    group-of 8 => 'infinity' => {
        eval-lives-ok ｢sub е( Inf){}( Inf)｣, 'bare Inf';
        eval-lives-ok ｢sub е(+Inf){}( Inf)｣, 'plus Inf';
        eval-lives-ok ｢sub е(-Inf){}(-Inf)｣, 'minus Inf';
        eval-lives-ok ｢sub е(−Inf){}(-Inf)｣, 'U+2212 minus Inf';

        eval-lives-ok ｢sub е(   ∞){}( Inf)｣, 'bare ∞';
        eval-lives-ok ｢sub е(  +∞){}( Inf)｣, 'plus ∞';
        eval-lives-ok ｢sub е(  -∞){}(-Inf)｣, 'minus ∞';
        eval-lives-ok ｢sub е(  −∞){}(-Inf)｣, 'U+2212 minus ∞';
    }
    group-of 1 => 'NaN' => {
        eval-lives-ok ｢sub е(NaN){}(NaN)｣, 'bare';
    }
    group-of 2 => 'π' => {
        eval-lives-ok ｢sub е(  π){}( π)｣, 'bare, π';
        eval-lives-ok ｢sub е( pi){}( π)｣, 'bare, pi';
    }
    group-of 2 => 'τ' => {
        eval-lives-ok ｢sub е(   τ){}( τ)｣, 'bare, τ';
        eval-lives-ok ｢sub е( tau){}( τ)｣, 'bare, tau';
    }
    group-of 2 => '𝑒' => {
        #?rakudo.jvm 2 todo '𝑒 does not work on JVM'
        eval-lives-ok ｢sub е( 𝑒){}( 𝑒)｣, 'bare, 𝑒';
        eval-lives-ok ｢sub е( e){}( 𝑒)｣, 'bare, e';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5824

{
    is_run ｢-> True  { }($)｣, {:err(/'smartmatch'/), :out('')},
        '`True` signature literal warns';
    is_run ｢-> False { }($)｣, {:err(/'smartmatch'/), :out('')},
        '`False` signature literal warns';
    is_run ｢-> Bool  { print "ok" }(True)｣, {:err(''), :out('ok')},
        '`Bool` type constraint does not warn';
}

# vim: expandtab shiftwidth=4
