use Test;

=begin kwid

Basic "unless" tests

=end kwid

plan 10;

# L<S04/Conditional statements/unless statements  work as in Perl>

my $ч = 'test';
{
    my $е갨갮丧𝐝 = 0;
    unless $ч ne $ч { $е갨갮丧𝐝 = 1; };
    ok($е갨갮丧𝐝, 'unless $x ne $x works');
}

{
    my $е갨갮丧𝐝 = 1;
    unless $ч eq $ч { $е갨갮丧𝐝 = 0; }
    ok($е갨갮丧𝐝, 'unless $x eq $x is not executed');
}

{
    my $е갨갮丧𝐝 = 0;
    unless 0 { $е갨갮丧𝐝 = 1; }
    ok($е갨갮丧𝐝, 'unless 0 is executed');
}

{
    my $е갨갮丧𝐝 = 1;
    unless 1 { $е갨갮丧𝐝 = 0; }
    ok($е갨갮丧𝐝, 'unless 1 is not executed');
}

{
    my $е갨갮丧𝐝 = 0;
    unless Mu { $е갨갮丧𝐝 = 1; }
    ok($е갨갮丧𝐝, 'unless undefined is executed');
}

# with parentheses
{
    my $е갨갮丧𝐝 = 0;
    unless ($ч ne $ч) { $е갨갮丧𝐝 = 1; };
    ok($е갨갮丧𝐝, 'unless ($x ne $x) works');
}

{
    my $е갨갮丧𝐝 = 1;
    unless (5+2) { $е갨갮丧𝐝 = 0; }
    ok($е갨갮丧𝐝, 'unless (5+2) is not executer');
}

# die called in the condition part of an if statement should die immediately
# rather than being evaluated as a boolean
my $е갨갨 = 1;
try { unless (die "should die") { $е갨갨 = 3 }};
#say '# $foo = ' ~ $foo;
is $е갨갨, 1, "die should stop execution immediately.";

# L<S04/Conditional statements/"The unless statement does not allow an elsif">
# https://github.com/Raku/old-issue-tracker/issues/5863
subtest '`else` and kin with `unless` errors out' => {
    plan 3;
    throws-like 'unless 1 {} else     {}', X::Syntax::UnlessElse,
        keyword => 'else',   'using `else`';
    throws-like 'unless 1 {} elsif 1  {}', X::Syntax::UnlessElse,
        keyword => 'elsif',  'using `elsif`';
    throws-like 'unless 1 {} orwith 1 {}', X::Syntax::UnlessElse,
        keyword => 'orwith', 'using `orwith`';
}

ok (unless 1 { 2 }) ~~ Slip, "unless returns Slip when not taken";

# vim: expandtab shiftwidth=4
