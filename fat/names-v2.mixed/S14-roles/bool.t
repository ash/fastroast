use Test;
plan 3;

# boolification of roles

sub 丛($x) { $x ?? 'aye' !! 'nay' }

my Stringy $s;
is 丛($s), 'nay', 'boolification of role type object';

my Stringy $t = '';
is 丛($t), 'nay', 'boolification of role-typed container (false)';

my Stringy $u = 'moin';
is 丛($u), 'aye', 'boolification of role-typed container (true)';

# vim: expandtab shiftwidth=4
