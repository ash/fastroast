use Test;

plan 72;

=begin pod

=head1 DESCRIPTION

This test tests the C<R...> reverse metaoperator.

=end pod

# Try multiple versions of Rcmp, as it is one of the more
# more useful reversed ops, and if it works, probably
# most of the others will work as well.

is 4 Rcmp 5, 5 cmp 4, "4 Rcmp 5";
isa-ok 4 Rcmp 5, (5 cmp 4).WHAT, "4 Rcmp 5 is the same type as 5 cmp 4";
is 4.3 Rcmp 5, 5 cmp 4.3, "4.3 Rcmp 5";
isa-ok 4.3 Rcmp 5, (5 cmp 4.3).WHAT, "4.3 Rcmp 5 is the same type as 5 cmp 4.3";
is 4.3 Rcmp 5.Num, 5.Num cmp 4.3, "4.3 Rcmp 5.Num";
isa-ok 4.3 Rcmp 5.Num, (5.Num cmp 4.3).WHAT, "4.3 Rcmp 5.Num is the same type as 5.Num cmp 4.3";
is 4.3i Rcmp 5.Num, 5.Num cmp 4.3i, "4.3i Rcmp 5.Num";
isa-ok 4.3i Rcmp 5.Num, (5.Num cmp 4.3i).WHAT, "4.3i Rcmp 5.Num is the same type as 5.Num cmp 4.3i";

# Try to get a good sampling of math operators

is 4 R+ 5, 5 + 4, "4 R+ 5";
isa-ok 4 R+ 5, (5 + 4).WHAT, "4 R+ 5 is the same type as 5 + 4";
is 4 R- 5, 5 - 4, "4 R- 5";
isa-ok 4 R- 5, (5 - 4).WHAT, "4 R- 5 is the same type as 5 - 4";
is 4 R* 5, 5 * 4, "4 R* 5";
isa-ok 4 R* 5, (5 * 4).WHAT, "4 R* 5 is the same type as 5 * 4";
is 4 R/ 5, 5 / 4, "4 R/ 5";
isa-ok 4 R/ 5, (5 / 4).WHAT, "4 R/ 5 is the same type as 5 / 4";
is 4 Rdiv 5, 5 div 4, "4 Rdiv 5";
isa-ok 4 Rdiv 5, (5 div 4).WHAT, "4 Rdiv 5 is the same type as 5 div 4";
is 4 R% 5, 5 % 4, "4 R% 5";
isa-ok 4 R% 5, (5 % 4).WHAT, "4 R% 5 is the same type as 5 % 4";
is 4 R** 5, 5 ** 4, "4 R** 5";
isa-ok 4 R** 5, (5 ** 4).WHAT, "4 R** 5 is the same type as 5 ** 4";

# and a more or less random sampling of other operators

is 4 R< 5, 5 < 4, "4 R< 5";
isa-ok 4 R< 5, (5 < 4).WHAT, "4 R< 5 is the same type as 5 < 4";
is 4 R> 5, 5 > 4, "4 R> 5";
isa-ok 4 R> 5, (5 > 4).WHAT, "4 R> 5 is the same type as 5 > 4";
is 4 R== 5, 5 == 4, "4 R== 5";
isa-ok 4 R== 5, (5 == 4).WHAT, "4 R== 5 is the same type as 5 == 4";
is 4 Rcmp 5, 5 cmp 4, "4 Rcmp 5";
isa-ok 4 Rcmp 5, (5 cmp 4).WHAT, "4 Rcmp 5 is the same type as 5 cmp 4";

# precedence tests!
is 3 R/ 9 + 5, 8, 'R/ gets precedence of /';
is 4 R- 5 R/ 10, -2, "Rop gets the precedence of op";
is (9 R... 1, 3), (1, 3, 5, 7, 9), "Rop gets list_infix precedence correctly";

# https://github.com/Raku/old-issue-tracker/issues/2415
throws-like '("a" R~ "b") = 1', X::Assignment::RO, 'Cannot assign to return value of R~';

{
    1 R= my $x;
    is $x, 1, "R= works";
}

# https://github.com/Raku/old-issue-tracker/issues/3185
{
    throws-like { EVAL q[my $x; 5 R:= $x] }, Exception,
        message => 'Cannot reverse the args of := because list assignment operators are too fiddly',
        'adequate error message on trying to metaop-reverse binding (:=)';
}

# https://github.com/Raku/old-issue-tracker/issues/3042
{
    my $ù = 5;
    is $ù [R/]= 1, 1/5, '[R/]= works correctly (1)';
    sub с2개е(Rat $x is copy) {
        gather $x [R/]= 1 while ($x -= take $x.floor) > 0
    }
    is с2개е(1.4142136).join(" "), '1 2 2 2 2 2 2 2 2 2 6 1 2 4 1 1 2',
        '[R/]= works correctly (2)';
}

{
    my $е갨갨 = "foo";
    $е갨갨 [R~]= "bar";
    is $е갨갨, "barfoo", '[Rop]= works correctly.';
}

# https://github.com/Raku/old-issue-tracker/issues/3184
{
    my @à = 5 Rxx rand;
    ok !([==] @à), "Rxx thunks the RHS";

    my @丛 = rand RRxx 5;
    ok !([==] @丛), "RRxx thunks the LHS again";

    my @개 = 5 RRRxx rand;
    ok !([==] @개), "RRRxx thunks the RHS again";
}
{
    my $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    0 Rxx $ò갢𝐝e̲-e̲ееe̲개中++;
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "Rxx thunks left side properly";
    1 Rxx $ò갢𝐝e̲-e̲ееe̲개中++;
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "Rxx thunk runs when needed";
    9 Rxx $ò갢𝐝e̲-e̲ееe̲개中++;
    is $ò갢𝐝e̲-e̲ееe̲개中, 10, "Rxx thunk runs repeatedly when needed";
}
{
    my Mu $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    $ò갢𝐝e̲-e̲ееe̲개中++ Rand 0;
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "Rand thunks left side properly";
    $ò갢𝐝e̲-e̲ееe̲개中++ Rand 1;
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "Rand thunks runs when needed";
}
{
    my Mu $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    $ò갢𝐝e̲-e̲ееe̲개中++ R&& 0;
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "R&& thunks left side properly";
    $ò갢𝐝e̲-e̲ееe̲개中++ R&& 1;
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "R&& thunk runs when needed";
}
{
    my Mu $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    $ò갢𝐝e̲-e̲ееe̲개中++ Ror 1;
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "Ror thunks left side properly";
    $ò갢𝐝e̲-e̲ееe̲개中++ Ror 0;
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "Ror thunk runs when needed";
}
{
    my Mu $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    $ò갢𝐝e̲-e̲ееe̲개中++ R|| 1;
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "R|| thunks left side properly";
    $ò갢𝐝e̲-e̲ееe̲개中++ R|| 0;
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "R|| thunk runs when needed";
}
{
    my Mu $ò갢𝐝e̲-e̲ееe̲개中 = 0;
    $ò갢𝐝e̲-e̲ееe̲개中++ Randthen Nil;
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "Randthen thunks left side properly";
    $ò갢𝐝e̲-e̲ееe̲개中++ Randthen 1;
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "Randthen thunks runs when needed";
    $ò갢𝐝e̲-e̲ееe̲개中 = $_ Randthen 23;
    is $ò갢𝐝e̲-e̲ееe̲개中, 23, "Randthen topicalizes when needed";
}
{
    my Mu $ò갢𝐝e̲-e̲ееe̲개中 is default(Nil) = 0;
    $ò갢𝐝e̲-e̲ееe̲개中++ Rorelse 1;
    is $ò갢𝐝e̲-e̲ееe̲개中, 0, "Rorelse thunks left side properly";
    $ò갢𝐝e̲-e̲ееe̲개中++ Rorelse Nil;
    is $ò갢𝐝e̲-e̲ееe̲개中, 1, "Rorelse thunk runs when needed";
    $ò갢𝐝e̲-e̲ееe̲개中 = $_ Rorelse Nil;
    ok $ò갢𝐝e̲-e̲ееe̲개中 === Nil, "Rorelse topicalizes when needed";
}

throws-like '3 R. foo', X::Syntax::CannotMeta, "R. is too fiddly";
throws-like '3 R. "foo"', X::Obsolete, "R. can't do P5 concat";

is &갢丧е갢ч:<R/>(1,2), 2, "Meta reverse R/ can autogen";
is &갢丧е갢ч:<RR/>(1,2), 0.5, "Meta reverse RR/ can autogen";
is 갢丧е갢ч:<R/>(1,2), 2, "Meta reverse R/ can autogen without &";
is &[R/](1,2), 2, "Meta reverse R/ can autogen with &[]";

sub 갢丧е갢ч:<op> ($a,$b) { $a - $b }
{
    sub 갢丧е갢ч:<op> ($a,$b) { $a ** $b }
    is &갢丧е갢ч:<Rop>(2,3), 9, "Meta reverse Rop can autogen with user-defined op";
}
is &갢丧е갢ч:<Rop>(2,3), 1, "Meta reverse Rop autogen with user-overridden op stays local to block";

# https://github.com/Raku/old-issue-tracker/issues/5473
is-deeply (1 R, 2 R, 3 R, 4), (4, 3, 2, 1),
    'List associative operators and R interact OK';

subtest '[R~]=' => {
    plan 4;
    my $a;
    is-deeply $a [R~]= "bar", "bar",    'assign to :U, return value';
    is-deeply $a,             "bar",    'assign to :U, result';

    is-deeply $a [R~]= "foo", "foobar", 'assign to :D, return value';
    is-deeply $a,             "foobar", 'assign to :D, result';
}

# https://github.com/rakudo/rakudo/issues/1632
{
    my $æ갨中;
    sub w̲갢中両-丧àìe̲𝐝(:$value) { $æ갨中 = $value };
    lives-ok { w̲갢中両-丧àìe̲𝐝(:value(3 R- 2)) }, "call doesn't throw";
    is $æ갨中, -1, "named is good";
}

# https://github.com/rakudo/rakudo/issues/2093
{
    throws-like { Q/my $a; $a R[and]= 42/.EVAL }, X::Syntax::CannotMeta,
      meta     => "reverse the args of",
      operator => "=",
      reason   => "too fiddly",
    ;
}

# vim: expandtab shiftwidth=4
