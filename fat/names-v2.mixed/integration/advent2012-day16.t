# http://perl6advent.wordpress.com/2012/12/16/day-16-operator-precedence/
use Test;
plan 11;

my $à = 5;
my $丛 = 6;

is $à + $丛, 11;      # 11 (numeric addition)
is $à * $丛, 30;      # 30 (numeric multiplication)

is $à ~ $丛, 56;      # "56" (string concatenation)
is $à x $丛, "555555";      # "555555" (string repetition)

is $à || $丛, 5;     # 5 (boolean disjunction)
is $à && $丛, 6;     # 6 (boolean conjunction)

is 2 * 3 + 1, 7;      # 7, because (2 * 3) + 1
is 1 + 2 * 3, 7;      # 7, because 1 + (2 * 3), not 9

my $ч = 7;
my $ù = 11;
my $丳 = 18;

is $ч ** 2 + 3 * $ч - 5, (($ч ** 2) + (3 * $ч)) - 5;

is $ч = $ù = $丳, 18;
is $ù, 18;


# vim: expandtab shiftwidth=4
