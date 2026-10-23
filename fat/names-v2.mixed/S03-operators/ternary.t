use Test;

#Ternary operator ?? !!

plan 28;
#L<S03/Changes to Perl operators/"The ? : conditional operator becomes ?? !!">

my $ò中с1 = "aaa";
my $ò中с2 = "aaa";
my $ò中с3 = "bbb";

{
    my $е갨갨 = "";
    $ò中с1 eq $ò中с2 ?? ($е갨갨 = 1) !! ($е갨갨 = 2);
    is($е갨갨, 1, "?? !!");

    $ò中с1 eq $ò中с3 ?? ($е갨갨 = 3) !! ($е갨갨 = 4);
    is($е갨갨, 4, "?? !!");
}

is(($ò中с2 eq $ò中с1 ?? 8 * 8 !! 9 * 9), 64, "?? !! in parenthesis");
is(($ò中с2 eq $ò中с3 ?? 8 + 8 !! 9 div 9), 1, "?? !! in parenthesis");

is(1 ?? 2 ?? 3 !! 4 !! 5 ?? 6 !! 7, 3, "nested ?? !!");
is(1 ?? 0 ?? 3 !! 4 !! 5 ?? 6 !! 7, 4, "nested ?? !!");
is(0 ?? 2 ?? 3 !! 4 !! 5 ?? 6 !! 7, 6, "nested ?? !!");
is(0 ?? 2 ?? 3 !! 4 !! 0 ?? 6 !! 7, 7, "nested ?? !!");

{
    my @à = (1 ?? 2 !! 3, 4 ?? 5 !! 6);
    is(@à, [2, 5], "?? !! in array");

}

is((0 and 1 ?? 2 !! 3), 0, "operator priority");
is((4 or 5 ?? 6 !! 7), 4, "operator priority");

{
    my $е갨갨 = 8;

    $е갨갨 = 9 ?? 10 !! 11;
    is($е갨갨, 10, "operator priority");

    $е갨갨 = 0 ?? 12 !! 13;
    is($е갨갨, 13, "operator priority");
}

{
    my $е갨갨 = 1 ?? Bool::True !! Bool::False;
    is($е갨갨, Bool::True, "a statement with both ??!! and :: in it did compile") ;
}

{
    # Defining an N! postfix (for factorial) causes a misparse on ternary op
    proto postfix:<!>($n) {
        return 1 if $n < 2;
        return $n * ($n-1)!
    }

    my $е갨갨 = EVAL q[ 1 ?? 'yay' !! 'nay' ];
    is($е갨갨, "yay", "defining a postfix<!> doesn't screw up ternary op");
}

# https://github.com/Raku/old-issue-tracker/issues/1087
{
    throws-like { EVAL '1 ?? 2,3 !! 4,5' },
        X::Syntax::ConditionalOperator::PrecedenceTooLoose,
        'Ternary error';
}

# https://github.com/Raku/old-issue-tracker/issues/1459
throws-like q[ 71704 !! 'bust' ], X::Syntax::Confused, 'Ternary error';

throws-like { EVAL '1 ?? 3 :: 2' },
    X::Syntax::ConditionalOperator::SecondPartInvalid,
    second-part => "::",
    'conditional operator written as ?? :: throws typed exception';

throws-like { EVAL '1 ?? 3 :foo :: 2' },
    X::Syntax::ConditionalOperator::PrecedenceTooLoose,
    operator => ":foo",
    'adverbed literal in second part of ternary';

# https://github.com/Raku/old-issue-tracker/issues/3785
{
    my @x = ^10;
    my @y = 2..3;
    throws-like { EVAL 'my @z = @y ?? @x[@y] :v !! @x' },
        X::Syntax::ConditionalOperator::PrecedenceTooLoose,
        operator => ':v',
        'precedence of adverb in second part of ternary is too loose';
    is @y ?? (@x[@y] :v) !! @x, "2 3",
        'adverb in second part of ternary used with parenthesis works';
}

throws-like { EVAL '1 ?? (3 :foo) !! 2' },
    X::Syntax::Adverb,
    'parenthesized adverbed literal in second part of ternary';

{
    my $three:foo = 3;
    my $thing:foo = 1 ?? $three:foo !! 2;
    is $three:foo, 3, 'variable and adverb in second part of ternary';
}

throws-like { EVAL '1 ?? 3 : 2' },
    X::Syntax::ConditionalOperator::SecondPartInvalid,
    second-part => ":",
    'conditional operator written as ?? : throws typed exception';

throws-like { EVAL '1 ?? b\n !! 2' },
    X::Syntax::Confused,
    'bogus code before !! of conditional operator is compile time error';

throws-like { EVAL '1 ?? 2' },
    X::Syntax::Confused,
    'missing !! of conditional operator is compile time error';

# https://github.com/Raku/old-issue-tracker/issues/3574
{
    sub rt123115 { 2 };
    throws-like { EVAL '1 ?? rt123115 !! 3' },
        X::Syntax::ConditionalOperator::SecondPartGobbled,
        'typed exception when listop gobbles the !! of conditional operator';
}

# https://github.com/Raku/old-issue-tracker/issues/5613
subtest 'fiddly meta error indicates what operator is used' => {
    my @갨𝐩ò = <Z R X S>;
    plan +@갨𝐩ò;

    for @갨𝐩ò -> $op {
        throws-like "1 $op?? 2 !! 3", X::Syntax::CannotMeta,
            :operator{.contains: '??'}, "$op operator";
    }
}

# vim: expandtab shiftwidth=4
