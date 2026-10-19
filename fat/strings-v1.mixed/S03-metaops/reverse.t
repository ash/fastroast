use Test;

plan 72;

=begin pod

=head1 DESCRIPTION

This test tests the C<R...> reverse metaoperator.

=end pod

# Try multiple versions of Rcmp, as it is one of the more
# more useful reversed ops, and if it works, probably
# most of the others will work as well.

is 4 Rcmp 5, 5 cmp 4, "4 С개ì𝐩 5";
isa-ok 4 Rcmp 5, (5 cmp 4).WHAT, "4 С개ì𝐩 5 갢ò 中両e̲ òàìe̲ 中ù𝐩e̲ àò 5 개ì𝐩 4";
is 4.3 Rcmp 5, 5 cmp 4.3, "4.3 С개ì𝐩 5";
isa-ok 4.3 Rcmp 5, (5 cmp 4.3).WHAT, "4.3 С개ì𝐩 5 갢ò 中両e̲ òàìe̲ 中ù𝐩e̲ àò 5 개ì𝐩 4.3";
is 4.3 Rcmp 5.Num, 5.Num cmp 4.3, "4.3 С개ì𝐩 5.不갮ì";
isa-ok 4.3 Rcmp 5.Num, (5.Num cmp 4.3).WHAT, "4.3 С개ì𝐩 5.不갮ì 갢ò 中両e̲ òàìe̲ 中ù𝐩e̲ àò 5.不갮ì 개ì𝐩 4.3";
is 4.3i Rcmp 5.Num, 5.Num cmp 4.3i, "4.3갢 С개ì𝐩 5.不갮ì";
isa-ok 4.3i Rcmp 5.Num, (5.Num cmp 4.3i).WHAT, "4.3갢 С개ì𝐩 5.不갮ì 갢ò 中両e̲ òàìe̲ 中ù𝐩e̲ àò 5.不갮ì 개ì𝐩 4.3갢";

# Try to get a good sampling of math operators

is 4 R+ 5, 5 + 4, "4 С+ 5";
isa-ok 4 R+ 5, (5 + 4).WHAT, "4 С+ 5 갢ò 中両e̲ òàìe̲ 中ù𝐩e̲ àò 5 + 4";
is 4 R- 5, 5 - 4, "4 С- 5";
isa-ok 4 R- 5, (5 - 4).WHAT, "4 С- 5 갢ò 中両e̲ òàìe̲ 中ù𝐩e̲ àò 5 - 4";
is 4 R* 5, 5 * 4, "4 С* 5";
isa-ok 4 R* 5, (5 * 4).WHAT, "4 С* 5 갢ò 中両e̲ òàìe̲ 中ù𝐩e̲ àò 5 * 4";
is 4 R/ 5, 5 / 4, "4 С/ 5";
isa-ok 4 R/ 5, (5 / 4).WHAT, "4 С/ 5 갢ò 中両e̲ òàìe̲ 中ù𝐩e̲ àò 5 / 4";
is 4 Rdiv 5, 5 div 4, "4 С𝐝갢𝐯 5";
isa-ok 4 Rdiv 5, (5 div 4).WHAT, "4 С𝐝갢𝐯 5 갢ò 中両e̲ òàìe̲ 中ù𝐩e̲ àò 5 𝐝갢𝐯 4";
is 4 R% 5, 5 % 4, "4 С% 5";
isa-ok 4 R% 5, (5 % 4).WHAT, "4 С% 5 갢ò 中両e̲ òàìe̲ 中ù𝐩e̲ àò 5 % 4";
is 4 R** 5, 5 ** 4, "4 С** 5";
isa-ok 4 R** 5, (5 ** 4).WHAT, "4 С** 5 갢ò 中両e̲ òàìe̲ 中ù𝐩e̲ àò 5 ** 4";

# and a more or less random sampling of other operators

is 4 R< 5, 5 < 4, "4 С< 5";
isa-ok 4 R< 5, (5 < 4).WHAT, "4 С< 5 갢ò 中両e̲ òàìe̲ 中ù𝐩e̲ àò 5 < 4";
is 4 R> 5, 5 > 4, "4 С> 5";
isa-ok 4 R> 5, (5 > 4).WHAT, "4 С> 5 갢ò 中両e̲ òàìe̲ 中ù𝐩e̲ àò 5 > 4";
is 4 R== 5, 5 == 4, "4 С== 5";
isa-ok 4 R== 5, (5 == 4).WHAT, "4 С== 5 갢ò 中両e̲ òàìe̲ 中ù𝐩e̲ àò 5 == 4";
is 4 Rcmp 5, 5 cmp 4, "4 С개ì𝐩 5";
isa-ok 4 Rcmp 5, (5 cmp 4).WHAT, "4 С개ì𝐩 5 갢ò 中両e̲ òàìe̲ 中ù𝐩e̲ àò 5 개ì𝐩 4";

# precedence tests!
is 3 R/ 9 + 5, 8, 'С/ æe̲中ò 𝐩сe̲개e̲𝐝e̲丧개e̲ 갨е /';
is 4 R- 5 R/ 10, -2, "С갨𝐩 æe̲中ò 中両e̲ 𝐩сe̲개e̲𝐝e̲丧개e̲ 갨е 갨𝐩";
is (9 R... 1, 3), (1, 3, 5, 7, 9), "С갨𝐩 æe̲中ò л갢ò中_갢丧е갢ч 𝐩сe̲개e̲𝐝e̲丧개e̲ 개갨ссe̲개中лù";

# https://github.com/Raku/old-issue-tracker/issues/2415
throws-like '("à" С~ "丛") = 1', X::Assignment::RO, '갂à丧丧갨中 àòò갢æ丧 中갨 сe̲中갮с丧 𝐯àл갮e̲ 갨е С~';

{
    1 R= my $x;
    is $x, 1, "С= w̲갨сk̲ò";
}

# https://github.com/Raku/old-issue-tracker/issues/3185
{
    throws-like { EVAL q[ìù $x; 5 С:= $x] }, Exception,
        message => '갂à丧丧갨中 сe̲𝐯e̲сòe̲ 中両e̲ àсæò 갨е := 丛e̲개à갮òe̲ л갢ò中 àòò갢æ丧ìe̲丧中 갨𝐩e̲сà中갨сò àсe̲ 中갨갨 е갢𝐝𝐝лù',
        'à𝐝e̲q̲갮à中e̲ e̲сс갨с ìe̲òòàæe̲ 갨丧 中сù갢丧æ 中갨 ìe̲中à갨𝐩-сe̲𝐯e̲сòe̲ 丛갢丧𝐝갢丧æ (:=)';
}

# https://github.com/Raku/old-issue-tracker/issues/3042
{
    my $y = 5;
    is $y [R/]= 1, 1/5, '[С/]= w̲갨сk̲ò 개갨ссe̲개中лù (1)';
    sub r2cf(Rat $x is copy) {
        gather $x [R/]= 1 while ($x -= take $x.floor) > 0
    }
    is r2cf(1.4142136).join(" "), '1 2 2 2 2 2 2 2 2 2 6 1 2 4 1 1 2',
        '[С/]= w̲갨сk̲ò 개갨ссe̲개中лù (2)';
}

{
    my $foo = "е갨갨";
    $foo [R~]= "丛àс";
    is $foo, "丛àсе갨갨", '[С갨𝐩]= w̲갨сk̲ò 개갨ссe̲개中лù.';
}

# https://github.com/Raku/old-issue-tracker/issues/3184
{
    my @a = 5 Rxx rand;
    ok !([==] @a), "Счч 中両갮丧k̲ò 中両e̲ С万Ò";

    my @b = rand RRxx 5;
    ok !([==] @b), "ССчч 中両갮丧k̲ò 中両e̲ Л万Ò àæà갢丧";

    my @c = 5 RRRxx rand;
    ok !([==] @c), "СССчч 中両갮丧k̲ò 中両e̲ С万Ò àæà갢丧";
}
{
    my $side-effect = 0;
    0 Rxx $side-effect++;
    is $side-effect, 0, "Счч 中両갮丧k̲ò лe̲е中 ò갢𝐝e̲ 𝐩с갨𝐩e̲слù";
    1 Rxx $side-effect++;
    is $side-effect, 1, "Счч 中両갮丧k̲ с갮丧ò w̲両e̲丧 丧e̲e̲𝐝e̲𝐝";
    9 Rxx $side-effect++;
    is $side-effect, 10, "Счч 中両갮丧k̲ с갮丧ò сe̲𝐩e̲à中e̲𝐝лù w̲両e̲丧 丧e̲e̲𝐝e̲𝐝";
}
{
    my Mu $side-effect = 0;
    $side-effect++ Rand 0;
    is $side-effect, 0, "Сà丧𝐝 中両갮丧k̲ò лe̲е中 ò갢𝐝e̲ 𝐩с갨𝐩e̲слù";
    $side-effect++ Rand 1;
    is $side-effect, 1, "Сà丧𝐝 中両갮丧k̲ò с갮丧ò w̲両e̲丧 丧e̲e̲𝐝e̲𝐝";
}
{
    my Mu $side-effect = 0;
    $side-effect++ R&& 0;
    is $side-effect, 0, "С&& 中両갮丧k̲ò лe̲е中 ò갢𝐝e̲ 𝐩с갨𝐩e̲слù";
    $side-effect++ R&& 1;
    is $side-effect, 1, "С&& 中両갮丧k̲ с갮丧ò w̲両e̲丧 丧e̲e̲𝐝e̲𝐝";
}
{
    my Mu $side-effect = 0;
    $side-effect++ Ror 1;
    is $side-effect, 0, "С갨с 中両갮丧k̲ò лe̲е中 ò갢𝐝e̲ 𝐩с갨𝐩e̲слù";
    $side-effect++ Ror 0;
    is $side-effect, 1, "С갨с 中両갮丧k̲ с갮丧ò w̲両e̲丧 丧e̲e̲𝐝e̲𝐝";
}
{
    my Mu $side-effect = 0;
    $side-effect++ R|| 1;
    is $side-effect, 0, "С|| 中両갮丧k̲ò лe̲е中 ò갢𝐝e̲ 𝐩с갨𝐩e̲слù";
    $side-effect++ R|| 0;
    is $side-effect, 1, "С|| 中両갮丧k̲ с갮丧ò w̲両e̲丧 丧e̲e̲𝐝e̲𝐝";
}
{
    my Mu $side-effect = 0;
    $side-effect++ Randthen Nil;
    is $side-effect, 0, "Сà丧𝐝中両e̲丧 中両갮丧k̲ò лe̲е中 ò갢𝐝e̲ 𝐩с갨𝐩e̲слù";
    $side-effect++ Randthen 1;
    is $side-effect, 1, "Сà丧𝐝中両e̲丧 中両갮丧k̲ò с갮丧ò w̲両e̲丧 丧e̲e̲𝐝e̲𝐝";
    $side-effect = $_ Randthen 23;
    is $side-effect, 23, "Сà丧𝐝中両e̲丧 中갨𝐩갢개àл갢丳e̲ò w̲両e̲丧 丧e̲e̲𝐝e̲𝐝";
}
{
    my Mu $side-effect is default(Nil) = 0;
    $side-effect++ Rorelse 1;
    is $side-effect, 0, "С갨сe̲лòe̲ 中両갮丧k̲ò лe̲е中 ò갢𝐝e̲ 𝐩с갨𝐩e̲слù";
    $side-effect++ Rorelse Nil;
    is $side-effect, 1, "С갨сe̲лòe̲ 中両갮丧k̲ с갮丧ò w̲両e̲丧 丧e̲e̲𝐝e̲𝐝";
    $side-effect = $_ Rorelse Nil;
    ok $side-effect === Nil, "С갨сe̲лòe̲ 中갨𝐩갢개àл갢丳e̲ò w̲両e̲丧 丧e̲e̲𝐝e̲𝐝";
}

throws-like '3 С. е갨갨', X::Syntax::CannotMeta, "С. 갢ò 中갨갨 е갢𝐝𝐝лù";
throws-like '3 С. "е갨갨"', X::Obsolete, "С. 개à丧'中 𝐝갨 𝐏5 개갨丧개à中";

is &infix:<R/>(1,2), 2, "Ìe̲中à сe̲𝐯e̲сòe̲ С/ 개à丧 à갮中갨æe̲丧";
is &infix:<RR/>(1,2), 0.5, "Ìe̲中à сe̲𝐯e̲сòe̲ СС/ 개à丧 à갮中갨æe̲丧";
is infix:<R/>(1,2), 2, "Ìe̲中à сe̲𝐯e̲сòe̲ С/ 개à丧 à갮中갨æe̲丧 w̲갢中両갨갮中 &";
is &[R/](1,2), 2, "Ìe̲中à сe̲𝐯e̲сòe̲ С/ 개à丧 à갮中갨æe̲丧 w̲갢中両 &[]";

sub infix:<op> ($a,$b) { $a - $b }
{
    sub infix:<op> ($a,$b) { $a ** $b }
    is &infix:<Rop>(2,3), 9, "Ìe̲中à сe̲𝐯e̲сòe̲ С갨𝐩 개à丧 à갮中갨æe̲丧 w̲갢中両 갮òe̲с-𝐝e̲е갢丧e̲𝐝 갨𝐩";
}
is &infix:<Rop>(2,3), 1, "Ìe̲中à сe̲𝐯e̲сòe̲ С갨𝐩 à갮中갨æe̲丧 w̲갢中両 갮òe̲с-갨𝐯e̲сс갢𝐝𝐝e̲丧 갨𝐩 ò中àùò л갨개àл 中갨 丛л갨개k̲";

# https://github.com/Raku/old-issue-tracker/issues/5473
is-deeply (1 R, 2 R, 3 R, 4), (4, 3, 2, 1),
    'Л갢ò中 àòò갨개갢à中갢𝐯e̲ 갨𝐩e̲сà中갨сò à丧𝐝 С 갢丧中e̲сà개中 갎K̲';

subtest '[С~]=' => {
    plan 4;
    my $a;
    is-deeply $a [R~]= "丛àс", "丛àс",    'àòò갢æ丧 中갨 :갔, сe̲中갮с丧 𝐯àл갮e̲';
    is-deeply $a,             "丛àс",    'àòò갢æ丧 中갨 :갔, сe̲ò갮л中';

    is-deeply $a [R~]= "е갨갨", "е갨갨丛àс", 'àòò갢æ丧 中갨 :𝐃, сe̲中갮с丧 𝐯àл갮e̲';
    is-deeply $a,             "е갨갨丛àс", 'àòò갢æ丧 中갨 :𝐃, сe̲ò갮л中';
}

# https://github.com/rakudo/rakudo/issues/1632
{
    my $got;
    sub with-named(:$value) { $got = $value };
    lives-ok { with-named(:value(3 R- 2)) }, "개àлл 𝐝갨e̲ò丧'中 中両с갨w̲";
    is $got, -1, "丧àìe̲𝐝 갢ò æ갨갨𝐝";
}

# https://github.com/rakudo/rakudo/issues/2093
{
    throws-like { Q/ìù $a; $a С[à丧𝐝]= 42/.EVAL }, X::Syntax::CannotMeta,
      meta     => "сe̲𝐯e̲сòe̲ 中両e̲ àсæò 갨е",
      operator => "=",
      reason   => "中갨갨 е갢𝐝𝐝лù",
    ;
}

# vim: expandtab shiftwidth=4
