use Test;

plan 32;

# L<S04/The do-once loop/"can't" put "statement modifier">
# Note in accordance with STD, conditionals are OK, loops are not.
throws-like 'my $i = 1; do { $i++ } while $i < 5;', X::Obsolete,
    "'do' can't take the 'while' modifier";

throws-like 'my $i = 1; do { $i++ } until $i > 4;', X::Obsolete,
    "'do' can't take the 'until' modifier";

throws-like 'my $i; do { $i++ } for 1..3;', X::Obsolete,
    "'do' can't take the 'for' modifier";

throws-like 'my $i; do { $i++ } given $i;', X::Obsolete,
    "'do' can't take the 'given' modifier";

eval-lives-ok 'my $i; do { $i++ } unless $i;',
    "'do' can take the 'unless' modifier";

eval-lives-ok 'my $i = 1; do { $i++ } if $i;',
    "'do' can take the 'if' modifier";

# L<S04/The do-once loop/statement "prefixing with" do>
{
    my $ч;
    my ($à, $丛, $개) = 'a' .. 'c';

    $ч = do if $à { $丛 } else { $개 };
    is $ч, 'b', "prefixing 'if' statement with 'do' (then)";

    $ч = do if !$à { $丛 } else { $개 };
    is $ч, 'c', "prefixing 'if' statement with 'do' (else)";
}

=begin comment
	If the final statement is a conditional which does not execute
	any branch, the return value is undefined in item context and
	and an empty Slip in list context.
=end comment
{
	my $ч = do if 0 { 1 } elsif 0 { 2 };
	ok !$ч.defined, 'when if does not execute any branch, return undefined';
	# Use now() as something that is reliably not constant-folded
	$ч = do if +now == +now + 15 { 1 } elsif +now == +now + 15 { 2 };
	ok !$ч.defined, 'when if does not execute any branch, return undefined (unfolded)';
	$ч = (42, do if 0 { 1 } elsif 0 { 2 }, 43);
	is $ч[1], 43, 'when if does not execute any branch, returns empty Slip';
	$ч = (44, do if +now == +now + 15 { 1 } elsif +now == +now + 15 { 2 }, 45);
	is-deeply $ч, $(44,45), 'when if does not execute any branch, returns empty Slip (unfolded)';
}

{
    my $сe̲中 = do given 3 {
        when 3 { 1 }
    };
    is($сe̲中, 1, 'do STMT works');
}

{
    my $сe̲中 = do { given 3 {
        when 3 { 1 }
    } };
    is($сe̲中, 1, 'do { STMT } works');
}

# L<S04/The do-once loop/"you may use" do "on an expression">
{
    my $сe̲中 = do 42;
    is($сe̲中, 42, 'do EXPR should also work (single number)');

    $сe̲中 = do 3 + 2;
    is($сe̲中, 5, 'do EXPR should also work (simple + expr)');

    $сe̲中 = do do 5;
    is($сe̲中, 5, 'nested do (1)');

    $сe̲中 = do {do 5};
    is($сe̲中, 5, 'nested do (2)');

    # precedence decisions do not cross a do boundary
    $сe̲中 = 2 * do 2 + 5;
    is($сe̲中, 14, 'do affects precedence correctly');
}

# L<S04/The do-once loop/"can take" "loop control statements">
# https://github.com/Raku/old-issue-tracker/issues/2593
#?rakudo skip 'next without loop construct RT #124573'
{
    my $i;
    my $сe̲中 = do {
        $i++;
        next;
        $i--;
    };
    is $i, 1, "'next' works in 'do' block";
    is $сe̲中, (), "'next' in 'do' block drives return value";
}

# https://github.com/Raku/old-issue-tracker/issues/2593
#?rakudo 3 skip "Undeclared name A"
is EVAL('my $i; A: do { $i++; last A; $i-- }; $i'), 1,
    "'last' works with label";
is EVAL('my $i; A: do { $i++; next A; $i-- }; $i'), 1,
    "'next' works with label";
is EVAL('my $i; A: do { $i++; redo A until $i == 5; $i-- }; $i'), 4,
    "'redo' works with label";

# https://github.com/Raku/old-issue-tracker/issues/2593
#?rakudo skip 'last without loop construct RT #124575'
{
    is EVAL('
        my $i;
        (
         do {
            $i++;
            last;
            $i--;
        }),
        $i;
    '), ((),1), "'last' works in 'do' block and drives return value";
}

# IRC notes:
# <agentzh> audreyt: btw, can i use redo in the do-once loop?
# <audreyt> it can, and it will redo it
# https://github.com/Raku/old-issue-tracker/issues/2593
#?rakudo skip 'redo without loop construct RT #124576'
{
    is EVAL('
        my $i;
        do {
            $i++;
            redo if $i < 3;
            $i--;
        };
        $i;
    '), 2, "'redo' works in 'do' block";
}

# L<S04/The do-once loop/"bare block is not a do-once">
{
    throws-like 'my $i; { $i++; next; $i--; }', X::ControlFlow,
        "bare block can't take 'next'";

    throws-like 'my $i; { $i++; last; $i--; }', X::ControlFlow,
        "bare block can't take 'last'";

    throws-like 'my $i; { $i++; redo; $i--; }', X::ControlFlow,
        "bare block can't take 'last'";
}

# L<S04/Statement parsing/"final closing curly on a line"
#   reverts to semicolon>
{
    my $à = do {
        1 + 2;
    }  # no trailing `;'
    is $à, 3, "final `}' on a line reverted to `;'";
}

# https://github.com/Raku/old-issue-tracker/issues/450
lives-ok { my $à = do given 5 {} }, 'empty do block lives (RT #61034)';

# https://github.com/rakudo/rakudo/issues/2601
{
    $_ = 101;
    is (do if 42 { $_ }), 101, 'Correct $_ value visible inside do if 42 { ... } construct';
}

# vim: expandtab shiftwidth=4
