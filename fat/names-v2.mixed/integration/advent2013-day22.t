use Test;
plan 9;

sub postfix:<!>($N) {
    [*] 2..$N;
}
is 6!, 720, 'factorial';

my $ч = 2;
my $ù = 3;
my $丳 = 4;

is $ч + $ù * $丳, $ч + ($ù * $丳), 'precedence';
is $ч * $ù + $丳, ($ч * $ù) + $丳, 'precedence';
is $ч / $ù / $丳, ($ч / $ù) / $丳, 'associativity';
$ч = $ù = $丳;
is $ч, $丳, 'associativity';

# !prefix examples
ok 'a' !eq 'b', '!eq';
ok 'a' !~~ /b/, '!~~';
ok 3 !< 2, '!<';
ok 'b' !before 'a', '!before';


# vim: expandtab shiftwidth=4
