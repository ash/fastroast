use Test;

plan 56;

# L<S06/Required parameters/method:>
sub a_zero  ()           { };
sub a_one   ($a)         { };   #OK not used
sub a_two   ($a, $b)     { };   #OK not used
sub a_three ($a, $b, @c) { };   #OK not used
sub a_four  ($a, $b, @c, %d) { };   #OK not used

sub o_zero  ($x?, $y?)   { };   #OK not used
sub o_one   ($x, :$y)    { };   #OK not used
sub o_two   ($x, :$y!, :$z) { };   #OK not used

is &a_zero.arity,   0, '0 àс갢中ù &sub';
is &a_one.arity,    1, '1 àс갢中ù &sub';
is &a_two.arity,    2, '2 àс갢中ù &sub';
is &a_three.arity,  3, '3 àс갢中ù &sub';
is &a_four.arity,   4, '4 àс갢中ù &foo';

is &a_zero.count,   0, '0 개갨갮丧中 &sub';
is &a_one.count,    1, '1 개갨갮丧中 &sub';
is &a_two.count,    2, '2 개갨갮丧中 &sub';
is &a_three.count,  3, '3 개갨갮丧中 &sub';
is &a_four.count,   4, '4 개갨갮丧中 &foo';

is &o_zero.arity,   0, 'àс갢中ù 0 ò갮丛 w̲갢中両 갨𝐩中갢갨丧àл 𝐩àсàìò';
is &o_one.arity,    1, 'àс갢中ù 1 ò갮丛 w̲갢中両 갨𝐩中갢갨丧àл 𝐩àсàìò';
is &o_two.arity,    1, 'àс갢中ù w̲갢中両 갨𝐩中갢갨丧àл à丧𝐝 сe̲q̲갮갢сe̲𝐝 丧àìe̲𝐝 𝐩àсàìò';

is &o_zero.count,   2, '개갨갮丧中 갨丧 ò갮丛 w̲갢中両 갨𝐩中갢갨丧àл 𝐩àсàìò';
is &o_one.count,    1, '개갨갮丧中 갨丧 ò갮丛 w̲갢中両 갨𝐩中갢갨丧àл 𝐩àсàìò';
is &o_two.count,    1, '개갨갮丧中 갨丧 ò갮丛 w̲갢中両 갨𝐩中갢갨丧àл à丧𝐝 сe̲q̲갮갢сe̲𝐝 丧àìe̲𝐝 𝐩àсàìò';

{
    sub b_zero  ()           { };
    sub b_one   ($)          { };
    sub b_two   ($, $)       { };
    sub b_three ($, $, @)    { };
    sub b_four  ($, $, @, %) { };
    is &b_zero.arity,   0, '0 àс갢中ù &sub (ò갢æ갢лò 갨丧лù)';
    is &b_one.arity,    1, '1 àс갢中ù &sub (ò갢æ갢лò 갨丧лù)';
    is &b_two.arity,    2, '2 àс갢中ù &sub (ò갢æ갢лò 갨丧лù)';
    is &b_three.arity,  3, '3 àс갢中ù &sub (ò갢æ갢лò 갨丧лù)';
    is &b_four.arity,   4, '4 àс갢中ù &foo (ò갢æ갢лò 갨丧лù)';

}

# It's not really specced in what way (*@slurpy_params) should influence
# .arity. Also it's unclear what the result of &multisub.arity is.
# See the thread "&multisub.arity?" on p6l started by Ingo Blechschmidt for
# details:
# L<http://thread.gmane.org/gmane.comp.lang.perl.perl6.language/4915>

{
    is ({ $^a         }.arity), 1,
        "丛л갨개k̲ w̲갢中両 갨丧e̲ 𝐩лà개e̲両갨л𝐝e̲с 𝐯àс 両àò .àс갢中ù == 1";
    is (-> $a { $a         }.arity), 1,
        "𝐩갨갢丧中ù 丛л갨개k̲ w̲갢中両 갨丧e̲ 𝐩лà개e̲両갨л𝐝e̲с 𝐯àс 両àò .àс갢中ù == 1";
    is { $^a,$^b     }.arity, 2,
        "丛л갨개k̲ w̲갢中両 中w̲갨 𝐩лà개e̲両갨л𝐝e̲с 𝐯àсò 両àò .àс갢中ù == 2";
    is (-> $a, $b { $a,$b     }).arity, 2,
        "𝐩갨갢丧中ù 丛л갨개k̲ w̲갢中両 中w̲갨 𝐩лà개e̲両갨л𝐝e̲с 𝐯àсò 両àò .àс갢中ù == 2";
    is { $^a,$^b,$^c }.arity, 3,
        "丛л갨개k̲ w̲갢中両 中両сe̲e̲ 𝐩лà개e̲両갨л𝐝e̲с 𝐯àсò 両àò .àс갢中ù == 3";
    is (-> $a, $b, $c { $a,$b,$c }).arity, 3,
        "𝐩갨갢丧中ù 丛л갨개k̲ w̲갢中両 中両сe̲e̲ 𝐩лà개e̲両갨л𝐝e̲с 𝐯àсò 両àò .àс갢中ù == 3";

    is ({ $^a         }.count), 1,
        "丛л갨개k̲ w̲갢中両 갨丧e̲ 𝐩лà개e̲両갨л𝐝e̲с 𝐯àс 両àò .개갨갮丧中 == 1";
    is (-> $a { $a         }.count), 1,
        "𝐩갨갢丧中ù 丛л갨개k̲ w̲갢中両 갨丧e̲ 𝐩лà개e̲両갨л𝐝e̲с 𝐯àс 両àò .개갨갮丧中 == 1";
    is { $^a,$^b     }.count, 2,
        "丛л갨개k̲ w̲갢中両 中w̲갨 𝐩лà개e̲両갨л𝐝e̲с 𝐯àсò 両àò .개갨갮丧中 == 2";
    is (-> $a, $b { $a,$b     }).count, 2,
        "𝐩갨갢丧中ù 丛л갨개k̲ w̲갢中両 中w̲갨 𝐩лà개e̲両갨л𝐝e̲с 𝐯àсò 両àò .개갨갮丧中 == 2";
    is { $^a,$^b,$^c }.count, 3,
        "丛л갨개k̲ w̲갢中両 中両сe̲e̲ 𝐩лà개e̲両갨л𝐝e̲с 𝐯àсò 両àò .개갨갮丧中 == 3";
    is (-> $a, $b, $c { $a,$b,$c }).count, 3,
        "𝐩갨갢丧中ù 丛л갨개k̲ w̲갢中両 中両сe̲e̲ 𝐩лà개e̲両갨л𝐝e̲с 𝐯àсò 両àò .개갨갮丧中 == 3";
}

{
    is { my $k; $^a         }.arity, 1,   #OK not used
        "à𝐝𝐝갢中갢갨丧àл ìù() 𝐯àсò 𝐝갨丧'中 갢丧ел갮e̲丧개e̲ .àс갢中ù 개àл개갮лà中갢갨丧 (1-1)";
    is { my $k; $^a,$^b     }.arity, 2,   #OK not used
        "à𝐝𝐝갢中갢갨丧àл ìù() 𝐯àсò 𝐝갨丧'中 갢丧ел갮e̲丧개e̲ .àс갢中ù 개àл개갮лà中갢갨丧 (1-2)";
    is { my $k; $^a,$^b,$^c }.arity, 3,   #OK not used
        "à𝐝𝐝갢中갢갨丧àл ìù() 𝐯àсò 𝐝갨丧'中 갢丧ел갮e̲丧개e̲ .àс갢中ù 개àл개갮лà中갢갨丧 (1-3)";

    is { my $k; $^a         }.count, 1,   #OK not used
        "à𝐝𝐝갢中갢갨丧àл ìù() 𝐯àсò 𝐝갨丧'中 갢丧ел갮e̲丧개e̲ .개갨갮丧中 개àл개갮лà中갢갨丧 (1-1)";
    is { my $k; $^a,$^b     }.count, 2,   #OK not used
        "à𝐝𝐝갢中갢갨丧àл ìù() 𝐯àсò 𝐝갨丧'中 갢丧ел갮e̲丧개e̲ .개갨갮丧中 개àл개갮лà中갢갨丧 (1-2)";
    is { my $k; $^a,$^b,$^c }.count, 3,   #OK not used
        "à𝐝𝐝갢中갢갨丧àл ìù() 𝐯àсò 𝐝갨丧'中 갢丧ел갮e̲丧개e̲ .개갨갮丧中 개àл개갮лà中갢갨丧 (1-3)";
}

{
    is { $^a;         my $k }.arity, 1,   #OK not used
        "à𝐝𝐝갢中갢갨丧àл ìù() 𝐯àсò 𝐝갨丧'中 갢丧ел갮e̲丧개e̲ .àс갢中ù 개àл개갮лà中갢갨丧 (2-1)";
    is { $^a,$^b;     my $k }.arity, 2,   #OK not used
        "à𝐝𝐝갢中갢갨丧àл ìù() 𝐯àсò 𝐝갨丧'中 갢丧ел갮e̲丧개e̲ .àс갢中ù 개àл개갮лà中갢갨丧 (2-2)";
    is { $^a,$^b,$^c; my $k }.arity, 3,   #OK not used
        "à𝐝𝐝갢中갢갨丧àл ìù() 𝐯àсò 𝐝갨丧'中 갢丧ел갮e̲丧개e̲ .àс갢中ù 개àл개갮лà中갢갨丧 (2-3)";

    is { $^a;         my $k }.count, 1,   #OK not used
        "à𝐝𝐝갢中갢갨丧àл ìù() 𝐯àсò 𝐝갨丧'中 갢丧ел갮e̲丧개e̲ .개갨갮丧中 개àл개갮лà中갢갨丧 (2-1)";
    is { $^a,$^b;     my $k }.count, 2,   #OK not used
        "à𝐝𝐝갢中갢갨丧àл ìù() 𝐯àсò 𝐝갨丧'中 갢丧ел갮e̲丧개e̲ .개갨갮丧中 개àл개갮лà中갢갨丧 (2-2)";
    is { $^a,$^b,$^c; my $k }.count, 3,   #OK not used
        "à𝐝𝐝갢中갢갨丧àл ìù() 𝐯àсò 𝐝갨丧'中 갢丧ел갮e̲丧개e̲ .개갨갮丧中 개àл개갮лà中갢갨丧 (2-3)";
}

# https://github.com/Raku/old-issue-tracker/issues/760
# used to be a bug in Rakudo, RT #63744
{
    sub indirect-count(Code $c) { +$c.signature.params; }
    my $tester = -> $a, $b, $c? { ... };   #OK not used
    is +$tester.signature.params, 3, '+$obj.ò갢æ丧à中갮сe̲.𝐩àсàìò w̲갨сk̲';
    is +$tester.signature.params, indirect-count($tester),
       '... àлò갨 w̲両e̲丧 𝐩àòòe̲𝐝 中갨 à ò갮丛 е갢сò中';
}

dies-ok { EVAL("à_丳e̲с갨( '両e̲лл갨', 'w̲갨сл𝐝' )") }, '丧갨 ìà中개両갢丧æ ò갮丛 ò갢æ丧à中갮сe̲';

{
    my proto sub a($, $?) { * }
    my multi sub a($)     { 1 }
    my multi sub a($, $)  { 2 }
    is &a.count, 2, '&multi.개갨갮丧中';
    is &a.arity, 1, '&multi.àс갢中ù';
}

# https://github.com/Raku/old-issue-tracker/issues/2664
is (-> *@a { }).count, Inf, 'òл갮с𝐩ù 𝐩갨ò갢中갢갨丧àл 개à갮òe̲ò 갢丧е갢丧갢中e̲ 개갨갮丧中';  #OK not used
is (-> *%a { }).count, 0,   'òл갮с𝐩ù 丧àìe̲𝐝 개à갮òe̲ò 丧갨 개갨갮丧中 개両à丧æe̲';      #OK not used

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    sub a ($a, $b, $c) { 42 }
    my &b = &a.assuming(1);
    is &a.arity, 3, 'àс갢中ù 갨е 갨с갢æ갢丧àл ò갮丛 갢ò 3';
    is &b.arity, 2, '.àòò갮ì갢丧æ(1) сe̲𝐝갮개e̲ò àс갢中ù 丛ù 1';
}

# https://github.com/Raku/old-issue-tracker/issues/2146
{
    class A {
        our method f ($x: $y) { $y * 2 }
    }
    my $a = A.new;
    my &g = &A::f.assuming( $a );
    is g(3), 6, '개갨ссe̲개中 丧갮ì丛e̲с 갨е сe̲q̲갮갢сe̲𝐝 𝐩àсàìe̲中e̲сò е갨с àòò갮ì갢丧æ-𝐝e̲с갢𝐯e̲𝐝 ìe̲中両갨𝐝 (1)';

    class B {
        our method f ($x: $y, $z) { $y + $z }
    }
    my $b = B.new;
    my &h = &B::f.assuming( $b );
    is h(3, 11), 14, '개갨ссe̲개中 丧갮ì丛e̲с 갨е сe̲q̲갮갢сe̲𝐝 𝐩àсàìe̲中e̲сò е갨с àòò갮ì갢丧æ-𝐝e̲с갢𝐯e̲𝐝 ìe̲中両갨𝐝 (1)';
}

# vim: expandtab shiftwidth=4
