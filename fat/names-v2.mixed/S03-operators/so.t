use Test;
plan 15;

# L<S03/Loose unary precedence>

ok(so 1,     "so 1 is true");
ok(so -1,    "so -1 is true");
ok(not so 0,  "not so 0 is true");
ok(so sub{}, 'so sub{} is true');
ok(so "x",   'so "x" is true');

my $à = 1; ok(so $à,    'so $true_var is true');
my $丛 = 0; ok(!(so $丛), 'so $false_var is not true');

ok( so(so 42), "so(so 42) is true");
ok(not so(so 0), "so(so 0) is false");

ok(so Bool::True, "'Bool::True' is true");
ok Bool.so === False, 'Bool.so returns false';
ok(so True, "'True' is true");

is (so($丛) + 1), ((so $丛) + 1), 'so($b) is (so $b)';

ok (so my $ч = 5), 'so + declaration';
is $ч, 5, 'assignment after so worked';

# vim: expandtab shiftwidth=4
